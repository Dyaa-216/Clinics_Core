import 'dart:convert';
import 'package:flutter_application_1/new/home_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controller/profilef.dart';
import '../controller/authcontroller.dart';
import 'package:get_storage/get_storage.dart';

void main() => runApp(ChatBotApp());

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.green.shade200,
        ),
      ),
      home: ChatScreen(),
    );
  }
}

class ChatMessage {
  String text;
  bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages =
      []; // Ensure this is a list of ChatMessage
  final TextEditingController _textController = TextEditingController();
  String Dta = "";
  String _dta = "";

  // Updated fetchP method to return a Future<String>
  Future<String> fetchP(String msg) async {
    String url = "http://192.168.1.3:6000/chatpy?message=${msg}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        return data['message']; // Return the message from the server
      } catch (e) {
        print("Failed to decode JSON: $e");
        return "Error in processing your message"; // Return error message
      }
    } else {
      print("Failed to fetch data");
      return "Error in fetching data"; // Return error message
    }
  }

// Updated _sendMessage method
  void _sendMessage(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, ChatMessage(text: text, isUserMessage: true));
      });

      String botResponse =
          await fetchP(text); // Await the response from the server
      setState(() {
        _messages.insert(
            0, ChatMessage(text: botResponse, isUserMessage: false));
      });

      _textController.clear();
    }
  }

  @override
  void initState() {
    super.initState();

    print("thhissssssssss is the fuck" + _dta);
    _messages.insert(
        0, ChatMessage(text: "Hi how can I help you?", isUserMessage: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        titleSpacing: 10,
        backgroundColor: Colors.green.shade200,
        leading: IconButton(
            icon: Icon(LineAwesomeIcons.angle_left),
            color: Colors.white,
            onPressed: () {
              Get.offAll(home_page());
            }),
        leadingWidth: 20,
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/r1.jpg"),
          ),
          title: const Text(
            'mO',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: const Text(
            'AI Chatbot',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  _buildMessageItem(_messages[index]),
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Align(
      alignment:
          message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color:
              message.isUserMessage ? Colors.green.shade200 : Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(
              color: message.isUserMessage ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _sendMessage(_textController.text),
          ),
        ],
      ),
    );
  }
}
