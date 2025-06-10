import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Settings/changemobilenum.dart';
import 'package:newfolder/Screens/Settings/mpinmain.dart';
import 'package:newfolder/Screens/Settings/mpinreset.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
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
import 'package:newfolder/Screens/PaymentHistory/paymenthistory.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Utils/auth_service.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Widgets/tab_item.dart';

class SettingsMain extends StatefulWidget {
  int selectedIndex = 0;

  SettingsMain({
    super.key,
  });

  @override
  State<SettingsMain> createState() => SettingsMainstate();
}

class SettingsMainstate extends State<SettingsMain> {
  String usernameValue = "Settings";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final List<String> myopinions = [
    "PROVISIONAL DIAGNOSIS CODE",
    "S43.4 — Sprain and strain Of shoulder joint(Primary)",
    "S43.4 - Sprain and strain of shoulder joint",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();

  }
  void _init() async {

    bool result = await checkEnableMpin();

    setState(() {
      isMpinEnabled = result;
    });
  }
  final myimageslist = [
    ["assets/profileM1.png"],
    ["assets/profileM2.png"],
    ["assets/profileM3.png"],
    ["assets/profileM4.png"],
  ];
  bool isMpinEnabled = false;
  bool isFingerprintEnabled = true;
  bool isBdayNotificationEnabled = true;
  bool isPromotionalEnabled = true;
  bool isNotificationEnabled = false;

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
          /*decoration: const BoxDecoration(
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
                      top: screenHeight * 0.055,
                      left: screenWidth * 0.045,
                      right: screenWidth * 0.02,
                      bottom: screenWidth * 0.02,
                    ),
                    margin: EdgeInsets.only(
                      right: screenHeight * 0.0,
                      top: screenHeight * 0.01,
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

                        Padding(
                          padding: EdgeInsets.only(left : MediaQuery.of(context).size.height * 0.00),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top:
                                  MediaQuery.of(context).size.height * 0.00,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.00,
                                  left:
                                  MediaQuery.of(context).size.height * 0.00,
                                  right:
                                  MediaQuery.of(context).size.height * 0.00,
                                ),
                                child: Text(
                                  usernameValue,
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.018,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

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

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Content Section
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.zero,
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
                            padding: EdgeInsets.only(
                                left:
                                MediaQuery.of(context).size.height * 0.015,
                                right:
                                MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.06),
                            child: Stack(
                              children: [
                                // Center image
                                Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height * 0.00,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(130.0),
                                          child: Image.asset(
                                            'assets/profileProfile1.png',
                                            height: MediaQuery.of(context).size.height * 0.12, // Adjust height
                                            width: MediaQuery.of(context).size.height * 0.12, // Adjust width
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 6, // Adjust positioning slightly above the bottom edge
                                        right: 4, // Adjust positioning slightly inside the right edge
                                        child: Container(
                                          width: MediaQuery.of(context).size.height * 0.018, // Online indicator size
                                          height: MediaQuery.of(context).size.height * 0.018,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green, // Online indicator color
                                            border: Border.all(
                                              width: MediaQuery.of(context).size.height * 0.002, // White border for a clean look
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  ,
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
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Priya Krishnamurty",
                                  style: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.016),
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
                                  "Email / UHID / Mobile Number",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.013),
                                ),
                              ),
                            ],
                          ),





                          // Change Mobile Number
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ChangeMobileNumber();
                                  },
                                ),
                              );
                            },
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.02),


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
                                            0.4,
                                            0.6,
                                            0.8,
                                            0.9,
                                            0.95
                                          ],
                                          colors: [
                                            Color(0xFFA8B1CE).withOpacity(0.07),
                                            Color(0xFFA8B1CE).withOpacity(0.05),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.00),



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
                                          0.002,
                                      top: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.002),
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
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.01,
                                                        right: MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.01,
                                                        bottom: MediaQuery.of(context).size.height * 0.01),
                                                    child: Text(
                                                      "Change Mobile Number",
                                                      style:
                                                      TextStyle(
                                                        color: Color(0xFF1F1F1F),
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
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
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00,
                                                right: MediaQuery.of(context).size.height * 0.02,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                              ),

                                              child:
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios,
                                                size: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.015, // Dynamic icon size
                                                color:
                                                Color(0xFF5F5F5F),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                          // Reset MPINR
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) {
                              //       return MpinResetSettings();
                              //     },
                              //   ),
                              // );
                            },
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.0),


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
                                            0.4,
                                            0.6,
                                            0.8,
                                            0.9,
                                            0.95
                                          ],
                                          colors: [
                                            Color(0xFFA8B1CE).withOpacity(0.07),
                                            Color(0xFFA8B1CE).withOpacity(0.05),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.00),



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
                                          0.002,
                                      top: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.002),
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
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.01,
                                                        right: MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.01,
                                                        bottom: MediaQuery.of(context).size.height * 0.01),
                                                    child: Text(
                                                      "MPIN",
                                                      style:
                                                      TextStyle(
                                                        color: Color(0xFF1F1F1F),
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
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
                                            // Container(
                                            //   margin: EdgeInsets.only(
                                            //     left: MediaQuery.of(context).size.height * 0.00,
                                            //     top: MediaQuery.of(context).size.height * 0.00,
                                            //     right: MediaQuery.of(context).size.height * 0.02,
                                            //     bottom: MediaQuery.of(context).size.height * 0.00,
                                            //   ),
                                            //
                                            //   child:
                                            //   Icon(
                                            //     Icons
                                            //         .arrow_forward_ios,
                                            //     size: MediaQuery.of(
                                            //         context)
                                            //         .size
                                            //         .height *
                                            //         0.015, // Dynamic icon size
                                            //     color:
                                            //     Color(0xFF5F5F5F),
                                            //   ),
                                            // ),

                                            Expanded(
                                              child: GestureDetector(
                                                behavior: HitTestBehavior.translucent, // lets taps go through to child
                                                onTap: () {
                                                  setState(() {
                                                    isMpinEnabled = !isMpinEnabled;
                                                  });

                                                },
                                                child: FlutterSwitch(
                                                  // width : MediaQuery.of(context).size.height * 0.025,
                                                  // height : MediaQuery.of(context).size.height * 0.015,
                                                  width : MediaQuery.of(context).size.height * 0.030,
                                                  height : MediaQuery.of(context).size.height * 0.017,
                                                  value : isMpinEnabled,
                                                  toggleSize: 11,
                                                  borderRadius: 20,
                                                  padding : 1,
                                                  activeColor: Color(0xFF00C5BB),
                                                  inactiveColor: Color(0xFFE4E7EC),
                                                  activeToggleColor: Colors.white,
                                                  inactiveToggleColor: Colors.white,
                                                  onToggle: (bool value) {
                                                    setState(() {
                                                      isMpinEnabled = value;
                                                    });

                                                    // if (value) {
                                                    //   Navigator.of(context).push(
                                                    //     MaterialPageRoute(builder: (context) => Mpin()),
                                                    //   );
                                                    // }

                                                    if (value) {

                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(builder: (context) => MpinResetSettings()),
                                                      );
                                                    } else {
                                                      deleteEnableMpin();
                                                    }


                                                  },

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
                            ),
                          ),


                          // Enable Fingerprint
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.0),


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
                                            0.4,
                                            0.6,
                                            0.8,
                                            0.9,
                                            0.95
                                          ],
                                          colors: [
                                            Color(0xFFA8B1CE).withOpacity(0.07),
                                            Color(0xFFA8B1CE).withOpacity(0.05),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.00),



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
                                          0.002,
                                      top: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.002),
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
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.01,
                                                        right: MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.01,
                                                        bottom: MediaQuery.of(context).size.height * 0.01),
                                                    child: Text(
                                                      "Enable Fingerprint",
                                                      style:
                                                      TextStyle(
                                                        color: Color(0xFF1F1F1F),
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
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

                                            // Transform.scale(
                                            //   scale: 0.6, // Adjust the scale to reduce size (e.g., 0.8 = 80% of original size)
                                            //   child: Switch(
                                            //     value: isFingerprintEnabled,
                                            //     onChanged: (bool value) {
                                            //       setState(() {
                                            //         isFingerprintEnabled = value;
                                            //       });
                                            //     },
                                            //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area padding
                                            //     activeColor: Color(0xFFFFFFFF), // Thumb color when ON
                                            //     activeTrackColor: Color(0xFF00C5BB), // Background color when ON
                                            //     inactiveThumbColor: Colors.grey, // Thumb color when OFF
                                            //     inactiveTrackColor: Colors.grey.shade300, // Background color when OFF
                                            //   ),
                                            // ),

                                            Expanded(
                                              child: GestureDetector(
                                                behavior: HitTestBehavior.translucent, // lets taps go through to child
                                                onTap: () {
                                                  setState(() {
                                                    isFingerprintEnabled = !isFingerprintEnabled;
                                                  });
                                                },
                                                child: FlutterSwitch(
                                                  // width : MediaQuery.of(context).size.height * 0.025,
                                                  // height : MediaQuery.of(context).size.height * 0.015,
                                                  width : MediaQuery.of(context).size.height * 0.030,
                                                  height : MediaQuery.of(context).size.height * 0.017,
                                                  value : isFingerprintEnabled,
                                                  toggleSize: 11,
                                                  borderRadius: 20,
                                                  padding : 1,
                                                  activeColor: Color(0xFF00C5BB),
                                                  inactiveColor: Color(0xFFE4E7EC),
                                                  activeToggleColor: Colors.white,
                                                  inactiveToggleColor: Colors.white,
                                                  onToggle: (value) {
                                                    setState(() {
                                                      isFingerprintEnabled = value;
                                                    });
                                                  },

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
                            ),
                          ),



                          // Notifications
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder:
                              //         (BuildContext context) {
                              //       return NotificationMain();
                              //     },
                              //   ),
                              // );
                            },
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.0),


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
                                            0.4,
                                            0.6,
                                            0.8,
                                            0.9,
                                            0.95
                                          ],
                                          colors: [
                                            Color(0xFFA8B1CE).withOpacity(0.07),
                                            Color(0xFFA8B1CE).withOpacity(0.05),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.00),



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
                                          0.002,
                                      top: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.002),
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
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.01,
                                                        right: MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.01,
                                                        bottom: MediaQuery.of(context).size.height * 0.01),
                                                    child: Text(
                                                      "Notification",
                                                      style:
                                                      TextStyle(
                                                        color: Color(0xFF1F1F1F),
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
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

                                            Expanded(
                                              child: GestureDetector(
                                                behavior: HitTestBehavior.translucent, // lets taps go through to child
                                                onTap: () {
                                                  setState(() {
                                                    isNotificationEnabled = !isNotificationEnabled;
                                                  });

                                                },
                                                child: FlutterSwitch(

                                                  width : MediaQuery.of(context).size.height * 0.030,
                                                  height : MediaQuery.of(context).size.height * 0.017,
                                                  value : isNotificationEnabled,
                                                  toggleSize: 11,
                                                  borderRadius: 20,
                                                  padding : 1,
                                                  activeColor: Color(0xFF00C5BB),
                                                  inactiveColor: Color(0xFFE4E7EC),
                                                  activeToggleColor: Colors.white,
                                                  inactiveToggleColor: Colors.white,
                                                  onToggle: (bool value) {
                                                    setState(() {
                                                      isNotificationEnabled = value;
                                                    });

                                                    // if (value) {
                                                    //   Navigator.of(context).push(
                                                    //     MaterialPageRoute(builder: (context) => Mpin()),
                                                    //   );
                                                    // }

                                                    // if (value) {
                                                    //
                                                    //   Navigator.of(context).push(
                                                    //     MaterialPageRoute(builder: (context) => MpinResetSettings()),
                                                    //   );
                                                    // } else {
                                                    //   deleteEnableMpin();
                                                    // }


                                                  },

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
                            ),
                          ),


                          // Birthday Notifications
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.0),


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
                                            0.4,
                                            0.6,
                                            0.8,
                                            0.9,
                                            0.95
                                          ],
                                          colors: [
                                            Color(0xFFA8B1CE).withOpacity(0.07),
                                            Color(0xFFA8B1CE).withOpacity(0.05),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.00),



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
                                          0.002,
                                      top: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.002),
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
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.01,
                                                        right: MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.01,
                                                        bottom: MediaQuery.of(context).size.height * 0.01),
                                                    child: Text(
                                                      "Birthday Notifications",
                                                      style:
                                                      TextStyle(
                                                        color: Color(0xFF1F1F1F),
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
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

                                            // Transform.scale(
                                            //   scale: 0.6, // Adjust the scale to reduce size (e.g., 0.8 = 80% of original size)
                                            //   child: Switch(
                                            //     value: isBdayNotificationEnabled,
                                            //     onChanged: (bool value) {
                                            //       setState(() {
                                            //         isBdayNotificationEnabled = value;
                                            //       });
                                            //     },
                                            //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area padding
                                            //     activeColor: Color(0xFFFFFFFF), // Thumb color when ON
                                            //     activeTrackColor: Color(0xFF00C5BB), // Background color when ON
                                            //     inactiveThumbColor: Colors.grey, // Thumb color when OFF
                                            //     inactiveTrackColor: Colors.grey.shade300, // Background color when OFF
                                            //   ),
                                            // ),

                                            Expanded(
                                              child: GestureDetector(
                                                behavior: HitTestBehavior.translucent, // lets taps go through to child
                                                onTap: () {
                                                  setState(() {
                                                    isBdayNotificationEnabled = !isBdayNotificationEnabled;
                                                  });
                                                },
                                                child: FlutterSwitch(
                                                  // width : MediaQuery.of(context).size.height * 0.025,
                                                  // height : MediaQuery.of(context).size.height * 0.015,
                                                  width : MediaQuery.of(context).size.height * 0.030,
                                                  height : MediaQuery.of(context).size.height * 0.017,
                                                  value : isBdayNotificationEnabled,
                                                  toggleSize: 11,
                                                  borderRadius: 20,
                                                  padding : 1,
                                                  activeColor: Color(0xFF00C5BB),
                                                  inactiveColor: Color(0xFFE4E7EC),
                                                  activeToggleColor: Colors.white,
                                                  inactiveToggleColor: Colors.white,
                                                  onToggle: (value) {
                                                    setState(() {
                                                      isBdayNotificationEnabled = value;
                                                    });
                                                  },

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
                            ),
                          ),


                          // Promotional Offers
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.0),


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
                                            0.4,
                                            0.6,
                                            0.8,
                                            0.9,
                                            0.95
                                          ],
                                          colors: [
                                            Color(0xFFA8B1CE).withOpacity(0.07),
                                            Color(0xFFA8B1CE).withOpacity(0.05),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.001),
                                            Color(0xFFA8B1CE).withOpacity(0.00),



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
                                          0.002,
                                      top: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.002),
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
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.01,
                                                        right: MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.01,
                                                        bottom: MediaQuery.of(context).size.height * 0.01),
                                                    child: Text(
                                                      "Promotional Offers",
                                                      style:
                                                      TextStyle(
                                                        color: Color(0xFF1F1F1F),
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
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

                                            // Transform.scale(
                                            //   scale: 0.6, // Adjust the scale to reduce size (e.g., 0.8 = 80% of original size)
                                            //   child: Switch(
                                            //     value: isPromotionalEnabled,
                                            //     onChanged: (bool value) {
                                            //       setState(() {
                                            //         isPromotionalEnabled = value;
                                            //       });
                                            //     },
                                            //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area padding
                                            //     activeColor: Color(0xFFFFFFFF), // Thumb color when ON
                                            //     activeTrackColor: Color(0xFF00C5BB), // Background color when ON
                                            //     inactiveThumbColor: Colors.grey, // Thumb color when OFF
                                            //     inactiveTrackColor: Colors.grey.shade300, // Background color when OFF
                                            //   ),
                                            // ),
                                            Expanded(
                                              child: GestureDetector(
                                                behavior: HitTestBehavior.translucent, // lets taps go through to child
                                                onTap: () {
                                                  setState(() {
                                                    isPromotionalEnabled = !isPromotionalEnabled;
                                                  });
                                                },
                                                child: FlutterSwitch(
                                                  // width : MediaQuery.of(context).size.height * 0.025,
                                                  // height : MediaQuery.of(context).size.height * 0.015,
                                                  width : MediaQuery.of(context).size.height * 0.030,
                                                  height : MediaQuery.of(context).size.height * 0.017,
                                                  value : isPromotionalEnabled,
                                                  toggleSize: 11,
                                                  borderRadius: 20,
                                                  padding : 1,
                                                  activeColor: Color(0xFF00C5BB),
                                                  inactiveColor: Color(0xFFE4E7EC),
                                                  activeToggleColor: Colors.white,
                                                  inactiveToggleColor: Colors.white,
                                                  onToggle: (value) {
                                                    setState(() {
                                                      isPromotionalEnabled = value;
                                                    });
                                                  },

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
