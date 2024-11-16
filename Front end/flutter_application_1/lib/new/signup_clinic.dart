import 'dart:convert';
import 'package:flutter_application_1/controller/authcontroller.dart';
import 'package:flutter_application_1/new/login_doctor.dart';
import 'package:flutter_application_1/new/welcome_page.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class signup_clinic extends StatefulWidget {
  const signup_clinic({super.key});

  @override
  State<signup_clinic> createState() => _signup_clinicState();
}

class _signup_clinicState extends State<signup_clinic> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? city;
  late String? addmind = "";
  List<String> _listOfdocs = [];
  List wholeList = [];

  String? spec;

  TextEditingController nid = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController conpass = TextEditingController();
  TextEditingController phonenum = TextEditingController();
  TextEditingController street = TextEditingController();

  List<String> getTimeRanges(String timeRange) {
    List<String> result = [];

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

  Future updoc(email, timerange) async {
    var url = "http://192.168.1.3:6000/updateDoc2";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email, "time_range": timerange}),
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

  Future fetchdoc() async {
    // the API endpoint
    String url = "http://192.168.1.3:6000/getdoctor?email=sss@hotmail.com";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the statfus code
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        setState(() {});
      } catch (e) {
        // handle the error
        print("Failed to decode JSON: $e");
      }
    } else {
      // handle the error
      print("Failed to fetch profile data");
    }
  }

  Future fetchP() async {
    // the API endpoint
    String url = "http://192.168.1.3:6000/getdocAdds";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print(data);
        setState(() {
          for (var message in data) {
            wholeList.add({'name': message['name'], 'email': message['email']});
            _listOfdocs.add(message['name']);
          }
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

  Future<void> _selectEndTime(BuildContext context) async {
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
    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchP();
  }

  final fs = GlobalKey<FormState>();
  LoginAuth noginAuth = LoginAuth();
  var data;
  void sinup_f(timeRange) async {
    var addemail =
        wholeList.where((element) => element['name'] == addmind).first;
    var formData = fs.currentState;
    var addemaill = addemail['email'];
    addSlot(addemaill, addemaill, timeRange);

    print(formData);
    String address = "";
    address = city! + " " + street.text;
    if (formData!.validate()) {
      data = await noginAuth.signUp_Clinic(pass.text, name.text, phonenum.text,
          address, timeRange.toString(), spec, addemaill);

      updoc(addemaill, timeRange.toString());
      Navigator.push(
        context, // This is the BuildContext
        MaterialPageRoute(
            builder: (context) =>
                welcome_page()), // This creates a route to login_patient
      );

      if (data != null) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => home_page()),
        // );
      }
    } else {
      print("sdfafadfaf flfkfkfkfkfkfkks");
    }
  }

  Future addSlot(email, email2, range) async {
    var url = "http://192.168.1.3:6000/addcldoc";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(
            {"cl_email": email, "doc_email": email2, "time_range": range}),
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
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.green.shade900,
            Colors.green.shade400,
            Colors.green.shade200,
          ])),
          child: Form(
            key: fs,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // #login, #welcome
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign UP",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                //const SizedBox(height: 20),

                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            //const SizedBox(height: 20,),
                            // #email, #password
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    AssetImage("assets/images/clinic.jpg"),
                              ),
                            ),
                            Container(
                              /*decoration: BoxDecoration(
                            
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const[
                              BoxShadow(
                                color: Color.fromRGBO(171, 171, 171, .7),blurRadius: 20,offset: Offset(0,10)),
                            ],
                          ),
*/

                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    //padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white),
                                        top: BorderSide(color: Colors.white),
                                        left: BorderSide(color: Colors.white),
                                        right: BorderSide(color: Colors.white),
                                      ),
                                    ),

                                    child: TextFormField(
                                      controller: name,
                                      decoration: InputDecoration(
                                          enabled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade200,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 3)),
                                          prefixIconColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => states.contains(
                                                          MaterialState.focused)
                                                      ? Colors.green
                                                      : Colors.grey),
                                          prefixIcon: Icon(Icons.person),
                                          hintText: "Name of clinic",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    padding: EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration.collapsed(
                                          hintText: 'Select Admin Doctor'),
                                      items: _listOfdocs
                                          .map((String value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        addmind = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                      color: Colors.white,
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon:
                                            Icon(Icons.keyboard_option_key),
                                        prefixIconColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => states.contains(
                                                        MaterialState.focused)
                                                    ? Colors.green
                                                    : Colors.grey),
                                        hintText: "Select Specialization",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                      items: <String>[
                                        'General',
                                        'Dentistry',
                                        'Orthopaedic',
                                        'Eye',
                                        'Pediatrics',
                                        'Internal',
                                        'Dermatology'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        // Handle change
                                        spec = newValue;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    //padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white),
                                        top: BorderSide(color: Colors.white),
                                        left: BorderSide(color: Colors.white),
                                        right: BorderSide(color: Colors.white),
                                      ),
                                    ),

                                    child: TextFormField(
                                      controller: phonenum,
                                      decoration: InputDecoration(
                                          enabled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade200,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 3)),
                                          prefixIconColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => states.contains(
                                                          MaterialState.focused)
                                                      ? Colors.green
                                                      : Colors.grey),
                                          prefixIcon: Icon(Icons.phone),
                                          hintText: "Phone Number",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  /* Container(
                                margin: EdgeInsets.all(5),
                               // padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:Border(bottom:BorderSide(color: Colors.white),top:BorderSide(color: Colors.white),left:BorderSide(color: Colors.white),right: BorderSide(color: Colors.white), ),),
                               
                                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration.collapsed(hintText: 'Select Patient'),
                    items: ['Option 1', 'Option 2', 'Option 3']
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (String? value) {},
                  ),
                              ),*/
                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    padding: EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration.collapsed(
                                          hintText: 'Select City',
                                          hintStyle:
                                              TextStyle(color: Colors.grey)),
                                      items: [
                                        'Nablus ',
                                        'Hebron',
                                        'Ramallah',
                                        'Jenin ',
                                        'Jerusalem',
                                        'Yafa',
                                        'Gaza ',
                                        'Haifa',
                                        'Jereco'
                                      ]
                                          .map((String value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        city = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    // padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white),
                                        top: BorderSide(color: Colors.white),
                                        left: BorderSide(color: Colors.white),
                                        right: BorderSide(color: Colors.white),
                                      ),
                                    ),

                                    child: TextFormField(
                                      controller: street,
                                      decoration: InputDecoration(
                                          enabled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade200,
                                              )),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 3)),
                                          prefixIconColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => states.contains(
                                                          MaterialState.focused)
                                                      ? Colors.green
                                                      : Colors.grey),
                                          prefixIcon: Icon(Icons.location_city),
                                          hintText: "Street",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  _selectStartTime(context),
                                              child: Text('Select Start Time'),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green[400],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  )),
                                            ),
                                            SizedBox(width: 50),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  _selectEndTime(context),
                                              child: Text('Select End Time'),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green[400],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                            'Selected Time Range: ${startTime != null ? DateFormat.Hm().format(DateTime(2022, 1, 1, startTime!.hour, startTime!.minute)) : 'Not selected'} - ${endTime != null ? DateFormat.Hm().format(DateTime(2022, 1, 1, endTime!.hour, endTime!.minute)) : 'Not selected'}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            // #login
                            Container(
                              height: 60,
                              width: 350,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green[400]),
                              child: ElevatedButton(
                                onPressed: () {
                                  String timeRange = DateFormat.Hm().format(
                                          DateTime(2022, 1, 1, startTime!.hour,
                                              startTime!.minute)) +
                                      "-" +
                                      DateFormat.Hm().format(DateTime(2022, 1,
                                          1, endTime!.hour, endTime!.minute));

                                  sinup_f(timeRange);
                                },
                                child: Text(
                                  "Sign UP",
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
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
