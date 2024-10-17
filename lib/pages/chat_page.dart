import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/custom_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String email;
  final String reciverID;
  ChatPage({super.key, required this.email, required this.reciverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageContoller = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  FocusNode myFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();
  bool isUserAtBottom = true;
  int lastMessageCount = 0;

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // Scroll down if keyboard is opened
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    // Listen to scroll events to track if the user is at the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        isUserAtBottom = true;
      } else {
        isUserAtBottom = false;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageContoller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollDown() {
    if (_scrollController.hasClients && isUserAtBottom) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void sendMesssage() async {
    if (_messageContoller.text.isNotEmpty) {
      await _chatService.sendMessage(widget.reciverID, _messageContoller.text);
      _messageContoller.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          centerTitle: true,
          title: Text(widget.email),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildUserInput(context)
          ],
        ));
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.reciverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Waiting...");
          }

          var messages = snapshot.data!.docs;

          // Only scroll if there are new messages and user is at the bottom
          if (messages.length != lastMessageCount && isUserAtBottom) {
            WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
          }

          // Update llast message count after rendering the widget
          lastMessageCount = messages.length;

          return ListView(
              controller: _scrollController,
              children: messages
                  .map((doc) => _buildMessageItem(doc, context))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

 
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

   
    var alignment =
        isCurrentUser ? Alignment.centerLeft : Alignment.centerRight;
    return Column(
      children: [
        Container(
          alignment: alignment,
          child: ChatBubble(
            message: data['message'],
            isCurrentUser: isCurrentUser,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          Expanded(
              child: CustomTextfield(
            hintText: 'Enter message',
            isPassword: false,
            controller: _messageContoller,
            focusNode: myFocusNode,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                    onPressed: sendMesssage, icon: Icon(Icons.send))),
          )
        ],
      ),
    );
  }
}
