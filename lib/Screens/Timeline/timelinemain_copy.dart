import 'dart:convert';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
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
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/HomeCare/diagnosticmain.dart';
import 'package:newfolder/Screens/HomeCare/doctorhcmain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Radiology/pastupcomingtestscan.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Timeline/timelinedetails.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';

import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';

import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';


class TimelineMain extends StatefulWidget {
  int selectedIndex = 0;

  TimelineMain({
    super.key,
  });

  @override
  State<TimelineMain> createState() => TimelineMainstate();
}

class TimelineMainstate extends State<TimelineMain> {
  String usernameValue = "TimeLine";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  bool _isExpandedfiles = true;
  final mytopspecialities = [
    ["assets/Diagnostic.png", "Diagnostic"],
    ["assets/Doctor.png", "Doctor"],
    ["assets/Nurse.png", "Nurse"],
    ["assets/Physio.png", "Physio"],
    ["assets/MedicalEquipment.png", "Medical Equipment's"],
  ];
  String? selectedCity;
  double _progress = 0.6;
  final TextEditingController countryController = TextEditingController();
  String? selectedCountryId;

  // Define the country values and names
  final List<Map<String, String>> countries = [
    {'id': '1', 'name': 'India'},
    {'id': '2', 'name': 'United States'},
    {'id': '3', 'name': 'Canada'},
    {'id': '4', 'name': 'Australia'},
    {'id': '5', 'name': 'United Kingdom'},
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  TextEditingController FullNameEditTextController = TextEditingController();
  TextEditingController AddTestDetailsTextController = TextEditingController();
  TextEditingController MobileNummberEditTextController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double progressWidth = MediaQuery.of(context).size.width * 0.92;

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
              Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  bottom: screenWidth * 0.02,
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
                          right: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF126086).withOpacity(0.2),
                          shape: BoxShape.circle,
                          border:
                          Border.all(width: 0.0, color: Color(0xFF126086)),
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

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                            ),
                            child: Text(
                              usernameValue,
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height * 0.018,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                            ),
                            child: Text(
                              useraddressValue,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.014,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
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
                                0.045,
                            width: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.045,
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
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.00),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.03),
                      topRight: Radius.circular(screenHeight * 0.03),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      // Progress Bars
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: [
                                // LinearProgressIndicator

                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.025,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: SizedBox(
                                    width: progressWidth,
                                    // Set width for the progress bar
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      // Set border radius for rounded corners
                                      child: LinearProgressIndicator(
                                        value: _progress,
                                        // Set the progress value (from 0.0 to 1.0)
                                        minHeight:
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                        // Set the height of the progress bar
                                        backgroundColor: Colors.grey[300],
                                        // Background color of the progress bar
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(Color(
                                            0xFF126086)), // Progress bar color
                                      ),
                                    ),
                                  ),
                                ),

                                // Circle positioned based on progress
                                Positioned(
                                  left: progressWidth * _progress - 13,
                                  // Position the circle at the progress point
                                  top: 13,
                                  // Adjust vertical position to align with the progress bar
                                  child: Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.018,
                                    height: MediaQuery.of(context).size.height *
                                        0.018,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xFF126086),
                                        // Border color for the circle
                                        width:
                                        MediaQuery.of(context).size.height *
                                            0.003,
                                      ),
                                      color: Colors
                                          .white, // Background color for the circle
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.02,
                            right: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left:
                                  MediaQuery.of(context).size.height * 0.0,
                                  right: MediaQuery.of(context).size.height *
                                      0.005,
                                  top:
                                  MediaQuery.of(context).size.height * 0.00,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.00),
                              child: Text(
                                "20-12-2023",
                                style: TextStyle(
                                    color: Color(0xFF126086),
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.014),
                              ),
                            ),
                            SizedBox(
                                width:
                                MediaQuery.of(context).size.height * 0.15),
                            Container(
                              padding: EdgeInsets.only(
                                  left:
                                  MediaQuery.of(context).size.height * 0.0,
                                  right: MediaQuery.of(context).size.height *
                                      0.005,
                                  top:
                                  MediaQuery.of(context).size.height * 0.00,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.00),
                              child: Text(
                                "11-01-2024",
                                style: TextStyle(
                                    color: Colors.black54,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.013),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Expansion Tile 1
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.010,
                          left: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height *
                                  0.01, // Dynamic border radius for top
                            ),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isExpandedfiles = !_isExpandedfiles;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9).withOpacity(0.2),
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey, // Top border color
                                        width: 2.0, // Top border thickness
                                      ),
                                      right: BorderSide(
                                        color:
                                        Colors.grey, // Right border color
                                        width: 2.0, // Right border thickness
                                      ),
                                      bottom: BorderSide(
                                        color:
                                        Colors.grey, // Bottom border color
                                        width: _isExpandedfiles
                                            ? 1.0
                                            : 2.0, // Reduced bottom border thickness on expansion
                                      ),
                                      left: BorderSide(
                                        color: Colors.grey, // Left border color
                                        width: 2.0, // Left border thickness
                                      ),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top left radius
                                      topRight: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top right radius
                                      bottomLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Bottom-left curve radius
                                      bottomRight: Radius.circular(MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.01), // Bottom-right curve radius
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.01, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01, // Dynamic bottom padding
                                    left: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic left padding
                                    right: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic right padding
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "December 2023",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.016, // Dynamic font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        _isExpandedfiles
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        size:
                                        MediaQuery.of(context).size.height *
                                            0.02, // Dynamic icon size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_isExpandedfiles)
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.01,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Left text column for each step

                                      Container(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            right: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00,
                                            top: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00,
                                            bottom: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.044),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.0,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00),
                                              child: Text(
                                                "20 - 12",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.014),
                                              ),
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.1),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.0,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00),
                                              child: Text(
                                                "25 - 12",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.014),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Vertical line with dots
                                      Column(
                                        children: [
                                          // Top section with dot
                                          Transform.rotate(
                                            angle: 45 * (3.14159 / 180),
                                            // Convert 45 degrees to radians
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                border: Border.all(
                                                    color: Color(0xFF126086),
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.01),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.04,
                                            color: Color(0xFF126086),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF126086),
                                              border: Border.all(
                                                  color: Color(0xFF126086),
                                                  width: 2),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.110,
                                            color: Color(0xFF126086),
                                          ),
                                          // Middle section with dot
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF126086),
                                              border: Border.all(
                                                  color: Color(0xFF126086),
                                                  width: 2),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.090,
                                            color: Color(0xFF126086),
                                          ),
                                          Transform.rotate(
                                            angle: 45 * (3.14159 / 180),
                                            // Convert 45 degrees to radians
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                border: Border.all(
                                                    color: Color(0xFF126086),
                                                    width: 2),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Right details column for each step
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              right: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.015,
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02,
                                              bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              // 1st column

                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) {
                                                        return TimelineDetails();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFFF1E6),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.0,
                                                            right: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            top: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00),
                                                        child: Text(
                                                          "Difficulty in breathing (OP)",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF126086),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.016),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.0,
                                                            right: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            top: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00),
                                                        child: Text(
                                                          "Dr. Steve, Cardiology",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              fontSize: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.014),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                        EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                        ),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: "HIP: ",
                                                                style:
                                                                TextStyle(
                                                                  // backgroundColor: Colors.black, // Background color for "HIP:"
                                                                  color: Colors
                                                                      .black,
                                                                  // Text color for "HIP:"
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  // Make "HIP:" bold
                                                                  fontSize: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.014,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                "Duration: 6 Days : Intensity: Severe Onset/Time course: Acute : Radiation of Pain: Chest Associated Symptoms:vomiting",
                                                                style:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  // Color for the rest of the text
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  // Bold for the rest of the text (optional)
                                                                  fontSize: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.014,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.014),
                                              // Spacing for vertical alignment

                                              // 2nd column
                                              Container(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFeaffe6),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right:
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      child: Text(
                                                        "Chest Pain (IP)",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF126086),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.016),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right:
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      child: Text(
                                                        "Dr. Steve, Cardiology",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.014),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.0,
                                                        right: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.015,
                                                        top: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        bottom: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                      ),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "HIP: ",
                                                              style: TextStyle(
                                                                // backgroundColor: Colors.black, // Background color for "HIP:"
                                                                color: Colors
                                                                    .black,
                                                                // Text color for "HIP:"
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                // Make "HIP:" bold
                                                                fontSize: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                              "Duration: 6 Days : Intensity: Severe Onset/Time course: Acute : Radiation of Pain: Chest Associated Symptoms:vomiting",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                // Color for the rest of the text
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                // Bold for the rest of the text (optional)
                                                                fontSize: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Expansion Tile 2
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.010,
                          left: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height *
                                  0.01, // Dynamic border radius for top
                            ),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isExpandedfiles = !_isExpandedfiles;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9).withOpacity(0.2),
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey, // Top border color
                                        width: 2.0, // Top border thickness
                                      ),
                                      right: BorderSide(
                                        color:
                                        Colors.grey, // Right border color
                                        width: 2.0, // Right border thickness
                                      ),
                                      bottom: BorderSide(
                                        color:
                                        Colors.grey, // Bottom border color
                                        width: _isExpandedfiles
                                            ? 1.0
                                            : 2.0, // Reduced bottom border thickness on expansion
                                      ),
                                      left: BorderSide(
                                        color: Colors.grey, // Left border color
                                        width: 2.0, // Left border thickness
                                      ),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top left radius
                                      topRight: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top right radius
                                      bottomLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Bottom-left curve radius
                                      bottomRight: Radius.circular(MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.01), // Bottom-right curve radius
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.01, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01, // Dynamic bottom padding
                                    left: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic left padding
                                    right: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic right padding
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "January 2024",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.016, // Dynamic font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        _isExpandedfiles
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        size:
                                        MediaQuery.of(context).size.height *
                                            0.02, // Dynamic icon size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_isExpandedfiles)
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.01,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Left text column for each step

                                      Container(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            right: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00,
                                            top: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00,
                                            bottom: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.044),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.0,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00),
                                              child: Text(
                                                "20 - 12",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.014),
                                              ),
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.1),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.0,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00),
                                              child: Text(
                                                "25 - 12",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.014),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Vertical line with dots
                                      Column(
                                        children: [
                                          // Top section with dot
                                          Transform.rotate(
                                            angle: 45 * (3.14159 / 180),
                                            // Convert 45 degrees to radians
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                border: Border.all(
                                                    color: Color(0xFF126086),
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.01),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.04,
                                            color: Color(0xFF126086),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF126086),
                                              border: Border.all(
                                                  color: Color(0xFF126086),
                                                  width: 2),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.110,
                                            color: Color(0xFF126086),
                                          ),
                                          // Middle section with dot
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF126086),
                                              border: Border.all(
                                                  color: Color(0xFF126086),
                                                  width: 2),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.090,
                                            color: Color(0xFF126086),
                                          ),
                                          Transform.rotate(
                                            angle: 45 * (3.14159 / 180),
                                            // Convert 45 degrees to radians
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                border: Border.all(
                                                    color: Color(0xFF126086),
                                                    width: 2),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Right details column for each step
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              right: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.015,
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02,
                                              bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              // 1st column

                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) {
                                                        return TimelineDetails();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFFF1E6),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.0,
                                                            right: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            top: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00),
                                                        child: Text(
                                                          "Difficulty in breathing (OP)",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF126086),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.016),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.0,
                                                            right: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            top: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00),
                                                        child: Text(
                                                          "Dr. Steve, Cardiology",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              fontSize: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.014),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                        EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                        ),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: "HIP: ",
                                                                style:
                                                                TextStyle(
                                                                  // backgroundColor: Colors.black, // Background color for "HIP:"
                                                                  color: Colors
                                                                      .black,
                                                                  // Text color for "HIP:"
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  // Make "HIP:" bold
                                                                  fontSize: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.014,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                "Duration: 6 Days : Intensity: Severe Onset/Time course: Acute : Radiation of Pain: Chest Associated Symptoms:vomiting",
                                                                style:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  // Color for the rest of the text
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  // Bold for the rest of the text (optional)
                                                                  fontSize: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.014,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.014),
                                              // Spacing for vertical alignment

                                              // 2nd column
                                              Container(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFeaffe6),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right:
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      child: Text(
                                                        "Chest Pain (IP)",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF126086),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.016),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right:
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      child: Text(
                                                        "Dr. Steve, Cardiology",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.014),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.0,
                                                        right: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.015,
                                                        top: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        bottom: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                      ),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "HIP: ",
                                                              style: TextStyle(
                                                                // backgroundColor: Colors.black, // Background color for "HIP:"
                                                                color: Colors
                                                                    .black,
                                                                // Text color for "HIP:"
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                // Make "HIP:" bold
                                                                fontSize: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                              "Duration: 6 Days : Intensity: Severe Onset/Time course: Acute : Radiation of Pain: Chest Associated Symptoms:vomiting",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                // Color for the rest of the text
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                // Bold for the rest of the text (optional)
                                                                fontSize: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),


                      // Expansion Tile 3
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.010,
                          left: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height *
                                  0.01, // Dynamic border radius for top
                            ),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isExpandedfiles = !_isExpandedfiles;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9).withOpacity(0.2),
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey, // Top border color
                                        width: 2.0, // Top border thickness
                                      ),
                                      right: BorderSide(
                                        color:
                                        Colors.grey, // Right border color
                                        width: 2.0, // Right border thickness
                                      ),
                                      bottom: BorderSide(
                                        color:
                                        Colors.grey, // Bottom border color
                                        width: _isExpandedfiles
                                            ? 1.0
                                            : 2.0, // Reduced bottom border thickness on expansion
                                      ),
                                      left: BorderSide(
                                        color: Colors.grey, // Left border color
                                        width: 2.0, // Left border thickness
                                      ),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top left radius
                                      topRight: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top right radius
                                      bottomLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Bottom-left curve radius
                                      bottomRight: Radius.circular(MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.01), // Bottom-right curve radius
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.01, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01, // Dynamic bottom padding
                                    left: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic left padding
                                    right: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic right padding
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "December 2023",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.016, // Dynamic font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(
                                        _isExpandedfiles
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        size:
                                        MediaQuery.of(context).size.height *
                                            0.02, // Dynamic icon size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_isExpandedfiles)
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.01,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Left text column for each step

                                      Container(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            right: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00,
                                            top: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00,
                                            bottom: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.044),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.0,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00),
                                              child: Text(
                                                "20 - 12",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.014),
                                              ),
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.1),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.0,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00),
                                              child: Text(
                                                "25 - 12",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.014),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Vertical line with dots
                                      Column(
                                        children: [
                                          // Top section with dot
                                          Transform.rotate(
                                            angle: 45 * (3.14159 / 180),
                                            // Convert 45 degrees to radians
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                border: Border.all(
                                                    color: Color(0xFF126086),
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.01),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.04,
                                            color: Color(0xFF126086),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF126086),
                                              border: Border.all(
                                                  color: Color(0xFF126086),
                                                  width: 2),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.110,
                                            color: Color(0xFF126086),
                                          ),
                                          // Middle section with dot
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF126086),
                                              border: Border.all(
                                                  color: Color(0xFF126086),
                                                  width: 2),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.002,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.090,
                                            color: Color(0xFF126086),
                                          ),
                                          Transform.rotate(
                                            angle: 45 * (3.14159 / 180),
                                            // Convert 45 degrees to radians
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                border: Border.all(
                                                    color: Color(0xFF126086),
                                                    width: 2),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Right details column for each step
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01,
                                              right: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.015,
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02,
                                              bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              // 1st column

                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) {
                                                        return TimelineDetails();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFFF1E6),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.0,
                                                            right: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            top: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00),
                                                        child: Text(
                                                          "Difficulty in breathing (OP)",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF126086),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.016),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.0,
                                                            right: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            top: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00),
                                                        child: Text(
                                                          "Dr. Steve, Cardiology",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              fontSize: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.014),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                        EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                        ),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: "HIP: ",
                                                                style:
                                                                TextStyle(
                                                                  // backgroundColor: Colors.black, // Background color for "HIP:"
                                                                  color: Colors
                                                                      .black,
                                                                  // Text color for "HIP:"
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  // Make "HIP:" bold
                                                                  fontSize: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.014,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                "Duration: 6 Days : Intensity: Severe Onset/Time course: Acute : Radiation of Pain: Chest Associated Symptoms:vomiting",
                                                                style:
                                                                TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  // Color for the rest of the text
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  // Bold for the rest of the text (optional)
                                                                  fontSize: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.014,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.014),
                                              // Spacing for vertical alignment

                                              // 2nd column
                                              Container(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFeaffe6),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8.0),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right:
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      child: Text(
                                                        "Chest Pain (IP)",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF126086),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.016),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.0,
                                                          right:
                                                          MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          top: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      child: Text(
                                                        "Dr. Steve, Cardiology",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.014),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.0,
                                                        right: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.015,
                                                        top: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        bottom: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                      ),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "HIP: ",
                                                              style: TextStyle(
                                                                // backgroundColor: Colors.black, // Background color for "HIP:"
                                                                color: Colors
                                                                    .black,
                                                                // Text color for "HIP:"
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                // Make "HIP:" bold
                                                                fontSize: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                              "Duration: 6 Days : Intensity: Severe Onset/Time course: Acute : Radiation of Pain: Chest Associated Symptoms:vomiting",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                // Color for the rest of the text
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                // Bold for the rest of the text (optional)
                                                                fontSize: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
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

  void showBottomSheet() => showModalBottomSheet(
    enableDrag: false,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    barrierColor: Colors.grey.withOpacity(0.9),
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) =>
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.025,
                      right: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.015),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.0,
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                      ),
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.0,
                        bottom: MediaQuery.of(context).size.height * 0.0,
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0,
                              bottom: MediaQuery.of(context).size.height * 0.03,
                              left: MediaQuery.of(context).size.height * 0.18,
                              right: MediaQuery.of(context).size.height * 0.18,
                            ),
                            child: Divider(
                              height: 0,
                              indent: 0,
                              thickness: MediaQuery.of(context).size.height * 0.008,
                              color:Color(0xFF95C8D6).withOpacity(0.3),
                            ),
                          ),

                          // Select the Type of Appointment
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.0,
                                right: MediaQuery.of(context).size.height * 0.02,
                                bottom: MediaQuery.of(context).size.height * 0.00),
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
                                      "Select the Type of Appointment",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
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
                                  builder: (BuildContext context) {
                                    return AppointmentsFootMain();
                                  },
                                ),
                              );
                            },
                            child:Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.025,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.015),
                              decoration: BoxDecoration(
                                color: Color(0xFFA8B1CE).withOpacity(0.1), // Background color of the container
                                /*  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(
                                          0.1), // Shadow color
                                      blurRadius:
                                      5, // Spread of the shadow
                                      offset: Offset(0,
                                          0), // Offset in x and y direction
                                    ),
                                  ],*/
                                borderRadius: BorderRadius.circular(
                                    8), // Optional: Rounded corners
                              ),

                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.0,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00),
                              // color: Colors.white,
                              child: Container(
                                // color: Colors.white,

                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin:
                                        Alignment.centerLeft,
                                        end:
                                        Alignment.centerRight,
                                        stops: [
                                          0.5,
                                          0.9
                                        ],
                                        colors: [
                                          Color(0xFFA8B1CE).withOpacity(0.1),
                                          Color(0xFFA8B1CE).withOpacity(0.1),
                                        ])),

                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.005,
                                        right:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.005,
                                        top:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.00,
                                        bottom:
                                        MediaQuery.of(context)
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
                                              EdgeInsets.only(
                                                left: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                              ),
                                              child:  Container(
                                                margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.height * 0.01,
                                                  right: MediaQuery.of(context).size.height * 0.01,
                                                  top: MediaQuery.of(context).size.height * 0.01,
                                                  bottom: MediaQuery.of(context).size.height * 0.01,
                                                ),
                                                height: MediaQuery.of(context).size.height * 0.025,
                                                width: MediaQuery.of(context).size.height * 0.025,
                                                child:
                                                Image.asset(
                                                  'assets/AppointmentBs.png',
                                                  fit:
                                                  BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(
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
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                  EdgeInsets
                                                      .only(
                                                    left: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    right: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    top: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.0,
                                                    bottom: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                  ),
                                                  child: Text(
                                                    "Appointments",
                                                    style:
                                                    TextStyle(
                                                      color: Color(0xFF126086),
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      fontSize: MediaQuery.of(context)
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
                                            size: MediaQuery.of(
                                                context)
                                                .size
                                                .height *
                                                0.018, // Dynamic icon size
                                            color:
                                            Color(0xFF126086),
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
                                  builder: (BuildContext context) {
                                    return TestAndServicesMain();
                                  },
                                ),
                              );
                            },
                            child:Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.025,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.015),
                              decoration: BoxDecoration(
                                color: Color(0xFFA8B1CE).withOpacity(0.1), // Background color of the container
                                /*  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(
                                          0.1), // Shadow color
                                      blurRadius:
                                      5, // Spread of the shadow
                                      offset: Offset(0,
                                          0), // Offset in x and y direction
                                    ),
                                  ],*/
                                borderRadius: BorderRadius.circular(
                                    8), // Optional: Rounded corners
                              ),

                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.0,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00),
                              // color: Colors.white,
                              child: Container(
                                // color: Colors.white,

                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin:
                                        Alignment.centerLeft,
                                        end:
                                        Alignment.centerRight,
                                        stops: [
                                          0.5,
                                          0.9
                                        ],
                                        colors: [
                                          Color(0xFFA8B1CE).withOpacity(0.1),
                                          Color(0xFFA8B1CE).withOpacity(0.1),
                                        ])),

                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.005,
                                        right:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.005,
                                        top:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.00,
                                        bottom:
                                        MediaQuery.of(context)
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
                                              EdgeInsets.only(
                                                left: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                              ),
                                              child:   Container(
                                                margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.height * 0.01,
                                                  right: MediaQuery.of(context).size.height * 0.01,
                                                  top: MediaQuery.of(context).size.height * 0.01,
                                                  bottom: MediaQuery.of(context).size.height * 0.01,
                                                ),
                                                height: MediaQuery.of(context).size.height * 0.025,
                                                width: MediaQuery.of(context).size.height * 0.025,
                                                child:
                                                Image.asset(
                                                  'assets/TestServicesBs.png',
                                                  fit:
                                                  BoxFit.fill,
                                                ),
                                              ),

                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(
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
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                  EdgeInsets
                                                      .only(
                                                    left: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    right: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    top: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.0,
                                                    bottom: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                  ),
                                                  child: Text(
                                                    "Test & Services",
                                                    style:
                                                    TextStyle(
                                                      color: Color(0xFF126086),
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      fontSize: MediaQuery.of(context)
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
                                            size: MediaQuery.of(
                                                context)
                                                .size
                                                .height *
                                                0.018, // Dynamic icon size
                                            color:
                                            Color(0xFF126086),
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
  );
}
