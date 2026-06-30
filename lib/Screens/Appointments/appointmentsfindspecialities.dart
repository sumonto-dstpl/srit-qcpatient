import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/Models/findspecialitiesres.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';

import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/finddoctorslist.dart';
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
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';



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
    ["assets/GeneralPhysician.png", "General\nPhysician"],
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
    // getSharedPrefs();
    super.initState();
  }

  Future getSharedPrefs() async {
    // CheckSession();
    getSpecialitiesList();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
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
              Header(userName: usernameValue),
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
      floatingActionButton:  CustomFloatingActionButton(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }







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
