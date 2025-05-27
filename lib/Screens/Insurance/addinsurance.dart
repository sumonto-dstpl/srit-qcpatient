import 'dart:convert';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/HomeCare/diagnosticmain.dart';
import 'package:newfolder/Screens/HomeCare/doctorhcmain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Radiology/pastupcomingtestscan.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';


import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';



class AddInsuranceMain extends StatefulWidget {
  int selectedIndex = 0;

  AddInsuranceMain({
    super.key,
  });

  @override
  State<AddInsuranceMain> createState() => AddInsuranceMainstate();
}

class AddInsuranceMainstate extends State<AddInsuranceMain> {
  String usernameValue = "Add New Insurance";
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

  String? selectedCountryId;

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

  TextEditingController InsurnceProviderTextController = TextEditingController();
  TextEditingController NationalIDTextController = TextEditingController();
  TextEditingController PolicyNameEditTextController = TextEditingController();
  TextEditingController StartDateController = TextEditingController();
  TextEditingController ExpiryDateTextController = TextEditingController();
  TextEditingController PrimaryinsuredNameTextController = TextEditingController();
  TextEditingController InsuranceTypeTextController = TextEditingController();
  TextEditingController CoverageLimitController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
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
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.height * 0.01,
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom:
                            MediaQuery.of(context).size.height * 0.00),
                        child:  Center(
                          child:Text(
                          "New Insurance Card",
                          style: TextStyle(
                              color: Color(0xFF126086),
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.018),
                        ),
                      ),
                      ),

                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.height * 0.01,
                            top: MediaQuery.of(context).size.height * 0.005,
                            bottom:
                            MediaQuery.of(context).size.height * 0.00),
                        child: Center(
                          child:Text(
                          "Please fill the Card Information Below",
                          style: TextStyle(
                              color: Color(0x80000000),
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.014),
                        ),
                      ),
                      ),





      Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.height *  0.02,
          right: MediaQuery.of(context).size.height *  0.02,
          top : MediaQuery.of(context).size.height *  0.02,
        ),
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01),
        decoration: BoxDecoration(
          color : Color(0x08000000),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Column(
          children: [





            // Insurance Provider *
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Insurance Provider ",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context)
                              .size
                              .height *
                              0.012,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                controller: InsurnceProviderTextController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                  FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-Z ]'))
                ],
                /*textCapitalization:
                                          TextCapitalization.characters,*/
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
                  hintText: "Enter the Insurance Provider name",
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



            //National ID or Iqama *
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.00,
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "National ID or Iqama",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context)
                              .size
                              .height *
                              0.012,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                NationalIDTextController,
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
                  hintText: "Enter national id or Iqama",
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




            //Policy Name *
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02,
                top: MediaQuery.of(context).size.height * 0.01,

              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Policy Name",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context)
                              .size
                              .height *
                              0.012,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                PolicyNameEditTextController,
                keyboardType: TextInputType.text,
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
                  hintText: "Enter policy name",
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



            //Start Date *
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02,
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Start Date",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context)
                              .size
                              .height *
                              0.012,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                StartDateController,
                keyboardType: TextInputType.text,
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
                  hintText: "Enter Membership Number",
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


            //Expiry Date *
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02,
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Expiry Date",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context)
                              .size
                              .height *
                              0.012,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                ExpiryDateTextController,
                keyboardType: TextInputType.text,
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
                  hintText: "Enter the expiration date",
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


            //Primary Insured Name
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height *
                    0.02,
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Primary Insured Name ",
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
                PrimaryinsuredNameTextController,
                keyboardType: TextInputType.text,
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
                  hintText: "Enter Primary Insured Name",
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


            //Insurance Type
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height *
                    0.02,
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Insurance Type",
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
                InsuranceTypeTextController,
                keyboardType: TextInputType.text,
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
                  hintText: "Enter Insurance Type",
                   hintStyle:TextStyle(
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


            // Coverage Limit
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height *
                    0.02,
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Coverage Limit",
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
                controller: CoverageLimitController,
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
                  hintText: "Enter Coverage Limit",
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



            // Upload File
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top:  MediaQuery.of(context).size.height * 0.02,
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
                                    .headline6!
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



    Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(
            left:
            MediaQuery.of(context).size.height *
                0.01,
            right:
            MediaQuery.of(context).size.height *
                0.0,
            bottom:
            MediaQuery.of(context).size.height *
                0.00,
            top:
            MediaQuery.of(context).size.height *
                0.0),
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height *
              0.00,
        ),
        child: ClipRRect(
          borderRadius:
          BorderRadius.circular(130.0),
          child: Image.asset(
            'assets/phinfofill.png',
            height:
            MediaQuery.of(context).size.height *
                0.02, // Adjust height
            width:
            MediaQuery.of(context).size.height *
                0.02, // Adjust width
            fit: BoxFit.fill,
          ),
        ),
      ),

      Expanded(
    child:
      Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * 0.01,
            right: MediaQuery.of(context).size.height * 0.01,
            top: MediaQuery.of(context).size.height * 0.02,
            bottom:
            MediaQuery.of(context).size.height * 0.0),
        child:  Text(
            "Please note your request will be reviewed. and we will notify you once it's verified.",
            style: TextStyle(
                color: Color(0x80000000),
                // overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                fontSize:
                MediaQuery.of(context).size.height * 0.014),

        ),
      ),
    ),
      ]
    ),





            // Submit Button
            GestureDetector(
              onTap: () async {

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
                      top: MediaQuery.of(context).size.height * 0.01,
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
                                    colors: [
                                      Color(0x99909090),
                                      Color(0x99909090),
                                    ])),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 0.0),
                            child: TextButton(
                              onPressed: () async {

                              },
                              child: Text("Submit",
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






            ]
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

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardVisible ? null :Container(
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

  void showBottomSheet() => showModalBottomSheet(
    enableDrag: false,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    barrierColor: Colors.grey.withOpacity(0.9),
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) =>
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.025,
                      right: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.015),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.0,
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                      ),
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.0,
                        bottom: MediaQuery.of(context).size.height * 0.0,
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0,
                              bottom: MediaQuery.of(context).size.height * 0.03,
                              left: MediaQuery.of(context).size.height * 0.18,
                              right: MediaQuery.of(context).size.height * 0.18,
                            ),
                            child: Divider(
                              height: 0,
                              indent: 0,
                              thickness: MediaQuery.of(context).size.height * 0.008,
                              color:Color(0xFF95C8D6).withOpacity(0.3),
                            ),
                          ),

                          // Select the Type of Appointment
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.0,
                                right: MediaQuery.of(context).size.height * 0.02,
                                bottom: MediaQuery.of(context).size.height * 0.00),
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
                                      "Select the Type of Appointment",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
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
                                  builder: (BuildContext context) {
                                    return AppointmentsFootMain();
                                  },
                                ),
                              );
                            },
                            child:Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.025,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.015),
                              decoration: BoxDecoration(
                                color: Color(0xFFA8B1CE).withOpacity(0.1), // Background color of the container
                                /*  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(
                                          0.1), // Shadow color
                                      blurRadius:
                                      5, // Spread of the shadow
                                      offset: Offset(0,
                                          0), // Offset in x and y direction
                                    ),
                                  ],*/
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
                                          Color(0xFFA8B1CE).withOpacity(0.1),
                                          Color(0xFFA8B1CE).withOpacity(0.1),
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
                                              child:  Container(
                                                margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.height * 0.01,
                                                  right: MediaQuery.of(context).size.height * 0.01,
                                                  top: MediaQuery.of(context).size.height * 0.01,
                                                  bottom: MediaQuery.of(context).size.height * 0.01,
                                                ),
                                                height: MediaQuery.of(context).size.height * 0.025,
                                                width: MediaQuery.of(context).size.height * 0.025,
                                                child:
                                                Image.asset(
                                                  'assets/AppointmentBs.png',
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
                                                    "Appointments",
                                                    style:
                                                    TextStyle(
                                                      color: Color(0xFF126086),
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
                                            Color(0xFF126086),
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
                                  builder: (BuildContext context) {
                                    return TestAndServicesMain();
                                  },
                                ),
                              );
                            },
                            child:Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.025,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.015),
                              decoration: BoxDecoration(
                                color: Color(0xFFA8B1CE).withOpacity(0.1), // Background color of the container
                                /*  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(
                                          0.1), // Shadow color
                                      blurRadius:
                                      5, // Spread of the shadow
                                      offset: Offset(0,
                                          0), // Offset in x and y direction
                                    ),
                                  ],*/
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
                                          Color(0xFFA8B1CE).withOpacity(0.1),
                                          Color(0xFFA8B1CE).withOpacity(0.1),
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
                                              child:   Container(
                                                margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.height * 0.01,
                                                  right: MediaQuery.of(context).size.height * 0.01,
                                                  top: MediaQuery.of(context).size.height * 0.01,
                                                  bottom: MediaQuery.of(context).size.height * 0.01,
                                                ),
                                                height: MediaQuery.of(context).size.height * 0.025,
                                                width: MediaQuery.of(context).size.height * 0.025,
                                                child:
                                                Image.asset(
                                                  'assets/TestServicesBs.png',
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
                                                    "Test & Services",
                                                    style:
                                                    TextStyle(
                                                      color: Color(0xFF126086),
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
                                            Color(0xFF126086),
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
  );
}
