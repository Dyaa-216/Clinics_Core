import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class Admin_Page extends StatefulWidget {
  @override
  _Admin_PageState createState() => _Admin_PageState();
}

class _Admin_PageState extends State<Admin_Page>
    with SingleTickerProviderStateMixin {
  final colors = <Color>[Colors.indigo, Colors.blue, Colors.orange, Colors.red];

  double _size = 250.0;

  bool _large = true;
  Future fetchdocss() async {
    print("h1");
    String url = "http://localhost:6000/getAllclinics";

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

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 0.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedSize(
              curve: Curves.easeIn,
              duration: Duration(seconds: 1),
              child: LeftDrawer(
                size: _size,
                key: null,
              )),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.black87),
                          onPressed: () {
                            _updateSize();
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'Dashboard',
                            style: TextStyle(
                                color: Colors.black87,
                                backgroundColor: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/doctor.jpg"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            'Admin / Home',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                color: Color(0xFFE7E7E7),
                                child: Card(
                                  color: Color(0xFFE7E7E7),
                                  child: Container(
                                    color: Colors.lime.shade300,
                                    width: 250,
                                    height: 140,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              '1.1K',
                                              style: TextStyle(fontSize: 24),
                                            )),
                                            Icon(Icons.more_vert),
                                          ],
                                        ),
                                        Text('Clinics')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                color: Color(0xFFE7E7E7),
                                child: Card(
                                  color: Color(0xFFE7E7E7),
                                  child: Container(
                                    color: Colors.tealAccent.shade400,
                                    width: 250,
                                    height: 140,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              '2.4K',
                                              style: TextStyle(fontSize: 24),
                                            )),
                                            Icon(Icons.more_vert),
                                          ],
                                        ),
                                        Text('Doctors')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                color: Color(0xFFE7E7E7),
                                child: Card(
                                  color: Color(0xFFE7E7E7),
                                  child: Container(
                                    color: Colors.green.shade200,
                                    width: 250,
                                    height: 140,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              '9.4K',
                                              style: TextStyle(fontSize: 24),
                                            )),
                                            Icon(Icons.more_vert),
                                          ],
                                        ),
                                        Text('Patient')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.all(16),
                                height: 350,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color: Colors.lime.shade300, width: 4),
                                ),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: Colors.lime.shade300,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5, top: 5),
                                                  child: Text(
                                                    "All Clinics",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4,
                                                    spreadRadius: 2)
                                              ]),
                                          child: InkWell(
                                            child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 50,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.search,
                                                        color: Colors
                                                            .lime.shade300,
                                                        size: 35),
                                                    Text(
                                                      "Search Clinic",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .lime.shade300,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      FutureBuilder<dynamic>(
                                        future: fetchdocss(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'));
                                          } else if (!snapshot.hasData ||
                                              snapshot.data.isEmpty) {
                                            return Center(
                                                child:
                                                    Text('No data available'));
                                          } else {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 4),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4,
                                                    spreadRadius: 2,
                                                  )
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: Column(
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            "Ahmad Clinic",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          subtitle: Text(
                                                              "5 Doctors\n3.4k Visits "),
                                                          leading: CircleAvatar(
                                                            radius: 25,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    "assets/images/Clinic.jpg"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80,
                                                    height: 50,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12),
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Remove",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  margin: const EdgeInsets.all(16),
                                  height: 350,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        color: Colors.tealAccent.shade400,
                                        width: 4),
                                  ),
                                  child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(children: [
                                        Container(
                                          width: double.infinity,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.tealAccent.shade400,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, top: 5),
                                                child: Text(
                                                  "All Doctors",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        "Dr.Ahmad",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "Eye Clinic \n3.4k Visits "),
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/doctor.jpg"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        "Dr.Ahmad",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "Eye Clinic \n3.4k Visits "),
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/doctor.jpg"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        "Dr.Ahmad",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle: Text(
                                                          "Eye Clinic \n3.4k Visits "),
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/doctor.jpg"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]))),
                              SizedBox(height: 10),
                              Container(
                                  margin: const EdgeInsets.all(16),
                                  height: 350,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        color: Colors.green.shade200, width: 4),
                                  ),
                                  child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(children: [
                                        Container(
                                          width: double.infinity,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade200,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, top: 5),
                                                child: Text(
                                                  "All Patients",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        "Ahmad ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle:
                                                          Text("3.4k Visits "),
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/patient.jpg"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        "Ahmad ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle:
                                                          Text("3.4k Visits "),
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/patient.jpg"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                spreadRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        "Ahmad ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      subtitle:
                                                          Text("3.4k Visits "),
                                                      leading: CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/patient.jpg"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ])))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: size,
        color: Colors.green,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              color: Colors.green.shade700,
              child: Text(
                'Clinic Core',
                style: TextStyle(color: Colors.white),
              ),
            ),
            _tile('Home'),
            Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(top: 30),
                child: Text('Application sections',
                    style: TextStyle(
                      color: Colors.black,
                    ))),
            _tile('Clinic'),
            _tile('Doctor'),
            _tile('Patient'),
          ],
        ),
      ),
    );
  }

  Widget _tile(String label) {
    return ListTile(
      title: Text(label, style: TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }
}
