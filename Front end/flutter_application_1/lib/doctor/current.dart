import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/doctor/MyReservation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class currentapp extends StatefulWidget {
  const currentapp({Key? key})
      : super(key: key); // no need to use super keyword

  @override
  _currentappState createState() =>
      _currentappState(); // override createState method
}

class _currentappState extends State<currentapp> {
  final userdata = GetStorage();
  Future fetchdocss(emai) async {
    print("h1");
    String url = "http://192.168.1.3:6000/getAppd?doc_email=${emai}&complete=0";

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

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Colors.tealAccent
                  .shade400, // Change the clock hands and text color here
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future Confirm(id) async {
    var url =
        "http://192.168.1.3:6000/Confirm?id=" + id.toString() + "&complete=1";
    DateTime? timestamp;
    timestamp = timestamp ?? DateTime.now();
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

  Future addNot(id, date) async {
    var url = "http://192.168.1.3:6000/rescedual?id=" + id.toString();
    DateTime? timestamp;
    timestamp = timestamp ?? DateTime.now();
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "date": date,
        }),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = json.decode(response.body);
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
                    height: 720,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border:
                            Border.all(color: Colors.green.shade200, width: 4)),
                    child: Column(
                      children: [
                        Text(
                          "Your Current Appointments :",
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
                                              clinic["cl_name"].toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text("Dr." +
                                                clinic["doc_name"].toString()),
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
                                                        color: Colors.black54),
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
                                                        color: Colors.black54),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Delete Appointment'),
                                                        content: Text(
                                                            'Are you sure to Dlete it?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text('OK'),
                                                            onPressed: () {
                                                              setState(() {});
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // Use endTime as needed...
                                                  _selectStartTime(context);
                                                  if (startTime != null) {
                                                    // Convert startTime to DateTime
                                                    final now = DateTime.now();
                                                    final startDateTime =
                                                        DateTime(
                                                            now.year,
                                                            now.month,
                                                            now.day,
                                                            startTime!.hour,
                                                            startTime!.minute);

                                                    // Add 15 minutes
                                                    final endDateTime =
                                                        startDateTime.add(
                                                            Duration(
                                                                minutes: 15));

                                                    // Convert back to TimeOfDay
                                                    endTime = TimeOfDay(
                                                        hour: endDateTime.hour,
                                                        minute:
                                                            endDateTime.minute);
                                                    print("eeeennnnnnnndddd" +
                                                        endTime.toString());
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Reschedule Appoinement'),
                                                          content: Text(
                                                              'Selected Time Range: ${startTime != null ? DateFormat.Hm().format(DateTime(2022, 1, 1, startTime!.hour, startTime!.minute)) : 'Not selected'} - ${endTime != null ? DateFormat.Hm().format(DateTime(2022, 1, 1, endTime!.hour, endTime!.minute)) : 'Not selected'}'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text('OK'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    // Use endTime as needed...

                                                    String newdate =
                                                        clinic["date"]
                                                                .toString()
                                                                .split(" ")[0] +
                                                            " " +
                                                            startTime!
                                                                .format(context)
                                                                .toString() +
                                                            ":" +
                                                            endTime!
                                                                .format(context)
                                                                .toString();
                                                    print(
                                                        "neeeeeeeeeewwwwwwwwww" +
                                                            newdate);
                                                    addNot(
                                                        clinic["id"], newdate);
                                                  }
                                                },
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.green.shade400,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Reschedule",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Confirm(clinic["id"]);
                                                  });
                                                },
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          240, 94, 131, 167),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                              );
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
