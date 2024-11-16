import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/new/Chat.dart';
import 'package:get/get.dart';
import 'notification.dart';
import 'ProfileMenu.dart';
import 'Profile.dart';
import 'ChatHome.dart';
import 'package:get_storage/get_storage.dart';
import 'HomePreClinic.dart';
import 'package:http/http.dart' as http;
import 'chatbot.dart';

class home_page extends StatefulWidget {
  home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  List images1 = [
    {"name": "general", "img": "assets/images/heart.jpg"},
    {"name": "Dentistry", "img": "assets/images/Dentistry.jfif"},
    {"name": "Orthopaedic", "img": "assets/images/orthopaedic.jfif"},
    {"name": "Eye", "img": "assets/images/eye.jpg"},
    {"name": "Pediatrics", "img": "assets/images/Pediatrics.jfif"},
    {"name": "internal", "img": "assets/images/internal.jfif"},
    {"name": "Dermatology", "img": "assets/images/Dermatology.jfif"},
  ];
  final userdata = GetStorage();
  Future fetchProfileData() async {
    print("h1");
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/pateintProfile?email=${userdata.read("email")}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print(data);
        setState(() {
          userdata.write("name", data[0]['name'].toString());
          userdata.write("Nid", data[0]['Nid'].toString());
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
    fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        leading: IconButton(
            onPressed: () {
              Get.offAll(notification());
            },
            icon: Icon(
              Icons.notifications,
              size: 40,
            )),
        shadowColor: Colors.green,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("PATIENT", textScaleFactor: 1.25),
        actions: [
          IconButton(
              onPressed: () {
                Get.offAll(Profile());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Profile()),
                // );
              },
              icon: Icon(
                Icons.person_pin,
                size: 40,
              )),
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.green.shade200,
        animationDuration: Duration(milliseconds: 300),
        items: [
          InkWell(
            onTap: () {
              // Use the Navigator to replace the current route with the home page
              Get.offAll(home_page());
            },
            child: Icon(
              Icons.home,
              color: Colors.white,
              size: 40,
            ),
          ),
          InkWell(
            onTap: () {
              // Use the Navigator to replace the current route with the home page
              //Get.offAll(ChatHome(name: 'suad'));
              Get.offAll(ChatHome());
            },
            child: Icon(
              Icons.wechat_sharp,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          children: [
            Container(
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.green.shade200, width: 4)),
                child: Column(children: [
                  Text(
                    "Use AI to diagnose disease :",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 60,
                    width: 350,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.green[400]),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(ChatBotApp());
                      },
                      child: Text(
                        "Using AI",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                    ),
                  ),
                ])),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 277,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.green.shade200, width: 4)),
                child: Column(
                  children: [
                    Text(
                      "Choose What You Want Clinic :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                    Container(
                      height: 240,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          spreadRadius: 2)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        // Wrap the image widget with a GestureDetector to handle the tap event
                                        GestureDetector(
                                          // Use the onTap property to specify the function to execute when the user taps on the image
                                          onTap: () {
                                            // Use the Navigator widget to push a new route to the navigation stack
                                            // You can customize the route to display the page you want
                                            Get.offAll(HomePreClinic(
                                              // the route to navigate to
                                              image: images1[index][
                                                  'img'], // the image to display
                                              imagename: images1[index][
                                                  'name'], // the name of the image
                                            ));
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15)),
                                            child: Image.asset(
                                              images1[index]["img"],
                                              height: 150,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            images1[index]["name"],
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green,
                                            ),
                                          ),
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
                    )
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 260,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.green.shade200, width: 4)),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Text(
                      "Your Current Appointments :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Zaid Clinic",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Dr Zaid \n Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade400,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Reschedule",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Zaid Clinic",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Dr Zaid \n Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade400,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Reschedule",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Zaid Clinic",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Dr Zaid \n Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
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
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 150,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade400,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        "Reschedule",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.green.shade200, width: 4)),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Text(
                      "Your Previous Appointments :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Zaid Clinic",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Dr Zaid \n Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
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
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Zaid Clinic",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Dr Zaid \n Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
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
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Zaid Clinic",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("Dr Zaid \n Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/images/doctor.jpg"),
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
                ))
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  // Declare a final variable to store the image
  final image;

  // Define a constructor that initializes the image variable
  DetailPage(this.image);

  // Override the build method to return a widget tree
  @override
  Widget build(BuildContext context) {
    // Return a scaffold widget that contains an app bar and a body
    return Scaffold(
      // Set the app bar title to the image name
      appBar: AppBar(
        title: Text(image["name"]),
      ),
      // Set the body to a center widget that contains the image
      body: Center(
        child: Image.asset(image["img"]),
      ),
    );
  }
}
