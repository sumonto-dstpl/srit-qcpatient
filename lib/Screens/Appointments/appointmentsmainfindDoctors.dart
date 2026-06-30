import 'dart:convert';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/finddoctorslist.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class AppointmentsMain extends StatefulWidget {
  int selectedIndex = 0;
  AppointmentsMain({
    super.key,
  });
  @override
  State<AppointmentsMain> createState() => AppointmentsMainstate();
}

class AppointmentsMainstate extends State<AppointmentsMain> {
  String usernameValue = "Find Doctors";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;

  final myphysicians = [
    ["assets/virtualconsultation.png", "Virtual Consultation"],
    ["assets/physicalconsultation.png", "Physical Consultation"],
  ];

  final myphysicianswithblurr = [
    [
      "assets/physicalconsultation.png",
      "Virtual Appointments will be available soon"
    ],
    [
      "assets/physicalconsultation.png",
      "Virtual Appointments will be available soon"
    ],
  ];

  final mytopspecialities = [
    ["assets/GeneralPhysician.png", "General Physician"],
    ["assets/ENT.png", "ENT"],
    ["assets/Dermatology.png", "Dermatology"],
    ["assets/Cardiology.png", "Cardiology"],
    ["assets/Urology.png", "Urology"],
    ["assets/Orthopedics.png", "Orthopedics"],
    ["assets/Endocrinology.png", "Endocrinology"],
    ["assets/Pediatrics.png", "Pediatrics"],
  ];

  final mybrowsebysymptoms = [
    ["assets/Cough.png", "Cough"],
    ["assets/RunnyNose.png", "Runny Nose"],
    ["assets/Stress.png", "Stress"],
    ["assets/ThroatPain.png", "Throat Pain"],
    ["assets/Cough.png", "Cough"],
    ["assets/RunnyNose.png", "Runny Nose"],
    ["assets/Stress.png", "Stress"],
    ["assets/ThroatPain.png", "Throat Pain"],
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),
        
        
        
