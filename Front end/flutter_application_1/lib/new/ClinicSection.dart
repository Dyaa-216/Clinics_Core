import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:get_storage/get_storage.dart';
import 'HomeClinic.dart';
import 'package:http/http.dart' as http;

class Clinic {
  final int id;
  final String email;
  final String name;
  final String phoneNum;
  final String specialization;
  final String address;

  Clinic({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNum,
    required this.specialization,
    required this.address,
  });

  // Factory method to create a Clinic object from a map
  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phoneNum: json['phone_num'],
      specialization: json['Specialization'],
      address: json['address'],
    );
  }
}

class ClinicSection extends StatefulWidget {
  final clinicTypee;
  ClinicSection(this.clinicTypee);
  @override
  _ClinicSectionState createState() => _ClinicSectionState();
}

class _ClinicSectionState extends State<ClinicSection> {
  List<Clinic> clinicsList = [];
  int cCount = 0;
  Future fetchClinic() async {
    print("h1");
    print(widget.clinicTypee);
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/clinic?Specialization=${widget.clinicTypee}";

    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var dataList = json.decode(response.body);

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
      body: FutureBuilder<dynamic>(
        future: fetchClinic(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return Container(
              height: 340,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var clinic = snapshot.data[index];
                  return Column(
                    children: [
                      Container(
                        height: 300,
                        width: 200,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeClinic(
                                              "${clinic['deamil']}")),
                                    );
                                    userdata.write(
                                        "clinicname", clinic['name']);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    child: Image.asset(
                                      "assets/images/clinic.jpg",
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${clinic['name']}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "${clinic['address']}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
