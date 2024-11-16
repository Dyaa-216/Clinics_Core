import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/Profile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditInformation extends StatefulWidget {
  const EditInformation({super.key});

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  bool isObscurePassword = true;
  String? gender;
  // Declare a form key and text controllers for each text field
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  final _SpecializationController = TextEditingController();
  final _passController = TextEditingController();
  final userdata = GetStorage();
  Map<String, dynamic>? profileData;

  // a function to fetch the profile data from the API
  Future fetchProfileData() async {
    print("h1");
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/getdoctor?email=${userdata.read("email")}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print(data);
        setState(() {
          _nameController.text = data[0]['name'];
          _phoneController.text = data[0]['phone_num'];
          _SpecializationController.text = data[0]['Specialization'];
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
    fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        shadowColor: Colors.lime.shade300,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("EDIT DOCTOR INFORMATION", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(Profile());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              buildTextField(
                  "Full Name", userdata.read("name"), false, _nameController),
              buildTextField("Email", "${userdata.read("email")}", false,
                  _emailController),
              buildTextField("Phone Number", userdata.read("phone_num"), false,
                  _phoneController),
              buildTextField("Specialization", userdata.read("Specialization"),
                  false, _phoneController),
              buildTextField("Password", "123", true, _passController),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.lime.shade300),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Edit Profile'),
                            content: Text('Yuor Profile Updated Successfully'),
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
                      "Save",
                      style: TextStyle(
                          fontSize: 15, letterSpacing: 2, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lime.shade300,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller:
            controller, // Use the text controller to get and set the text field value
        validator: (value) {
          // Add some validation logic to the text field
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
        enabled: labelText == "Email"
            ? false
            : true, // Add this line to disable the email text field
      ),
    );
  }
}
