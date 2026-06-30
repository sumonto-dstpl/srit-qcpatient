import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Core/Dialog/delete_dialog.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
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
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class MedicationsMain extends StatefulWidget {
  int selectedIndex = 0;

  MedicationsMain({
    super.key,
  });

  @override
  State<MedicationsMain> createState() => MedicationsMainstate();
}

class MedicationsMainstate extends State<MedicationsMain> {
  String usernameValue = "Medications";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final mytopspecialities = [
    ["assets/Diagnostic.png", "Diagnostic"],
    ["assets/Doctor.png", "Doctor"],
    ["assets/Nurse.png", "Nurse"],
    ["assets/Physio.png", "Physio"],
    ["assets/MedicalEquipment.png", "Medical Equipment's"],
  ];
  final List<String> uploadfilestime = [
    "Now",
    "15 min ago",
    "24 hours ago",
  ];

  List<String> activePrescriptions = [
    "Active Prescription 1",
    "Active Prescription 2",
    "Active Prescription 3"
  ];
  List<String> previousPrescriptions = [
    "Previous Prescription 1",
    "Previous Prescription 2",
    "Previous Prescription 3"
  ];

  final myspecialities = [
    ["assets/Hematology.png", "Hematology"],
    ["assets/Oncology.png", "Oncology"],
    ["assets/OrganTransplant.png", "Organ Transplant"],
    ["assets/SupportSpecialties.png", "Support Specialties"],
  ];

