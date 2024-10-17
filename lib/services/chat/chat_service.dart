import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
//get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
//get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

//send message
  Future<void> sendMessage(String reciverID, message) async {
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
        sendID: currentUserID,
        senderEmail: currentUserEmail,
        reciverID: reciverID,
        message: message,
        timestamp: timestamp);
    //construct chat room ID for the two users(sorted to ensure uniqueness)
    List<String> ids = [currentUserID, reciverID];
    ids.sort(); //sort the ids (this ensure the chatroomID is the same for anny 2 people)
    String chatRoomID = ids.join('_');
    //add new message to databasse
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }
//get message

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //construct a chat room ID for the two users

    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
/**snapshots(): هذه الدالة تُعيد تدفق (stream) من التحديثات الحية (real-time updates) من قاعدة البيانات. يعني أنك ستحصل على كل التغييرات التي تحدث على مجموعة Users بشكل لحظي. */