import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
import 'package:tic_tech_teo_2023/models/Doctor.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';
import '../../../Color_File/colors.dart';
import '../../Custom_Drawer/patient_drawerfile.dart';
import 'package:tic_tech_teo_2023/models/Appointment.dart';

import '../../Profile/Doctor/DoctorProfile.dart';
import 'calMain.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> searchList;

  CustomSearchDelegate(this.searchList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredResults = searchList
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredResults[index]),
          onTap: () {
            Navigator.push(
              context,

              MaterialPageRoute(
                builder: (context) => SearchResultScreen(result: filteredResults[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedResults = searchList
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestedResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          splashColor: Colors.red,
          title: Text(suggestedResults[index]),
          onTap: () {
            query = suggestedResults[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class SearchResultScreen extends StatelessWidget {
  final String result;

  const SearchResultScreen({required this.result});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: ()
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientHomeScreen())) ;
            },
          ),
          title: Text("${result}"),
        ),
      ),
    );
  }
}


class PatientHomeScreen extends StatefulWidget {
   const PatientHomeScreen({super.key});

  @override

  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {

  Future futureData = AppointmentRequests.isThereAppointment(curUser.userID!);

  bool isThereAppointment = false;

  MyAppointment appointment = MyAppointment();
  DateTime today = DateTime.now();

  List<String>  Uninames = [
    'Dr.D1',
    'Dr.D2',
    'Dr.D3',
    'Dr.D4',
    'Dr.D5',
    'Dr.D6',
    'Dr.D7',
  ] ;

  List<String> filterednames = [];

  void callback(){
    print("callback triggerd");

    setState(() {});
  }



  @override
  void initState() {
    super.initState();
    filterednames.addAll(Uninames);
  }

  void searchContainers(String query) {
    setState(() {
      filterednames = Uninames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {  
    String strDate = "${today.day}/${today.month}/${today.year}";
    print("uT: ${curUser.userID}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    Uninames,
                  ),
                );
              },
              icon: Icon(Icons.search),
            ),
          )
        ],
        backgroundColor: Colors.black, // Make the AppBar background transparent
        elevation: 0, // Remove the shadow,
        title: Text('Hello , ${curUser.name}'),
      ),
      drawer:Drawer(
        child: drawerPatient(),
      ) ,

      body: SingleChildScrollView(
        child: Column(
          
          children: [
            FutureBuilder(
                future: AppointmentRequests.isThereAppointment(curUser.userID!),
                builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return Container(child: Text(""),);
                    }
                    else if (snapshot.hasData){
                      //todo
                      // print("is Appo res: ${snapshot.data}  ${curUser.auth_token}");
                      final res = snapshot.data["responseData"]["appointments"];
                      if(res.length == 0){
                        return Container();
                      }
                      else{
                        return appointmentCard(context, MyAppointment.fromJSON(res[0]), callback);
                      }

                    }
                  }

                  return Container();
                }
            ),
            
            FutureBuilder(
                future: DoctorRequests.getDoctors(strDate),
                builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return Text("Error");
                    }
                    else if (snapshot.hasData){
                      final Map<String, dynamic> res = snapshot.data as Map<String, dynamic>;
                      List<dynamic> strDoctorList = res["responseData"]["vacant_doctors"];
                      print("type:${strDoctorList[0].runtimeType}");
                      print("type:${strDoctorList[0]}");

                      List<Doctor> doctorList = strDoctorList.map((e) => Doctor.fromJSON(e)).toList();
                      Uninames = doctorList.map((e) => e.name??"-1").toList();
                      Uninames.remove("-1");
                      return displayDoctors(context, doctorList);
                      return Text("$res");
                    }
                  }

                  return Center(
                    child: Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width*0.9),
                      child: SpinKitCircle(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                    ),
                  );



                }),

          ],
        ),
      ),
    );
  }
}


Container appointmentCard(context, MyAppointment appointment, Function callback){

  return Container(
    width: MediaQuery.of(context).size.width,

    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(right: 105.0),
            child: Text("Upcoming Appoinments",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
          ),
          SizedBox(height: 20,),
          Container(
            width: 450,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20,),
                Padding(
                  padding:  EdgeInsets.only(bottom: 52.0),
                  child: CircleAvatar(child: Center(child: Icon(Icons.medical_services_outlined,color: Colors.white,),),backgroundColor: Colors.black,radius: 20,),
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(right: 36,top: 15),
                      child: Text("Dr.${appointment.doctorName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
                    ),
                 SizedBox(height: 10,),
                 Padding(
                   padding: EdgeInsets.only(right: 18.0),
                   child: Text("Date : ${appointment.date}",style: TextStyle(fontSize: 15,color: Colors.black),),
                 ),
                 SizedBox(height: 10,),
                 Padding(
                   padding: EdgeInsets.only(right: 18.0),
                   child: Text("Time:${appointment.slot}",style: TextStyle(fontSize: 15,color: Colors.black),),
                 ),


                  ],
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 38.0),
                  child: Row(
                    children: [
                      OutlinedButton(
                          onPressed: () async {
                            //todo: canal appo
                            final res = await AppointmentRequests.cancel(appointment.id!);
                            print("res: $res");

                            bool isdeleted = res["responseData"]["deleted"];
                            // if(isdeleted){
                              callback.call();
                            // }



                          },
                          style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(
                                  color: Colors.black,)) // Border color

                          ),
                          child: Text("Cancel",style: TextStyle(color: Colors.black),)

                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );

}



// display doctor..........


Column displayDoctors(context, List<Doctor> doctorList){
  return Column(
    children: [
      SizedBox(height: 10,),
      Padding(
        padding:  EdgeInsets.only(right: 188.0),
        child: Text("Other Doctors ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      Container(
        decoration: BoxDecoration(
        ),
        height: MediaQuery.of(context).size.height-100,
        child: ListView.builder(
          itemCount: doctorList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 14.0,vertical: 10),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 52.0),
                      child: CircleAvatar(child: Center(child: Icon(Icons.medical_services_outlined,color: Colors.white,),),backgroundColor: Colors.black,radius: 20,),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.34,top:15),
                          child: Text("Dr. ${doctorList[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            OutlinedButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorProfile(doctor: doctorList[index],))) ;
                                },
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                        color: Colors.black,)) // Border color

                              ),
                                child: Text("Veiw Profile",style: TextStyle(color: Colors.black),

                                )
                            ),
                            SizedBox(width: 20,),
                            OutlinedButton(
                                onPressed: (){
                                  print("doctor: ${doctorList[index]}");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CalPatient(doctorName: doctorList[index].name, doctorToken: doctorList[index].id, patientToken: curUser.userID)));
                                },
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide(
                                          color: Colors.black,)) // Border color

                                ),
                                child: Text("Take Appointment",style: TextStyle(color: Colors.black),)
                            ),
                          ],
                        )

                      ],
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width*0.85,
                height: MediaQuery.of(context).size.height*0.15,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            );
          }),
      ),
    ],
  );
}