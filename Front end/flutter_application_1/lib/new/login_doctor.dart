import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/controller/authcontroller.dart';
import '../clinic/home_page_clinic.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/doctor/home_page_doctor.dart';
import 'package:flutter_application_1/new/home_page.dart';
import 'package:flutter_application_1/new/signup_doctor.dart';
import 'package:flutter_application_1/new/signup_patient.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class login_doctor extends StatefulWidget {
  const login_doctor({super.key});

  @override
  State<login_doctor> createState() => _login_doctorState();
}

class _login_doctorState extends State<login_doctor> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final userdata = GetStorage();
  late int comp = 7;
  bool showSpinner = false;
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  LoginAuth loginAuth = LoginAuth();

  Future fetchP(email) async {
    print(userdata.read("email"));
    // the API endpoint
    String url = "http://192.168.1.3:6000/getdoctor?email=" + email;
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the statfus code
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        setState(() {
          setState(() {
            comp = data[0]['status'];
            userdata.write("name", data[0]['name']);
            userdata.write("email", data[0]['email']);
            userdata.write("time_range", data[0]['time_range']);
            userdata.write("Specialization", data[0]['Specialization']);
            userdata.write("phone_num", data[0]['phone_num']);
          });
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

  Future login(email, password) async {
    var url = "http://192.168.1.3:6000/logIn/pateint";
    print("kiiiiiiiiiiiiiiiiiiiiasiaaaaaaaaaaaaaa");
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = jsonDecode(response.body);

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

  void Login_fire() async {
    // setState(() {
    //   showSpinner = true;
    // });
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email.text, password: pass.text);
      if (user != null) {
        // setState(() {
        //   showSpinner = false;
        // }
        //);
      }
    } catch (e) {
      print(e);
    }
  }

  var data;
  void Login_f() async {
    var formData = formstate.currentState;

    if (formData!.validate()) {
      fetchP(email.text);
      data = await login(email.text, pass.text);
      if (data != null) {
        userdata.write("email", email.text);
        userdata.write("isLogged", true);
        print("ccccccccoooooooooommp " + comp.toString());
        if (comp == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sorry!'),
                content: Text('You must Wait for Admin add you'),
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
        } else if (comp == 1) {
          Login_fire();
          Get.offAll(home_page_doctor());
        } else if (comp == 2) {
          Login_fire();
          Get.offAll(home_page_clinic());
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sorry!'),
                content: Text('Somethind goes wrong!!'),
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
        }

        //Get.offAll(home_page_doctor());
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => home_page()),
        // );
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.green.shade900,
              Colors.green.shade400,
              Colors.green.shade200,
            ])),
            child: Form(
              key: formstate,
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
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),
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
                                  radius: 100,
                                  backgroundImage:
                                      AssetImage("assets/images/doctor.jpg"),
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
                                      margin: EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.white),
                                          top: BorderSide(color: Colors.white),
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: email,
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
                                                            MaterialState
                                                                .focused)
                                                        ? Colors.green
                                                        : Colors.grey),
                                            prefixIcon: Icon(Icons.email),
                                            hintText: "Email",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.white),
                                          top: BorderSide(color: Colors.white),
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      child: TextFormField(
                                        obscureText:
                                            true, // this will hide the text
                                        obscuringCharacter: '*',
                                        controller: pass,
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
                                                            MaterialState
                                                                .focused)
                                                        ? Colors.green
                                                        : Colors.grey),
                                            prefixIcon: Icon(Icons.lock),
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
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
                                    Login_f();
                                  },
                                  child: Text(
                                    "Log In",
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
                              const Text(
                                'Don\'t have an account ? ',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff939393),
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const signup_doctor()))
                                },
                                child: const Text(
                                  'Sign-up',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
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
            )),
      ),
    );
  }
}
