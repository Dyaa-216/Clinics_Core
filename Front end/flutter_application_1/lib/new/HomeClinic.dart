import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/new/DoctorSection.dart';

class HomeClinic extends StatefulWidget {
  final clinicEmail;

  HomeClinic(this.clinicEmail);

  @override
  _HomeClinicState createState() => _HomeClinicState();
}

class _HomeClinicState extends State<HomeClinic> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.green.shade400.withOpacity(0.5),
                  Colors.green.shade400
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage("assets/images/doctor.jpg"),
                          ),
                          Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Zaid Clinic",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Your Health is Our \n First Priority",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 6,
                                  spreadRadius: 3)
                            ]),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Doctor Here ...",
                              helperStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 25,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Available Doctors",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                SizedBox(
                  height: 340, // Assign a finite height
                  child: DoctorSection(widget.clinicEmail),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 60,
                  width: 370,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green[400]),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.offAll(HomeClinic(widget.clinicEmail));
                    },
                    label: Text(
                      "Go Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
