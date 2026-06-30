import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:newfolder/constants/time_slot_constants.dart';

import '../../utils/TimeSlotSelector.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';

class DiagnosticMain extends StatefulWidget {
  int selectedIndex = 0;
  DiagnosticMain({
    super.key,
  });
  @override
  State<DiagnosticMain> createState() => DiagnosticMainstate();
}

class DiagnosticMainstate extends State<DiagnosticMain> {
  String usernameValue = "Diagnostic";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  bool _isExpandedtime = true;
  bool _isExpandedlocation = true;
  String selectedSlot = "";
  DateTime? _selectedDay;

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  void checkGuestUser() async {
    final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";
    if (isLoggedIn == "YES") {
      Timer(Duration(seconds: 0), () {
        LoginBottomSheet.show(context, false);
      });
    }
  }


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
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.020,
                          left: MediaQuery.of(context).size.height * 0.02,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.150,
                        child: DottedBorder(
                          color: Color(0xFF343434).withOpacity(0.3),
                          strokeWidth: 1,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8),
                          child: Center(
                            // Ensures the content is centered within the border
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Aligns content vertically
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Aligns content horizontally
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.02,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  width: screenHeight * 0.04,
                                  height: screenHeight * 0.04,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/homecare.png"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.00,
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
                                                  0.006),
                                      child: Text(
                                        "choose file to upload",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1F1F1F),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.014,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.00,
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
                                                  0.02),
                                      child: RichText(
                                        text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .merge(
                                                TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  'image or pdf Should be less than',
                                              style: TextStyle(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.w600,
                                                fontSize: screenHeight * 0.012,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' 10MB',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: screenHeight * 0.012,
                                                color: Color(0xFF126086),
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
                        ),
                      ),

                      // 1st Expansion Tile
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.015,
                          left: MediaQuery.of(context).size.height * 0.015,
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
                                    _isExpandedtime = !_isExpandedtime;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .white, // Background color (optional)
                                    border: Border(
                                      top: BorderSide(
                                        color: Color(
                                            0x24000000), // Top border color
                                        width: 2.0, // Top border thickness
                                      ),
                                      right: BorderSide(
                                        color: Color(
                                            0x24000000), // Right border color
                                        width: 2.0, // Right border thickness
                                      ),
                                      bottom: BorderSide(
                                        color: Color(
                                            0x24000000), // Bottom border color
                                        width: _isExpandedtime
                                            ? 1.0
                                            : 2.0, // Reduced bottom border thickness on expansion
                                      ),
                                      left: BorderSide(
                                        color: Color(
                                            0x24000000), // Left border color
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
                                        0.005, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic bottom padding
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
                                        "Select Time",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.014, // Dynamic font size
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        _isExpandedtime
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.02, // Dynamic icon size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_isExpandedtime)
                                if (_isExpandedtime)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.011,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.0),
                                    // child: Align(
                                    //   alignment: Alignment.centerLeft,
                                    //   child: Text(
                                    //     "Select Your Time",
                                    //     style: TextStyle(
                                    //       fontSize:
                                    //           MediaQuery.of(context).size.height *
                                    //               0.014,
                                    //       fontWeight: FontWeight.w500,
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                              if (_isExpandedtime)
                                TimeSlotSelector(
                                  timeSlots: timeSlots,
                                  selectedDate: _selectedDay ?? DateTime.now(),
                                  onSelected: (selectedTime) {
                                    setState(() {
                                      selectedSlot = selectedTime;
                                    });
                                    // print("Selected Slot: $selectedSlot");
                                    // print("Selected Slot: $selectedSlot");
                                  },
                                ),
                              if (_isExpandedtime)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.02,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.011,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.0),
                                  // child: Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text(
                                  //     "Select Your Time",
                                  //     style: TextStyle(
                                  //       fontSize:
                                  //           MediaQuery.of(context).size.height *
                                  //               0.014,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // 2nd Expansion Tile
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.015,
                          left: MediaQuery.of(context).size.height * 0.015,
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
                                    _isExpandedlocation = !_isExpandedlocation;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .white, // Background color (optional)
                                    border: Border(
                                      top: BorderSide(
                                        color: Color(
                                            0x24000000), // Top border color
                                        width: 2.0, // Top border thickness
                                      ),
                                      right: BorderSide(
                                        color: Color(0x24000000),
                                        width: 2.0, // Right border thickness
                                      ),
                                      bottom: BorderSide(
                                        color: Color(0x24000000),
                                        width: _isExpandedlocation
                                            ? 1.0
                                            : 2.0, // Reduced bottom border thickness on expansion
                                      ),
                                      left: BorderSide(
                                        color: Color(0x24000000),
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
                                        0.005, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic bottom padding
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
                                        "Select Location",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.014, // Dynamic font size
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        _isExpandedlocation
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.02, // Dynamic icon size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_isExpandedlocation)
                                Container(
                                  color: Colors.white,
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
                                    shrinkWrap:
                                        true, // Prevents infinite height
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
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
                                                              0.01,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01,
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
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          130.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/Homehomecare.png',
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
                                                                0.02),
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
                                                                  "Home Address",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black87,
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
                                                                      0.00,
                                                                ),
                                                                child: Text(
                                                                  "65 Mohamed Bin Al Qassim St, Doha, Qatar",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0x99000000),
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
                      ),

                      //
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.015,
                          bottom: MediaQuery.of(context).size.height * 0.016,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Align them to the start
                          children: <Widget>[
                            Icon(
                              Icons.add, // The add icon
                              color: Color(
                                  0xFF126086), // Set the color for the icon
                              size: MediaQuery.of(context).size.height *
                                  0.02, // Set icon size
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.height *
                                    0.005), // Space between the icon and text
                            Container(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                    MediaQuery.of(context).size.height * 0.00,
                                top: MediaQuery.of(context).size.height * 0.005,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.00,
                              ),
                              child: Text(
                                "Add new Address",
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Add service button
                      GestureDetector(
                        onTap: () async {
                          final isLoggedIn =
                              await UserSecureStorage.getIfGuestLogged() ??
                                  "NO";
                          if (isLoggedIn == "YES") {
                            Timer(Duration(seconds: 0), () {
                              LoginBottomSheet.show(context, false);
                            });
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HomePageMain();
                                },
                              ),
                            );
                          }
                        },
                        child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.00,
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                    MediaQuery.of(context).size.height * 0.00),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.height * 0.04,
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.07,
                                left:
                                    MediaQuery.of(context).size.height * 0.04),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.012),
                                          gradient: LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.center,
                                              stops: [
                                                0.5,
                                                0.9
                                              ],
                                              colors: [
                                                Color(0xFFBDBDBD),
                                                Color(0xFFBDBDBD),
                                              ])),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 0.0),
                                      child: TextButton(
                                        onPressed: () async {
                                          final isLoggedIn =
                                              await UserSecureStorage
                                                      .getIfGuestLogged() ??
                                                  "NO";
                                          if (isLoggedIn == "YES") {
                                            Timer(Duration(seconds: 0), () {
                                              LoginBottomSheet.show(
                                                  context, false);
                                            });
                                          } else {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return HomePageMain();
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        child: Text("Book Service",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 9.0,
                                              horizontal:
                                                  12.0), // ← Adjust this
                                          minimumSize: Size(0,
                                              0), // Removes minimum button constraints
                                          tapTargetSize: MaterialTapTargetSize
                                              .shrinkWrap, // Removes extra tap padding
                                        ),
                                      ),
                                    ),
                                  ),
                                ])),
                      )
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
