import 'dart:convert';
import 'dart:ui';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Radiology/pastupcomingtestscan.dart';
import 'package:newfolder/Screens/Widgets/custom_type_calender.dart';
import 'package:newfolder/utils/UploadBox.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
import 'dart:async';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';

class RadiologyMain extends StatefulWidget {
  int selectedIndex = 0;

  RadiologyMain({
    super.key,
  });

  @override
  State<RadiologyMain> createState() => RadiologyMainstate();
}

class RadiologyMainstate extends State<RadiologyMain> {
  String usernameValue = "Radiology";
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
  String? selectedCity ;
  final TextEditingController countryController = TextEditingController();
  String? selectedCountryId;
  bool isAllFilled = false;
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
  TextEditingController MobileNummberEditTextController = TextEditingController();
  TextEditingController choosecityEditTextController = TextEditingController();
  TextEditingController selecthosEditTextController = TextEditingController();
  TextEditingController preffereddateEditTextController = TextEditingController();
  TextEditingController choosetestEditTextController = TextEditingController();
  TextEditingController AddTestDetailsTextController = TextEditingController();

  final List<String> uploadfilestime = [
    "Now",

  ];

  // ✅ List of all controllers
  late List<TextEditingController> controllers;
  void initState() {

    super.initState();
    // commnted by asgar
    // checkGuestUser();




  }


  void checkGuestUser() async {
    final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";
    if (isLoggedIn == "YES") {
      Timer(Duration(seconds: 0), () {
        LoginBottomSheet.show(context,true);
      });
    }
  }

  List<Map<String, dynamic>> selectedFiles = [];

  void handleFilesChanged(List<Map<String, dynamic>> files) {
    setState(() {
      selectedFiles = files;
      checkRadiologyField();
    });
    print("📂 Updated files count: ${files.length}");
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

    return Scaffold(
      // resizeToAvoidBottomPadding: false, // fluter 1.x
      resizeToAvoidBottomInset: true ,// fluter 2.x
      body:



      Container(
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
                      top: MediaQuery.of(context).size.height * 0.015,
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



                      // Banner
                      GestureDetector(
                        onTap: () {

                        },
                        child: Card(
                          elevation: 0,
                          child: Container(
                            // width: MediaQuery.of(context).size.height * 0.490,
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                    MediaQuery.of(context).size.height * 0.005,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.00,
                                top: MediaQuery.of(context).size.height * 0.005),
                            color: Colors.white,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.015,
                                  right: MediaQuery.of(context).size.height * 0.015,
                                  bottom: MediaQuery.of(context).size.height * 0.01,
                                  top: MediaQuery.of(context).size.height * 0.0),
                              // height: MediaQuery.of(context).size.height * 0.22,
                              decoration: BoxDecoration(
                                // color: Color(0xFFC80000), // Fallback color if image fails to load
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage("assets/radiologyBg.png"),
                                  // Path to your banner image
                                  fit: BoxFit
                                      .cover, // Ensure image fills the container
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top : MediaQuery.of(context).size.height * 0.01,
                                        left : MediaQuery.of(context).size.height * 0.015,
                                        bottom : MediaQuery.of(context).size.height * 0.01,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.002,
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            child: Text(
                                              "How it Works?",
                                              style: TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  // overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.014),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.002,
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0),
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            130.0),
                                                    child: Image.asset(
                                                      'assets/Shareyourdetails.png',
                                                      height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height *
                                                          0.032, // Adjust height
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height *
                                                          0.032, // Adjust width
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.012,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.002,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0),
                                                  child: Text(
                                                    "Share your details",
                                                    style: TextStyle(
                                                        color: Color(0xFFFFFFFF),
                                                        // overflow: TextOverflow.ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.012),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.005,
                                                right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.002,
                                                top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.00,
                                                bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      right:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      bottom:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      top:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0),
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        130.0),
                                                    child: Image.asset(
                                                      'assets/radiologycall.png',
                                                      height: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.032, // Adjust height
                                                      width: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.032, // Adjust width
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.012,
                                                      right:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.002,
                                                      top:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0),
                                                  child: Text(
                                                    "We will call and confirm the appointment within 2 hours.",
                                                    style: TextStyle(
                                                        color: Color(0xFFFFFFFF),
                                                        // overflow: TextOverflow.ellipsis,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.012),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.005,
                                                right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.002,
                                                top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.00,
                                                bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      right:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      bottom:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      top:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0),
                                                  padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        130.0),
                                                    child: Image.asset(
                                                      'assets/radiologyTick.png',
                                                      height: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.032, // Adjust height
                                                      width: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.032, // Adjust width
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.012,
                                                      right:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.002,
                                                      top:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0),
                                                  child: Text(
                                                    "Please carry your prescription during your visit",
                                                    style: TextStyle(
                                                        color: Color(0xFFFFFFFF),
                                                        // overflow: TextOverflow.ellipsis,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.012),
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
                        ),
                      ),

                      Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height *  0.02,
                            right: MediaQuery.of(context).size.height *  0.02,
                          ),
                          decoration: BoxDecoration(
                            color : Color(0x08000000),
                            borderRadius: BorderRadius.circular(10),

                          ),
                        child : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.01,
                                  right: MediaQuery.of(context).size.height * 0.01,
                                  top: MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.01),
                              child:  Center(
                                child:Text(
                                  "Share Your Details",
                                  style: TextStyle(
                                      color: Color(0xFF126086),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.016),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height *
                                    0.02,

                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Full Name",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height *
                                    0.02,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.02,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,
                              ),
                              child: TextFormField(
                                controller: FullNameEditTextController,
                                onChanged: (value) => checkRadiologyField(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-zA-Z ]'))
                                ],
                                style: TextStyle(
                                    color: Color(0xFF111111),
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.text,
                                validator: (input) => input!.length < 3
                                    ? "First Name should be more than 3 characters"
                                    : null,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height *
                                        0.02,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Enter your Full Name",
                                  hintStyle: TextStyle(
                                    color: Color(0x4D111111),
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Color(0xFFF1F1F1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: Color(0xFFF1F1F1)),
                                  ),
                                ),
                              ),
                            ),

                            // Mobile No
                            Padding(
                              padding: new EdgeInsets.only(
                                  left:
                                  MediaQuery.of(context).size.height *
                                      0.025,
                                  right:
                                  MediaQuery.of(context).size.height *
                                      0.0,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,

                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Mobile Number",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height *
                                    0.02,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.02,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,
                              ),
                              child: new TextFormField(
                                controller:
                                MobileNummberEditTextController,
                                onChanged: (value) => checkRadiologyField(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'))
                                ],
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                validator: (input) => input!.length < 3
                                    ? "Mobile Number should be more than 3 characters"
                                    : null,
                                decoration: new InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height *
                                        0.02,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Enter your Mobile Number",
                                  hintStyle: TextStyle(
                                    color: Color(0x4D111111),
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Color(0xFFF1F1F1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: Color(0xFFF1F1F1)),
                                  ),

                                ),
                              ),
                            ),

