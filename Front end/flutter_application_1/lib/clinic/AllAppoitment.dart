import 'dart:convert';
import 'package:flutter_application_1/clinic/AddDoctor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/clinic/home_page_clinic.dart';
import 'package:flutter_application_1/new/Profile.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AllAppoitment extends StatefulWidget {
  const AllAppoitment({Key? key}) : super(key: key);

  @override
  State<AllAppoitment> createState() => _AllAppoitmentState();
}

class _AllAppoitmentState extends State<AllAppoitment> {
  bool isObscurePassword = true;
  Future fetchdocss() async {
    String url = "http://192.168.1.3:6000/getAppe?cl_email=" + "Top Clinic";

    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var dataList = json.decode(response.body);

        return dataList;
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime.shade300,
          shadowColor: Colors.lime.shade300,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          title: Text("All Clinic Appointments", textScaleFactor: 1.25),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAll(home_page_clinic());
              },
              icon: const Icon(LineAwesomeIcons.angle_left)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add), // Replace with desired icon
              onPressed: () {
                // Add your onPressed code here
                Get.offAll(AddDoctor());
              },
            ),
            // Add more IconButton widgets here if needed
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              FutureBuilder<dynamic>(
                future: fetchdocss(), // Replace with your async data source
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display loading indicator while waiting for the data
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle the error case
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    // If the Future is complete and has data, display the Container
                    return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 2)
                            ]),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var clinic = snapshot.data[index];
                              String s = clinic["doc_name"].toString();
                              return Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            clinic["cl_name"].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(s),
                                          trailing: Container(
                                            width: 80,
                                            height: 50,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12),
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                          leading: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                                "assets/images/patient.jpg"),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Divider(
                                            thickness: 1,
                                            height: 20,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.black54,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  clinic["date"]
                                                      .toString()
                                                      .split(" ")[0],
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time_filled,
                                                  color: Colors.black54,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  clinic["date"]
                                                      .toString()
                                                      .split(" ")[1],
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }));
                  } else {
                    // Handle the case when there's no data
                    return Text('No data available');
                  }
                },
              )
            ],
          ),
        ));
  }
}
