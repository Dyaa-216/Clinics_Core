import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/authcontroller.dart';
import 'package:flutter_application_1/new/home_page.dart';
import 'package:flutter_application_1/new/login_patient.dart';
import 'package:flutter_application_1/new/signup_patient.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/fireMethods.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../controller/image.dart';
import 'package:http/http.dart' as http;

class signup_patient extends StatefulWidget {
  const signup_patient({super.key});

  @override
  State<signup_patient> createState() => _signup_patientState();
}

class _signup_patientState extends State<signup_patient> {
  String? gender;

  TextEditingController email = TextEditingController();
  TextEditingController nid = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController conpass = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phonenum = TextEditingController();
  TextEditingController weight = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final fs = GlobalKey<FormState>();

  LoginAuth noginAuth = LoginAuth();

  var data;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  Future pickimage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = XFile(img!.path);
    });
    Uploadimg(img: image!.path).uploadimage();
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green.shade400)),
                    onPressed: () {
                      Navigator.pop(context);
                      pickimage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green.shade400)),
                    onPressed: () {
                      Navigator.pop(context);
                      pickimage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void sinup_fire() async {
    String? ttoken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $ttoken");
    var formData = fs.currentState;
    if (formData!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: pass.text,
        );
        _firestore.collection("patient").doc(credential.user!.uid).set({
          "email": email.text,
          "password": pass.text,
          "name": name.text,
          "token": ttoken
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future addui(Imagename, patemail) async {
    var url = "http://192.168.1.3:6001/inert";

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": patemail, "image": Imagename}),
      );

      if (response.statusCode == 200) {
        // Successful response, you can process the response here.
        var responseData = jsonDecode(response.body);
        print(responseData);
      } else if (response.statusCode == 401) {
        // Unauthorized response, "Log in failed" scenario.
        print("inserted failed");
      } else {
        // Handle other status codes as needed.
        print("Unexpected status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void sinup_f() async {
    print(gender);
    var formData = fs.currentState;
    print(formData);

    if (formData!.validate()) {
      data = await noginAuth.signUp_Patinet(email.text, name.text, nid.text,
          pass.text, phonenum.text, age.text, weight.text, gender);

      sinup_fire();
      addui(image?.name, email.text);
      Navigator.push(
        context, // This is the BuildContext
        MaterialPageRoute(
            builder: (context) =>
                login_patient()), // This creates a route to login_patient
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
                        image != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(400),
                                  child: Image.file(
                                    //to show image, you type like this.
                                    File(image!.path),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      AssetImage("assets/images/patient.jpg"),
                                ),
                              ),
                        Container(
                          height: 30,
                          width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[400]),
                          child: ElevatedButton(
                            onPressed: () {
                              myAlert();
                            },
                            child: Text(
                              "Upload Image Profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[400],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                )),
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
                                              color: Colors.green, width: 3)),
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.green
                                                  : Colors.grey),
                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Name of Patient",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
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
                                  controller: nid,
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
                                              color: Colors.green, width: 3)),
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.green
                                                  : Colors.grey),
                                      prefixIcon: Icon(Icons.flag),
                                      hintText: "Ntional ID",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
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
                                              color: Colors.green, width: 3)),
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.green
                                                  : Colors.grey),
                                      prefixIcon: Icon(Icons.email),
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
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
                                  obscureText: true, // this will hide the text
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
                                              color: Colors.green, width: 3)),
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.green
                                                  : Colors.grey),
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
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
                                  obscureText: true, // this will hide the text
                                  obscuringCharacter: '*',
                                  controller: conpass,
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
                                              color: Colors.green, width: 3)),
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.green
                                                  : Colors.grey),
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
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
                                              color: Colors.green, width: 3)),
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.green
                                                  : Colors.grey),
                                      prefixIcon: Icon(Icons.phone),
                                      hintText: "Phone Number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
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
                                  controller: age,
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
                                              color: Colors.green, width: 3)),
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.green
                                                  : Colors.grey),
                                      prefixIcon: Icon(Icons.date_range),
                                      hintText: "Age in Year",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
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
                                  controller: weight,
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
                                              color: Colors.green, width: 3)),
                                      prefixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.green
                                                  : Colors.grey),
                                      prefixIcon: Icon(Icons.scale),
                                      hintText: "Weight in Kg",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Padding(padding: EdgeInsets.all(5)),
                                    Text(
                                      'Gender :',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                    Radio(
                                        activeColor: Colors.green,
                                        value: 'male',
                                        groupValue: gender,
                                        onChanged: (val) {
                                          setState(() {
                                            gender = val;
                                          });
                                        }),

                                    Text(
                                      'Male',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),

                                    Radio(
                                        activeColor: Colors.green,
                                        value: 'female',
                                        groupValue: gender,
                                        onChanged: (val) {
                                          setState(() {
                                            gender = val;
                                          });
                                        }),

                                    Text(
                                      'Female',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),

                                    // style: TextStyle(fontSize: )
                                  ],
                                ),
                              ),
                            ],
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
                              //sinup_f();
                              sinup_f();
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
                        // #login
                        /* Container(
                          height: 60,
                          
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[400]
                          ),
                          child: const Center(
                            child: Text("Sign UP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                          ),
                        ),*/
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
