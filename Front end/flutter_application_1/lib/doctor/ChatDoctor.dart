//import 'package:flutter_application_1/new/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/new/MassageModel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatDoctor extends StatefulWidget {
  final Remail;

  ChatDoctor(this.Remail);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatDoctor> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? meesageText;

  void sendNotification(String title, String body, String receiverId) async {
    final db = FirebaseFirestore.instance;
    final userRef = db.collection('patient').doc(receiverId);
    String? ttoken = await FirebaseMessaging.instance.getToken();
    print("FCM Tokenxxxxx: $ttoken");

    final userDoc = await userRef.get();
    final token = userDoc.data()!['token'];
    print('FCM Token: $token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAlNwno4w:APA91bGL-kFh9gAGRXGvNHKhVxfq-gvL3y9RFX9M-zmE83n8I5QbX5lOl9RARAJpILQ1jJknIqFeN9Eicj8qTMaqqOvDBDmYhJnqTtarGDQhW_VFWMKzrSYjkWAvNVWXalyQHBuvYyJv',
    };

    final bodys = json.encode({
      'notification': {
        'title': title,
        'body': body,
      },
      'to':
          "cwyinE4TT3ipuEcKhW8EG3:APA91bGv9KSZefuSBXWWeOIh-NeSweQ33U2iWInMZh_O2iEAI3PZbgrk0BImpKZSi6NwkjGtPQG1bJX_BfI7mIcJxJf8r1gvoIbfwTy1A8gn8zifMwGu7HBzFvOFsfre7rOmTWnUTvZc",
    });
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final response = await http.post(
      url,
      headers: headers,
      body: bodys,
    );

    print('Response: ${response.body}');
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> fetchMessages() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("messages").get();
      for (var message in snapshot.docs) {
        print(message.data());
      }
    } catch (e) {
      print(e);
    }
  }

  void getSyncmessage() async {
    await for (var messages in _firestore.collection("messages").snapshots()) {
      for (var message in messages.docs) {
        print(message.data());
      }
    }
  }
  // _chatBubble(Message message, bool isMe, bool isSameUser) {
  //   if (isMe) {
  //     return Column(
  //       children: <Widget>[
  //         Container(
  //           alignment: Alignment.topRight,
  //           child: Container(
  //             constraints: BoxConstraints(
  //               maxWidth: MediaQuery.of(context).size.width * 0.80,
  //             ),
  //             padding: EdgeInsets.all(10),
  //             margin: EdgeInsets.symmetric(vertical: 10),
  //             decoration: BoxDecoration(
  //               color: Colors.green.shade200,
  //               borderRadius: BorderRadius.circular(15),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.5),
  //                   spreadRadius: 2,
  //                   blurRadius: 5,
  //                 ),
  //               ],
  //             ),
  //             child: Text(
  //               message.text,
  //               style: TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //         !isSameUser
  //             ? Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: <Widget>[
  //                   Text(
  //                     message.time,
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.black45,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.grey.withOpacity(0.5),
  //                           spreadRadius: 2,
  //                           blurRadius: 5,
  //                         ),
  //                       ],
  //                     ),
  //                     child: CircleAvatar(
  //                       radius: 15,
  //                       backgroundImage: AssetImage(message.sender.imageUrl),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             : Container(
  //                 child: null,
  //               ),
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       children: <Widget>[
  //         Container(
  //           alignment: Alignment.topLeft,
  //           child: Container(
  //             constraints: BoxConstraints(
  //               maxWidth: MediaQuery.of(context).size.width * 0.80,
  //             ),
  //             padding: EdgeInsets.all(10),
  //             margin: EdgeInsets.symmetric(vertical: 10),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(15),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.5),
  //                   spreadRadius: 2,
  //                   blurRadius: 5,
  //                 ),
  //               ],
  //             ),
  //             child: Text(
  //               message.text,
  //               style: TextStyle(
  //                 color: Colors.black54,
  //               ),
  //             ),
  //           ),
  //         ),
  //         !isSameUser
  //             ? Row(
  //                 children: <Widget>[
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.grey.withOpacity(0.5),
  //                           spreadRadius: 2,
  //                           blurRadius: 5,
  //                         ),
  //                       ],
  //                     ),
  //                     child: CircleAvatar(
  //                       radius: 15,
  //                       backgroundImage: AssetImage(message.sender.imageUrl),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Text(
  //                     message.time,
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.black45,
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             : Container(
  //                 child: null,
  //               ),
  //       ],
  //     );
  //   }
  // }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: const Color.fromRGBO(76, 175, 80, 1),
            onPressed: () {
              getSyncmessage();
            },
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                this.meesageText = value;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.tealAccent.shade400,
            onPressed: () {
              Message m = Message(
                  sender: this.signedInUser.email.toString(),
                  receiver: "e@gmail.com",
                  content: this.meesageText.toString());
              _firestore.collection('messages').add(m.toMap());
              sendNotification("MN", this.meesageText.toString(),
                  "ItUt5kaQqHhigMBRkzgiXuSHv2P2");
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade400,
        centerTitle: true,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: widget.Remail,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(text: '\n'),
              TextSpan(
                text: 'Online',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(LineAwesomeIcons.angle_left),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages) {
                  final messageData = message.data()
                      as Map<String, dynamic>; // Cast to Map<String, dynamic>
                  final messageText = messageData['content'];
                  final messageSender = messageData['sender'];
                  final currentUser = signedInUser.email;
                  final messageBubble = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    isMe: currentUser == messageSender,
                  );
                  messageBubbles.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: messageBubbles,
                  ),
                );
              },
            ),
            Container(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: const Color.fromRGBO(76, 175, 80, 1),
                    width: 2,
                  ),
                ),
              ),
            ),
            _sendMessageArea(),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  MessageBubble({required this.sender, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.tealAccent.shade400 : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;

  ChatBubble({
    required this.color,
    required this.alignment,
  });

  var _radius = 10.0;
  var _x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (alignment == Alignment.topRight) {
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          size.width - 8,
          size.height,
          bottomLeft: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
          topLeft: Radius.circular(_radius),
        ),
        Paint()
          ..color = this.color
          ..style = PaintingStyle.fill,
      );
      var path = new Path();
      path.moveTo(size.width - _x, size.height - 20);
      path.lineTo(size.width - _x, size.height);
      path.lineTo(size.width, size.height);
      canvas.clipPath(path);
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          size.width - _x,
          0.0,
          size.width,
          size.height,
          topRight: Radius.circular(_radius),
        ),
        Paint()
          ..color = this.color
          ..style = PaintingStyle.fill,
      );
    } else {
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          _x,
          0,
          size.width,
          size.height,
          bottomRight: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
          topLeft: Radius.circular(_radius),
        ),
        Paint()
          ..color = this.color
          ..style = PaintingStyle.fill,
      );
      var path = new Path();
      path.moveTo(0, size.height);
      path.lineTo(_x, size.height);
      path.lineTo(_x, size.height - 20);
      canvas.clipPath(path);
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          0,
          0.0,
          _x,
          size.height,
          topRight: Radius.circular(_radius),
        ),
        Paint()
          ..color = this.color
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
