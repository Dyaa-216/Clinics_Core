import 'dart:convert';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/doctor/MyReservation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class prevapp extends StatefulWidget {
  const prevapp({Key? key}) : super(key: key); // no need to use super keyword

  @override
  _prevappState createState() => _prevappState(); // override createState method
}

class _prevappState extends State<prevapp> {
  final userdata = GetStorage();
  Future fetchdocss(emai) async {
    print("h1");
    String url = "http://192.168.1.3:6000/getAppd?doc_email=${emai}&complete=1";

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
    //  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.tealAccent.shade400,
          shadowColor: Colors.tealAccent,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          title: Text("MY RESERVATION", textScaleFactor: 1.25),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAll(MyReservation());
              },
              icon: const Icon(LineAwesomeIcons.angle_left)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 10),
            FutureBuilder<dynamic>(
              future: fetchdocss(userdata.read("email")),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return Container(
                    height: 900,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border:
                            Border.all(color: Colors.green.shade200, width: 4)),
                    child: Column(
                      children: [
                        Text(
                          "Your Previous Appointments :",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var clinic = snapshot.data[index];
                              return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
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
                                  child: Column(children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2)
                                          ]),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                clinic["cl_name"].toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(clinic["doc_name"]
                                                  .toString()),
                                              trailing: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: AssetImage(
                                                    "assets/images/patient.jpg"),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
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
                                                      clinic["date"]
                                                          .toString()
                                                          .split(" ")[0],
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
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
                                                      clinic["date"]
                                                          .toString()
                                                          .split(" ")[1],
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 10),
          ]),
        ));
  }
}
