import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/ClinicInfo.dart';
import 'package:flutter_application_1/clinic/home_page_clinic.dart';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class AllDoctor extends StatefulWidget {
  const AllDoctor({Key? key}) : super(key: key);

  @override
  State<AllDoctor> createState() => _AllDoctorState();
}

class _AllDoctorState extends State<AllDoctor> {
  bool isObscurePassword = true;
  List<String> _listOfemails = [];
  List wholeList = [];

  Future updated(email) async {
    var url = "http://192.168.1.3:6000/updateDoc01?email=${email}&status=0";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({}),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = json.decode(response.body);
        print("ppppppppppppppppp");
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

  Future deletedoc(email) async {
    var url = "http://192.168.1.3:6000/deleteDc?email=" + email.toString();
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({}),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = json.decode(response.body);
        print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
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

  Future fetchdocs() async {
    print("mmm");
    String url =
        "http://192.168.1.3:6000/clinicdocs?cl_email=" + userdata.read("email");

    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var dataList = json.decode(response.body);
        for (var message in dataList) {
          _listOfemails.add(message['doc_email']);
        }
        print(_listOfemails);
        for (var message in _listOfemails) {
          fetchP(message);
        }

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

  Future fetchP(nn) async {
    // the API endpoint
    String url = "http://192.168.1.3:6000/getdoctor?email=${nn}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the statfus code
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        setState(() {
          wholeList.add({
            "email": data[0]['email'].toString(),
            "name": data[0]['name'].toString(),
            "Specialization": data[0]['Specialization'].toString(),
            "time_range": data[0]['time_range'].toString()
          });
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

    fetchdocs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime.shade300,
          shadowColor: Colors.lime.shade300,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          title: Text("All Clinic Doctors", textScaleFactor: 1.25),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAll(home_page_clinic());
              },
              icon: const Icon(LineAwesomeIcons.angle_left)),
        ),
        body: ListView.builder(
          itemCount: wholeList.length, // Use the length of wholeList
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Add your action here. For example, navigate to a new screen or display a message
                print("d,dkkddkddddddddddddddl");
                Get.offAll(ClinicInfo(wholeList[index]['email']));
                print("Container tapped: ${wholeList[index]['name']}");
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Dr." + wholeList[index]["name"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                wholeList[index]["Specialization"] + " Clinic"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/doctor.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    wholeList[index]['email'] != userdata.read("email")
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // Background color
                              onPrimary: Colors.white, // Text color
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize:
                                  Size(100, 50), // Fixed width and height
                            ),
                            onPressed: () {
                              // Define your action here when button is pressed
                              print("Remove button pressed");
                              setState(() {
                                deletedoc(wholeList[index]["email"]);
                                updated(wholeList[index]["email"]);
                              });
                            },
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Text(
                            "Admin",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
