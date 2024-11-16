import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
class CurrentAppoitment extends StatefulWidget {
  const CurrentAppoitment({super.key});

  @override
  State<CurrentAppoitment> createState() => _CurrentAppoitmentState();
}

class _CurrentAppoitmentState extends State<CurrentAppoitment> {
bool isObscurePassword=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade400,
        shadowColor:Colors.tealAccent.shade400 ,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
        title:Text("CURRENT APPOITMENT",textScaleFactor: 1.25),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
        
         ),
      body: 
      SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                child: Column(
                 children: [
                   SizedBox(height: 15,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2
                          )
                        ]
                      ),
                      child:SizedBox(
                        
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Zaid ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                               subtitle: Text(" Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage("assets/images/patient.jpg"),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 1,
                                height: 20,
                              ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    
                                    children: [
                                      Icon(Icons.calendar_month,color: Colors.black54,),
                                      SizedBox(width: 5,)
                                      ,Text("12/12/2023",
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time_filled,color: Colors.black54,),
                                      SizedBox(width: 5,)
                                      ,Text("10:30 AM",
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),),
                                      
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),
                        
                          ],
                        ),
                      ) ,
                    ),
                     Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2
                          )
                        ]
                      ),
                      child:SizedBox(
                        
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Ahmad ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              subtitle: Text(" Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage("assets/images/patient.jpg"),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 1,
                                height: 20,
                              ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    
                                    children: [
                                      Icon(Icons.calendar_month,color: Colors.black54,),
                                      SizedBox(width: 5,)
                                      ,Text("12/12/2023",
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time_filled,color: Colors.black54,),
                                      SizedBox(width: 5,)
                                      ,Text("10:30 AM",
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),),
                                      
                                      
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),
                             
                          ],
                        ),
                      ) ,
                    ),
                     Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2
                          )
                        ]
                      ),
                      child:SizedBox(
                        
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Dyaa",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              subtitle: Text(" Eye Clinic"),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage("assets/images/patient.jpg"),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 1,
                                height: 20,
                              ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    
                                    children: [
                                      Icon(Icons.calendar_month,color: Colors.black54,),
                                      SizedBox(width: 5,)
                                      ,Text("12/12/2023",
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time_filled,color: Colors.black54,),
                                      SizedBox(width: 5,)
                                      ,Text("10:30 AM",
                                      style: TextStyle(
                                        color: Colors.black54
                                      ),),
                                     
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),
                              
                          ],
                        ),
                      ) ,
                    ),
                 ]
                ),
              )
            );
          
      
      
 }
 
  }
