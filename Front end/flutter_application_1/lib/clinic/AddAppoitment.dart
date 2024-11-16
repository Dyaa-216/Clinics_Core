import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/Profile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddAppoitment extends StatefulWidget {
  @override
  _AddAppoitmentState createState() => _AddAppoitmentState();
}

class _AddAppoitmentState extends State<AddAppoitment> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
              'Selected Date: ${selectedDate.toLocal()}',
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
                  color: Colors.green[400]),
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
                  color: Colors.green[400]),
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
            SizedBox(height: 100),
            Container(
              height: 60,
              width: 350,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green[400]),
              child: ElevatedButton(
                onPressed: () {},
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