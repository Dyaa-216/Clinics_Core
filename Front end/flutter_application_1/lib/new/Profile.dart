import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/new/ProfileMenu.dart';
import 'package:flutter_application_1/new/prescSection.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'welcome_page.dart';
import 'home_page.dart';
import 'EditInformation.dart';
import 'MyReservation.dart';

const String tProfileImage = 'assets/images/patient.jpg';
const String tProfileHeading = 'Zaid Sad Al Deen';
const String tProfileSubHeading = 'Zaid@gmail.com';
final userdata = GetStorage();
final _auth = FirebaseAuth.instance;

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        shadowColor: Colors.green,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("PATIENT PROFILE", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(home_page());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage(tProfileImage))),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(userdata.read("name"),
                  style: Theme.of(context).textTheme.headline4),
              Text(userdata.read("email"),
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              /* SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfile()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
                ),
              ),*/
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "My Reservation",
                  icon: LineAwesomeIcons.calendar,
                  onPress: () {
                    Get.offAll(MyReservation());
                  }),
              ProfileMenuWidget(
                  title: "My perscpiptions",
                  icon: LineAwesomeIcons.wallet,
                  onPress: () {
                    print(userdata.read("Nid"));
                    prisc(userdata.read("Nid"));
                  }),
              // ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () {}),
              ProfileMenuWidget(
                  title: "Edit Information",
                  icon: LineAwesomeIcons.user_edit,
                  onPress: () {
                    Get.offAll(EditInformation());
                  }),
              ProfileMenuWidget(
                  title: "More Information",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    _auth.signOut();
                    userdata.write("isLogged", false);
                    userdata.remove("email");
                    Get.offAll(welcome_page());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
