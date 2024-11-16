import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/home_page_clinic.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ClinicSpecialties extends StatefulWidget {
  const ClinicSpecialties({Key? key}) : super(key: key);

  @override
  State<ClinicSpecialties> createState() => _ClinicSpecialtiesState();
}

class _ClinicSpecialtiesState extends State<ClinicSpecialties> {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        shadowColor: Colors.lime.shade300,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("All Specialization", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(home_page_clinic());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12, blurRadius: 4, spreadRadius: 2)
                    ]),
                child: InkWell(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,
                              color: Colors.lime.shade300, size: 35),
                          Text(
                            "Add a Specialty",
                            style: TextStyle(
                                color: Colors.lime.shade300,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                )),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Eye Clinic",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage("assets/images/eye.jpg"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Remove",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Heart Clinic",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage("assets/images/heart.jpg"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Remove",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
