import 'package:flutter/material.dart';
import 'package:flutter_application_1/new/signup_clinic.dart';
import 'package:flutter_application_1/controller/authcontroller.dart';
import 'package:flutter_application_1/new/home_page.dart';

class login_clinic extends StatefulWidget {
  const login_clinic({super.key});

  @override
  State<login_clinic> createState() => _login_clinicState();
}

class _login_clinicState extends State<login_clinic> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  final GlobalKey<FormState> formstate = GlobalKey<FormState>();

  LoginAuth loginAuth = LoginAuth();

  var data;
  void Login_f() async {
    var formData = formstate.currentState;

    if (formData!.validate()) {
      data = await loginAuth.login(email.text, pass.text);
      if (data != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => home_page()),
        );
      }
    } else {}
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
                                    AssetImage("assets/images/patient.jpg"),
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
                                                  color: Colors.green,
                                                  width: 3)),
                                          prefixIconColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => states.contains(
                                                          MaterialState.focused)
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
                                        bottom: BorderSide(color: Colors.white),
                                        top: BorderSide(color: Colors.white),
                                        left: BorderSide(color: Colors.white),
                                        right: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    child: TextFormField(
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
                                                          MaterialState.focused)
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
                                            const signup_clinic()))
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
    );
  }
}
