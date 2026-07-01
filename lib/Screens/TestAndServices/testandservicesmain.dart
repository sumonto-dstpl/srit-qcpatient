import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
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
import 'package:newfolder/Screens/HomeCare/homecaremain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Medications/medicationselecttime.dart';
import 'package:newfolder/Screens/Medications/medicationsmybook.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Radiology/pastupcomingtestscan.dart';
import 'package:newfolder/Screens/Radiology/radiologymain.dart';
import 'package:newfolder/Screens/Radiology/testscandetails.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Widgets/tab_item.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class TestAndServicesMain extends StatefulWidget {
  int selectedIndex = 3;

  TestAndServicesMain({
    super.key,
  });

  @override
  State<TestAndServicesMain> createState() => TestAndServicesMainstate();
}

class TestAndServicesMainstate extends State<TestAndServicesMain> {
  String usernameValue = "Test & Services";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 3;
  List<String> previousPrescriptions = [
    "Previous Prescription 1",
    "Previous Prescription 2",
    "Previous Prescription 3"
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          width: double.infinity,
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
                  Header(userName: usernameValue),

                  // Main Content Section
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.03),
                          topRight: Radius.circular(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.03),
                        ),
                      ),
                      child: Column(
                        children: [
                          // TabBar Section
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.04,
                                right:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.04,
                                bottom:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.018,
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.045,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              color: Color(0x66D9D9D9),
                              border: Border.all(
                                // Add a red border
                                color: Color(0xFFD9D9D9).withOpacity(
                                    0.4), // Red color for the border
                                width: 2, // Border width
                              ),
                            ),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              dividerColor: Colors.transparent,
                              indicator: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              labelColor: Color(0xFF126086),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.014,
                                fontFamily: "Inter"
                              ),
                              unselectedLabelColor: Colors.black,
                              unselectedLabelStyle:
                              TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.014,
                                  fontFamily: "Inter"
                              ),
                              tabs: [
                                Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Past Orders",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Upcoming Orders",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // TabBarView Section
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Active Prescription List
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.012,
                                      right:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.012,
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.00,
                                      bottom:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.00),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                      Radius.circular(screenHeight * 0.03),
                                      topRight:
                                      Radius.circular(screenHeight * 0.03),
                                    ),
                                  ),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height *
                                              0.005, // Dynamic top padding
                                          bottom: MediaQuery.of(context).size.height *
                                              0.0, // Dynamic bottom padding
                                          left: MediaQuery.of(context).size.height *
                                              0.0, // Dynamic left padding
                                          right: MediaQuery.of(context).size.height *
                                              0.0, // Dynamic right padding
                                        ),
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap:
                                          true, // Prevents infinite height
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {

                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                    return TestScanDetails();
                                                }));

                                              },
                                              child: Card(
                                                elevation: 0.0,
                                                color: Colors.white,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white, // Background color of the container
                                                    border: Border.all(
                                                      color: Colors.black.withOpacity(0.1), // Border color
                                                      width: 1, // Border width
                                                    ),
                                                    borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
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
                                                              Color(0xFFffffff),
                                                              Color(0xFFffffff)
                                                            ])),
                                                    margin: EdgeInsets.only(
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
                                                            0.00,
                                                        top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.015,
                                                        right: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.025,
                                                        bottom: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.01,
                                                        top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.01),
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
                                                              Container(
                                                                height : MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.05,
                                                                width : MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.05,
                                                                padding:
                                                                EdgeInsets.only(
                                                                  left: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.00,
                                                                ),
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      130.0),
                                                                  child:
                                                                  Image.asset(
                                                                    'assets/Radiologytestdetails.png',
                                                                    fit:
                                                                    BoxFit.fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.03),
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
                                                                        "X - ray Bone",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(0xFF1F1F1F),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                          fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.014,
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                            0.00,
                                                                        bottom: MediaQuery.of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.005,
                                                                      ),
                                                                      child: Text(
                                                                        "US ABDOMEN COMPLETE",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(0x80000000),
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.012,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start, // Adjust alignment as needed
                                                                      children: [
                                                                        Container(
                                                                          padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                          ),
                                                                          child: Text(
                                                                            "December, 20  2023",
                                                                            style: TextStyle(
                                                                              color: Color(0xFF126086),
                                                                              fontWeight: FontWeight.w600,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                            ),
                                                                          ),
                                                                        ),

                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.005,
                                                                            right: MediaQuery.of(context).size.height * 0.005,
                                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                          ),
                                                                          height: 10,
                                                                          width: 1.0, // Same as border width
                                                                          color:  Color(0xFF126086), // Border color
                                                                        ),
                                                                        Container(
                                                                          padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                          ),
                                                                          child: Text(
                                                                            "11 : 11 AM",
                                                                            style: TextStyle(
                                                                              color: Color(0xFF126086),
                                                                              fontWeight: FontWeight.w600,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
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
                                                                Color(0xFF5F5F5F),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),


                                    ],
                                  ),

                                ),

                                // Previous Prescription List
                                Container(
                                  height: double
                                      .infinity,
                                  // Ensures it occupies full height
                                  width: double
                                      .infinity,
                                  // Ensures it occupies full width
                                  color: Colors
                                      .white,
                                  // You can change the background color
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, // Center vertically
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center, // Center horizontally
                                    children: [

                                      Container(
                                        padding:EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.00,
                                            right: MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height * 0.0,
                                            top: MediaQuery.of(context).size.height * 0.04),
                                        color: Colors.white,
                                        child:
                                        Image.asset(
                                          'assets/NoPreviousPrescriptionstoview.png',
                                          // Replace with your image asset
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.340,
                                          // Adjust the height of the image
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.340, // Adjust the width of the image
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.00,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.00,
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
                                        ),
                                        child: Text(
                                          "No upcoming orders to view",
                                          style: TextStyle(
                                            fontSize: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.016,
                                            color: Color(0xFF126086),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),





                                    ],
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
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  CustomFloatingActionButton(),
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
      ),
    );
  }


}
