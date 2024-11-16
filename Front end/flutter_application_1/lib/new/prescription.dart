import 'dart:convert';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:flutter_application_1/new/prescSection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controller/profilef.dart';
import '../controller/authcontroller.dart';
import 'package:get_storage/get_storage.dart';
import "../controller/fireMethods.dart";

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _EditInformationState();
}

class _EditInformationState extends State<Prescription> {
  Map<String, dynamic>? profileData;
  final cNid = TextEditingController();
  // a function to fetch the profile data from the API

  @override
  void initState() {
    super.initState();
  }

  bool flagt = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        shadowColor: Colors.green,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("Search Prescription", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            padding: EdgeInsets.all(11.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: cNid,
              decoration: InputDecoration.collapsed(hintText: 'National ID'),
              onChanged: (value) {
                flagt = value.isNotEmpty;
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 42,
                width: 250,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.green.shade200),
                  ), //ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.tealAccent.shade400),
                  onPressed: () {
                    if (flagt) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SizedBox(
                            height: 700, // Assign a finite height
                            child: prisc(cNid.text),
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Please Enter'),
                            content: Text('Please enter a valid National ID'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'Search Prescription Photo',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
