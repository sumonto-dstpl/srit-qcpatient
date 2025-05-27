import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/finddoctorslist.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';

class QuickSearchWithData extends StatefulWidget {
  const QuickSearchWithData({
    super.key,
  });
  @override
  State<QuickSearchWithData> createState() => QuickSearchWithDatastate();
}

class QuickSearchWithDatastate extends State<QuickSearchWithData> {
  String usernameValue = "Find Specialties";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";

  final myphysicians = [
    ["assets/CategoryAppoinment.png", "Virtual Consultation"],
    ["assets/CategoryHomeCare.png", "Physical Consultation"],
  ];

  final myphysicianswithblurr = [
    [
      "assets/ambulancealert.png",
      "Virtual Appointments will be available soon"
    ],
    [
      "assets/ambulancealert.png",
      "Virtual Appointments will be available soon"
    ],
  ];

  final myspecialities = [
    ["assets/Hematology.png", "Hematology"],
    ["assets/Oncology.png", "Oncology"],
    ["assets/OrganTransplant.png", "Organ Transplant"],
    ["assets/SupportSpecialties.png", "Support Specialties"],
  ];

  final myOtherServices = [
    ["assets/OtherServicesDiagnostic.png", "Diagnostic"],
    ["assets/OtherServicesDoctor.png", "Doctor"],
    ["assets/OtherServicesNurse.png", "Nurse"],
    ["assets/OtherServicesPhysio.png", "Physio"],
    ["assets/OtherServicesMedicalEquipment's.png", "Medical Equipment's"],
  ];

  final myhealyhblogbanner = [
    ["assets/healthblogbanner1.png", "Appoinment"],
    ["assets/healthblogbanner2.png", "Home Care"],
    ["assets/healthblogbanner3.png", "Medications"],
    ["assets/healthblogbanner4.png", "Lab"],
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();
  TextEditingController SearchEditTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  bottom: screenWidth * 0.02,
                ),
                margin: EdgeInsets.only(
                  right: screenHeight * 0.0,
                  top: screenHeight * 0.0,
                  bottom: screenHeight * 0.0,
                  left: screenHeight * 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ),

              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.005,
                      right: MediaQuery.of(context).size.height * 0.005,
                      top: MediaQuery.of(context).size.height * 0.02,
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
                      // Search Input Field

