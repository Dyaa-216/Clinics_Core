import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:stacked_notification_cards/stacked_notification_cards.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'home_page.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  final userdata = GetStorage();
  final StreamController _streamController =
      StreamController<QuerySnapshot>.broadcast();

  List<NotificationCard> _listOfNotification = [];

  Future fetchP() async {
    print("h1");
    print(userdata.read("email"));
    // the API endpoint
    String url =
        "http://192.168.1.3:6000/pNots?receiver=${userdata.read("email")}";
    // make a GET request
    var response = await http.get(Uri.parse(url));
    // check the status code
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        print(data);
        setState(() {
          for (var message in data) {
            _listOfNotification.add(
              NotificationCard(
                date: DateTime.parse(message['time']),
                title: "From Dr. " + message['sname'],
                subtitle: message['content'],
                leading: const Icon(
                  Icons.account_circle,
                  size: 48,
                ),
              ),
            );
          }
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
    fetchP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        shadowColor: Colors.green,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("PATIENT NOTIFICATION", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(home_page());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            StackedNotificationCards(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 2.0,
                )
              ],
              notificationCardTitle: 'Notification',
              notificationCards: [..._listOfNotification],
              cardColor: Colors.green.shade100, //0xFFF1F1F1
              padding: 16,
              actionTitle: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              showLessAction: Text(
                'Show less',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade200,
                ),
              ),
              onTapClearAll: () {
                setState(() {
                  _listOfNotification.clear();
                });
              },
              clearAllNotificationsAction: Icon(Icons.close),
              clearAllStacked: Text('Clear All'),
              cardClearButton: Text(
                'clear',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              cardViewButton:
                  Text('view', style: TextStyle(fontWeight: FontWeight.bold)),
              onTapClearCallback: (index) {
                setState(() {
                  _listOfNotification.removeAt(index);
                });
              },
              onTapViewCallback: (index) {},
            ),
          ],
        ),
      ),
    );
  }
}
