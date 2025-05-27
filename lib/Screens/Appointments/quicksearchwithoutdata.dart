import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithdata.dart';
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

class QuickSearchWithoutData extends StatefulWidget {
  const QuickSearchWithoutData({
    super.key,
  });
  @override
  State<QuickSearchWithoutData> createState() => QuickSearchWithoutDatastate();
}

class QuickSearchWithoutDatastate extends State<QuickSearchWithoutData> {
  String usernameValue = "Find Specialties";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";

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
                                  size: screenHeight * 0.02,
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
                                        bottom: screenHeight * 0.01,
                                        right : screenHeight * 0.01,
                                    ),
                                    child: TextFormField(
                                      controller: SearchEditTextController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(15),
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-zA-Z0-9]')),
                                      ],
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      style: TextStyle(color: Colors.black45),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) => input!.length < 3
                                          ? "Search should be more than 3 characters"
                                          : null,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height * 0.02,
                                          MediaQuery.of(context).size.height * 0.012,
                                          MediaQuery.of(context).size.height * 0.012,
                                          MediaQuery.of(context).size.height * 0.012,
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFF7F5F6),
                                        hintText: "Search By Doctor",
                                        hintStyle: TextStyle(
                                          color: Colors.black26,
                                          fontSize: screenHeight * 0.016,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: Colors.black45,
                                            size: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.024 ,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return QuickSearchWithData();
                                                },
                                              ),
                                            );
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

                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.055,
                            right: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.00),
                        child: Text(
                          "Please Enter a Search term with atleast 3 characters to search",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.013),
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
    );
  }
}
