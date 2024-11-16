// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import './message.dart';

// class chatService extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Future<void> sendMessage(String recive, String messaget) async {
//     final String cuurrentId = _auth.currentUser!.uid.toString();
//     final String cuurrentEmail = _auth.currentUser!.uid.toString();
//     final Timestamp currenttime = Timestamp.now();

//     Message newmessage = new Message(
//         senderId: cuurrentId.toString(),
//         senderEmail: cuurrentEmail.toString(),
//         receiverId: recive.toString(),
//         message: messaget.toString(),
//         timestamp: currenttime);

//     List<String> ids = [cuurrentId, recive];
//     ids.sort();
//     String chatRoom = ids.join("_");
//     if (cuurrentId != recive) {
//       await _firestore
//           .collection("chatRoom")
//           .doc(chatRoom)
//           .collection("messages")
//           .doc(newmessage.toMap().toString());
//     }

//     Stream<QuerySnapshot> getMessage(String userid, String otherid) {
//       List<String> ids = [cuurrentId, recive];
//       ids.sort();
//       String chatRoomid = ids.join("_");
//       return _firestore
//           .collection("chatRoom")
//           .doc(chatRoomid)
//           .collection("messages")
//           .orderBy("timestamp", descending: false)
//           .snapshots();
//     }
//   }
// }
