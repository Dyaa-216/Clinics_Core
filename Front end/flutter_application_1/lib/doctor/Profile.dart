import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/doctor/MyReservation.dart';
import 'package:flutter_application_1/doctor/PreviousAppoitment.dart';
import 'package:flutter_application_1/doctor/ProfileMenu.dart';
import 'package:flutter_application_1/doctor/calender.dart';
import 'package:flutter_application_1/new/EditInformation.dart';
import 'package:flutter_application_1/doctor/home_page_doctor.dart';
import 'package:flutter_application_1/new/welcome_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'MyReservation.dart';
import 'EditInformation.dart' as doctor;

const String tProfileImage = 'assets/images/patient.jpg';
const String tProfileHeading = 'Zaid Sad Al Deen';
const String tProfileSubHeading = 'Zaid@gmail.com';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userdata = GetStorage();
    final _auth = FirebaseAuth.instance;

    //  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade400,
        shadowColor: Colors.tealAccent,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title: Text("DOCTOR PROFILE", textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(home_page_doctor());
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
              Text("Dr. " + userdata.read("name"),
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
              // ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () {}),
              ProfileMenuWidget(
                  title: "Add Appointment",
                  icon: LineAwesomeIcons.info,
                  onPress: () {
                    Get.offAll(calender());
                  }),
              ProfileMenuWidget(
                  title: "Edit Information",
                  icon: LineAwesomeIcons.user_edit,
                  onPress: () {
                    Get.offAll(doctor.EditInformation());
                  }),

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
      /*
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade400,
        leading: IconButton(onPressed: (){}, icon: Icon( Icons.arrow_left,size: 40,)),
        shadowColor:Colors.green ,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title:Text("PATIENT PROFILE",textScaleFactor: 1.25),
        centerTitle: true,
      ),
      body: 
      
      Container(
        //color: Colors.tealAccent.shade400,
        child: Padding(
          
          padding: 
        const EdgeInsets.all(20),
        child: Column(
          
          children: [
            const SizedBox(height: 40,),
            CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage("assets/images/patient.jpg"),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.tealAccent.shade400),top:BorderSide(color: Colors.tealAccent.shade400),left:BorderSide(color: Colors.tealAccent.shade400),right: BorderSide(color: Colors.tealAccent.shade400), ),
                ),
              child: ListTile(
                title: Text("Name"),
                subtitle: Text("Zaid Sad"),
                leading: Icon(Icons.person ,color: Colors.tealAccent.shade400,),
                tileColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.tealAccent.shade400),top:BorderSide(color: Colors.tealAccent.shade400),left:BorderSide(color: Colors.tealAccent.shade400),right: BorderSide(color: Colors.tealAccent.shade400), ),
                ),
              child: ListTile(
                title: Text("Email"),
                subtitle: Text("Zaid Sad@gmail.com"),
                leading: Icon(Icons.email ,color: Colors.tealAccent.shade400,),
                tileColor: Colors.white,
              ),
            ),
          ],
        ),
        ),
      ),
        */
