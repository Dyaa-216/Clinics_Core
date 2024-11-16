import 'dart:convert';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controller/profilef.dart';
import '../controller/authcontroller.dart';
import 'package:get_storage/get_storage.dart';

class UserProfile {
  final String email;
  final String username;
  final String phone;
  final String age;
  final String weight;
  final String gender;

  // Add other profile properties as needed

  UserProfile(
      {required this.email,
      required this.username,
      required this.phone,
      required this.age,
      required this.weight,
      required this.gender});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        email: json['email'],
        username: json['username'],
        phone: json['phone'],
        age: json['age'],
        weight: json['weight'],
        gender: json['gender']);
  }
}

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
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final userdata = GetStorage();
  LoginAuth noginAuth = LoginAuth();
  Map<String, dynamic>? profileData;

  // a function to fetch the profile data from the API
  Future fetchProfileData() async {
    print("h1");
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/pateintProfile?email=${userdata.read("email")}";
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
          _ageController.text = data[0]['age'].toString();
          _weightController.text = data[0]['weight'].toString();
          gender = data[0]['gender'];
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
  // var data;
  // void sinup_f() async {
  //   UserProfile user =new
  //   print(gender);
  //   var formData = _formKey.currentState;
  //   print(formData);

  //   if (formData!.validate()) {
  //     data = await noginAuth.saka(_emailController.text, _nameController.text,
  //         _phoneController.text, _ageController.text, _weightController.text, gender);
  //     if (data != null) {

  //     }
  //   } else {
  //     print("sdfafadfaf flfkfkfkfkfkfkks");
  //   }
  // }

// a function to display the profile data as widgets
  // Widget displayProfileData() {
  //   // check if the profile data is null
  //   if (profileData == null) {
  //     // return a loading indicator
  //     return Center(
  //       child: CircularProgressIndicator(),
  //     );
  //     print("hiii");
  //   } else {
  //     print(profileData!['name']);

  //     // return a column of text widgets
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("Name: ${profileData!['name']}"),
  //         Text("Email: ${profileData!['email']}"),
  //         Text("Bio: ${profileData!['bio']}"),
  //       ],
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        shadowColor: Colors.green,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("EDIT PATIENT INFORMATION", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(Profile());
              ;
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey, // Use the form key to validate and submit the form
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                buildTextField("Full Name", "Zaid", false, _nameController),
                buildTextField("Email", "${userdata.read("email")}", false,
                    _emailController),
                buildTextField(
                    "Phone Number", "0568409621", false, _phoneController),
                buildTextField("Person Id", "123456789", false, _idController),
                buildTextField("Age", "22", false, _ageController),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        'Gender :',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
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
                        style: TextStyle(fontSize: 20, color: Colors.grey),
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
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),

                      // style: TextStyle(fontSize: )
                    ],
                  ),
                ),
                buildTextField("Weight", "57", false, _weightController),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.green.shade200),
                      ),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate and submit the form
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Updated successfully'),
                            ),
                          );

                          // Do something with the form data
                          print("Form submitted");
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade200,
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
