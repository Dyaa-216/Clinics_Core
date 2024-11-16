import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/AllDoctor.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const String tProfileImage = 'assets/images/doctor.jpg';
const String tProfileHeading = 'Zaid Sad Al Deen';
const String tProfileSubHeading = 'Zaid@gmail.com';

class ClinicInfo extends StatefulWidget {
  // You can add attributes and a constructor if needed

  final String clinicEmail;

  ClinicInfo(this.clinicEmail); // Constructor

  @override
  _ClinicInfoState createState() => _ClinicInfoState();
}

class _ClinicInfoState extends State<ClinicInfo> {
  String Name = "";
  String Email = "";
  String Phone = "";
  String spec = "";
  String gen = "";

  Future fetchP() async {
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/getdoctor?email=${widget.clinicEmail}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        // Assuming data is a List of Maps and you're interested in the first item
        var firstItem = data[0];
        setState(() {
          Name = firstItem["name"].toString();
          Email = firstItem["email"].toString();
          spec = firstItem["Specialization"].toString();
          Phone = firstItem["phone_num"].toString();
          gen = "Male"; // Assuming gender is not in the JSON
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
    fetchP();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        shadowColor: Colors.green,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("DOCTOR INFORMATION", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(AllDoctor());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(
              screenWidth * 0.05), // Adjust padding based on screen width
          child: Column(
            children: [
              SizedBox(height: 0.1 * screenWidth),
              CircleAvatar(
                radius: screenWidth * 0.25,
                backgroundImage: AssetImage(tProfileImage),
              ),
              SizedBox(height: 0.05 * screenWidth),
              // For the ListTile widgets, you can simplify the code by creating a function
              _buildListTile("Name", Name, Icons.person, Colors.lime.shade300),
              _buildListTile("Email", Email, Icons.email, Colors.lime.shade300),
              _buildListTile(
                  "Specialization", spec, Icons.phone, Colors.lime.shade300),
              _buildListTile(
                  "Phone Number", Phone, Icons.phone, Colors.lime.shade300),
              _buildListTile(
                  "Gender", gen, Icons.transgender, Colors.lime.shade300),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(
      String title, String subtitle, IconData icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.lime.shade300),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon, color: iconColor),
        tileColor: Colors.white,
      ),
    );
  }
}
