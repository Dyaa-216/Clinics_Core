import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/Profile.dart';
import 'package:get/get.dart';

const String tProfileImage = 'assets/images/doctor.jpg';
const String tProfileHeading = 'Zaid Sad Al Deen';
const String tProfileSubHeading = 'Zaid@gmail.com';

class MyReservation extends StatelessWidget {
  const MyReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime.shade300,
          shadowColor: Colors.lime,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          title: Text("MY RESERVATION", textScaleFactor: 1.25),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 150.0),
              Container(
                height: 60,
                width: 370,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.lime.shade300),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Current Reservation",
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
              SizedBox(height: 32.0),
              Container(
                height: 60,
                width: 370,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.lime.shade300),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Previous Reservation",
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
              SizedBox(height: 32.0),
              Container(
                height: 60,
                width: 370,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.lime.shade300),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "UnRecorded Reservation",
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
              SizedBox(height: 80.0),
              Container(
                height: 60,
                width: 370,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.lime.shade300),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.offAll(Profile());
                  },
                  label: Text(
                    "Go Back",
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
        ));
  }
}
