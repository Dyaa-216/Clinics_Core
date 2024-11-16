import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/doctor/ChatHomeDoctor.dart';
import 'package:flutter_application_1/doctor/Profile.dart';
import 'package:flutter_application_1/doctor/UploadPrescription.dart';
import 'package:flutter_application_1/doctor/sendNotification.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Profile.dart';
import 'package:http/http.dart' as http;
import 'ChatHomeDoctor.dart';

class home_page_doctor extends StatefulWidget {
  home_page_doctor({super.key});
  @override
  State<home_page_doctor> createState() => _home_page_doctorState();
}

class _home_page_doctorState extends State<home_page_doctor> {
  final userdata = GetStorage();
  XFile? image;
  final ImagePicker picker = ImagePicker();
  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.tealAccent.shade400)),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.tealAccent.shade400)),
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future fetchP() async {
    print(userdata.read("email"));
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/getdoctor?email=${userdata.read("email")}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the statfus code
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        setState(() {
          userdata.write("name", data[0]['name'].toString());
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.tealAccent.shade400,
          leading: IconButton(
              onPressed: () {
                Get.offAll(sendNotification());
              },
              icon: Icon(
                Icons.notifications,
                size: 40,
              )),
          shadowColor: Colors.tealAccent.shade400,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          title: Text("DOCTOR", textScaleFactor: 1.25),
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(Profile());
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
          color: Colors.tealAccent.shade400,
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
              size: 40,
            ),
            InkWell(
              onTap: () {
                // Use the Navigator to replace the current route with the home page
                //Get.offAll(ChatHome(name: 'suad'));
                Get.offAll(ChatHomeDoctor());
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
              InkWell(
                onTap: () {
                  Get.offAll(UploadPrescription());
                },
                child: Container(
                    height: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: Colors.tealAccent.shade400, width: 4)),
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(children: [
                          Text(
                            "Upload Prescription :",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.tealAccent.shade400),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Select Patinet'),
                              items: ['Option 1', 'Option 2', 'Option 3']
                                  .map((String value) =>
                                      DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {},
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15),
                            padding: EdgeInsets.all(11.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.tealAccent.shade400),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextField(
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Code of Prescription'),
                              onChanged: (value) {},
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 42,
                                width: 250,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )),
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.tealAccent.shade400),
                                  ), //ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.tealAccent.shade400),
                                  onPressed: () {
                                    myAlert();
                                  },
                                  child: Text(
                                    'Upload Prescription Photo',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),

                              //if image not null show the image
                              //if image null show text
                              image != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          //to show image, you type like this.
                                          File(image!.path),
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 300,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "No Image",
                                      style: TextStyle(fontSize: 15),
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 370,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.tealAccent.shade400),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Go Back",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.tealAccent.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                            ),
                          ),
                        ]))),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 260,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: Colors.tealAccent.shade400, width: 4)),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                  "Zaid ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(" Eye Clinic"),
                                trailing: CircleAvatar(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                  "Ahmad ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(" Eye Clinic"),
                                trailing: CircleAvatar(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                  "Dyaa",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(" Eye Clinic"),
                                trailing: CircleAvatar(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: Colors.tealAccent.shade400, width: 4)),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(children: [
                        Text(
                          "Your UnRecorded Appointments :",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                              EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]))),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: Colors.tealAccent.shade400, width: 4)),
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                  "Zaid ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(" Eye Clinic"),
                                trailing: CircleAvatar(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                  "Ahmad ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(" Eye Clinic"),
                                trailing: CircleAvatar(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                  "Dyaa",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(" Eye Clinic"),
                                trailing: CircleAvatar(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ))
            ],
          ),
        ));
  }
}