                            //Choose City
                            Padding(
                              padding: new EdgeInsets.only(
                                left:
                                MediaQuery.of(context).size.height *
                                    0.025,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.0,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,

                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Choose City",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height *
                                    0.02,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.02,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,
                              ),
                              child:   TextFormField(
                                controller:
                                choosecityEditTextController,
                                onChanged: (value) => checkRadiologyField(),
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(15),
                                  // FilteringTextInputFormatter.allow(
                                  //     RegExp('[0-9]'))
                                ],


                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                  fontWeight: FontWeight.w500,
                                ),

                                validator: (input) => input!.length < 3
                                    ? "Mobile Number should be more than 3 characters"
                                    : null,

                                decoration: new InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height *
                                        0.02,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Enter your city",
                                  hintStyle: TextStyle(
                                    color: Color(0x4D111111),
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Color(0xFFF1F1F1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: Color(0xFFF1F1F1)),
                                  ),

                                ),
                              ),
                            ),



                            //Select Hospital/Clinic
                            Padding(
                              padding: new EdgeInsets.only(
                                left:
                                MediaQuery.of(context).size.height *
                                    0.025,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.0,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,

                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Select Hospital/Clinic",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height *
                                    0.02,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.02,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,
                              ),
                              child: new TextFormField(
                                controller:
                                selecthosEditTextController,
                                onChanged: (value) => checkRadiologyField(),
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(15),
                                  // FilteringTextInputFormatter.allow(
                                  //     RegExp('[0-9]'))
                                ],


                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                // onSaved: (input) => loginRequestModel.email = input,
                                validator: (input) => input!.length < 3
                                    ? "Mobile Number should be more than 3 characters"
                                    : null,

                                decoration: new InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height *
                                        0.02,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Enter Hospital/Clinic ",
                                  hintStyle: TextStyle(
                                    color: Color(0x4D111111),
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Color(0xFFF1F1F1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: Color(0xFFF1F1F1)),
                                  ),

                                ),
                              ),
                            ),


                            //Preferred Date of Appoinment
                            Padding(
                              padding: new EdgeInsets.only(
                                left:
                                MediaQuery.of(context).size.height *
                                    0.025,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.0,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,

                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Prefered Date of Appointment",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.02,
                                right: MediaQuery.of(context).size.height * 0.02,
                                top: MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: SizedBox(
                                height: 32,
                                child: TextFormField(
                                  controller: preffereddateEditTextController,
                                  readOnly: true,
                                  onTap: () async {
                                    FocusScope.of(context).unfocus(); // Hide keyboard

                                    // Open Custom Calendar in Bottom Sheet
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                      ),
                                      builder: (_) {
                                        return Container(
                                          padding: EdgeInsets.all(16),
                                          height: 350, // Adjust as needed
                                          child: CustomTypeCalendar(
                                            minDate: DateTime.now(),
                                            onDateSelected: (selectedDate) {
                                              String formattedDate =
                                                  "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}";

                                              preffereddateEditTextController.text = formattedDate;
                                              checkRadiologyField();

                                              Navigator.pop(context); // Close bottom sheet after selection
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: TextStyle(
                                    color: Color(0xFF111111),
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  validator: (input) => input!.isEmpty ? "Please select a date" : null,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 10,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFFFFFFF),
                                    hintText: "Select Date",
                                    hintStyle: TextStyle(
                                      color: Color(0x4D111111),
                                      fontSize: MediaQuery.of(context).size.height * 0.012,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    suffixIcon: Icon(Icons.calendar_today, size: 13, color: Color(0xFF126086)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                    ),
                                  ),
                                ),
                              )
                              ,
                            ),

                            //Choose Tests
                            Padding(
                              padding: new EdgeInsets.only(
                                left:
                                MediaQuery.of(context).size.height *
                                    0.025,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.0,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,

                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Choose Tests",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height *
                                    0.02,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.02,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,
                              ),
                              child: new TextFormField(
                                controller:
                                choosetestEditTextController,
                                onChanged: (value) => checkRadiologyField(),
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(15),
                                  // FilteringTextInputFormatter.allow(
                                  //     RegExp('[0-9]'))
                                ],
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                validator: (input) => input!.length < 3
                                    ? "Mobile Number should be more than 3 characters"
                                    : null,
                                decoration: new InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height *
                                        0.02,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Enter Tests",
                                  hintStyle: TextStyle(
                                    color: Color(0x4D111111),
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Color(0xFFF1F1F1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: Color(0xFFF1F1F1)),
                                  ),

                                ),
                              ),
                            ),


                            // Add Test Details
                            Padding(
                              padding: new EdgeInsets.only(
                                left:
                                MediaQuery.of(context).size.height *
                                    0.025,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.0,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,

                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Add Test Details",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height *
                                    0.02,
                                right:
                                MediaQuery.of(context).size.height *
                                    0.02,
                                top :  MediaQuery.of(context).size.height *
                                    0.01,
                              ),
                              child: TextFormField(
                                controller: AddTestDetailsTextController,
                                onChanged: (value) => checkRadiologyField(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50),
                                  // FilteringTextInputFormatter.allow(
                                  //     RegExp('[a-zA-Z ]'))
                                ],
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.text,
                                validator: (input) => input!.length < 3
                                    ? "Last Name should be more than 3 characters"
                                    : null,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height *
                                        0.02,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Enter Test Details",
                                  hintStyle: TextStyle(
                                    color: Color(0x4D111111),
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.012,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        color: Color(0xFFF1F1F1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: Color(0xFFF1F1F1)),
                                  ),
                                ),
                              ),
                            ),





                            UploadBox(onFilesChanged: handleFilesChanged),


                            // Request Call Button
                            GestureDetector(
                              onTap: () async {
                                checkRadiologyField();
                                 if(isAllFilled){
                                   Navigator.of(context).push(
                                     MaterialPageRoute(
                                       builder: (BuildContext context) {
                                         return PastUpcomingscanMain(initialTabIndex: 1);
                                       },
                                     ),
                                   );
                                 }




                                 else{
                                   print("Fill all the FIeld");
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
                                      MediaQuery.of(context).size.height * 0.02,
                                      top: MediaQuery.of(context).size.height * 0.03,
                                      bottom:
                                      MediaQuery.of(context).size.height * 0.05,
                                      left:
                                      MediaQuery.of(context).size.height * 0.02),
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
                                                    colors: isAllFilled ? [  Color(0xFF126086), Color(0xFF126086)  ] :[  Color(0x99909090), Color(0x99909090), ]




                                                )),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: TextButton(
                                              onPressed: () async {
                                                if(isAllFilled){
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) {
                                                        return PastUpcomingscanMain(initialTabIndex: 1);
                                                      },
                                                    ),
                                                  );
                                                }
                                                else {
                                                    print("Fill all the Filed");
                                                }
                                              },
                                              child: Text("Request Call",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.018,
                                                    fontWeight: FontWeight.w600,
                                                  )
                                              ),
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.symmetric(vertical: 9.5, horizontal: 12.0), // ← Adjust this
                                                minimumSize: Size(0, 0), // Removes minimum button constraints
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap padding
                                              ),

                                            ),
                                          ),
                                        ),
                                      ])),
                            )

                          ],
                        )
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
      floatingActionButton: isKeyboardVisible ? null : CustomFloatingActionButton(),

      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }





  void checkRadiologyField() {

    if( FullNameEditTextController.text.isNotEmpty && MobileNummberEditTextController.text.isNotEmpty &&
        choosecityEditTextController.text.isNotEmpty && selecthosEditTextController.text.isNotEmpty &&
        preffereddateEditTextController.text.isNotEmpty && choosetestEditTextController.text.isNotEmpty &&
        AddTestDetailsTextController.text.isNotEmpty && selectedFiles.isNotEmpty
    ){
      print("Filled ");
      setState(() {
        isAllFilled = true;
      });
    }

    else {
      print("Filled all the field");
      setState(() {
        isAllFilled = false;
      });
    }




  }
}
