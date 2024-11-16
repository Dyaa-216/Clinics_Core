import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> onBckgorundmessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?..body}");
  print("Payload: ${message.data}");
}

class Dnotifications {
  final _messaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _messaging.requestPermission();
    final FCMTooken = await _messaging.getToken();
    print("Token:$FCMTooken");
    FirebaseMessaging.onBackgroundMessage(onBckgorundmessage);
  }
}
