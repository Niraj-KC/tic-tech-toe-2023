import 'package:flutter/material.dart' ;
import 'package:tic_tech_teo_2023/Home_Screen%20Pages/Main_screens/Patient/PatientHomeScreen.dart';


import '../../../utils/constants.dart';
import 'CustomCon.dart';


class PatientSettings extends StatefulWidget {
  const PatientSettings({super.key});

  @override
  State<PatientSettings> createState() => _PatientSettingsState();
}

class _PatientSettingsState extends State<PatientSettings> {
  final  ageControl = TextEditingController();
  int? Age = curUser.age ;

  final weightControl = TextEditingController();
  int? Weigth = curUser.age;

  final heigthControl = TextEditingController();
  int? heigth = curUser.age;

  final passControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Settings",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
          leading:
            BackButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientHomeScreen())) ;
              },
            )

        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
          child: Column(
            children: [
              CustomCon(
                Name: "Weight :${curUser.weight}",
                icon: Icon(Icons.monitor_weight),
                padding: 0.25,
                ontap: () {
                  showDialog(context: context, builder: (context)
                  {
                    return AlertDialog(
                      content: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextFormField(
                          controller: weightControl,
                          decoration: InputDecoration(
                            labelText: "Enter Your Weight : ",
                            border: OutlineInputBorder(),

                          ),
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: null,
                          // onChanged: ,
                        ),

                      ),
                      title: Text("Current Weight"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {

                              });
                            },
                            child: Text("Save")),
                      ],
                    );
                  }) ;
                },),
              CustomCon(
                Name: "Height :  ${curUser.height}",
                icon: Icon(Icons.height),
                padding: 0.27,
                ontap: () {
                  showDialog(context: context, builder: (context)
                  {
                    return AlertDialog(
                      content: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextFormField(
                          controller: heigthControl,
                          decoration: InputDecoration(
                            labelText: "Enter Your Current Height : ",
                            border: OutlineInputBorder(),

                          ),
                          keyboardType: TextInputType.number,
                          maxLines: null,
                          // onChanged: ,
                        ),

                      ),
                      title: Text("Current Heigth"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {

                              });
                            },
                            child: Text("Save")),
                      ],
                    );
                  }) ;
                },),
              CustomCon(
                Name: "Age  : ${curUser.age}",
                icon: Icon(Icons.timelapse),
                padding:0.33,
                ontap: () {
                  showDialog(context: context, builder: (context)
                  {
                    return AlertDialog(
                      content: Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextFormField(
                          controller: ageControl,
                          decoration: InputDecoration(
                            labelText: "Enter Your Current Age : ",
                            border: OutlineInputBorder(),

                          ),
                          keyboardType: TextInputType.number,
                          maxLines: null,
                          // onChanged: ,
                        ),

                      ),
                      title: Text("Current Age"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              setState(() {

                              });
                            },
                            child: Text("Save")),
                      ],
                    );
                  }) ;
                },),
            ],
          ),
        ),
      ),
    );
  }
}