        child: Stack(children: [
          Column(
            children: <Widget>[

                 Header(userName: usernameValue,),
              // Main Content Section
              Expanded(

                  child: Container(
                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(screenHeight * 0.03),
                                        topRight: Radius.circular(screenHeight * 0.03),
                                        bottomLeft: Radius.circular(screenHeight * 0.0),
                                        bottomRight: Radius.circular(screenHeight * 0.00),
                                        // bottomCenter: 0,
                                      ),
                                    ),
                    child : Column(
                    children: [
              Container(
                padding: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        right: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .height * 0.01),
                width: double.infinity,
                decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenHeight * 0.03),
                        topRight: Radius.circular(screenHeight * 0.03),
                      ),
                    ),
                child:
                  Column(
                    children: [
               GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return QuickSearchWithoutData();
                              },
                            ),
                          );
                        },
                        child:
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                          ),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.05,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7F5F6),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          alignment: Alignment.centerRight,
                          
                          margin: EdgeInsets.only(
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: 10,
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.02,
                                    right: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.00,
                                    bottom: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.0),
                                child: Text(
                                  "Search by",
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      // overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.014
                                  ),
                                ),
                              ),


                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.008,
                                    right: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.00,
                                    bottom: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.0),
                                child:
                                DefaultTextStyle(
                                  style: TextStyle(
                                      color: Color(0xFF126086),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.016),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      RotateAnimatedText(
                                        'Doctor',
                                        textStyle: TextStyle(
                                            color: Color(0xFF126086),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.014), // Red text
                                      ),
                                      RotateAnimatedText(
                                        'Speciality',
                                        textStyle: TextStyle(
                                            color: Color(0xFF126086),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.014),
                                      ),

                                      RotateAnimatedText(
                                        'Symptoms',
                                        textStyle: TextStyle(
                                            color: Color(0xFF126086),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.014),
                                      ),
                                    ],
                                    repeatForever: true,
                                    pause: Duration(milliseconds: 500),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return QuickSearchWithoutData();
                                          },
                                        ),
                                      );
                                      print("Tap Event");
                                    },
                                  ),
                                ),
                              ),

                              Spacer(),
                              // Pushes the search icon to the end of the Row
                              Padding(
                                padding: EdgeInsets.only(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black45,
                                  size: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
              ]
                  ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                      top: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(screenHeight * 0.03),
                    //   topRight: Radius.circular(screenHeight * 0.03),
                    // ),
                  ),
                  child: ListView(
                      padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [



                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.0),
                        margin: EdgeInsets.only(bottom: 0),
                        child: GridView.count(
                          childAspectRatio: 1.4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            left: screenHeight * 0.0,
                            right: screenHeight * 0.0,
                            top: screenHeight * 0.0,
                            bottom: 0.0,
                          ),
                          crossAxisCount: 2,
                          crossAxisSpacing: screenHeight * 0.015,
                          mainAxisSpacing: screenHeight * 0.015,
                          children: [
                            ...myphysicians.map(
                              (i) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      print("Item tapped: $i"); // Debugging

                                      // Check based on title or any unique identifier
                                      if (i[1] == 'Virtual Consultation') {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return FindDoctorsListMain(
                                                  "videoconference",
                                                physical_virtual_mode: "virtual",
                                              ); // Replace with your specific widget
                                            },
                                          ),
                                        );
                                      } else if (i[1] ==
                                          'Physical Consultation') {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return FindDoctorsListMain(
                                                  "in-person"); // Replace with another widget
                                            },
                                          ),
                                        );
                                      } else {
                                        print(
                                            "Unhandled case for title: ${i[1]}");
                                      }
                                    },
                                    child: Container(
                                      width: screenHeight * 0.2,
                                      height: screenHeight * 0.1,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE8F0F3),

                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.01),
                                        image: DecorationImage(
                                          image: AssetImage(i[0]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(screenHeight * 0.005),
                                    child: Text(
                                      i[1],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      // Top Specialties
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.0,
                            right: MediaQuery.of(context).size.height * 0.0,
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.015),
                            
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                    right: MediaQuery.of(context).size.height *
                                        0.00,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Top Specialities",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.014,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return AppointmentsFindSpecialities();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.00),
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Color(0xFF126086),
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.012,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      // Top Specialties Grid
                      Container(
                        color: Colors.white,
                        child: GridView.count(
                          shrinkWrap:
                              true, // This ensures the GridView takes up as much space as needed
                          physics:
                              NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.0,
                            right: MediaQuery.of(context).size.height * 0.0,
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                          ),
                          crossAxisCount: 4,
                          // crossAxisSpacing: screenHeight * 0.02,
                          // mainAxisSpacing: screenHeight * 0.01,
                          children: [
                            ...mytopspecialities.map(
                              (i) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return FindDoctorsListMain(
                                                "in-person"); // Replace with another widget
                                          },
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFFE8F0F3),
                                      padding:
                                          EdgeInsets.all(screenHeight * 0.01),
                                      minimumSize: Size(screenHeight * 0.04,
                                          screenHeight * 0.04),
                                    ),
                                    child: Container(
                                      width: screenHeight * 0.03,
                                      height: screenHeight * 0.03,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(i[0]),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height : screenHeight * 0.001),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(screenHeight * 0.00),
                                      child: Text(
                                        i[1],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              (10 /
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height),
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                       // Browse by Symptoms
                      Padding(
                        padding: EdgeInsets.only(
                           top :MediaQuery.of(context).size.height * 0.015,
                            left: MediaQuery.of(context).size.height * 0.0,
                            right: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.015),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                    right: MediaQuery.of(context).size.height *
                                        0.00,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Browse by Symptoms",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.014,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                    right: MediaQuery.of(context).size.height *
                                        0.00,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                    color: Color(0xFF126086),
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.012,
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      // Browse by Symptoms Grid
                      Container(
                        color: Colors.white,
                        child: GridView.count(
                          shrinkWrap:
                              true, // This ensures the GridView takes up as much space as needed
                          physics:
                              NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.0,
                            right: MediaQuery.of(context).size.height * 0.0,
                            top: MediaQuery.of(context).size.height * 0.005,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                          ),
                          crossAxisCount: 4,
                          // crossAxisSpacing: screenHeight * 0.02,
                          // mainAxisSpacing: screenHeight * 0.01,
                          children: [
                            ...mybrowsebysymptoms.map(
                              (i) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      // Your onPressed action here
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFFE8F0F3),
                                      padding:
                                          EdgeInsets.all(screenHeight * 0.01),
                                      minimumSize: Size(screenHeight * 0.05,
                                          screenHeight * 0.05
                                      ),
                                    ),
                                    child: Container(
                                      width: screenHeight * 0.03,
                                      height: screenHeight * 0.03,
                                      decoration: BoxDecoration(

                                        image: DecorationImage(
                                          image: AssetImage(i[0]),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(screenHeight * 0.002),
                                    child: Text(
                                      i[1],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .height *
                                            (10 /
                                                MediaQuery.of(context)
                                                    .size
                                                    .height),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height :  screenHeight * 0.05),
                    ],
                  ),
                ),
              ),
              ],
                    ),
                  ),
              )
            ],
          ),
        ]),
      ),

      // First  - Center Docked
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(),

      bottomNavigationBar:   CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }




}
