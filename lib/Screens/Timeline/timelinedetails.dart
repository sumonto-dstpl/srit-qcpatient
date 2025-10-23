import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/finddoctorslist.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithdata.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/HomeCare/diagnosticmain.dart';
import 'package:newfolder/Screens/HomeCare/doctorhcmain.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';

import 'package:newfolder/Screens/HomeCare/homecaremain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Medications/medicationselecttime.dart';
import 'package:newfolder/Screens/Medications/medicationsmybook.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Widgets/tab_item.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';

import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';


class TimelineDetails extends StatefulWidget {
  int selectedIndex = 0;

  String? image;
  String? doctorName;
  String? profession;
  TimelineDetails({
    super.key,
    this.doctorName,
    this.profession,
    this.image,
  });

  @override
  State<TimelineDetails> createState() => TimelineDetailsstate();
}

class TimelineDetailsstate extends State<TimelineDetails> {
  String usernameValue = "TimeLine";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final List<String> myopinions = [
    "PROVISIONAL DIAGNOSIS CODE",
    "S43.4 — Sprain and strain Of shoulder joint(Primary)",
    "S43.4 - Sprain and strain of shoulder joint",
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          width: double.infinity,
         /* decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color(0xFF126086),
                Color(0xFF126086),
                Color(0xFF126086),
              ],
            ),
          ),*/

          decoration: const BoxDecoration(
            image: DecorationImage(
              // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
              image: AssetImage("assets/Background Pattern.png"),
              fit: BoxFit.cover, // Adjusts how the image fills the container
            ),
          ),

          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  // Top Section
                Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.07,
                  left: screenWidth * 0.045,
                  right: screenWidth * 0.045,
                  bottom: screenWidth * 0.06,
                ),
                margin: EdgeInsets.only(
                  right: screenHeight * 0.0,
                  top: screenHeight * 0.0,
                  bottom: screenHeight * 0.01,
                  left: screenHeight * 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.035,
                        width: MediaQuery.of(context).size.height * 0.035,
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.00,
                          top: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                        ),
                        decoration: BoxDecoration(

                          color: Color(0xFF126086).withOpacity(0.2),

                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 0.0, color: Color(0xFF126086)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(130.0),
                          child: Image.asset(
                            'assets/medicationBack.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                          ),
                          child: Text(
                            usernameValue,
                            style: TextStyle(
                              fontSize:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.018,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),


                        GestureDetector(
                          onTap: () {
                             Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) {
                                      return AddressScreen();
                                    },
                                  ),
                                );
                          },
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // Align items to the start
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                  horizontal: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                ),
                                child: Text(
                                  useraddressValue,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.012,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                // Downward pointing arrow
                                color: Colors.white,
                                size: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02, // Responsive size
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                    // Action Bar 2nd half
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // Cart
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (BuildContext context) {
                                    return AddToCartMain();
                                  },
                                ),
                              );
                            },
                            child:
                            AppointmentIconBadge(
                              appointmentcount: "",
                            ),
                          ),


                          // Notification
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (BuildContext context) {
                                    return NotificationMain();
                                  },
                                ),
                              );
                            },
                            child:
                            IconBadge(
                              notificationcount: "",
                            ),
                          ),


                          // Profile Image
                          userprofilepValue != "NA"
                              ?

                          GestureDetector(
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ProfileMain();
                                    },
                                  ),
                                );
                              }, child:
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.050,
                            width: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.050,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Colors.white,
                              ),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: Image
                                    .memory(
                                    base64Decode(userprofilepValue))
                                    .image,
                              ),
                            ),
                          )
                          )
                              : GestureDetector(
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ProfileMain();
                                  },
                                ),
                              );
                            }, child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.04,
                            width: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.04,
                            padding: EdgeInsets.only(
                              left: MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.00,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1.0,
                                color: Colors.white,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(130.0),
                              child: Image.asset(
                                'assets/drsujeet.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          )










                        ],
                      ),
                    ),
                  ],
                ),
              ),

                  // Main Content Section
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.00,
                                top: MediaQuery.of(context).size.height * 0.04
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.height * 0.03),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.height * 0.03),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          Container(
                            
                            child: Stack(
                              children: [
                                // Center image
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(130.0),
                                      child: Image.asset(
                                       widget.image ??  'assets/NutanBhatt.png',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11, // Adjust height
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.11, // Adjust width
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.015,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                 widget.doctorName ??  "Dr. Nutan Bhatt",
                                  style: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                 widget.profession ??  "General physician / Internal Medicine",
                                  style: TextStyle(
                                      color: Color(0x80000000),
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //
            //               Container(
            //                 decoration: BoxDecoration(
            //                   color: Color(0xFFA8B1CE).withOpacity(0.1),
            //                   // Background color of the container
            //                   /*border: Border.all(
            //   color: Colors.black.withOpacity(0.1), // Border color
            //   width: 1, // Border width
            // ),*/
            //                   borderRadius: BorderRadius.circular(
            //                       8), // Optional: Rounded corners
            //                 ),
            //                 padding: EdgeInsets.only(
            //                     left: MediaQuery.of(context).size.height * 0.01,
            //                     right:
            //                         MediaQuery.of(context).size.height * 0.002,
            //                     bottom:
            //                         MediaQuery.of(context).size.height * 0.01,
            //                     top: MediaQuery.of(context).size.height * 0.01),
            //                 margin: EdgeInsets.only(
            //                     left: MediaQuery.of(context).size.height * 0.05,
            //                     right:
            //                         MediaQuery.of(context).size.height * 0.05,
            //                     bottom:
            //                         MediaQuery.of(context).size.height * 0.01,
            //                     top: MediaQuery.of(context).size.height * 0.01),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     // First row: Image and column with 2 texts
            //                     Expanded(
            //                       flex: 2,
            //                       child: Row(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                         children: [
            //                           Expanded(
            //                             flex: 1,
            //                             child: Image.asset(
            //                               'assets/calendercard.png',
            //                               // Replace with your image path
            //                               height: MediaQuery.of(context)
            //                                       .size
            //                                       .height *
            //                                   0.022,
            //                               width: MediaQuery.of(context)
            //                                       .size
            //                                       .height *
            //                                   0.022,
            //                               fit: BoxFit.cover,
            //                             ),
            //                           ),
            //                           Expanded(
            //                             flex: 7,
            //                             child: Container(
            //                               padding: EdgeInsets.only(
            //                                   left: MediaQuery.of(context)
            //                                           .size
            //                                           .height *
            //                                       0.002,
            //                                   right: MediaQuery.of(context)
            //                                           .size
            //                                           .height *
            //                                       0.00,
            //                                   top: MediaQuery.of(context)
            //                                           .size
            //                                           .height *
            //                                       0.00,
            //                                   bottom: MediaQuery.of(context)
            //                                           .size
            //                                           .height *
            //                                       0.00),
            //                               child: Text(
            //                                 "December, 20  2023",
            //                                 style: TextStyle(
            //                                     color: Color(0xFF126086),
            //                                     // overflow: TextOverflow.ellipsis,
            //                                     fontWeight: FontWeight.bold,
            //                                     fontSize: MediaQuery.of(context)
            //                                             .size
            //                                             .height *
            //                                         0.014),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //
            //                     // Divider or custom container
            //                     Row(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                         children: [
            //                           Container(
            //                             width:
            //                                 MediaQuery.of(context).size.height *
            //                                     0.002,
            //                             height:
            //                                 MediaQuery.of(context).size.height *
            //                                     0.02,
            //                             color: Colors.grey[400],
            //                             // Divider color
            //                             margin: EdgeInsets.symmetric(
            //                                 horizontal: 10.0),
            //                           ),
            //                         ]),
            //
            //                     // Second row: Image and column with 2 texts
            //                     Expanded(
            //                       flex: 1,
            //                       child: Row(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           Container(
            //                             padding: EdgeInsets.only(
            //                                 left: MediaQuery.of(context)
            //                                         .size
            //                                         .height *
            //                                     0.002,
            //                                 right: MediaQuery.of(context)
            //                                         .size
            //                                         .height *
            //                                     0.002,
            //                                 top: MediaQuery.of(context)
            //                                         .size
            //                                         .height *
            //                                     0.00,
            //                                 bottom: MediaQuery.of(context)
            //                                         .size
            //                                         .height *
            //                                     0.00),
            //                             child: Text(
            //                               "7:30 AM",
            //                               style: TextStyle(
            //                                   color: Color(0xFF126086),
            //                                   // overflow: TextOverflow.ellipsis,
            //                                   fontWeight: FontWeight.bold,
            //                                   fontSize: MediaQuery.of(context)
            //                                           .size
            //                                           .height *
            //                                       0.014),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),

                          // Symptoms
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.01,
                                horizontal: MediaQuery.of(context).size.height * 0.015,
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.01,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFA8B1CE).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IntrinsicHeight( // Makes divider full height of tallest child
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 🗓️ Date (Flexible to wrap)
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/calendercard.png',
                                            height: MediaQuery.of(context).size.height * 0.022,
                                            width: MediaQuery.of(context).size.height * 0.022,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.height * 0.008),
                                          Flexible(
                                            child: Text(
                                              "December, 20  2023",
                                              style: TextStyle(
                                                color: const Color(0xFF126086),
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Vertical Divider
                                    Container(
                                      width: 1,
                                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.012),
                                      color: Colors.grey[400],
                                    ),

                                    // 🕢 Time (fixed, no wrap unless too long)
                                    Text(
                                      "7:30 AM",
                                      style: TextStyle(
                                        color: const Color(0xFF126086),
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.height * 0.014,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Symptoms",
                                  style: TextStyle(
                                      color: Color(0xFF1F1F1F),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "C/O Rt shoulder pain with difficulty in moving his shoulder",
                                  style: TextStyle(
                                      color: Color(0x99000000),
                                      fontWeight: FontWeight.w400,
                                      // overflow: TextOverflow.ellipsis,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.012
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Diagnoses
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Diagnoses",
                                  style: TextStyle(
                                      color: Color(0xFF1F1F1F),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.014
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01, // Dynamic top padding
                                  bottom: MediaQuery.of(context).size.height *
                                      0.0, // Dynamic bottom padding
                                  left: MediaQuery.of(context).size.height *
                                      0.0, // Dynamic left padding
                                  right: MediaQuery.of(context).size.height *
                                      0.0, // Dynamic right padding
                                ),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  // Prevents infinite height
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: myopinions.length,
                                  // Use the length of the string list
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                      ),
                                      child: Text(
                                        '${myopinions[index]}',
                                        // Display the string at the current index
                                        style: TextStyle(
                                            color: Color(0x99000000),
                                            fontWeight: FontWeight.w400,
                                            // overflow: TextOverflow.ellipsis,
                                            fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                          height: 1,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),



                          // Treatment and Medication
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Treatment and Medication",
                                  style: TextStyle(
                                      color: Color(0xFF1F1F1F),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.014
                                  ),
                                ),
                              ),

                            ],
                          ),

                          // Heading Row
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.00),
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01),
                            decoration: BoxDecoration(
                              // color: Colors.blue.withOpacity(0.2),
                              color : Color(0xFFF3FAFD),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ), // Adds top curves
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                      "Medication",
                                      style: TextStyle(
                                          color: Color(0xFF667085),
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014),
                                    ),


                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                      "Dosage",
                                      style: TextStyle(
                                          color: Color(0xFF667085),
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014),
                                    ),

                                
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 2nd row
                          Container(

                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.001,
                                bottom:
                                MediaQuery.of(context).size.height * 0.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                TreatmentMedicationDetail(text: "EZIPAN 100 ML - AND THYME EXTRACT(OD 70 GM)098 CM", backgroundcolor: Color(0x66F0F0F0)),

                                TreatmentMedicationDetail(text: "CAPSULE • ORAL - IBID) at 600.18 00", backgroundcolor: Color(0xFFFFFFFF)),
                              ],
                            ),
                          ),

                          // 3rd row
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.0,
                                right:
                                MediaQuery.of(context).size.height * 0.0,
                                top: MediaQuery.of(context).size.height * 0.0,
                                bottom:
                                MediaQuery.of(context).size.height * 0.00),
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                MediaQuery.of(context).size.height * 0.01),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                TreatmentMedicationDetail(text: "VOLTAREN EMULGEL G Bx/l EACH", backgroundcolor: Color(0xFFFFFFFFF)),
                                Expanded(
                                  child: Container(
                                    color : Color(0x66F0F0F0),
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height * 0.015,
                                        right: MediaQuery.of(context).size.height * 0.015,
                                        top: MediaQuery.of(context).size.height * 0.008,
                                        bottom: MediaQuery.of(context).size.height * 0.008),
                                    alignment: Alignment.center,
                                    child:
                                    Text(
                                      "EMULGEL - TOPICAL - (TIO) at",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          // overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.012),
                                    ),


                                  ),
                                ),



                              ],
                            ),
                          ),


                          // Bottom Row
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.005,
                                right: MediaQuery.of(context).size.height * 0.005,
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.00),
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(06),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.01,
                                      right: MediaQuery.of(context).size.height * 0.01,
                                      top: MediaQuery.of(context).size.height * 0.01,
                                      bottom: MediaQuery.of(context).size.height * 0.01,),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[



                                          GestureDetector(
                                            onTap: () async {

                                            },
                                            child: Container(
                                              padding: new EdgeInsets.symmetric(
                                                  horizontal: MediaQuery.of(context).size.height * 0.015,

                                                  vertical: MediaQuery.of(context).size.height * 0.006,

                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF13678F),
                                                borderRadius: BorderRadius.circular(5),
                                              ),


                                              margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                right: MediaQuery.of(context).size.height * 0.005,
                                              ),
                                              // color: Colors.grey[300],
                                              alignment: Alignment.center,
                                              // height:
                                              // MediaQuery.of(context).size.height * 0.070,
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/Downlaod.png",
                                                    fit: BoxFit.fill,
                                                    color: Colors.white,
                                                    height: 10,
                                                    width: 10,
                                                  ),
                                                  SizedBox(width : 5),
                                                  Text("Radiology Report",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontWeight: FontWeight.w600,
                                                          fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {

                                            },
                                            child: Container(
                                              padding: new EdgeInsets.symmetric(
                                                horizontal: MediaQuery.of(context).size.height * 0.015,

                                                vertical: MediaQuery.of(context).size.height * 0.006,

                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF13678F),
                                                borderRadius: BorderRadius.circular(5),
                                              ),


                                              margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                right: MediaQuery.of(context).size.height * 0.005,
                                              ),
                                              // color: Colors.grey[300],
                                              alignment: Alignment.center,
                                              // height:
                                              // MediaQuery.of(context).size.height * 0.070,
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/Downlaod.png",
                                                    fit: BoxFit.fill,
                                                    color: Colors.white,
                                                    height: 10,
                                                    width: 10,
                                                  ),
                                                  SizedBox(width : 5),
                                                  Text("Lab Reports",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontWeight: FontWeight.w600,
                                                          fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                                ],
                                              ),
                                            ),
                                          ),



                                        ]),
                                  ),
                                ]),
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: screenHeight * 0.07,  // Outer circle height (adjust as needed)
          width: screenHeight * 0.07, // Outer circle width (adjust as needed)
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // Padding color (background ring)
          ),
          child: Padding(
            padding: EdgeInsets.all(
                screenHeight * 0.008), // Padding inside the outer circle
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Color(0xFF126086),
              // Button color
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return UploadPrescriptionMain();
                    },
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(screenHeight * 0.008),
                width: screenHeight * 0.03, // Adjust image width
                height: screenHeight * 0.03, // Adjust image height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/Upload.png'), // Replace with your asset path
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              elevation: 0.0,
              shape: CircleBorder(), // Ensures the button remains circular
            ),
          ),
        ),
        bottomNavigationBar: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    blurRadius: 20, // Spread of the shadow
                    offset: Offset(
                        0, -4), // Position the shadow above the BottomAppBar
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent, // Remove splash color
                  highlightColor: Colors.transparent, // Remove highlight color
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType
                      .fixed,
                  // Set fixed type for equal spacing
                  currentIndex: _selectedIndex,
                  // Track the selected tab
                  // Track the selected tab
                  onTap: _onItemTapped,

                  backgroundColor: Colors.white,
                  selectedItemColor:
                  Color(0xFF126086),
                  // Color for the selected item
                  unselectedItemColor:
                  Color(0xFF484C52),
                  // Color for unselected items
                  selectedFontSize: MediaQuery
                      .of(context)
                      .size
                      .height *
                      0.014,
                  // Hide the label font for selected items
                  unselectedFontSize: MediaQuery
                      .of(context)
                      .size
                      .height *
                      0.012,
                  // Hide the label font for unselected items
                  elevation: 0,
                  // Disable elevation
                  items: [
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.005,
                        ), // Add padding
                        child: Image.asset(
                          'assets/Homeactive.png',
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                        ),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.005,
                        ), // Add padding
                        child: Image.asset(
                          'assets/MyReports.png',
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                        ),
                      ),
                      label: 'My Reports',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.025,
                        ), // Add padding
                        child: Image.asset(
                          'assets/Appoinments.png',
                          width: 0,
                          height: 0,
                        ),
                      ),
                      label: 'Upload',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.005,
                        ), // Add padding
                        child: Image.asset(
                          'assets/Appoinments.png',
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                        ),
                      ),
                      label: 'Appointments',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.005,
                        ), // Add padding
                        child: Image.asset(
                          'assets/MyHealth.png',
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                        ),
                      ),
                      label: 'My Health',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      int selected = index;

      if (selected == 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePageMain()),
                (Route<dynamic> route) => false);
      } else if (selected == 1) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyReportsMain();
            },
          ),
        );
      } else if (selected == 2) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return UploadPrescriptionMain();
            },
          ),
        );
      } else if (selected == 3) {
        showBottomSheet();
      }
      else if (selected == 4) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyHealthMain();
            },
          ),
        );
      }

      /* widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;*/

      // Fluttertoast.showToast(msg: "test", toastLength: Toast.LENGTH_LONG);
      print(selected);
    });
  }

  void showBottomSheet() =>
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: false,
          backgroundColor: Colors.transparent, // Make modal background transparent
          barrierColor: Colors.transparent,
          transitionAnimationController: AnimationController(
            duration: const Duration(milliseconds: 200),
            vsync: Navigator.of(context),
          ),// No default barrier color
          builder: (BuildContext context) {
            return Stack(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, -2), // Shadow appears above the sheet
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ), // Keep your content background
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter setState) =>
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.025,
                                          right: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.0,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.015),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.01,
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
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              // Container(
                                              //   padding: EdgeInsets.only(
                                              //     top: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.0,
                                              //     bottom: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.03,
                                              //     left: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.18,
                                              //     right: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.18,
                                              //   ),
                                              //   child: Divider(
                                              //     height: 0,
                                              //     indent: 0,
                                              //     thickness: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.008,
                                              //     color: Color(0xFF95C8D6).withOpacity(0.3),
                                              //   ),
                                              // ),

                                              // Select the Type of Appointment

                                              GestureDetector(


                                                child: Center(
                                                  child: Container(

                                                    padding: EdgeInsets.only(
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.03,
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.18,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.18,
                                                    ),


                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.23,
                                                    // Same thickness as Divider
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.006,
                                                    // Same thickness as Divider
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFD9D9D9),
                                                      // Divider color
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          10), // Rounded edges
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.02),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.0,
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.02,
                                                    bottom: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.00),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
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
                                                                0.00),
                                                        child: Text(
                                                          "Select the Type of Appointment",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF2F3335),
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontSize:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.016,
                                                          ),
                                                        ),
                                                      ),

                                                    ]),
                                              ),


                                              //  Appointments
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) {
                                                        return AppointmentsFootMain();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.025,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.015),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFA8B1CE)
                                                        .withOpacity(
                                                        0.1),

                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        8), // Optional: Rounded corners
                                                  ),

                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00),
                                                  // color: Colors.white,
                                                  child: Container(
                                                    // color: Colors.white,

                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        gradient: LinearGradient(
                                                            begin:
                                                            Alignment
                                                                .centerLeft,
                                                            end:
                                                            Alignment
                                                                .centerRight,
                                                            stops: [
                                                              0.5,
                                                              0.9
                                                            ],
                                                            colors: [
                                                              Color(0x0A056390),
                                                              Color(0x0A056390),
                                                            ])),

                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        right: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                            left:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            right:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            top:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                    left: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.00,
                                                                  ),
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                      left: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      right: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      top: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                    ),
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    child:
                                                                    Image.asset(
                                                                      'assets/Appointments_ls.png',
                                                                      fit:
                                                                      BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.010),
                                                              Expanded(
                                                                flex: 8,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        top: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        bottom: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                      ),
                                                                      child: Text(
                                                                        "Appointments",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xFF126086),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontSize: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.014,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                              // Adding the side arrow at the end
                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                                // Dynamic icon size
                                                                color:
                                                                Color(
                                                                    0xFF126086),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //  Test And Services
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) {
                                                        return TestAndServicesMain();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.025,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.015),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFA8B1CE)
                                                        .withOpacity(
                                                        0.1),

                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        8), // Optional: Rounded corners
                                                  ),

                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00),
                                                  // color: Colors.white,
                                                  child: Container(
                                                    // color: Colors.white,

                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        gradient: LinearGradient(
                                                            begin:
                                                            Alignment
                                                                .centerLeft,
                                                            end:
                                                            Alignment
                                                                .centerRight,
                                                            stops: [
                                                              0.5,
                                                              0.9
                                                            ],
                                                            colors: [
                                                              Color(0x0A056390),
                                                              Color(0x0A056390),
                                                            ])),

                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        right: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                            left:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            right:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            top:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                    left: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.00,
                                                                  ),
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                      left: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      right: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      top: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                    ),
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    child:
                                                                    Image.asset(
                                                                      'assets/TestServicesBs.png',
                                                                      fit:
                                                                      BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),

                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.010),
                                                              Expanded(
                                                                flex: 8,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        top: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        bottom: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                      ),
                                                                      child: Text(
                                                                        "Test & Services",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xFF126086),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontSize: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.014,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                              // Adding the side arrow at the end
                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                                // Dynamic icon size
                                                                color:
                                                                Color(
                                                                    0xFF126086),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ]
            );
          }
      );
}


class TreatmentMedicationDetail extends StatelessWidget {
  final String text;
  final Color backgroundcolor;

  const TreatmentMedicationDetail(
      {
        super.key,
        required this.text,
        required this.backgroundcolor
      });



  @override
  Widget build(BuildContext context) {
      return Expanded(
        child: Container(
          color : backgroundcolor,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.02,

            vertical: MediaQuery.of(context).size.height * 0.005,

          ),
          alignment: Alignment.center,
          child:
          Text(
              text,
            style: TextStyle(
                color: Color(0x80101828),
                // overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                fontSize:
                MediaQuery.of(context).size.height *
                    0.011
            ),
          ),


        ),
      );
  }

}