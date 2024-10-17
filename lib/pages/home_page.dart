import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          title: Text("Home"),
          centerTitle: true,
          actions: [],
        ),
        body: StreamBuilder(
          stream: _chatService.getUsersStream(),
          builder: (context, snapshot) {
        
            if (snapshot.hasError) {
              return Text("Error......");
            }
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading......");
            }
         
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!
                    .map<Widget>(
                        (userData) => _buildUserLitsItem(userData, context))
                    .toList(),
              );
            }
            return Container();
          },
        ));
  }

  Widget _buildUserLitsItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserTile(
          text: userData['email'],
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ChatPage(
                  email: userData['email'],
                  reciverID: userData['uid'],
                );
              },
            ));
          },
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
