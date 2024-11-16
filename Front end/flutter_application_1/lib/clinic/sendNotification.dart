import 'dart:convert';
import 'package:flutter_application_1/clinic/home_page_clinic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SendNotification extends StatefulWidget {
  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  final userdata = GetStorage();
  final cc = TextEditingController();
  List<String> _listOfNotification = [];
  List wholeList = [];
  late String? patName = "";
  bool isAll = false;
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future addNot(sender, receiver, sname, rname, content) async {
    var url = "http://192.168.1.3:6000/addNot";
    DateTime? timestamp;
    timestamp = timestamp ?? DateTime.now();
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "sender": sender,
          "receiver": receiver,
          "sname": sname,
          "rname": rname,
          "content": content,
          "time": timestamp.toString()
        }),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = json.decode(response.body);
        return responseData;
      } else if (response.statusCode == 401) {
        // Unauthorized response, "Log in failed" scenario.
        print("Log in failed");
      } else {
        // Handle other status codes as needed.
        print("Unexpected status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future fetchP() async {
    print("h1");
    print(userdata.read("email"));
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/getNots?email=${userdata.read("email")}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print(data);
        setState(() {
          for (var message in data) {
            wholeList.add(
                {'name': message['pat_name'], 'email': message['pat_email']});
            _listOfNotification.add(message['pat_name']);
          }
        });
      } catch (e) {
        // handle the error
        print("Failed to decode JSON: $e");
      }
    } else {
      // handle the error
      print("Failed to fetch profile data");
    }
  }

  @override
  void initState() {
    super.initState();
    isAll = false;
    fetchP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        shadowColor: Colors.lime.shade300,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("MAKE NOTIFICATION ", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(home_page_clinic());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lime.shade300),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration:
                        InputDecoration.collapsed(hintText: 'Select Patinet'),
                    items: _listOfNotification
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      patName = value;
                    },
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.lime.shade300,
                      value: isAll,
                      onChanged: (value) {
                        setState(() {
                          isAll = true;
                        });
                      },
                    ),
                    Text('Select All Patient'),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lime.shade300),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: cc,
                    maxLines: 7,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Content of Notification'),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    if (!isAll) {
                      var reemil = wholeList
                          .where((element) => element['name'] == patName)
                          .first;
// Get the email from the element
                      var remail = reemil['email'];

                      addNot(userdata.read("email"), remail,
                          userdata.read("name"), patName, cc.text);
                    } else {
                      for (var item in wholeList) {
                        addNot(userdata.read("email"), item['email'],
                            userdata.read("name"), patName, cc.text);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lime.shade300,
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// BLoC
