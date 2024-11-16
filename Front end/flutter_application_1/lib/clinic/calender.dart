import 'dart:convert';
import 'package:flutter_application_1/clinic/Profile.dart';
import 'package:flutter_application_1/clinic/ProfileMenu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'Profile.dart';

class calender extends StatefulWidget {
  const calender({super.key});

  @override
  _calenderState createState() => _calenderState();
}

class _calenderState extends State<calender> {
  final userdata = GetStorage();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> _listOfNotification = [];
  List wholeList = [];
  late String? patName = "";
  TimeOfDay addMinutes(TimeOfDay time, int minutes) {
    int totalMinutes = time.hour * 60 + time.minute + minutes;
    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;

    // Handle the case where the new hour is more than 23
    newHour = newHour % 24;

    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  Future fetchP() async {
    print("h1");
    print(userdata.read("email"));
    // the API endpoint
    String url = "http://192.168.1.3:6000/getAllpatients";
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
            wholeList.add(
                {'name': message['pat_name'], 'email': message['pat_email']});
            _listOfNotification.add(message['pat_name']);
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

  @override
  void initState() {
    super.initState();

    fetchP();
  }

  Future addApp(sender, receiver, name, sname, rname) async {
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        if (child == null) {
          // Handle the null case or provide a default widget
          return CircularProgressIndicator();
        }
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.lime.shade300, // Your desired color

            colorScheme: ColorScheme.light(
                primary: Colors.lime.shade300), // Your desired color
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // etc.
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.lime.shade300, // Your desired color
            // Your desired color
            colorScheme: ColorScheme.light(
                primary: Colors.lime.shade300), // Your desired color
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            // etc.
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        shadowColor: Colors.lime,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("ADD APPOITMENT ", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(Profile());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Date: ${selectedDate.toString().split(" ")[0]}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Time: ${selectedTime.format(context)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: 350,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.lime.shade300),
              child: ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  "Select Date",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lime.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: 350,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.lime.shade300),
              child: ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  "Select Time",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lime.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lime.shade300),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: DropdownButtonFormField<String>(
                decoration:
                    InputDecoration.collapsed(hintText: 'Select Patinet'),
                items: _listOfNotification
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (String? value) {},
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lime.shade300),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: DropdownButtonFormField<String>(
                decoration:
                    InputDecoration.collapsed(hintText: 'Select Doctor'),
                items: ['Option 1', 'Option 2', 'Option 3']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (String? value) {},
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: 350,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.lime.shade300),
              child: ElevatedButton(
                onPressed: () {
                  TimeOfDay newTime = addMinutes(selectedTime, 15);
                  String dates = selectedDate.toString() +
                      " " +
                      selectedTime.toString() +
                      "-" +
                      newTime.toString();
                  print(dates);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lime.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}//onPressed: () => _selectTime(context),