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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (BuildContext context) {
                                  return PreferredHospitalLocationScreen();
                                },
                              ),
                            );
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
                          // Add your onTap logic here
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
                                  LengthLimitingTextInputFormatter(15),
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
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     left: MediaQuery.of(context).size.height *
                            //         0.02,
                            //     right:
                            //     MediaQuery.of(context).size.height *
                            //         0.02,
                            //     top :  MediaQuery.of(context).size.height *
                            //         0.01,
                            //   ),
                            //   child: new TextFormField(
                            //     controller:
                            //     preffereddateEditTextController,
                            //     readOnly: true,
                            //     // onChanged: (value) => checkRadiologyField(),
                            //
                            //     onTap: () async {
                            //       FocusScope.of(context).unfocus(); // Hide keyboard
                            //
                            //       // Open Custom Calendar in Bottom Sheet
                            //       showModalBottomSheet(
                            //         context: context,
                            //         backgroundColor: Colors.white,
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            //         ),
                            //         builder: (_) {
                            //           return Container(
                            //             padding: EdgeInsets.all(16),
                            //             height: 350, // Adjust as needed
                            //             child: CustomTypeCalendar(
                            //               onDateSelected: (selectedDate) {
                            //                 String formattedDate =
                            //                     "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}";
                            //
                            //                 preffereddateEditTextController.text = formattedDate;
                            //
                            //
                            //                 Navigator.pop(context); // Close bottom sheet after selection
                            //               },
                            //             ),
                            //           );
                            //         },
                            //       );
                            //
                            //       checkRadiologyField();
                            //     },
                            //     inputFormatters: [
                            //       LengthLimitingTextInputFormatter(15),
                            //       // FilteringTextInputFormatter.allow(
                            //       //     RegExp('[0-9]'))
                            //     ],
                            //
                            //
                            //     style: TextStyle(
                            //       color: Color(0xFF111111),
                            //       fontSize: MediaQuery.of(context).size.height * 0.012,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //
                            //     validator: (input) => input!.length < 3
                            //         ? "Mobile Number should be more than 3 characters"
                            //         : null,
                            //     /* validator: (input) => !input.contains('@')
                            //   ? "Email Id should be valid"
                            //   : null,*/
                            //     decoration: new InputDecoration(
                            //       isDense: true,
                            //       contentPadding: EdgeInsets.fromLTRB(
                            //         MediaQuery.of(context).size.height *
                            //             0.02,
                            //         MediaQuery.of(context).size.height *
                            //             0.01,
                            //         MediaQuery.of(context).size.height *
                            //             0.01,
                            //         MediaQuery.of(context).size.height *
                            //             0.01,
                            //       ),
                            //       filled: true,
                            //       fillColor: Color(0xFFFFFFFF),
                            //       hintText: "Enter appointment date",
                            //       hintStyle: TextStyle(
                            //         color: Color(0x4D111111),
                            //         fontSize: MediaQuery.of(context)
                            //             .size
                            //             .height *
                            //             0.012,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius:
                            //         BorderRadius.circular(5.0),
                            //         borderSide: BorderSide(
                            //             color: Color(0xFFF1F1F1)),
                            //       ),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.all(
                            //             Radius.circular(5.0)),
                            //         borderSide:
                            //         BorderSide(color: Color(0xFFF1F1F1)),
                            //       ),
                            //       suffixIcon: Icon(Icons.calendar_today,  color: Color(0xFF126086)),
                            //     ),
                            //   ),
                            // ),
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
                                  hintText: "Enter appointment date",
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



                            // // Upload File
                            // GestureDetector(
                            //   onTap: () => getImageFromGallery,
                            //   child: Container(
                            //     width: double.infinity,
                            //     padding: EdgeInsets.only(
                            //       top:  MediaQuery.of(context).size.height * 0.02,
                            //       bottom: MediaQuery.of(context).size.height * 0.0,
                            //       right: MediaQuery.of(context).size.height * 0.020,
                            //       left: MediaQuery.of(context).size.height * 0.02,
                            //     ),
                            //     // height: MediaQuery.of(context).size.height * 0.150,
                            //     child: DottedBorder(
                            //       color: Color(0xFF343434).withOpacity(0.3),
                            //       strokeWidth: 1,
                            //       borderType: BorderType.RRect,
                            //       radius: Radius.circular(8),
                            //       child: Center(
                            //         // Ensures the content is centered within the border
                            //         child: Column(
                            //           mainAxisAlignment: MainAxisAlignment
                            //               .center, // Aligns content vertically
                            //           crossAxisAlignment: CrossAxisAlignment
                            //               .center, // Aligns content horizontally
                            //           children: <Widget>[
                            //             Container(
                            //               margin: EdgeInsets.only(
                            //                   left: MediaQuery.of(context).size.height *
                            //                       0.00,
                            //                   right:
                            //                   MediaQuery.of(context).size.height *
                            //                       0.00,
                            //                   top: MediaQuery.of(context).size.height *
                            //                       0.02,
                            //                   bottom:
                            //                   MediaQuery.of(context).size.height *
                            //                       0.01),
                            //               width: screenHeight * 0.04,
                            //               height: screenHeight * 0.04,
                            //               decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                   image: AssetImage("assets/homecare.png"),
                            //                   fit: BoxFit.contain,
                            //                 ),
                            //               ),
                            //             ),
                            //             Column(
                            //               children: <Widget>[
                            //                 Container(
                            //                   padding:
                            //                   EdgeInsets.only(
                            //                       left: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.00,
                            //                       right: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.00,
                            //                       top: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.00,
                            //                       bottom: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.006),
                            //                   child: Text(
                            //                     "choose file to upload",
                            //                     style: TextStyle(
                            //                       fontWeight: FontWeight.w600,
                            //                       color: Color(0xFF1F1F1F),
                            //                       fontSize: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.014,
                            //
                            //                     ),
                            //                     overflow: TextOverflow.ellipsis,
                            //                   ),
                            //                 ),
                            //                 Container(
                            //                   padding:
                            //                   EdgeInsets.only(
                            //                       left: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.00,
                            //                       right: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.00,
                            //                       top: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.00,
                            //                       bottom: MediaQuery.of(context)
                            //                           .size
                            //                           .height *
                            //                           0.02),
                            //                   child: RichText(
                            //                     text: TextSpan(
                            //                       style: Theme.of(context)
                            //                           .textTheme
                            //                           .titleLarge!
                            //                           .merge(
                            //                         TextStyle(
                            //                             color: Theme.of(context)
                            //                                 .primaryColor),
                            //                       ),
                            //                       children: [
                            //                         TextSpan(
                            //                           text:
                            //                           'image or pdf Should be less than',
                            //                           style: TextStyle(
                            //                             color: Color(0xFF000000)
                            //                                 .withOpacity(0.4),
                            //                             fontWeight: FontWeight.w600,
                            //                             fontSize: screenHeight * 0.012,
                            //                           ),
                            //                         ),
                            //                         TextSpan(
                            //                           text: ' 10MB',
                            //                           style: TextStyle(
                            //                             fontWeight: FontWeight.w600,
                            //                             fontSize: screenHeight * 0.012,
                            //                             color: Color(0xFF126086),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),

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




                  // Drop down below Show
                 /* DropdownMenu<String>(
                    controller: countryController,
                    label: const Text('Country'),
                    width: 300,
                    dropdownMenuEntries: countries
                        .map<DropdownMenuEntry<String>>((country) => DropdownMenuEntry<String>(
                      value: country['id']!, // The argument type 'String?' can't be assigned to the parameter type 'String
                      label: country['name']!, // Display the country name
                    ))
                        .toList(),
                    enableFilter: true,
                    menuStyle: const MenuStyle(
                      alignment: Alignment.bottomLeft,
                      maximumSize: MaterialStatePropertyAll(Size.fromHeight(200)), // Limit menu height
                    ),
                    requestFocusOnTap: true,
                    onSelected: (String? countryId) {
                      selectedCountryId = countryId;
                      print('Selected Country ID: $selectedCountryId');
                    },
                  ),*/







                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardVisible ? null : Container(
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
                                                                      'assets/AppointmentBs.png',
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
