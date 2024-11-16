import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class DoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.1 ,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/doctor.jpg"),fit: BoxFit.cover),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) )
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.lime.withOpacity(0.9),
                       Colors.lime.withOpacity(0),
                        Colors.lime.withOpacity(0),
      
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:EdgeInsets.only(top: 30,left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:[ BoxShadow(
                                  color:Colors.grey,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                   ),
                                   ]
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color:Colors.lime.shade300, ),
                              ),
                            ),
                          ),
                          
                        ],
                      ), ),
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Visits",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),),
                                SizedBox(height: 8,),
                                Text("1.8k",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Name",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),),
                                SizedBox(height: 8,),
                                Text("Dr.Diaa",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Experiance",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),),
                                SizedBox(height: 8,),
                                Text("10 year",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),
                                )
                              ],
                            ),
                            
                          ],
                        ),
                      )
                  ],
                ),
              ),
      
            ),
             SizedBox(height: 10,),
            Container(
              
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.lime.shade300,width: 4)
                ),
              child: 
              SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                child: Column(
                 children: [
                  Text(
                      "Your Current Appointments :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7)
                      ),
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
                                title: Text("Zaid ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),),
                                
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
            ),
            SizedBox(height: 10,),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.lime.shade300,width: 4)
                ),
              child: 
              SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                child: Column(
                 children: [
                  Text(
                      "Your UnRecorded Appointments :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7)
                      ),
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
                                )
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
                                )
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
                                        ),),
      
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
                                
                                
                            ],
                          ),
                        ) ,
                      ),
      
                 ]
                )
              )
            ),
            SizedBox(height: 10,),
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.lime.shade300,width: 4)
                ),
              child: 
              SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                child: Column(
                 children: [
                  Text(
                      "Your Previous Appointments :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7)
                      ),
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
                                title: Text("Zaid ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),),
                                 

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
            )
      
      
      
          ],
        ),
      ),
    );
  }
}