                      Container(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.0,
                          left: screenWidth * 0.0,
                          right: screenWidth * 0.0,
                          bottom: screenWidth * 0.0,
                        ),
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.0,
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                            left: MediaQuery.of(context).size.height * 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: screenHeight * 0.045,
                                width: screenHeight * 0.045,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100]!.withOpacity(0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: Color(0xFF126086),
                                  size: screenHeight * 0.025,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: screenHeight *
                                    0.005), // Add spacing between widgets
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(
                                        bottom: screenHeight * 0.01),
                                    child: TextFormField(
                                      controller: SearchEditTextController,
                                      /* inputFormatters: [
                                        LengthLimitingTextInputFormatter(15),
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-zA-Z0-9]')),
                                      ],*/
                                      /*textCapitalization:
                                          TextCapitalization.characters,*/
                                      style: TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) => input!.length < 3
                                          ? "Search should be more than 3 characters"
                                          : null,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(
                                            screenHeight * 0.012),
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        hintText: "Search By Doctor",
                                        hintStyle: TextStyle(
                                          color: Colors.black26,
                                          fontSize: screenHeight * 0.016,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                          borderSide:
                                          BorderSide(color: Colors.grey),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                        ),
                                        suffixIcon: IconButton(
                                          icon:  Icon(
                                            Icons.search,
                                            color: Colors.black45,
                                            size: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.02,
                                          ),
                                          onPressed: () {
                                            // Your search logic here
                                            print("Search icon clicked!");
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // General Physician
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0x99F7F5F6),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          top : MediaQuery.of(context).size.height * 0.005,
                          bottom : MediaQuery.of(context).size.height * 0.005,

                        ),
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.015,
                          right :MediaQuery.of(context).size.height * 0.28,

                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.access_time_sharp,
                                  color: Colors.black,
                                  size: MediaQuery.of(context).size.height *
                                      0.016
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                        right:
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                        top:
                                        MediaQuery.of(context).size.height *
                                            0.00,
                                        bottom:
                                        MediaQuery.of(context).size.height *
                                            0.00),
                                    child: Text(
                                      "General Physician",
                                      style: TextStyle(
                                        color: Color(0xCC000000),
                                        // fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),

                      // Specialties
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.015,
                            right: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.02),
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
                                  "Specialties",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.014,
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              bottom:
                              MediaQuery.of(context).size.height * 0.020 ,
                              left : MediaQuery.of(context).size.height * 0.01 ,
                              right : MediaQuery.of(context).size.height * 0.01 ,

                            ),
                            child: ListView.builder(
                              physics: ScrollPhysics(), // Ensures scrolling
                              shrinkWrap:
                              true, // Prevents ListView from taking up extra space
                              itemCount: myspecialities
                                  .length, // Use the length of the list
                              itemBuilder: (BuildContext context, int index) {
                                final speciality = myspecialities[
                                index]; // Get the current item
                                final imagePath = speciality[0];
                                final text = speciality[1];

                                return GestureDetector(
                                  onTap: () {
                                    // Add your onTap logic here
                                  },
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.02,
                                          right:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.005,
                                          bottom: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01,
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // gradient: LinearGradient(
                                        //   begin: Alignment.centerLeft,
                                        //   end: Alignment.centerRight,
                                        //   stops: [0.5, 0.9],
                                        //   colors: [
                                        //     Color(0xFFE8F0F3).withOpacity(0.5),
                                        //     Color(0xFFE8F0F3).withOpacity(0.5),
                                        //   ],
                                        // ),
                                        color : Color(0xB2F7F5F6),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.02,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.02,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(imagePath),
                                                fit: BoxFit.contain,

                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.015,
                                          ),
                                          Expanded(
                                            child: Text(
                                              text,
                                              style: TextStyle(
                                                 color: Color(0xFF13658C),
                                                 fontWeight: FontWeight.w500,
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
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      // Doctors
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.015,
                            right: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                            top: MediaQuery.of(context).size.height * 0.0),
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
                                  "Doctors",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.014,
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Provide a width constraint using SizedBox or Expanded
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.015,
                                right:
                                MediaQuery.of(context).size.height * 0.015,
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
                              itemCount: 3, // You can adjust the item count
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    /*if (index == 0) {
                                      print("Custom FAB pressed!");
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (BuildContext context) {
                                            return FindDoctorsListMain();
                                          },
                                        ),
                                      );
                                    } else if (index == 1) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (BuildContext context) {
                                            return FindDoctorsListMain();
                                          },
                                        ),
                                      );
                                    } else {
                                      // Handle other indices
                                      print("Button $index clicked!");
                                    }*/
                                  },
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Background color of the container
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
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
                                      width:
                                      MediaQuery.of(context).size.height *
                                          0.450,
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
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
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
                                                // color: Colors.red,
                                                height: MediaQuery.of(context).size.height * 0.07,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.005,
                                                    right:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.005,
                                                    top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    bottom:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00),


                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.01),
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
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.015),
                                                    Expanded(
                                                      child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                      
                                                      
                                                        children: <Widget>[
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery
                                                                    .of(
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
                                                                    0.01,
                                                                bottom: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.00),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                  
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.height *
                                                                            0.00,
                                                                        right: MediaQuery.of(context).size.height *
                                                                            0.00,
                                                                        top: MediaQuery.of(context).size.height *
                                                                            0.0,
                                                                        bottom: MediaQuery.of(context).size.height *
                                                                            0.00),
                                                                    child: Text(
                                                                      "Dr. Nutan Bhatt",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                          MediaQuery.of(context).size.height * 0.016),
                                                                    ),
                                                                  ),
                                                                   
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Color(0xFFF3F5F9),
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          8),
                                                                    ),
                                                                    padding: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.height *
                                                                            0.005,
                                                                        right: MediaQuery.of(context).size.height *
                                                                            0.012,
                                                                        top: MediaQuery.of(context).size.height *
                                                                            0.003,
                                                                        bottom: MediaQuery.of(context).size.height *
                                                                            0.003),
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                          Colors.amber,
                                                                          size: MediaQuery.of(context).size.height *
                                                                              0.015,
                                                                        ),
                                                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005 ,),
                                                                        Text(
                                                                          "4.2",
                                                                          style: TextStyle(
                                                                              color: Colors.black87,
                                                                              fontWeight: FontWeight.w600,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.012),
                                                                        )
                                                                      ],
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                          SizedBox(height: screenHeight * 0.005,),
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery
                                                                    .of(
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
                                                                    0.00),
                                                            child: Text(
                                                              "General physician / Internal Medicine",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.014),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
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

                      // Preventive Health Checkup
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.015,
                            right: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                            top: MediaQuery.of(context).size.height * 0.02),
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
                                  "Preventive Health Checkup",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.014,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add your onTap logic here
                        },
                        child: Material(
                          type: MaterialType
                              .transparency, // Removes Card's default margin
                          child: Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.015,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.005,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // gradient: LinearGradient(
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              //   stops: [0.5, 0.9],
                              //   colors: [
                              //     Color(0xFFE8F0F3).withOpacity(0.5),
                              //     Color(0xFFE8F0F3).withOpacity(0.5),
                              //   ],
                              // ),
                              color : Color(0xB2F7F5F6),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.height *
                                      0.02,
                                  height: MediaQuery.of(context).size.height *
                                      0.02,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/nodatasearchicon.png"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                Expanded(
                                  child: Text(
                                    "No result found for the searched keyword - Organ Transplant",
                                    style: TextStyle(
                                      color: Color(0xFF13658C),
                                      fontWeight: FontWeight.w500,
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
                        ),
                      ),

                      // Service
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.015,
                            right: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.02,
                            top: MediaQuery.of(context).size.height * 0.02),
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
                                  "Service",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.014,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Add your onTap logic here
                        },
                        child: Material(
                          type: MaterialType
                              .transparency, // Removes Card's default margin
                          child: Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.015,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.005,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // gradient: LinearGradient(
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              //   stops: [0.5, 0.9],
                              //   colors: [
                              //     Color(0xFFE8F0F3).withOpacity(0.5),
                              //     Color(0xFFE8F0F3).withOpacity(0.5),
                              //   ],
                              // ),
                              color : Color(0xB2F7F5F6),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.height *
                                      0.02,
                                  height: MediaQuery.of(context).size.height *
                                      0.02,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/nodatasearchicon.png"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                Expanded(
                                  child: Text(
                                    "No result found for the searched keyword - Organ Transplant",
                                    style: TextStyle(
                                      color: Color(0xFF13658C),
                                      fontWeight: FontWeight.w500,
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
