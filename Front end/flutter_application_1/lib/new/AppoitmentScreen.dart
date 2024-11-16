import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:flutter_application_1/new/home_page.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

DateTime today = DateTime.now();

// Create another DateTime object with the date and time of the next day
// by adding one day to the current DateTime object
DateTime tomorrow = today.add(Duration(days: 1));

class AppointmentScreen extends StatefulWidget {
  final doctorEmail;
  final doctorName;
  final tr;

  AppointmentScreen(this.doctorEmail, this.doctorName, this.tr);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool k = false;
  int selectedIndex = -1;
  int selectedIndex1 = -1;
  late String doctorEmail = "";
  late String doctorName = "";
  late String tr = "";
  late String timers = "";
  String formatMyDateday(String dateString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date to show only the month (e.g., 'DEC')
    return DateFormat('dd').format(dateTime).toUpperCase();
  }

  List<Map<String, dynamic>> getss = []; // Initialize the list

  Future fetchdocs(email) async {
    print("Fetching documents..." + email);
    String url = "http://192.168.1.3:6000/getslot?email=" + email;

    // Make a GET request
    var response = await http.get(Uri.parse(url));
    print(response.body);

    if (response.statusCode == 200) {
      try {
        var dataList = json.decode(response.body) as List;
        setState(() {
          getss.clear(); // Clear the list before adding new items
          for (var message in dataList) {
            getss.add(
                {'date': message['date'], 'complete': message['complete']});
          }
        });
      } catch (e) {
        // Handle JSON parsing error
        print("Failed to decode JSON: $e");
      }
    } else {
      // Handle non-200 response
      print(
          "Failed to fetch profile data with status code: ${response.statusCode}");
    }
  }

  late String? selectedDate = "";
  late String? selectedtime = "";
  String formatMyDatemonth(String dateString) {
    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date to show only the month (e.g., 'DEC')
    return DateFormat('MMM').format(dateTime).toUpperCase();
  }

  List<String> getTimeRanges(String timeRange) {
    List<String> result = [];
    print(timeRange);
    // Splitting the time range into start and end times
    List<String> times = timeRange.split('-');
    DateTime startTime = DateTime.parse('2020-01-01 ' + times[0] + ':00');
    DateTime endTime = DateTime.parse('2020-01-01 ' + times[1] + ':00');

    // Looping through each quarter-hour
    for (DateTime time = startTime;
        time.isBefore(endTime);
        time = time.add(Duration(minutes: 15))) {
      // Formatting the start and end of each quarter-hour
      String start = DateFormat('HH:mm').format(time);
      String end = DateFormat('HH:mm').format(time.add(Duration(minutes: 15)));

      // Adding the range to the result
      result.add('$start-$end');
    }

    return result;
  }

  Future addpd(sender, receiver, name) async {
    print("hiisssi" + sender);
    print("hiirrri" + receiver);

    var url = "http://192.168.1.3:6000/addPatdoc";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "pat_email": sender,
          "doc_email": receiver,
          "pat_name": name,
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

  Future addApp(sender, receiver, name, sname, rname, mm) async {
    var url = "http://192.168.1.3:6000/addApp";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "doc_name": sender,
          "doc_email": receiver,
          "pat_email": name,
          "date": sname,
          "complete": rname,
          "cl_name": mm,
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    fetchdocs(userdata.read("email"));
    print("This is Date: " +
        formatMyDateday(DateTime.now().toString()) +
        "/" +
        formatMyDatemonth(DateTime.now().toString()));
  }

  @override
  Widget build(BuildContext context) {
    late List<String> timeRanges = getTimeRanges(widget.tr);
    List<String> testr = ["select date"];
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/doctor.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.green.withOpacity(0.9),
                  Colors.green.withOpacity(0),
                  Colors.green.withOpacity(0),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ]),
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    color: Colors.green.shade200,
                                    icon: const Icon(Icons.arrow_back)),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ]),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    // _firestore.collection('chat').add({
                                    //   "sender": userdata.read('email'),
                                    // });
                                    Get.off(home_page());
                                    // _firestore.collection('chat').add({
                                    //   "sender": "nader@hotmail.com",
                                    //   "receiver": "djkjdjjdf"
                                    // });
                                  },
                                  color: Colors.green.shade200,
                                  icon: const Icon(Icons.message)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. " + widget.doctorName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Maiores culpa aliquid iusto voluptatibus inventore cum reprehenderit, adipisci vitae ut architecto alias dicta saepe repellat impedit aspernatur vero ratione voluptate incidunt.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.6)),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text("Book Date",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black.withOpacity(0.6))),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 72,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          DateTime tomorrows = today.add(Duration(days: index));
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex =
                                    index; // Update the selected index on tap

                                selectedDate =
                                    tomorrows.toString().split(" ")[0];
                                for (var i = 0; i < timeRanges.length; i++) {
                                  for (var j = 0; j < getss.length; j++) {
                                    if (selectedDate ==
                                        getss[j]["date"].split(" ")[0]) {
                                      if (selectedtime ==
                                          getss[i]["date"].split(" ")[1]) {
                                        timeRanges.remove(timeRanges[i]);
                                        print("jdjddjjdjdjdjdjdj");
                                      }
                                    }
                                  }
                                }
                                k = true;
                                print(selectedDate);
                                for (var i in timeRanges) {
                                  print(i);
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 25),
                              decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? Colors.green.shade200
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        spreadRadius: 2)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatMyDateday(tomorrows.toString()),
                                    style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.green.shade500
                                                .withOpacity(0.6)),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    formatMyDatemonth(tomorrows.toString()),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.green.shade500
                                                .withOpacity(0.6)),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text("Book Time",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black.withOpacity(0.6))),
                  SizedBox(
                    height: 8,
                  ),
                  k == false
                      ? Container()
                      : Container(
                          height: 72,
                          child: ListView.builder(
                            key: ValueKey(timeRanges.length),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: timeRanges
                                .length, // Set itemCount to the length of snapshot.data
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    // Update the selected index on tap
                                    selectedIndex1 = index;
                                    timers = timeRanges[index];
                                    print(timers.toString());
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 25),
                                  decoration: BoxDecoration(
                                    color: selectedIndex1 == index
                                        ? Colors.green.shade200
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 4,
                                          spreadRadius: 2),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      timeRanges[index]
                                          .toString(), // Display the time range from the data
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: selectedIndex1 == index
                                            ? Colors.white
                                            : Colors.green.shade500
                                                .withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(
                    height: 20,
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
                        String text = selectedDate! + " " + timers;

                        addApp(
                            widget.doctorName,
                            widget.doctorEmail,
                            userdata.read("email"),
                            text,
                            0,
                            userdata.read("clinicname"));
                        addpd(widget.doctorEmail.toString(),
                            userdata.read("email"), userdata.read("name"));
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Booked Successfully'),
                              content:
                                  Text('The Appointment Booked Successfully'),
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
                      },
                      child: Text(
                        "Book Appoitment",
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
      ),
    );
  }
}
