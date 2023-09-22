import 'package:flutter/material.dart' ;
import '../Color_File/colors.dart';


class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {

  bool isSignupScreen = true;
  bool isMale = true;
  bool isRememberMe = false;

  // filtercheep
  bool isDoctor = true ;
  bool isMonday = false ;
  bool isTuesday = false ;
  bool isWednesday = false ;
  bool isThusday = false ;
  bool isFriday = false ;
  bool isSaturday = false ;
  bool isSunday = true ;


  // for time picker
  TimeOfDay timeStart = TimeOfDay(hour: 9, minute: 00);
  TimeOfDay timeEnd = TimeOfDay(hour: 18, minute: 00);


  // signin
  TextEditingController username = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController password1 = TextEditingController();

  // signup
  TextEditingController password2 = TextEditingController();
  TextEditingController email2 = TextEditingController();

  // for doctor
  TextEditingController RegistrationNumber = TextEditingController();
  TextEditingController doctorWorkingHoursStart = TextEditingController() ;
  TextEditingController doctorWorkingHoursEnd = TextEditingController() ;

  TextEditingController BloodGroup = TextEditingController();
  TextEditingController Height = TextEditingController();
  TextEditingController Weight = TextEditingController() ;
  TextEditingController Age = TextEditingController() ;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Login_Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login_register.jpg"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFF3b5999).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Welcome",
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TextSpan(
                              text: isSignupScreen ? " to MedEase," : " Back,",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      isSignupScreen
                          ? "Sign Up to Continue"
                          : "Sign In to Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          buildBottomHalfContainer(true),

          // Animation of container

          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 550 : 270,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Login_Palette.Login_activeColor
                                        : Login_Palette.Login_textColor),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Login_Palette.Login_activeColor
                                        : Login_Palette.Login_textColor),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom buttons

        ],
      ),
    );
  }




  // Custom Classes...........................................................................


  //  Signin screen

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, "info@demouri.com", false, true,email2),
          buildTextField(
              Icons.lock_outline, "**********", true, false,password2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Login_Palette.PrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Login_Palette.PrimaryColor))
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Login_Palette.PrimaryColor)),
              )
            ],
          )
        ],
      ),
    );
  }

  // Singup screen

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.account_box_outlined, "User Name",
              false, false,username),
          buildTextField(
              Icons.email, "email", false, true,email1),
          buildTextField(
              Icons.lock_outline, "password", true, false,password1),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  color: isMale
                                      ? Login_Palette.PrimaryColor
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 1,
                                      color: isMale
                                          ? Colors.transparent
                                          : Login_Palette.PrimaryColor),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.man,
                                color: isMale ? Colors.white : Login_Palette.PrimaryColor,
                              ),
                            ),
                            Text(
                              "Male",
                              style: TextStyle(color: Login_Palette.PrimaryColor,fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  color: isMale
                                      ? Colors.transparent
                                      : Login_Palette.PrimaryColor,
                                  border: Border.all(
                                      width: 1,
                                      color: isMale
                                          ? Login_Palette.PrimaryColor
                                          : Colors.transparent),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.woman,
                                color: isMale ?Login_Palette.PrimaryColor : Colors.white,
                              ),
                            ),
                            Text(
                              "Female",
                              style: TextStyle(color: Login_Palette.PrimaryColor,fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDoctor = true;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  color: isDoctor
                                      ? Login_Palette.PrimaryColor
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 1,
                                      color: isDoctor
                                          ? Colors.transparent
                                          : Login_Palette.PrimaryColor),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.medical_services_outlined,
                                color: isDoctor ? Colors.white : Login_Palette.PrimaryColor,
                              ),
                            ),
                            Text(
                              "Doctor",
                              style: TextStyle(color: Login_Palette.PrimaryColor,fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDoctor = false;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  color: isDoctor
                                      ? Colors.transparent
                                      : Login_Palette.PrimaryColor,
                                  border: Border.all(
                                      width: 1,
                                      color: isDoctor
                                          ? Login_Palette.PrimaryColor
                                          : Colors.transparent),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.masks_outlined,
                                color: isDoctor ?Login_Palette.PrimaryColor : Colors.white,
                              ),
                            ),
                            Text(
                              "Patient",
                              style: TextStyle(color: Login_Palette.PrimaryColor,fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),

          // Patient and Doctor selection :
          isDoctor ? Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildTextField(
                    Icons.app_registration_outlined, "Registration Number", false, false,RegistrationNumber),
                Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Choose Your Working Hours        ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.4),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(children: [Text("To     : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              InkWell(
                                onTap: ()async{
                                  final TimeOfDay ? timeOfDay = await showTimePicker(
                                      context: context,
                                      initialTime: timeStart,
                                      initialEntryMode: TimePickerEntryMode.dial,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                          child: child ?? Container(),
                                        );
                                      }

                                  );
                                  if(timeOfDay!=null)
                                  {
                                    setState(() {
                                      timeStart = timeOfDay ;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  child: Center(child: Text("${timeStart.hour}:${timeStart.minute}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all()
                                  ),
                                ),
                              ),],),
                            SizedBox(height: 10,),
                            Row(children: [Text("From : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              InkWell(
                                onTap: ()async{
                                  final TimeOfDay ? timeOfDay = await showTimePicker(
                                      context: context,
                                      initialTime: timeEnd,
                                      initialEntryMode: TimePickerEntryMode.dial,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                          child: child ?? Container(
                                          ),
                                        );
                                      }

                                  );
                                  if(timeOfDay!=null)
                                  {
                                    setState(() {
                                      timeEnd = timeOfDay ;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  child: Center(child: Text("${timeEnd.hour}:${timeEnd.minute}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(),
                                  ),
                                ),
                              ),],)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Choose Your Non - Working Days",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(width: 15,),
                          FilterChip(
                              label: Text("Mon",style: TextStyle(color: Colors.white),),
                              selected: isMonday,
                              backgroundColor: Colors.black,
                              selectedColor: Colors.red,
                              onSelected: (bool value){setState(()
                          {
                            isMonday = !isMonday;
                          });}),
                          SizedBox(width: 15,),
                          FilterChip(
                              label: Text("Tue",style: TextStyle(color: Colors.white),),
                              selected: isTuesday,
                              backgroundColor: Colors.black,
                              selectedColor: Colors.red,
                              onSelected: (bool value){setState(()
                              {
                                isTuesday = !isTuesday;
                              });}),
                          SizedBox(width: 15,),
                          FilterChip(
                              label: Text("Wed",style: TextStyle(color: Colors.white),),
                              selected: isWednesday,
                              backgroundColor: Colors.black,
                              selectedColor: Colors.red,
                              onSelected: (bool value){setState(()
                              {
                                isWednesday = !isWednesday;
                              });}),
                          SizedBox(width: 15,),
                          FilterChip(
                              label: Text("Thu",style: TextStyle(color: Colors.white),),
                              selected: isThusday,
                              backgroundColor: Colors.black,
                              selectedColor: Colors.red,
                              onSelected: (bool value){setState(()
                              {
                                isThusday = !isThusday;
                              });}),
                          SizedBox(width: 15,),
                          FilterChip(
                              label: Text("Fri",style: TextStyle(color: Colors.white),),
                              selected: isFriday,
                              backgroundColor: Colors.black,
                              selectedColor: Colors.red,
                              onSelected: (bool value){setState(()
                              {
                                isFriday = !isFriday;
                              });}),
                          SizedBox(width: 15,),
                          FilterChip(
                              label: Text("Sat",style: TextStyle(color: Colors.white),),
                              selected: isSaturday,
                              backgroundColor: Colors.black,
                              selectedColor: Colors.red,
                              onSelected: (bool value){setState(()
                              {
                                isSaturday= !isSaturday;
                              });}),
                          SizedBox(width: 15,),
                          FilterChip(
                              label: Text("Sun",style: TextStyle(color: Colors.white),),
                              selected: isSunday,
                              backgroundColor: Colors.black,
                              selectedColor: Colors.red,
                              onSelected: (bool value){setState(()
                              {
                                isSunday= !isSunday;
                              });}),
                          SizedBox(width: 15,),
                        ],
                      ),
                    ),


                  ],
                )



              ],
            ),
          ) :Container(
            child : Column(
              children: [
                buildTextField(
                    Icons.height, "Height", false, false,Height),
                buildTextField(
                    Icons.monitor_weight, "Weight", false, false,Weight),
                buildTextField(
                    Icons.bloodtype, "Blood Group", false, true,BloodGroup),
                buildTextField(
                    Icons.timelapse, "Age", false, true,Age),


              ],
            )

          ),

          // TERMS AND CONDITION OPTION :
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(color: Login_Palette.PrimaryColor,fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      //recognizer: ,
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 710 : 460,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 250.0),
        child: Center(
          child: InkWell(
            onTap: (){print("ok");},
            child: Container(

              height: 60,
              width: 60,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    if (showShadow)
                      BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        spreadRadius: 1.5,
                        blurRadius: 10,
                      )
                  ]),
              child: !showShadow
                  ? Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.red
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ]),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              )
                  : Center(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail,  TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: control,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Login_Palette.PrimaryColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Login_Palette.PrimaryColor),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Login_Palette.PrimaryColor),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}

