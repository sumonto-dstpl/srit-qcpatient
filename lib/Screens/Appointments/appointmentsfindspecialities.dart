import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/Models/findspecialitiesres.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';

import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';

import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';


import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';




class AppointmentsFindSpecialities extends StatefulWidget {
  const AppointmentsFindSpecialities({
    super.key,
  });
  @override
  State<AppointmentsFindSpecialities> createState() =>
      AppointmentsFindSpecialitiesstate();
}

class AppointmentsFindSpecialitiesstate
    extends State<AppointmentsFindSpecialities> {
  ConnectivityService connectivityservice = ConnectivityService();

  int _selectedIndex = 0;

  APIService apiService = new APIService();
  late ProgressDialog progressDialog;

  List<SpecialityResponse>? responselist = [];

  String usernameValue = "Find Specialties";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  final mytopspecialities = [
    ["assets/GeneralPhysician.png", "General Physician"],
    ["assets/ENT.png", "ENT"],
    ["assets/Dermatology.png", "Dermatology"],
    ["assets/Cardiology.png", "Cardiology"],
    ["assets/Urology.png", "Urology"],
    ["assets/Orthopedics.png", "Orthopedics"],
    ["assets/Endocrinology.png", "Endocrinology"],
    ["assets/Pediatrics.png", "Pediatrics"],
    ["assets/GeneralPhysician.png", "General Physician"],
    ["assets/ENT.png", "ENT"],
    ["assets/Dermatology.png", "Dermatology"],
    ["assets/Cardiology.png", "Cardiology"],
    ["assets/Urology.png", "Urology"],
    ["assets/Orthopedics.png", "Orthopedics"],
    ["assets/Endocrinology.png", "Endocrinology"],
    ["assets/Pediatrics.png", "Pediatrics"],
    ["assets/GeneralPhysician.png", "General Physician"],
    ["assets/ENT.png", "ENT"],
    ["assets/Dermatology.png", "Dermatology"],
    ["assets/Cardiology.png", "Cardiology"],
    ["assets/Urology.png", "Urology"],
    ["assets/Orthopedics.png", "Orthopedics"],
    ["assets/Endocrinology.png", "Endocrinology"],
    ["assets/Pediatrics.png", "Pediatrics"],
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();
  TextEditingController SearchEditTextController = TextEditingController();

  @override
  void initState() {
    getSharedPrefs();
    super.initState();
  }

  Future getSharedPrefs() async {
    // CheckSession();
    getSpecialitiesList();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    progressDialog.style(
        message: 'Loading..' '\nPlease Wait',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          color: Colors.blueAccent,
          strokeWidth: MediaQuery.of(context).size.height * 0.002,
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 13.0,
        ),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w600));
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
              // Container(
              //   padding: EdgeInsets.only(
              //     top: screenHeight * 0.05,
              //     left: screenWidth * 0.02,
              //     right: screenWidth * 0.02,
              //     bottom: screenWidth * 0.02,
              //   ),
              //   margin: EdgeInsets.only(
              //     right: screenHeight * 0.0,
              //     top: screenHeight * 0.0,
              //     bottom: screenHeight * 0.01,
              //     left: screenHeight * 0.0,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Expanded(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               padding: EdgeInsets.only(
              //                 top: MediaQuery.of(context).size.height * 0.00,
              //                 bottom: MediaQuery.of(context).size.height * 0.00,
              //                 left: MediaQuery.of(context).size.height * 0.00,
              //                 right: MediaQuery.of(context).size.height * 0.00,
              //               ),
              //               child: Text(
              //                 usernameValue,
              //                 style: TextStyle(
              //                   fontSize:
              //                       MediaQuery.of(context).size.height * 0.018,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //                 overflow: TextOverflow.ellipsis,
              //                 textAlign: TextAlign.left,
              //               ),
              //             ),
              //             Container(
              //               padding: EdgeInsets.only(
              //                 top: MediaQuery.of(context).size.height * 0.00,
              //                 bottom: MediaQuery.of(context).size.height * 0.00,
              //                 left: MediaQuery.of(context).size.height * 0.00,
              //                 right: MediaQuery.of(context).size.height * 0.00,
              //               ),
              //               child: Text(
              //                 useraddressValue,
              //                 style: TextStyle(
              //                   overflow: TextOverflow.ellipsis,
              //                   fontSize:
              //                       MediaQuery.of(context).size.height * 0.014,
              //                   color: Colors.white,
              //                 ),
              //                 textAlign: TextAlign.left,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       // Action Bar 2nd half
              //       Expanded(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //
              //
              //             // Cart
              //             GestureDetector(
              //               onTap: () {
              //                 Navigator.of(context).push(
              //                   MaterialPageRoute(
              //                     builder:
              //                         (BuildContext context) {
              //                       return AddToCartMain();
              //                     },
              //                   ),
              //                 );
              //               },
              //               child:
              //               AppointmentIconBadge(
              //                 appointmentcount: "",
              //               ),
              //             ),
              //
              //
              //             // Notification
              //             GestureDetector(
              //               onTap: () {
              //                 Navigator.of(context).push(
              //                   MaterialPageRoute(
              //                     builder:
              //                         (BuildContext context) {
              //                       return NotificationMain();
              //                     },
              //                   ),
              //                 );
              //               },
              //               child:
              //               IconBadge(
              //                 notificationcount: "",
              //               ),
              //             ),
              //
              //
              //             // Profile Image
              //             userprofilepValue != "NA"
              //                 ?
              //
              //             GestureDetector(
              //                 onTap: () async {
              //                   Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                       builder: (BuildContext context) {
              //                         return ProfileMain();
              //                       },
              //                     ),
              //                   );
              //                 }, child:
              //             Container(
              //               height: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height *
              //                   0.050,
              //               width: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height *
              //                   0.050,
              //               decoration: BoxDecoration(
              //                 border: Border.all(
              //                   width: 1.0,
              //                   color: Colors.white,
              //                 ),
              //                 shape: BoxShape.circle,
              //                 image: new DecorationImage(
              //                   fit: BoxFit.fill,
              //                   image: Image
              //                       .memory(
              //                       base64Decode(userprofilepValue))
              //                       .image,
              //                 ),
              //               ),
              //             )
              //             )
              //                 : GestureDetector(
              //               onTap: () async {
              //                 Navigator.of(context).push(
              //                   MaterialPageRoute(
              //                     builder: (BuildContext context) {
              //                       return ProfileMain();
              //                     },
              //                   ),
              //                 );
              //               }, child: Container(
              //               height: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height *
              //                   0.045,
              //               width: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height *
              //                   0.045,
              //               padding: EdgeInsets.only(
              //                 left: MediaQuery
              //                     .of(context)
              //                     .size
              //                     .height *
              //                     0.00,
              //               ),
              //               decoration: BoxDecoration(
              //                 color: Colors.green,
              //                 shape: BoxShape.circle,
              //                 border: Border.all(
              //                   width: 1.0,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(130.0),
              //                 child: Image.asset(
              //                   'assets/drsujeet.png',
              //                   fit: BoxFit.fill,
              //                 ),
              //               ),
              //             ),
              //             )
              //
              //
              //
              //
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // Main Content Section
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
                            /* Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) {
                                      return GoogleMapScreen();
                                    },
                                  ),
                                );*/
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
                      // Search Input Field
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
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                              decoration: BoxDecoration(
                                color: Color(0xFFA8B1CE).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              alignment: Alignment.centerRight,
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
                              margin: EdgeInsets.only(
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.0,
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
                                    child:  Text(
                                              'Speciality',
                                              style: TextStyle(
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
                                    // DefaultTextStyle(
                                    //   style: TextStyle(
                                    //       color: Color(0xFF126086),
                                    //       overflow: TextOverflow.ellipsis,
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize:
                                    //       MediaQuery
                                    //           .of(context)
                                    //           .size
                                    //           .height * 0.016),
                                    //   child: AnimatedTextKit(
                                    //     animatedTexts: [
                                    //       RotateAnimatedText(
                                    //         'Doctor',
                                    //         textStyle: TextStyle(
                                    //             color: Color(0xFF126086),
                                    //             overflow: TextOverflow.ellipsis,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize:
                                    //             MediaQuery
                                    //                 .of(context)
                                    //                 .size
                                    //                 .height *
                                    //                 0.014), // Red text
                                    //       ),
                                    //       RotateAnimatedText(
                                    //         'Speciality',
                                    //         textStyle: TextStyle(
                                    //             color: Color(0xFF126086),
                                    //             overflow: TextOverflow.ellipsis,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize:
                                    //             MediaQuery
                                    //                 .of(context)
                                    //                 .size
                                    //                 .height *
                                    //                 0.014),
                                    //       ),
                                    //
                                    //       RotateAnimatedText(
                                    //         'Symptoms',
                                    //         textStyle: TextStyle(
                                    //             color: Color(0xFF126086),
                                    //             overflow: TextOverflow.ellipsis,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize:
                                    //             MediaQuery
                                    //                 .of(context)
                                    //                 .size
                                    //                 .height *
                                    //                 0.014),
                                    //       ),
                                    //     ],
                                    //     repeatForever: true,
                                    //     pause: Duration(milliseconds: 500),
                                    //     onTap: () {
                                    //       Navigator.of(context).push(
                                    //         MaterialPageRoute(
                                    //           builder: (BuildContext context) {
                                    //             return QuickSearchWithoutData();
                                    //           },
                                    //         ),
                                    //       );
                                    //       print("Tap Event");
                                    //     },
                                    //   ),
                                    // ),
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
                      bottom: MediaQuery.of(context).size.height * 0.025),
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
                    children: [
                     
                      // Top Specialties
                      Padding(
                        padding: EdgeInsets.only(
                            top : MediaQuery.of(context).size.height * 0.015,
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
                          // crossAxisSpacing: 10,
                          // mainAxisSpacing: 10,
                          
                          children: [
                            // Manually create the list of widgets for each item in responselist
                            // mytopspecialities
                            for (var i = 0; i < mytopspecialities!.length; i++)
                              Column(
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
                                      minimumSize: Size(screenHeight * 0.04,
                                          screenHeight * 0.04),
                                    ),
                                    child: Container(
                                      width: screenHeight * 0.03,
                                      height: screenHeight * 0.03,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(mytopspecialities[i]
                                              [
                                              0]), // Ensure `mytopspecialities` is correctly defined
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(screenHeight * 0.00),
                                      child: Text(
                                        mytopspecialities![i]
                                        [1],
                                            // .name!, // Ensure `responselist` is correctly defined
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),                    ],
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

      // First  - Center Docked
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

      // Bottom Navigation with another  positioned on the right
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
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

  /*void CheckSession() {
    connectivityservice.checkconnectivity().then((intenet) async {
      final prefusertypevalue = await UserSecureStorage.getUserType() ?? 'NA';
      progressDialog = ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: true,
          showLogs: false);
      progressDialog.style(
          message: 'Loading Data..' '\nPlease Wait',
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(
            color: Colors.blueAccent,
            strokeWidth: MediaQuery.of(context).size.height * 0.002,
          ),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
            color: Colors.blueAccent,
            fontSize: 13.0,
          ),
          messageTextStyle: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w600));
      if (intenet != null && intenet) {
        progressDialog.show();
        var user = await apiService.GetDashboardDetailsnew();
        final preNRStatuscodeval =
            await UserSecureStorage.getNRStatuscodeval() ?? 'NA';

        if (preNRStatuscodeval == "401") {
          var user = await apiService.refreshtoken();
          final preNRStatuscodevalforrefresh =
              await UserSecureStorage.getNRStatuscodeval() ?? 'NA';

          if (preNRStatuscodevalforrefresh == "200") {
            CheckSession();
          } else if (preNRStatuscodevalforrefresh == "401") {
            progressDialog.hide();
            customalert.showError(context);
          } else if (preNRStatuscodevalforrefresh == "400") {
            progressDialog.hide();
            customalert.showError(context);
          }
        } else {
          getPendingRecordList();
        }
      } else {
        final snackBar =
            SnackBar(content: Text("No Internet, Check Connectivity!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }*/

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

  void getSpecialitiesList() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        /* progressDialog.showMaterial(
            title: "Loading Data", message: "Please wait");*/
        progressDialog.show();
        dynamic user = await apiService.findspecialitieslist();

        if (user.message != null) {
          progressDialog.hide();
          final snackBar = SnackBar(content: Text(user.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        // Get the list data and show it

        else if (user.response!.length > 0) {
          progressDialog.hide();

          setState(() {
            responselist = user.response;
          });

          /* final snackBar = SnackBar(
            content: Text("Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );*/
        } else {
          progressDialog.hide();
          final snackBar = SnackBar(
            content: Text("Specialities Not Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // customalert.showError(context, user.error);
        }
      } else {
        // No-Internet Case
        final snackBar = SnackBar(
          content: Text("No Internet, Check Connectivity!"),
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
