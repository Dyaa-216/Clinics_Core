import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/ChatClinic.dart';
import 'package:flutter_application_1/clinic/MassageModel.dart';
import 'package:flutter_application_1/clinic/home_page_clinic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChatHomeClinic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        shadowColor: Colors.lime.shade300,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        title: Text(
          "HOME CHAT",
          textScaleFactor: 1.25,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAll(home_page_clinic());
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) {
          final Message chat = chats[index];
          double avatarRadius = 35;
          if (MediaQuery.of(context).size.width > 600) {
            avatarRadius = 50;
          }
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatClinic(
                  user: chat.sender,
                ),
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
                    decoration: chat.unread
                        ? BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(avatarRadius)),
                            border: Border.all(
                              width: 2,
                              color: Colors.lime.shade300,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          )
                        : BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: AssetImage(chat.sender.imageUrl),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          chat.sender.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          chat.text,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    chat.time,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
