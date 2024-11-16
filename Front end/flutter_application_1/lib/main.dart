import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:firebase_core/firebase_core.dart';
import './controller/notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import './controller/fireMethods.dart';
//import 'package:flutter_application_1/first_ui.dart';
//import 'package:flutter_application_1/insta/face.dart';
//import 'package:flutter_application_1/insta/insta.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     home: SplashScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
void main() async {
  Get.testMode = true;
  // Ensure that Flutter widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await GetStorage.init();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyAoeJ8pL4GS_CQQ6aor0bepfr-teFEuDGk",
            appId: "1:639348745100:android:77e8a460d816864fd1eca9",
            messagingSenderId: "639348745100",
            projectId: "clinics-chat",
          ),
        )
      : await Firebase.initializeApp();
  await FirebaseApi().initNot();
  FirebaseMessaging.instance.getInitialMessage();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  FirebaseMessaging.onMessage.listen((message) {
    print(message.notification?.body);
    print(message.notification?.title);
  });
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // analytics.logEvent(
  //   name: 'test_event',
  //   parameters: {'string': 'string', 'int': 42, 'bool': true},
  // );

  // Run the app
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }

}
class screen extends StatefulWidget {
  Function fun;
  screen(this.fun);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}
class MyAppState extends State<MyApp>{
  bool isdark=false;
  changeTheme(bool value){
    isdark=value;
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
    theme:isdark?ThemeData.dark():ThemeData.light(),
    home: screen(changeTheme));
  }
}*/
class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Text('data'),

      // Future.delayed( Duration(seconds: 5), (){
      // });
    );
  }
}
