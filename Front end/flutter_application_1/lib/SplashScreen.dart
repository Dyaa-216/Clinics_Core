import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/Admin_Page.dart';
import 'package:flutter_application_1/clinic/AddDoctor.dart';
import 'package:flutter_application_1/clinic/AllAppoitment.dart';
import 'package:flutter_application_1/clinic/AllDoctor.dart';
import 'package:flutter_application_1/clinic/ChatHomeClinic.dart';
import 'package:flutter_application_1/clinic/ClinicInfo.dart';
import 'package:flutter_application_1/clinic/ClinicSpecialties.dart';
import 'package:flutter_application_1/clinic/DoctorPage.dart';
import 'package:flutter_application_1/clinic/PatientPage.dart';
import 'package:flutter_application_1/clinic/SpecificAppoitment.dart';
import 'package:flutter_application_1/clinic/home_page_clinic.dart';
import 'package:flutter_application_1/clinic/notification.dart';
import 'package:flutter_application_1/doctor/PreviousAppoitment.dart';
import 'package:flutter_application_1/doctor/UploadPrescription.dart';
import 'package:flutter_application_1/doctor/home_page_doctor.dart';
import 'package:flutter_application_1/new/Chat.dart';
import 'package:flutter_application_1/new/home_page.dart';
import 'package:flutter_application_1/new/login_patient.dart';
import 'package:flutter_application_1/new/signup_doctor.dart';
import 'package:flutter_application_1/new/signup_patient.dart';
import 'package:flutter_application_1/new/signup_clinic.dart';
import 'package:flutter_application_1/new/welcome_page.dart';
import './new/chatbot.dart';
import './new/HomePreClinic.dart';
import './clinic/calender.dart';
import './new/HomeClinic.dart';
import './new/ProfileMenu.dart';
import './new/Profile.dart';
import './new/EditInformation.dart';
import './new/AppoitmentScreen.dart';
import './clinic/AddAppoitment.dart';
//import 'package:flutter_application_1/new/signup_patient.dart';
import './new/ChatHome.dart';
import 'clinic/MyReservation.dart';
import "new/notification.dart";

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  String url =
      "https://images.unsplash.com/photo-1614517453351-6c1522fc7a56?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ClinicSpecialties(),
        ));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Image.asset(
              "assets/images/intro1.jpeg",
            )),
          ],
        ),
      ),
    );
  }
}
