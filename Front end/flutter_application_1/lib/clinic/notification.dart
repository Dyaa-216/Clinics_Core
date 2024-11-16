import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:stacked_notification_cards/stacked_notification_cards.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationCard> _listOfNotification = [
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 4),
      ),
      leading:const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'text with image link',
      subtitle:
          "Hi its my testing <b>Laila</b> <b>https://www.kasandbox.org/programming-images/avatars/spunky-sam.png</b>",
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 4),
      ),
      leading:const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'image link',
      subtitle:
          "https://www.kasandbox.org/programming-images/avatars/spunky-sam.png",
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 4),
      ),
      leading:const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'text with image link',
      subtitle:
          "Hi its my testing <b>Laila</b> https://www.kasandbox.org/programming-images/avatars/spunky-sam.png",
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 10),
      ),
      leading:const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'OakTree 3',
      subtitle:
          'hi all it is nooo https://sample-videos.com/img/Sample-png-image-1mb.png</p>',
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 10),
      ),
      leading: const Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'OakTree 8',
      subtitle: 'test <b>https://en.wikipedia.org/wiki/Cat#/media/File:Cat_August_2010-4.jpg</b>',
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 30),
      ),
      leading: Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: "OakTree 4",
      subtitle: 'We believe in the power of mobile computing.We believe in the power of mobile computing.We believe in the power of mobile computing.We believe in the power of mobile computing.We believe in the power of mobile computing.We believe in the power of mobile computing.We believe in the power of mobile computing.We believe in the power of mobile computing.We believe in the power of mobile computing.We believe in the power of mobile computing.',
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 44),
      ),
      leading: Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'OakTree 5',
      subtitle: 'We believe in the power of mobile computing.\n\n\n\n\n https://upload.wikimedia.org',
    ),
    NotificationCard(
      date: DateTime.now().subtract(
        const Duration(minutes: 4),
      ),
      leading: Icon(
        Icons.account_circle,
        size: 48,
      ),
      title: 'text with image link',
      subtitle:
          "Hi its my testing <b>Laila</b> https://www.kasandbox.org/programming-images/avatars/spunky-sam.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lime.shade300,
        shadowColor: Colors.lime,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text(
          "PATIENT NOTIFICATION",
          textScaleFactor: screenWidth > 600 ? 1.5 : 1.25, // Adjust font size for larger screens
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
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
              notificationCardTitle: 'Message',
              notificationCards: [..._listOfNotification],
              cardColor: Colors.lime.shade300,
              padding: screenWidth > 600 ? 32 : 16, // Adjust padding based on screen width
              actionTitle: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: screenWidth > 600 ? 28 : 24, // Adjust font size based on screen width
                  fontWeight: FontWeight.bold,
                ),
              ),
              showLessAction: Text(
                'Show less',
                style: TextStyle(
                  fontSize: screenWidth > 600 ? 22 : 18, // Adjust font size based on screen width
                  fontWeight: FontWeight.bold,
                  color: Colors.lime.shade300,
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
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              cardViewButton: Text('view', style: TextStyle(fontWeight: FontWeight.bold)),
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
