import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/AllAppoitment.dart';
import 'package:flutter_application_1/clinic/AllDoctor.dart';
import 'package:flutter_application_1/clinic/ChatHomeClinic.dart';
import 'package:flutter_application_1/clinic/ClinicSpecialties.dart';
import 'package:flutter_application_1/clinic/Profile.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'sendNotification.dart';

import 'package:http/http.dart' as http;

class home_page_clinic extends StatefulWidget {
  const home_page_clinic({super.key});
  @override
  State<home_page_clinic> createState() => _home_page_clinicState();
}

class _home_page_clinicState extends State<home_page_clinic> {
  final userdata = GetStorage();
  Future fetchClinic() async {
    print("h1");
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/getClinicn?deamil=" + userdata.read("email");

    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var dataList = json.decode(response.body);
        userdata.write("clinicname", dataList["name"][0]);
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
  void initState() {
    super.initState();

    fetchClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        leading: Padding(
          padding:
              const EdgeInsets.all(10.0), // Adjust padding as per requirement
          child: IconButton(
            onPressed: () {
              Get.offAll(SendNotification());
            },
            icon: const Icon(
              Icons.notifications,
              size: 30,
            ), // Reduced size to 30 for better visibility on smaller screens
          ),
        ),
        shadowColor: Colors.lime.shade300,
        shape: ContinuousRectangleBorder(
            borderRadius:
                BorderRadius.circular(25)), // Reduced borderRadius to 25
        title: const Text(
          "CLINIC",
          // ignore: deprecated_member_use
          textScaleFactor:
              1.2, // Slightly reduced scale factor for better visibility
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.all(10.0), // Adjust padding as per requirement
            child: IconButton(
              onPressed: () {
                Get.offAll(Profile());
              },
              icon: const Icon(
                Icons.person_pin,
                size: 30,
              ), // Reduced size to 30 for better visibility on smaller screens
            ),
          ),
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.lime.shade300,
        animationDuration: const Duration(milliseconds: 300),
        height: 60, // Adjusted height for better display
        items: [
          InkWell(
            onTap: () {
              // Use the Navigator to replace the current route with the home page
              //Get.offAll(ChatHome(name: 'suad'));
              Get.offAll(home_page_clinic());
            },
            child: Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
          ), // Reduced size to 30 for better visibility on smaller screens
          InkWell(
            onTap: () {
              // Use the Navigator to replace the current route with the home page
              //Get.offAll(ChatHome(name: 'suad'));
              Get.offAll(ChatHomeClinic());
            },
            child: Icon(
              Icons.wechat_sharp,
              color: Colors.white,
              size: 40,
            ),
          ), // Reduced size to 30 for better visibility on smaller screens
        ],
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10),
          children: [
            Container(
              height: 260,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.lime.shade300, width: 4),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.lime.shade300,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/clinic.jpg',
                                  width:
                                      70, // Adjusted image width for better visibility
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 5, top: 15),
                                    child: Text(
                                      "Clinic Specialties",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "zaid clinic",
                                    style:
                                        TextStyle(color: Colors.grey.shade50),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Increased space between elements

                          InkWell(
                            onTap: () {
                              Get.offAll(const ClinicSpecialties());
                            },
                            child: Container(
                              width: 80,
                              height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.lime.shade300,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Eye Clinic",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/eye.jpg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Heart Clinic",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/heart.jpg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 260,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.lime.shade300, width: 4),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.lime.shade300,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/clinic.jpg',
                                  width:
                                      70, // Adjusted image width for better visibility
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 5, top: 15),
                                    child: Text(
                                      "All Clinic Doctors",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "zaid clinic",
                                    style:
                                        TextStyle(color: Colors.grey.shade50),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Increased space between elements

                          InkWell(
                            onTap: () {
                              Get.offAll(AllDoctor());
                            },
                            child: Container(
                              width: 80,
                              height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.lime.shade300,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Dr.Zaid",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("3.4k Visits"),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Dr.Zaid",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("3.4k Visits"),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Dr.Zaid",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("3.4k Visits"),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10), // Increased spacing between containers

            Container(
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.lime.shade300, width: 4)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.lime.shade300,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/clock.PNG',
                                width:
                                    70, // Adjusted image width for better visibility
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 15),
                                  child: Text(
                                    "All Clinic Appoitment",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "zaid clinic",
                                  style: TextStyle(color: Colors.grey.shade50),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Increased space between elements

                        InkWell(
                          onTap: () {
                            Get.offAll(AllAppoitment());
                          },
                          child: Container(
                            width: 80,
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.lime.shade300,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.lime.shade300, width: 4)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.lime.shade300,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/heart.jpg',
                                width:
                                    70, // Adjusted image width for better visibility
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 15),
                                  child: Text(
                                    "Heart Clinic Doctors",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "zaid clinic",
                                  style: TextStyle(color: Colors.grey.shade50),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Increased space between elements

                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 80,
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.lime.shade300,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Dr.Zaid",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("3.4k Visits"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/doctor.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Dr.Zaid",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("3.4k Visits"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/doctor.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Dr.Zaid",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("3.4k Visits"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/doctor.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.lime.shade300, width: 4)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.lime.shade300,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/clock.PNG',
                                width:
                                    70, // Adjusted image width for better visibility
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 15),
                                  child: Text(
                                    "Heart Clinic Appoitments",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "zaid clinic",
                                  style: TextStyle(color: Colors.grey.shade50),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Increased space between elements

                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 80,
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.lime.shade300,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.lime.shade300, width: 4)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.lime.shade300,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/eye.jpg',
                                width:
                                    70, // Adjusted image width for better visibility
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 15),
                                  child: Text(
                                    "Eye Clinic Doctors",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "zaid clinic",
                                  style: TextStyle(color: Colors.grey.shade50),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Increased space between elements

                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 80,
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.lime.shade300,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Dr.Zaid",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("3.4k Visits"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/doctor.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Dr.Zaid",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("3.4k Visits"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/doctor.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Dr.Zaid",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("3.4k Visits"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/doctor.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.lime.shade300, width: 4)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.lime.shade300,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/clock.PNG',
                                width:
                                    70, // Adjusted image width for better visibility
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5, top: 15),
                                  child: Text(
                                    "Eye Clinic Appoitments",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "zaid clinic",
                                  style: TextStyle(color: Colors.grey.shade50),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Increased space between elements

                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 80,
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.lime.shade300,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Zaid ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(" Eye Clinic \n Dr.Diaa"),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/images/patient.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "12/12/2023",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "10:30 AM",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
    );
  }
}
