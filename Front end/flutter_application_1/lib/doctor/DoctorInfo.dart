import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
const String tProfileImage='assets/images/doctor.jpg';
const String tProfileHeading='Zaid Sad Al Deen';
const String tProfileSubHeading='Zaid@gmail.com';
class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  //  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade400,
        shadowColor:Colors.green ,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title:Text("DOCTOR INFORMATION",textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
        
         ),
         body: 
      SingleChildScrollView(
         physics: BouncingScrollPhysics(),
        child:
      Container(
        //color: Colors.tealAccent.shade400,
        child: Padding(
          
          padding: 
        const EdgeInsets.all(20),
        child: Column(
          
          
          children: [
            
            SizedBox(height: 40,),
           CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage("assets/images/doctor.jpg"),
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

            const SizedBox(height: 10,),
             Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.tealAccent.shade400),top:BorderSide(color: Colors.tealAccent.shade400),left:BorderSide(color: Colors.tealAccent.shade400),right: BorderSide(color: Colors.tealAccent.shade400), ),
                ),
              child: ListTile(
                title: Text("Specialization"),
                subtitle: Text("Eye"),
                leading: Icon(Icons.phone ,color: Colors.tealAccent.shade400,),
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
                title: Text("Phone Number"),
                subtitle: Text("0568409621"),
                leading: Icon(Icons.phone ,color: Colors.tealAccent.shade400,),
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
                title: Text("Gender"),
                subtitle: Text("Fmale"),
                leading: Icon(Icons.transgender ,color: Colors.tealAccent.shade400,),
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
                title: Text("Password"),
                subtitle: Text("123"),
                leading: Icon(Icons.lock ,color: Colors.tealAccent.shade400,),
                tileColor: Colors.white,
              ),
            ),
            
            
            
          ],
        ),
        ),
      ),
      )
    );
  }
}