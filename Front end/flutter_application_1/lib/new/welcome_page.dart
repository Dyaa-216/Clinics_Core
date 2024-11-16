import 'package:flutter_application_1/new/prescription.dart';

import 'login_doctor.dart';
import 'signup_clinic.dart';
import 'login_patient.dart';
import 'package:flutter/material.dart';

class welcome_page extends StatefulWidget {
  const welcome_page({super.key});

  @override
  State<welcome_page> createState() => _welcome_pageState();
}

class _welcome_pageState extends State<welcome_page> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // #login, #welcome
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Clinic core!",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Your health is our priority",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // #email, #password
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CircleAvatar(
                            radius: 120,
                            backgroundImage:
                                AssetImage("assets/images/intro1.jpeg"),
                          ),
                        ),

                        const SizedBox(height: 30),
                        Text(
                          "Are you?",
                          style: TextStyle(
                              color: Colors.green.shade900, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        // #login
                        Container(
                          height: 60,
                          width: 350,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[400]),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login_patient()),
                              );
                            },
                            child: Text(
                              "Patient",
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
                        Container(
                          height: 60,
                          width: 350,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[400]),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login_doctor()),
                              );
                            },
                            child: Text(
                              "Doctor",
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
                        Container(
                          height: 60,
                          width: 350,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[400]),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup_clinic()),
                              );
                            },
                            child: Text(
                              "Clinic",
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
                        Container(
                          height: 60,
                          width: 350,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[400]),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Prescription()),
                              );
                            },
                            child: Text(
                              "Pharmacy & Other",
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
