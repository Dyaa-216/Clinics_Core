import 'dart:convert';
import 'package:flutter_application_1/clinic/AllAppoitment.dart';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddDoctor extends StatefulWidget {
  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  bool isChecked = false;
  late String docName = "";
  late String speci = "";
  List<String> _listOfNotification = [];
  List wholeList = [];

  List<String> spcis = [
    "Dermatology",
    "internal",
    "Pediatrics",
    "Eye",
    "Orthopaedic",
    "Dentistry"
  ];
  Future addSlot(email, email2, range) async {
    var url = "http://192.168.1.3:6000/addcldoc";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(
            {"cl_email": email, "doc_email": email2, "time_range": range}),
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

  Future fetchdocss(s) async {
    print("h1:" + s.toString());
    String url = "http://192.168.1.3:6000/getAdddoctors?spece=" + s.toString();

    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var dataList = json.decode(response.body);

        setState(() {
          for (var message in dataList) {
            wholeList.add({'name': message['name'], 'email': message['email']});
            _listOfNotification.add(message['name']);
          }
        });

        return dataList;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        shadowColor: Colors.lime,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("Add Doctor", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(AllAppoitment());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lime.shade300),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: DropdownButtonFormField<String>(
                decoration:
                    InputDecoration.collapsed(hintText: 'Select Specialty'),
                items: spcis
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    speci = value.toString();
                    fetchdocss(speci);
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lime.shade300),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: DropdownButtonFormField<String>(
                decoration:
                    InputDecoration.collapsed(hintText: 'Select Doctor'),
                items: _listOfNotification
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (String? value) {
                  docName = value.toString();
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                var reemil = wholeList
                    .where((element) => element['name'] == docName)
                    .first;
// Get the email from the element
                var remail = reemil['email'];
                addSlot(userdata.read("email"), remail,
                    userdata.read("time_range"));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lime.shade300,
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
      ),
    );
  }
}

// BLoC
