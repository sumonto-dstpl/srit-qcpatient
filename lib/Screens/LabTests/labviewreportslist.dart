import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
class LabViewReports extends StatefulWidget {
  int selectedIndex = 0;
  LabViewReports({
    super.key,
  });
  @override
  State<LabViewReports> createState() => LabViewReportsstate();
}

class LabViewReportsstate extends State<LabViewReports> {
  String usernameValue = "Full Body Checkup";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;

  final mybrowsebyhealthcond = [
    ["assets/Diagnostic.png", "Harmone"],
    ["assets/Doctor.png", "Diabetes"],
    ["assets/Nurse.png", "Joint Pain"],
    ["assets/Physio.png", "Thyroid"],
    ["assets/MedicalEquipment.png", "Heart"],
    ["assets/Diagnostic.png", "Bone"],
    ["assets/Doctor.png", "Blood Sugar"],
    ["assets/Nurse.png", "Vitamin"],
    ["assets/Physio.png", "Hair Fall"],
    ["assets/MedicalEquipment.png", "Liver"],
    ["assets/Physio.png", "Kidney"],
    ["assets/MedicalEquipment.png", "Fever"],
  ];

  final myhealthpackages = [
    ["assets/Diagnostic.png", "Full Body Checkup"],
    ["assets/Doctor.png", "Men’s Wellness"],
    ["assets/Nurse.png", "Women’s Health"],
    ["assets/Physio.png", "Thyroid Package"],
    ["assets/MedicalEquipment.png", "Heart Package"],
    ["assets/Diagnostic.png", "Diabetes package"],
    ["assets/Doctor.png", "Blood Studies Package"],
    ["assets/Nurse.png", "Vitamin package"],
    ["assets/Physio.png", "Hairfall package"],
    ["assets/MedicalEquipment.png", "Liver Package"],
    ["assets/Physio.png", "Kidney Package"],
    ["assets/MedicalEquipment.png", "Fever Package"],
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
              Header(userName: usernameValue),

              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.00,
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
                    children: [

                      Padding(
                        padding: new EdgeInsets.only(
                            left: MediaQuery.of(context).size.height *
                                0.00,
                            right: MediaQuery.of(context).size.height *
                                0.0,
                            top: MediaQuery.of(context).size.height *
                                0.00,
                            bottom: MediaQuery.of(context).size.height *
                                0.01),
                        child: Text(
                          "Reports Details",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:
                            MediaQuery.of(context).size.height *
                                0.018,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),


                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Provide a width constraint using SizedBox or Expanded
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                MediaQuery.of(context).size.height * 0.010,
                                top: MediaQuery.of(context).size.height * 0.00),
                            // height: MediaQuery.of(context).size.height * 0.190,
                            child: ListView.builder(
                              physics: ScrollPhysics(), // Ensures scrolling
                              shrinkWrap:
                              true, // Prevents ListView from taking up extra space
                              scrollDirection: Axis
                                  .vertical, // Makes the ListView horizontal
                              itemCount: 2, // You can adjust the item count
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Background color of the container
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(
                                                0.1), // Shadow color
                                            blurRadius:
                                            5, // Spread of the shadow
                                            offset: Offset(0,
                                                0), // Offset in x and y direction
                                          ),
                                        ],
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
                                                            "View Reports",
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
                                                            "Tap to check your View Report",
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
                          // Additional widgets can be added here
                        ],
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




}