  bool _isExpandeduploadedfiles = true;

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  List previousPrescriptionStatus = [
    {"status" : "Pending" , "circleColor" : Color(0xFFFF9500),"textColor" :  Color(0xFFFF9500), "backgroundColor" : Color(0x33FF9500)},
    {"status" : "Completed" ,"circleColor" : Color(0xFF12B76A), "textColor" :  Color(0xFF027A48), "backgroundColor" : Color(0xFFECFDF3)},
  ] ;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    TextEditingController SearchEditTextController = TextEditingController();

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
                                    .height * 0.03,
                                right:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03,
                                bottom:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01,
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              // color: Color(0xFFA8B1CE).withOpacity(0.4),
                              color : Color(0x66D9D9D9),
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
                                      0.014
                              ),
                              unselectedLabelColor: Colors.black,
                              unselectedLabelStyle:
                              TextStyle(fontWeight: FontWeight.w500),
                              tabs: [
                                Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Active Prescription",
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
                                        "Previous Prescription",
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
                                          0.005,
                                      right:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.005,
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
                                    children: [



                                      // Doctors
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.height *
                                                  0.015, // Dynamic top padding
                                              bottom: MediaQuery.of(context).size.height *
                                                  0.0, // Dynamic bottom padding
                                              left: MediaQuery.of(context).size.height *
                                                  0.01, // Dynamic left padding
                                              right: MediaQuery.of(context).size.height *
                                                  0.01, // Dynamic right padding
                                            ),
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap:
                                              true, // Prevents infinite height
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: uploadfilestime.length,
                                              itemBuilder: (context, index) {


                                                final file = uploadfilestime[index];

                                                return

                                                  Dismissible(
                                                      key: Key(file), // Unique key for each item
                                                      direction: DismissDirection.endToStart, // Allow swipe from right to left
                                                      background: Container(
                                                        // color: Colors.red,

                                                          alignment: Alignment.centerRight,
                                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                                          child: Image.asset(
                                                            'assets/deleteicon.png',
                                                            height: 20,
                                                            width: 20,

                                                          )
                                                      ),
                                                      confirmDismiss: (direction) async {

                                                        return await DeleteDialog.show(
                                                          context: context,
                                                          barrierLabel: "MedicationDelete",
                                                          message: "Are you sure to Remove the Selected Medication ?",

                                                        );
                                                      },
                                                      onDismissed: (direction) {
                                                        // Remove the item immediately from the list
                                                        setState(() {
                                                          uploadfilestime.removeAt(index);
                                                        });


                                                      },
                                                      child: GestureDetector(
                                                        onTap: () {},
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
                                                                        Container(
                                                                          height : screenHeight * 0.06,
                                                                          width : screenHeight * 0.06,
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                            left: MediaQuery.of(
                                                                                context)
                                                                                .size
                                                                                .height *
                                                                                0.00,
                                                                          ),
                                                                          margin: EdgeInsets.only(
                                                                            left: screenHeight * 0.01,
                                                                            top: screenHeight * 0.005,
                                                                            bottom: screenHeight * 0.005,
                                                                            right: screenHeight * 0.01,
                                                                          ),
                                                                          child: ClipRRect(
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                130.0),
                                                                            child:
                                                                            Image.asset(
                                                                              'assets/medicationjpg.png',
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
                                                                                0.010),
                                                                        Expanded(
                                                                          flex: 6,
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
                                                                                  "Prescription_1.jpg",
                                                                                  style:
                                                                                  TextStyle(
                                                                                    color: Colors
                                                                                        .black87,
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
                                                                                      0.00,
                                                                                ),
                                                                                child: Text(
                                                                                  "5 Mb",
                                                                                  style:
                                                                                  TextStyle(
                                                                                    color: Colors
                                                                                        .black54,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .bold,
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
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.only(

                                                                            right: screenHeight * 0.01,
                                                                          ),
                                                                          child: Text(
                                                                            uploadfilestime[index],
                                                                            style: TextStyle(
                                                                              fontSize: screenHeight * 0.011,
                                                                              color: Color(0xFF126086),
                                                                              fontWeight: FontWeight.w500,
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
                                                        ),
                                                      )



                                                  );
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
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
                                                    0.010,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.00),
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.height *
                                                  0.015, // Dynamic top padding
                                              bottom: MediaQuery.of(context).size.height *
                                                  0.0, // Dynamic bottom padding
                                              left: MediaQuery.of(context).size.height *
                                                  0.01, // Dynamic left padding
                                              right: MediaQuery.of(context).size.height *
                                                  0.01, // Dynamic right padding
                                            ),
                                            // height: MediaQuery.of(context).size.height * 0.190,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics: ScrollPhysics(),

                                              // Ensures scrolling
                                              shrinkWrap: true,

                                              // Prevents ListView from taking up extra space
                                              scrollDirection: Axis.vertical,

                                              // Makes the ListView horizontal
                                              itemCount: 2,

                                              // You can adjust the item count
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: prescriptionList("active"),
                                                );
                                              },
                                            ),
                                          ),
                                          // Additional widgets can be added here
                                        ],
                                      ),
                                    ],
                                  ),
                                ),



                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery
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
                                    children: [



                                      // Doctors
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // Container(
                                          //   padding: EdgeInsets.only(
                                          //     top: MediaQuery.of(context).size.height *
                                          //         0.015, // Dynamic top padding
                                          //     bottom: MediaQuery.of(context).size.height *
                                          //         0.0, // Dynamic bottom padding
                                          //     left: MediaQuery.of(context).size.height *
                                          //         0.01, // Dynamic left padding
                                          //     right: MediaQuery.of(context).size.height *
                                          //         0.01, // Dynamic right padding
                                          //   ),
                                          //   child: ListView.builder(
                                          //     padding: EdgeInsets.zero,
                                          //     shrinkWrap:
                                          //     true, // Prevents infinite height
                                          //     physics: NeverScrollableScrollPhysics(),
                                          //     itemCount: uploadfilestime.length,
                                          //     itemBuilder: (context, index) {
                                          //
                                          //
                                          //       final file = uploadfilestime[index];
                                          //
                                          //       return
                                          //
                                          //         Dismissible(
                                          //             key: Key(file), // Unique key for each item
                                          //             direction: DismissDirection.endToStart, // Allow swipe from right to left
                                          //             background: Container(
                                          //               color: Colors.white,
                                          //               alignment: Alignment.centerRight,
                                          //               padding: EdgeInsets.symmetric(horizontal: 20),
                                          //               child: Icon(
                                          //                 Icons.delete,
                                          //                 color: Colors.red,
                                          //               ),
                                          //             ),
                                          //             onDismissed: (direction) {
                                          //               // Remove the item immediately from the list
                                          //               setState(() {
                                          //                 uploadfilestime.removeAt(index);
                                          //               });
                                          //
                                          //
                                          //             },
                                          //             child:
                                          //
                                          //             GestureDetector(
                                          //               onTap: () {},
                                          //               child: Card(
                                          //                 elevation: 0.0,
                                          //                 color: Colors.white,
                                          //                 child: Container(
                                          //                   decoration: BoxDecoration(
                                          //                     color: Colors.white, // Background color of the container
                                          //                     border: Border.all(
                                          //                       color: Colors.black.withOpacity(0.1), // Border color
                                          //                       width: 1, // Border width
                                          //                     ),
                                          //                     borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                                          //                   ),
                                          //
                                          //                   padding: EdgeInsets.only(
                                          //                       left: MediaQuery.of(context)
                                          //                           .size
                                          //                           .height *
                                          //                           0.00,
                                          //                       right: MediaQuery.of(context)
                                          //                           .size
                                          //                           .height *
                                          //                           0.00,
                                          //                       bottom: MediaQuery.of(context)
                                          //                           .size
                                          //                           .height *
                                          //                           0.0,
                                          //                       top: MediaQuery.of(context)
                                          //                           .size
                                          //                           .height *
                                          //                           0.00),
                                          //                   // color: Colors.white,
                                          //                   child: Container(
                                          //                     // color: Colors.white,
                                          //
                                          //                     decoration: BoxDecoration(
                                          //                         borderRadius:
                                          //                         BorderRadius.circular(10),
                                          //                         gradient: LinearGradient(
                                          //                             begin:
                                          //                             Alignment.centerLeft,
                                          //                             end:
                                          //                             Alignment.centerRight,
                                          //                             stops: [
                                          //                               0.5,
                                          //                               0.9
                                          //                             ],
                                          //                             colors: [
                                          //                               Color(0xFFffffff),
                                          //                               Color(0xFFffffff)
                                          //                             ])),
                                          //                     margin: EdgeInsets.only(
                                          //                         left: MediaQuery.of(context)
                                          //                             .size
                                          //                             .height *
                                          //                             0.00,
                                          //                         right: MediaQuery.of(context)
                                          //                             .size
                                          //                             .height *
                                          //                             0.00,
                                          //                         bottom: MediaQuery.of(context)
                                          //                             .size
                                          //                             .height *
                                          //                             0.00,
                                          //                         top: MediaQuery.of(context)
                                          //                             .size
                                          //                             .height *
                                          //                             0.00),
                                          //                     padding: EdgeInsets.only(
                                          //                         left: MediaQuery.of(context)
                                          //                             .size
                                          //                             .height *
                                          //                             0.005,
                                          //                         right: MediaQuery.of(context)
                                          //                             .size
                                          //                             .height *
                                          //                             0.005,
                                          //                         bottom: MediaQuery.of(context)
                                          //                             .size
                                          //                             .height *
                                          //                             0.005,
                                          //                         top: MediaQuery.of(context)
                                          //                             .size
                                          //                             .height *
                                          //                             0.005),
                                          //                     child: Column(
                                          //                       crossAxisAlignment:
                                          //                       CrossAxisAlignment.start,
                                          //                       children: <Widget>[
                                          //                         Container(
                                          //                           padding: EdgeInsets.only(
                                          //                             left:
                                          //                             MediaQuery.of(context)
                                          //                                 .size
                                          //                                 .height *
                                          //                                 0.005,
                                          //                             right:
                                          //                             MediaQuery.of(context)
                                          //                                 .size
                                          //                                 .height *
                                          //                                 0.005,
                                          //                             top:
                                          //                             MediaQuery.of(context)
                                          //                                 .size
                                          //                                 .height *
                                          //                                 0.00,
                                          //                             bottom:
                                          //                             MediaQuery.of(context)
                                          //                                 .size
                                          //                                 .height *
                                          //                                 0.00,
                                          //                           ),
                                          //                           child: Row(
                                          //                             crossAxisAlignment:
                                          //                             CrossAxisAlignment
                                          //                                 .center,
                                          //                             mainAxisAlignment:
                                          //                             MainAxisAlignment
                                          //                                 .start,
                                          //                             children: <Widget>[
                                          //                               Container(
                                          //                                 height : screenHeight * 0.06,
                                          //                                 width : screenHeight * 0.06,
                                          //                                 padding:
                                          //                                 EdgeInsets.only(
                                          //                                   left: MediaQuery.of(
                                          //                                       context)
                                          //                                       .size
                                          //                                       .height *
                                          //                                       0.00,
                                          //                                 ),
                                          //                                 margin: EdgeInsets.only(
                                          //                                   left: screenHeight * 0.01,
                                          //                                   top: screenHeight * 0.005,
                                          //                                   bottom: screenHeight * 0.005,
                                          //                                   right: screenHeight * 0.01,
                                          //                                 ),
                                          //                                 child: ClipRRect(
                                          //                                   borderRadius:
                                          //                                   BorderRadius
                                          //                                       .circular(
                                          //                                       130.0),
                                          //                                   child:
                                          //                                   Image.asset(
                                          //                                     'assets/medicationjpg.png',
                                          //                                     fit:
                                          //                                     BoxFit.fill,
                                          //                                   ),
                                          //                                 ),
                                          //                               ),
                                          //                               SizedBox(
                                          //                                   width: MediaQuery.of(
                                          //                                       context)
                                          //                                       .size
                                          //                                       .height *
                                          //                                       0.010),
                                          //                               Expanded(
                                          //                                 flex: 6,
                                          //                                 child: Column(
                                          //                                   crossAxisAlignment:
                                          //                                   CrossAxisAlignment
                                          //                                       .start,
                                          //                                   mainAxisAlignment:
                                          //                                   MainAxisAlignment
                                          //                                       .center,
                                          //                                   children: <Widget>[
                                          //                                     Container(
                                          //                                       padding:
                                          //                                       EdgeInsets
                                          //                                           .only(
                                          //                                         left: MediaQuery.of(
                                          //                                             context)
                                          //                                             .size
                                          //                                             .height *
                                          //                                             0.00,
                                          //                                         right: MediaQuery.of(
                                          //                                             context)
                                          //                                             .size
                                          //                                             .height *
                                          //                                             0.00,
                                          //                                         top: MediaQuery.of(
                                          //                                             context)
                                          //                                             .size
                                          //                                             .height *
                                          //                                             0.0,
                                          //                                         bottom: MediaQuery.of(
                                          //                                             context)
                                          //                                             .size
                                          //                                             .height *
                                          //                                             0.00,
                                          //                                       ),
                                          //                                       child: Text(
                                          //                                         "Prescription_1.jpg",
                                          //                                         style:
                                          //                                         TextStyle(
                                          //                                           color: Colors
                                          //                                               .black87,
                                          //                                           overflow:
                                          //                                           TextOverflow
                                          //                                               .ellipsis,
                                          //                                           fontWeight:
                                          //                                           FontWeight
                                          //                                               .bold,
                                          //                                           fontSize: MediaQuery.of(context)
                                          //                                               .size
                                          //                                               .height *
                                          //                                               0.014,
                                          //                                         ),
                                          //                                       ),
                                          //                                     ),
                                          //                                     Container(
                                          //                                       padding:
                                          //                                       EdgeInsets
                                          //                                           .only(
                                          //                                         left: MediaQuery.of(
                                          //                                             context)
                                          //                                             .size
                                          //                                             .height *
                                          //                                             0.00,
                                          //                                         right: MediaQuery.of(
                                          //                                             context)
                                          //                                             .size
                                          //                                             .height *
                                          //                                             0.00,
                                          //                                         top: MediaQuery.of(
                                          //                                             context)
                                          //                                             .size
                                          //                                             .height *
                                          //                                             0.00,
                                          //                                         bottom: MediaQuery.of(
                                          //                                             context)
                                          //                                             .size
                                          //                                             .height *
                                          //                                             0.00,
                                          //                                       ),
                                          //                                       child: Text(
                                          //                                         "5 Mb",
                                          //                                         style:
                                          //                                         TextStyle(
                                          //                                           color: Colors
                                          //                                               .black54,
                                          //                                           fontWeight:
                                          //                                           FontWeight
                                          //                                               .bold,
                                          //                                           overflow:
                                          //                                           TextOverflow
                                          //                                               .ellipsis,
                                          //                                           fontSize: MediaQuery.of(context)
                                          //                                               .size
                                          //                                               .height *
                                          //                                               0.012,
                                          //                                         ),
                                          //                                       ),
                                          //                                     ),
                                          //                                   ],
                                          //                                 ),
                                          //                               ),
                                          //                               Container(
                                          //                                 margin: EdgeInsets.only(
                                          //
                                          //                                   right: screenHeight * 0.01,
                                          //                                 ),
                                          //                                 child: Text(
                                          //                                   uploadfilestime[index],
                                          //                                   style: TextStyle(
                                          //                                     fontSize: screenHeight * 0.011,
                                          //                                     color: Color(0xFF126086),
                                          //                                     fontWeight: FontWeight.w500,
                                          //                                   ),
                                          //                                 ),
                                          //                               )
                                          //
                                          //
                                          //
                                          //
                                          //                             ],
                                          //                           ),
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             )
                                          //
                                          //         );
                                          //     },
                                          //   ),
                                          // ),
                                          Container(
                                            margin: EdgeInsets.only(
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
                                                    0.010,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.00),
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.height *
                                                  0.015, // Dynamic top padding
                                              bottom: MediaQuery.of(context).size.height *
                                                  0.0, // Dynamic bottom padding
                                              left: MediaQuery.of(context).size.height *
                                                  0.01, // Dynamic left padding
                                              right: MediaQuery.of(context).size.height *
                                                  0.01, // Dynamic right padding
                                            ),
                                            // height: MediaQuery.of(context).size.height * 0.190,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics: ScrollPhysics(),

                                              // Ensures scrolling
                                              shrinkWrap: true,

                                              // Prevents ListView from taking up extra space
                                              scrollDirection: Axis.vertical,

                                              // Makes the ListView horizontal
                                              itemCount: 2,

                                              // You can adjust the item count
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                final item = previousPrescriptionStatus[index];
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: prescriptionList("previous",item: item),
                                                );
                                              },
                                            ),
                                          ),
                                          // Additional widgets can be added here
                                        ],
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



  Widget prescriptionList(String prescriptionType,{Map? item}){
    return Stack(
      children: [
        Card(
        elevation: 0.0,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors
                .white,
            // Background color of the container
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(
                    0.1),
                // Shadow color
                blurRadius:
                5,
                // Spread of the shadow
                offset: Offset(0,
                    0), // Offset in x and y direction
              ),
            ],
            borderRadius:
            BorderRadius.circular(
                8), // Optional: Rounded corners
          ),
          width:
          MediaQuery
              .of(context)
              .size
              .height *
              0.450,
          padding: EdgeInsets.only(
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
              bottom: MediaQuery
                  .of(
                  context)
                  .size
                  .height *
                  0.0,
              top: MediaQuery
                  .of(
                  context)
                  .size
                  .height *
                  0.00),
          // color: Colors.white,
          child: Container(
            // color: Colors.white,

            decoration: BoxDecoration(
                borderRadius:
                BorderRadius
                    .circular(
                    10),
                gradient: LinearGradient(
                    begin: Alignment
                        .centerLeft,
                    end: Alignment
                        .centerRight,
                    stops: [
                      0.5,
                      0.9
                    ],
                    colors: [
                      Color(
                          0xFFffffff),
                      Color(
                          0xFFffffff)
                    ])),
            margin: EdgeInsets.only(
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
                bottom: MediaQuery
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
                    0.00),
            padding: EdgeInsets
                .only(
                left: MediaQuery
                    .of(
                    context)
                    .size
                    .height *
                    0.005,
                right: MediaQuery
                    .of(
                    context)
                    .size
                    .height *
                    0.005,
                bottom: MediaQuery
                    .of(
                    context)
                    .size
                    .height *
                    0.005,
                top: MediaQuery
                    .of(
                    context)
                    .size
                    .height *
                    0.005),
            child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: <Widget>[
                  Container(
                    // color: Colors.red,
                    // height: MediaQuery.of(context).size.height * 0.12,
                    padding: EdgeInsets
                        .only(
                        left: MediaQuery
                            .of(
                            context)
                            .size
                            .height *
                            0.015,
                        right: MediaQuery
                            .of(
                            context)
                            .size
                            .height *
                            0.005,
                        top: MediaQuery
                            .of(
                            context)
                            .size
                            .height *
                            0.015,
                        bottom: MediaQuery
                            .of(
                            context)
                            .size
                            .height *
                            0.00),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .center,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .start,
                      children: <
                          Widget>[
                        // Expanded(
                        //   flex: 2,
                        //   child:
                        //   Container(
                        //     padding:
                        //     EdgeInsets
                        //         .only(
                        //       left: MediaQuery
                        //           .of(
                        //           context)
                        //           .size
                        //           .height *
                        //           0.00,
                        //     ),
                        //     child:
                        //     ClipRRect(
                        //       borderRadius:
                        //       BorderRadius
                        //           .circular(
                        //           130.0),
                        //       child:
                        //       Image
                        //           .asset(
                        //         'assets/NutanBhatt.png',
                        //         fit:
                        //         BoxFit
                        //             .fill,
                        //       ),
                        //     ),
                        //   ),
                        //
                        //
                        // ),
                        Container(
                          height : MediaQuery.of(
                              context)
                              .size
                              .height *
                              0.055,
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
                            child: Image.asset(
                              'assets/NutanBhatt.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery
                                .of(
                                context)
                                .size
                                .height *
                                0.015),
                        Expanded(
                          flex: 8,
                          child:
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                            children: <
                                Widget>[
                              Container(
                                padding: EdgeInsets
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
                                        0.00),
                                child:
                                Text(
                                  "Dr. Nutan Bhatt",
                                  style: TextStyle(
                                      color: Colors
                                          .black87,
                                      overflow: TextOverflow
                                          .ellipsis,
                                      fontWeight: FontWeight
                                          .w600,
                                      fontSize: MediaQuery
                                          .of(
                                          context)
                                          .size
                                          .height *
                                          0.016),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets
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
                                        0.00,
                                    bottom: MediaQuery
                                        .of(
                                        context)
                                        .size
                                        .height *
                                        0.00),
                                child:
                                Text(
                                  "General physician / Internal Medicine",
                                  style: TextStyle(
                                      color: Colors
                                          .black54,
                                      fontWeight: FontWeight
                                          .w500,
                                      overflow: TextOverflow
                                          .ellipsis,
                                      fontSize: MediaQuery
                                          .of(
                                          context)
                                          .size
                                          .height *
                                          0.014),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets
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
                                        0.00,
                                    bottom: MediaQuery
                                        .of(
                                        context)
                                        .size
                                        .height *
                                        0.00),
                                child:
                                Row(
                                  children: [
                                    Text(
                                      "August 20 2024",
                                      style: TextStyle(
                                          color: Color(
                                              0xFF126086),
                                          fontWeight: FontWeight
                                              .w600,
                                          overflow: TextOverflow
                                              .ellipsis,
                                          fontSize: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .height *
                                              0.012),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      height: MediaQuery.of(context).size.height * 0.004,
                                      width: MediaQuery.of(context).size.height * 0.004,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF126086),
                                        shape: BoxShape.circle,
                                      ),
                                    ),

                                    Text(
                                      "Priya Krishnamurty ",
                                      style: TextStyle(
                                          color: Color(
                                              0xFF126086),
                                          fontWeight: FontWeight
                                              .w600,
                                          overflow: TextOverflow
                                              .ellipsis,
                                          fontSize: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .height *
                                              0.012),
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

                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.02,
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.005,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    padding: EdgeInsets
                        .only(
                        left: MediaQuery
                            .of(
                            context)
                            .size
                            .height *
                            0.025,
                        right: MediaQuery
                            .of(
                            context)
                            .size
                            .height *
                            0.005,
                        bottom: MediaQuery
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
                            0.01),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius
                          .circular(
                          5),
                      gradient:
                      LinearGradient(
                        begin: Alignment
                            .centerLeft,
                        end: Alignment
                            .centerRight,
                        stops: [
                          0.5,
                          0.9
                        ],
                        colors: [
                          Color(0x0F7F7F7F)

                          ,
                          Color(0x0F7F7F7F)


                        ],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .center,
                      children: [

                        Expanded(
                          child: Text(
                            "3 MEDICINES INCLUDED",
                            style: TextStyle(
                              color: Color(
                                  0xFF126086),
                              fontWeight:
                              FontWeight
                                  .w500,
                              fontSize: MediaQuery
                                  .of(
                                  context)
                                  .size
                                  .height *
                                  0.012,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      // color:Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // color:Colors.green[100],
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.0,
                        right: MediaQuery.of(context).size.height * 0.0,
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.00),
                    margin : EdgeInsets.only(

                        top: MediaQuery.of(context).size.height * 0.007,
                        bottom: MediaQuery.of(context).size.height * 0.015
                    ),
                    child:


                    Row(
                      mainAxisAlignment: prescriptionType == "active" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end ,
                      children: <Widget>[
                        if(prescriptionType == "active")
                        GestureDetector(
                          onTap: () async {
                          },
                          child: Container(

                            decoration: BoxDecoration(
                              // color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xFF126086),// Border color
                                width: 0.5,            // Border width
                              ),
                            ),

                            padding: new EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.025,
                                right: MediaQuery.of(context).size.height * 0.025,
                                top: MediaQuery.of(context).size.height * 0.007,
                                bottom: MediaQuery.of(context).size.height * 0.007
                            ),
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.0,
                            ),
                            alignment: Alignment.center,
                            // height:
                            // MediaQuery.of(context).size.height * 0.070,
                            child: Text("View Prescription",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF126086),
                                    fontWeight: FontWeight.w600,
                                    fontSize:  MediaQuery.of(context).size.height * 0.014)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if(prescriptionType == "active"){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (BuildContext context) {
                                    return MedicatiSelectTimeSlot(
                                        "widget.doctoridval");
                                  },
                                ),
                              );
                            }

                          },
                          child: Container(

                            decoration: BoxDecoration(
                              color: Color(0xFF126086),
                              borderRadius: BorderRadius.circular(5),
                            ),

                            padding: new EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.025,
                                right: MediaQuery.of(context).size.height * 0.025,
                                top: MediaQuery.of(context).size.height * 0.007,
                                bottom: MediaQuery.of(context).size.height * 0.007
                            ),
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.02,
                            ),
                            // color: Colors.grey[300],
                            alignment: Alignment.center,
                            // height:
                            // MediaQuery.of(context).size.height * 0.070,
                            child: Text(
                                (prescriptionType == "active") ? "Book Follow -Up" : "View Prescription" ,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize:  MediaQuery.of(context).size.height * 0.014)),
                          ),
                        ),

                      ],
                    ),

                  ),

                ]),
          ),
        ),
      ),
        if(prescriptionType == "previous")
        Positioned(
          right: 10,
          top: 10,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),),
            child: Container(
              decoration: BoxDecoration(
                color: item?['backgroundColor'] ?? Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.005,
                vertical: MediaQuery.of(context).size.height * 0.002,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.008,
                    width: MediaQuery.of(context).size.height * 0.008, // 👈 same as height
                    decoration:   BoxDecoration(
                      color: item?['circleColor'] ?? Colors.grey, // 👈 circle ka color
                      shape: BoxShape.circle, // 👈 makes it circular
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height * 0.005,),
                  Text(
                      item?['status'] ?? "Status",
                    style: TextStyle(
                      color : item?['textColor'] ?? Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]
    );
  }
}

