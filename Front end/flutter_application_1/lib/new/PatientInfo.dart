import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
const String tProfileImage='assets/images/patient.jpg';
const String tProfileHeading='Zaid Sad Al Deen';
const String tProfileSubHeading='Zaid@gmail.com';
class PatientInfo extends StatelessWidget {
  const PatientInfo({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  //  var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        shadowColor:Colors.green ,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title:Text("PATIENT INFORMATION",textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
        
         ),
         body: 
      SingleChildScrollView(
         physics: BouncingScrollPhysics(),
        child:
      Container(
        //color: Colors.green.shade200,
        child: Padding(
          
          padding: 
        const EdgeInsets.all(20),
        child: Column(
          
          
          children: [
            
            SizedBox(height: 40,),
           CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage("assets/images/patient.jpg"),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.green.shade200),top:BorderSide(color: Colors.green.shade200),left:BorderSide(color: Colors.green.shade200),right: BorderSide(color: Colors.green.shade200), ),
                ),
              child: ListTile(
                title: Text("Name"),
                subtitle: Text("Zaid Sad"),
                leading: Icon(Icons.person ,color: Colors.green.shade200,),
                tileColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.green.shade200),top:BorderSide(color: Colors.green.shade200),left:BorderSide(color: Colors.green.shade200),right: BorderSide(color: Colors.green.shade200), ),
                ),
              child: ListTile(
                title: Text("Email"),
                subtitle: Text("Zaid Sad@gmail.com"),
                leading: Icon(Icons.email ,color: Colors.green.shade200,),
                tileColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.green.shade200),top:BorderSide(color: Colors.green.shade200),left:BorderSide(color: Colors.green.shade200),right: BorderSide(color: Colors.green.shade200), ),
                ),
              child: ListTile(
                title: Text("Phone Number"),
                subtitle: Text("0568409621"),
                leading: Icon(Icons.phone ,color: Colors.green.shade200,),
                tileColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.green.shade200),top:BorderSide(color: Colors.green.shade200),left:BorderSide(color: Colors.green.shade200),right: BorderSide(color: Colors.green.shade200), ),
                ),
              child: ListTile(
                title: Text("Person Id"),
                subtitle: Text("123456789"),
                leading: Icon(Icons.perm_identity ,color: Colors.green.shade200,),
                tileColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.green.shade200),top:BorderSide(color: Colors.green.shade200),left:BorderSide(color: Colors.green.shade200),right: BorderSide(color: Colors.green.shade200), ),
                ),
              child: ListTile(
                title: Text("Age"),
                subtitle: Text("22"),
                leading: Icon(Icons.date_range ,color: Colors.green.shade200,),
                tileColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
             Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.green.shade200),top:BorderSide(color: Colors.green.shade200),left:BorderSide(color: Colors.green.shade200),right: BorderSide(color: Colors.green.shade200), ),
                ),
              child: ListTile(
                title: Text("Gender"),
                subtitle: Text("Fmale"),
                leading: Icon(Icons.transgender ,color: Colors.green.shade200,),
                tileColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
             Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.green.shade200),top:BorderSide(color: Colors.green.shade200),left:BorderSide(color: Colors.green.shade200),right: BorderSide(color: Colors.green.shade200), ),
                ),
              child: ListTile(
                title: Text("Weight"),
                subtitle: Text("57"),
                leading: Icon(Icons.scale ,color: Colors.green.shade200,),
                tileColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10,),
             Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border:Border(bottom:BorderSide(color: Colors.green.shade200),top:BorderSide(color: Colors.green.shade200),left:BorderSide(color: Colors.green.shade200),right: BorderSide(color: Colors.green.shade200), ),
                ),
              child: ListTile(
                title: Text("Password"),
                subtitle: Text("123"),
                leading: Icon(Icons.lock ,color: Colors.green.shade200,),
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