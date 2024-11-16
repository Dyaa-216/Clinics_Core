import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/new/AppoitmentScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DoctorSection extends StatefulWidget {
  final clemail;
  DoctorSection(this.clemail);
  @override
  _DoctorSectionState createState() => _DoctorSectionState();
}

class _DoctorSectionState extends State<DoctorSection> {
  List<String> _listOfemails = [];
  List wholeList = [];
  Future fetchdocs() async {
    print("mmm");
    String url =
        "http://192.168.1.3:6000/clinicdocs?cl_email=${widget.clemail}";

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
    return Container(
      height: 340,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: wholeList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 300,
                width: 200,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.offAll(AppointmentScreen(
                                wholeList[index]["email"],
                                wholeList[index]["name"],
                                wholeList[index]["time_range"]));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            child: Image.asset(
                              "assets/images/doctor.jpg",
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 45,
                            width: 45,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. " + wholeList[index]["name"],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Text(
                                wholeList[index]["Specialization"],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
