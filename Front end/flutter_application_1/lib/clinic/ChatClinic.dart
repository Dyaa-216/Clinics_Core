import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/MassageModel.dart';
import 'package:flutter_application_1/clinic/UserModel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChatClinic extends StatefulWidget {
  final User? user;
  ChatClinic({this.user});
  @override
  _ChatClinicState createState() => _ChatClinicState();
}

class _ChatClinicState extends State<ChatClinic> {
  _chatBubble(Message message, bool isMe, bool isSameUser) {
    double maxWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      children: <Widget>[
        Container(
          alignment: isMe ? Alignment.topRight : Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? Colors.lime.shade300 : Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black54,
              ),
            ),
          ),
        ),
        if (!isSameUser)
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              Text(
                message.time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
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
                  radius: 15,
                  backgroundImage: AssetImage(message.sender.imageUrl),
                ),
              ),
            ],
          ),
      ],
    );
  }

  _sendMessageArea() {
    double iconSize = 25;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: iconSize,
            color: Colors.lime.shade300,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: iconSize,
            color: Colors.lime.shade300,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int? prevUserId;

    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        centerTitle: true,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.user!.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(text: '\n'),
              widget.user!.isOnline
                  ? TextSpan(
                      text: 'Online',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : TextSpan(
                      text: 'Offline',
                      style: TextStyle(
                        fontSize: 11,
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
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                final bool isMe = message.sender.id == currentUser.id;
                final bool isSameUser = prevUserId == message.sender.id;
                prevUserId = message.sender.id;
                return _chatBubble(message, isMe, isSameUser);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
