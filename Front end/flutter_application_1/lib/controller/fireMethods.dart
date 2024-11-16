import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseApi {
  final _fire = FirebaseMessaging.instance;

  Future<void> initNot() async {
    try {
      await _fire.requestPermission();

      final fcmToken = await _fire.getToken();

      if (fcmToken != null) {
        print("FCM Token: " + fcmToken);
      } else {
        print("FCM Token is null");
      }
    } catch (e) {
      print("Error fetching FCM token: $e");
    }
  }
}
