import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const String tProfileImage = 'assets/images/patient.jpg';
const String tProfileHeading = 'Zaid Sad Al Deen';
const String tProfileSubHeading = 'Zaid@gmail.com';

Future deleteapp(id) async {
  var url = "http://192.168.1.3:6000/deleteApp?id=" + id.toString();
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
      print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
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

class MyReservation extends StatefulWidget {
  const MyReservation({Key? key})
      : super(key: key); // no need to use super keyword

  @override
  _MyReservationState createState() =>
      _MyReservationState(); // override createState method
}

class _MyReservationState extends State<MyReservation> {
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
              primary: Colors
                  .green.shade400, // Change the clock hands and text color here
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

  Future fetchdocss(emai) async {
    print("h1");
    String url = "http://192.168.1.3:6000/getAppp?pat_email=${emai}&complete=1";

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

  Future fetchdocs(emai) async {
    print("h1");
    String url = "http://192.168.1.3:6000/getAppp?pat_email=${emai}&complete=0";

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
          backgroundColor: Colors.green.shade200,
          shadowColor: Colors.green,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          title: Text("MY RESERVATION", textScaleFactor: 1.25),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAll(Profile());
              },
              icon: const Icon(LineAwesomeIcons.angle_left)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 10),
            FutureBuilder<dynamic>(
              future: fetchdocs(userdata.read("email")),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return Container(
                    height: 380,
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
                                                  "assets/images/doctor.jpg"),
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
                                                              setState(() {
                                                                deleteapp(int
                                                                    .tryParse(clinic[
                                                                            "id"]
                                                                        .toString()));
                                                              });
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
                                                onTap: () async {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PaypalCheckout(
                                                      sandboxMode: true,
                                                      clientId:
                                                          "ARn_BvxFI8yrqPWv2rV6TtGnxcQoWwN7n9I6_j2J0cCQ9ZCvQFIkgiHJXflZjmmh2uh18I8mACxpDoFS",
                                                      secretKey:
                                                          "ECj4iIi7vITtFgEBhjK8wXEP1R6GaO6e6OOB_U3KSLBkkaVJ8IMLv3N_qc9wTZQrilyXZgqWDU_mtbmI",
                                                      returnURL:
                                                          "success.snippetcoder.com",
                                                      cancelURL:
                                                          "cancel.snippetcoder.com",
                                                      transactions: const [
                                                        {
                                                          "amount": {
                                                            "total": '70',
                                                            "currency": "USD",
                                                            "details": {
                                                              "subtotal": '70',
                                                              "shipping": '0',
                                                              "shipping_discount":
                                                                  0
                                                            }
                                                          },
                                                          "description":
                                                              "The payment transaction description.",
                                                          // "payment_options": {
                                                          //   "allowed_payment_method":
                                                          //       "INSTANT_FUNDING_SOURCE"
                                                          // },
                                                          "item_list": {
                                                            "items": [
                                                              {
                                                                "name": "Apple",
                                                                "quantity": 4,
                                                                "price": '5',
                                                                "currency":
                                                                    "USD"
                                                              },
                                                              {
                                                                "name":
                                                                    "Pineapple",
                                                                "quantity": 5,
                                                                "price": '10',
                                                                "currency":
                                                                    "USD"
                                                              }
                                                            ],

                                                            // shipping address is not required though
                                                            //   "shipping_address": {
                                                            //     "recipient_name": "Raman Singh",
                                                            //     "line1": "Delhi",
                                                            //     "line2": "",
                                                            //     "city": "Delhi",
                                                            //     "country_code": "IN",
                                                            //     "postal_code": "11001",
                                                            //     "phone": "+00000000",
                                                            //     "state": "Texas"
                                                            //  },
                                                          }
                                                        }
                                                      ],
                                                      note:
                                                          "Contact us for any questions on your order.",
                                                      onSuccess:
                                                          (Map params) async {
                                                        print(
                                                            "onSuccess: $params");
                                                      },
                                                      onError: (error) {
                                                        print(
                                                            "onError: $error");
                                                        Navigator.pop(context);
                                                      },
                                                      onCancel: () {
                                                        print('cancelled:');
                                                      },
                                                    ),
                                                  ));
                                                },
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          242, 7, 30, 236),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Text(
                                                      "PayPal?",
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
                    height: 380,
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
                                                "Zaid Clinic",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(clinic["doc_name"]
                                                  .toString()),
                                              trailing: CircleAvatar(
                                                radius: 25,
                                                backgroundImage: AssetImage(
                                                    "assets/images/doctor.jpg"),
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
            )
          ]),
        ));
  }
}
