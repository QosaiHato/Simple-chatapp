import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sendID;
  final String senderEmail;
  final String reciverID;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.sendID,
      required this.senderEmail,
      required this.reciverID,
      required this.message,
      required this.timestamp});

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderID': sendID,
      'senderEmail': senderEmail,
      'reciverID': reciverID,
      'message': message,
      'timestamp': timestamp
    };
  }
}
