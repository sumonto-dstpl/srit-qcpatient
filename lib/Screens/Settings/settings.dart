import 'dart:io';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
import 'package:newfolder/Screens/Settings/mpinreset.dart';
import 'package:newfolder/Screens/Settings/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Utils/auth_service.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Data/biometric_service.dart';
import '../Utils/profile_avatar.dart';
import 'dart:async';

import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';

class SettingsMain extends StatefulWidget {
  int selectedIndex = 0;
  String? mobileNumber;
  SettingsMain({
    super.key,
    this.mobileNumber,
  });

  @override
  State<SettingsMain> createState() => SettingsMainstate();
}

class SettingsMainstate extends State<SettingsMain> {
  String username = 'Settings' ;
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
    _loadBiometricPreference();
    _loadData();

  }

  void _loadData() async {
    // await Future.delayed(const Duration(seconds: 2));// Simulating API call
    isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";


    // Dynamic naming: Guest01 for guest, otherwise use stored user name
    setState(() {});
    if (isGuestUser) {
      usernameValue = "Guest";
    } else {
      String? username = await UserSecureStorage.getUsernameid();
      Map<String, dynamic>? user = await UserSecureStorage.getUser(username!);
      print("user 111: $user");
      if (user != null && user['data'] != null) {
        String? fname = user['data']['fname'];
        String? lname = user['data']['lname'];
        usernameValue = ((fname ?? "") + " " + (lname ?? "")).trim();
        mobileNumber = user['data']['mobile'] ?? "Mobile Number";
      } else {
        usernameValue = "ashdsaj";
      }
    }





    if (isGuestUser) {
      Timer(Duration(seconds: 0), () {
        LoginBottomSheet.show(context, true);
      });
    }
  }
  void _init() async {

    bool result = await checkEnableMpin();

    setState(() {
      isMpinEnabled = result;
    });
  }

  Future<void> _loadBiometricPreference() async {
    bool enabled = await BiometricService.isBiometricEnabled();
    print("_loadBiometricPreference");
    setState(() {
      isFingerprintEnabled = enabled;
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

  bool isGuestUser =false;
  File? selectedImage;
  String UHID = "UHID";
  String mobileNumber = "Mobile Number";

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
                  Header(userName: username,showProfile: false,),

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
                      child: Column(

                        children: [
                          Container(
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
                                    .height * 0.05,
                                bottom: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.00),
                            margin : EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height *
                                    0.02
                            ),
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
                                    onTap: () async {
                                      if (isGuestUser) return; // disable picking for guest users

                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                        type: FileType.image,
                                      );

                                      if (result != null) {
                                        setState(() {
                                          selectedImage = File(result.files.single.path!);
                                        });
                                      }
                                    },
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          isGuestUser
                                              ? ProfileAvatar(
                                            name: "Guest User",
                                            radius: MediaQuery.of(context).size.height * 0.06,
                                            backgroundColor: Color(0x66D9D9D9),
                                            textColor: Colors.white,
                                          )
                                              : ClipRRect(
                                            borderRadius: BorderRadius.circular(130.0),
                                            child: selectedImage != null
                                                ? Image.file(
                                              selectedImage!,
                                              height: MediaQuery.of(context).size.height * 0.12,
                                              width: MediaQuery.of(context).size.height * 0.12,
                                              fit: BoxFit.cover,
                                            )
                                                : Image.asset(
                                              'assets/drsujeet.png',
                                              height: MediaQuery.of(context).size.height * 0.12,
                                              width: MediaQuery.of(context).size.height * 0.12,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          if (!isGuestUser)
                                            Positioned(
                                              bottom: 6,
                                              right: 4,
                                              child: Container(
                                                width: MediaQuery.of(context).size.height * 0.018,
                                                height: MediaQuery.of(context).size.height * 0.018,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green,
                                                  border: Border.all(
                                                    width: MediaQuery.of(context).size.height * 0.002,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            left:
                                            MediaQuery.of(context).size.height * 0.01,
                                            right:
                                            MediaQuery.of(context).size.height * 0.01,
                                            top:
                                            MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height *
                                                0.00),
                                        child: Text(
                                          usernameValue,
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
                                              left:
                                              MediaQuery.of(context).size.height * 0.01,
                                              right:
                                              MediaQuery.of(context).size.height * 0.01,
                                              top:
                                              MediaQuery.of(context).size.height * 0.00,
                                              bottom: MediaQuery.of(context).size.height *
                                                  0.00),
                                          child: RichText(
                                            text: TextSpan(
                                              text: "SID0007 | ${mobileNumber}",
                                              style: TextStyle(
                                                color: Color(0xFF126086),
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ]
                            ),
                          ),







                          // Change Mobile Number
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return OtpVerification();
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
                                                  onToggle: (bool value) async {
                                                    setState(() {
                                                      isMpinEnabled = value;
                                                    });

                                                    // if (value) {
                                                    //   Navigator.of(context).push(
                                                    //     MaterialPageRoute(builder: (context) => Mpin()),
                                                    //   );
                                                    // }

                                                    if (value) {

                                                      // Navigator.of(context).push(
                                                      //   MaterialPageRoute(builder: (context) => MpinResetSettings()),
                                                      // );
                                                      await secureStorage.write(key: 'mpinEnabled', value: "true");

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



                                            Expanded(
                                              child: FlutterSwitch(
                                                width: MediaQuery.of(context).size.height * 0.030,
                                                height: MediaQuery.of(context).size.height * 0.017,
                                                value: isFingerprintEnabled,
                                                toggleSize: 11,
                                                borderRadius: 20,
                                                padding: 1,
                                                activeColor: const Color(0xFF00C5BB),
                                                inactiveColor: const Color(0xFFE4E7EC),
                                                activeToggleColor: Colors.white,
                                                inactiveToggleColor: Colors.white,

                                                onToggle: (value) async {
                                                  if (value) {
                                                    // get current user id (mobile)
                                                    String? userId = await UserSecureStorage.getUsernameid();

                                                    // check if MPIN exists for this user
                                                    final user = await UserSecureStorage.getUser(userId ?? '');
                                                    final hasMpin = user != null && (user['mpin']?.toString().isNotEmpty ?? false);

                                                    if (hasMpin) {
                                                      // ✅ MPIN already exists → only enable biometric, no redirection
                                                      bool success = await BiometricService.enableBiometric(context);
                                                      if (success) {
                                                        setState(() => isFingerprintEnabled = true);
                                                      } else {
                                                        setState(() => isFingerprintEnabled = false);
                                                      }
                                                    } else {
                                                      // 🚨 MPIN not set → go to correct MPIN setup screen
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => MpinResetSettings(),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    await BiometricService.disableBiometric();
                                                    setState(() => isFingerprintEnabled = false);
                                                  }
                                                },

                                              ),
                                            ),

                                            // Expanded(
                                            //   child: GestureDetector(
                                            //     behavior: HitTestBehavior.translucent, // lets taps go through to child
                                            //     onTap: () {
                                            //       setState(() {
                                            //         isFingerprintEnabled = !isFingerprintEnabled;
                                            //       });
                                            //     },
                                            //     child:
                                            //     FlutterSwitch(
                                            //       // width : MediaQuery.of(context).size.height * 0.025,
                                            //       // height : MediaQuery.of(context).size.height * 0.015,
                                            //       width : MediaQuery.of(context).size.height * 0.030,
                                            //       height : MediaQuery.of(context).size.height * 0.017,
                                            //       value : isFingerprintEnabled,
                                            //       toggleSize: 11,
                                            //       borderRadius: 20,
                                            //       padding : 1,
                                            //       activeColor: Color(0xFF00C5BB),
                                            //       inactiveColor: Color(0xFFE4E7EC),
                                            //       activeToggleColor: Colors.white,
                                            //       inactiveToggleColor: Colors.white,
                                            //       // onToggle: (value) {
                                            //       //   setState(() {
                                            //       //     isFingerprintEnabled = value;
                                            //       //   });
                                            //       // },
                                            //       onToggle: (value) async {
                                            //         if (value) {
                                            //           bool success = await BiometricService.enableBiometric(context);
                                            //           if (success) {
                                            //             setState(() => isFingerprintEnabled = true);
                                            //           } else {
                                            //             setState(() => isFingerprintEnabled = false);
                                            //           }
                                            //         } else {
                                            //           await BiometricService.disableBiometric();
                                            //           setState(() => isFingerprintEnabled = false);
                                            //         }
                                            //       },
                                            //
                                            //     ),
                                            //   ),
                                            // ),
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
        floatingActionButton:  CustomFloatingActionButton(),
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
      ),
    );
  }




}
