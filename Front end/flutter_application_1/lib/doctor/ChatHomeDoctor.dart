import 'package:flutter/material.dart';
import 'package:flutter_application_1/doctor/MassageModel.dart';
import 'package:flutter_application_1/doctor/ChatDoctor.dart';
import 'package:flutter_application_1/doctor/home_page_doctor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/new/MassageModel.dart';
import 'package:flutter_application_1/new/Chat.dart';
import 'package:flutter_application_1/new/home_page.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHomeDoctor extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

// This is the State class for ChatHome
class _ChatHomeState extends State<ChatHomeDoctor> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
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

  Future<String> getReceiverName(String receiverEmail) async {
    var docSnapshot = await _firestore
        .collection('patient')
        .where('email', isEqualTo: receiverEmail)
        .limit(1)
        .get();
    if (docSnapshot.docs.isNotEmpty) {
      return docSnapshot.docs.first
          .data()['name']; // Assuming 'name' is the field
    }
    return 'Mohammed'; // Fallback name
  }

  void fff() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade400,
        shadowColor: Colors.white,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("HOME CHAT", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(home_page_doctor());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: Container(
        child: StreamBuilder(
          stream: _firestore
              .collection('chat')
              .where("receiver", isEqualTo: signedInUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            } else {
              var numberOfDocs = snapshot.data?.docs.length;
              var docs = snapshot.data?.docs;
              return ListView.builder(
                itemCount: numberOfDocs,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var doc = docs?[index];
                  var data = doc?.data() as Map<String, dynamic>;
                  // Extracting the receiver's email
                  String receiverEmail = data['receiver'];
                  return FutureBuilder<String>(
                      future: getReceiverName(receiverEmail),
                      builder: (context, nameSnapshot) {
                        if (!nameSnapshot.hasData) {
                          return Container(); // or some placeholder widget
                        }
                        String receiverName = nameSnapshot.data ?? 'Unknown';

                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatDoctor(receiverEmail),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(2),
                                  // decoration: chat.unread
                                  //     ? BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.all(Radius.circular(40)),
                                  //         border: Border.all(
                                  //           width: 2,
                                  //           color: Colors.green.shade200,
                                  //         ),
                                  //         // shape: BoxShape.circle,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             color: Colors.grey.withOpacity(0.5),
                                  //             spreadRadius: 2,
                                  //             blurRadius: 5,
                                  //           ),
                                  //         ],
                                  //       )
                                  //     : BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             color: Colors.grey.withOpacity(0.5),
                                  //             spreadRadius: 2,
                                  //             blurRadius: 5,
                                  //           ),
                                  //         ],
                                  //       ),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        AssetImage("assets/images/clinic.jpg"),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  padding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                receiverName,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "time",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "chat text",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              );
            }
          },
        ),
      ),
    );
  }
}
