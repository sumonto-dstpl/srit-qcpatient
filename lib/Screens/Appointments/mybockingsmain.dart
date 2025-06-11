import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/Models/appointmentselectime.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/appointmentsmainfindDoctors.dart';
import 'package:newfolder/Screens/Appointments/bottomsheet_for_payment.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';
import 'package:newfolder/Screens/Appointments/doctordetailpage.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Medications/bottomsheet_for_payment.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/ShareToOtherApp.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Widgets/readmoreless.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
import 'dart:async';


class MyBookingsMain extends StatefulWidget {
  // final String doctoridval;
  final String selectedDate;
  final String selectedTime;
  const MyBookingsMain({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    // required this.doctoridval,
  });
  @override
  State<MyBookingsMain> createState() => MyBookingsMainstate();
}

class MyBookingsMainstate extends State<MyBookingsMain> {
  String usernameValue = "Hello, Priya Krishnamurty";
  String useraddressValue = "Reg: TSMC/FMR/09823";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  bool _isSharing = false;


  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();
  final myimageslist = [
    ["assets/appointmentimg1.png"],
    ["assets/appointmentimg2.png"],
    ["assets/appointmentimg3.png"],
    ["assets/appointmentimg5.png"],
  ];


  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;
  AppointmentSelectTimeResponse? responsedetails;

  String getFormattedDateTime() {
    try {
      final combined = "${widget.selectedDate}, ${widget.selectedTime} PM"; // append if needed
      print("DEBUG: Combined string -> $combined");

      final parsed = DateFormat("dd-MM-yyyy, hh:mm a").parse(combined);
      return DateFormat("MMMM dd yyyy, hh:mm a").format(parsed);
    } catch (e) {
      print("ERROR: Failed to parse date/time - $e");
      return "Invalid date/time";
    }
  }


  @override
  void initState() {
    getSharedPrefs();
    super.initState();
  }

  Future getSharedPrefs() async {
    // CheckSession();
    // getBookingDetails();
  }


  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    progressDialog.style(
        message: 'Loading..' '\nPlease Wait',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          color: Colors.blueAccent,
          strokeWidth: MediaQuery.of(context).size.height * 0.002,
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 13.0,
        ),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w600));
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(
                top: screenHeight * 0.07,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                bottom: screenWidth * 0.0,
              ),
              margin: EdgeInsets.only(
                right: screenHeight * 0.0,
                top: screenHeight * 0.0,
                bottom: screenHeight * 0.0,
                left: screenHeight * 0.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.height * 0.03,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.0,
                        top: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.0,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF126086).withOpacity(0.2),
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 0.0, color: Color(0xFF126086)),
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
                  userprofilepValue != "NA"
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.250,
                          width: MediaQuery.of(context).size.height * 0.200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Colors.white,
                            ),
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  Image.memory(base64Decode(userprofilepValue))
                                      .image,
                            ),
                          ),
                        )
                      : Container(
                        // color: Colors.blue,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.0,
                              right: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.00),
                          height: MediaQuery.of(context).size.height * 0.250,
                          width: MediaQuery.of(context).size.height * 0.21,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/bookappointmentdoc.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.250,
                    // color: Colors.blue,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.0,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.0,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[100]!.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.005,
                                    right: MediaQuery.of(context).size.height *
                                        0.012,
                                    top: MediaQuery.of(context).size.height *
                                        0.002,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.002),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: MediaQuery.of(context).size.height *
                                          0.015,
                                    ),
                                    Text(
                                      "4.2",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.012),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  // Navigator.pop(context);
                                  if (_isSharing) return;
                                  _isSharing = true;
                                  try {
                                    // Call your static method that wraps Share.share()
                                    ShareToOtherApp.share();

                                    // Add a delay because Share.share() returns immediately
                                    await Future.delayed(Duration(seconds: 2));
                                  } catch (e) {
                                    print('Sharing failed: $e');
                                  } finally {
                                    _isSharing = false;
                                  }
                                },
                                onDoubleTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.020,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.00),
                                  height: screenHeight * 0.03,
                                  width: screenHeight * 0.03,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue[100]!.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    // Ensures the image is centered
                                    child: Image.asset(
                                      'assets/share.png', // Replace with your actual asset path
                                      // color: Color(0xFF000000).withOpacity(0.2), // Optional: Apply color tint
                                      height: screenHeight * 0.035,
                                      width: screenHeight * 0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        Container(
                          // color: Colors.white,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.005,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                          ),
                          child: Text(
                            useraddressValue,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.012,
                              color: Colors.white,
                            ),
                            // textAlign: TextAlign.left,
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
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.01,
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.00),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.02),
                    topRight: Radius.circular(screenHeight * 0.02),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Container(
                    //       padding: EdgeInsets.only(
                    //           left: MediaQuery.of(context).size.height * 0.01,
                    //           right: MediaQuery.of(context).size.height * 0.01,
                    //           top: MediaQuery.of(context).size.height * 0.01,
                    //           bottom:
                    //               MediaQuery.of(context).size.height * 0.005),
                    //       child: Text(
                    //         "Dr. Nutan Bhatt",
                    //         style: TextStyle(
                    //             color: Color(0xFF126086),
                    //             overflow: TextOverflow.ellipsis,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize:
                    //                 MediaQuery.of(context).size.height * 0.02),
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.only(
                    //           left: MediaQuery.of(context).size.height * 0.01,
                    //           right: MediaQuery.of(context).size.height * 0.01,
                    //           top: MediaQuery.of(context).size.height * 0.00,
                    //           bottom:
                    //               MediaQuery.of(context).size.height * 0.005),
                    //       child: Text(
                    //         "General physician / Internal Medicine",
                    //         style: TextStyle(
                    //             color: Colors.black54,
                    //             fontWeight: FontWeight.bold,
                    //             overflow: TextOverflow.ellipsis,
                    //             fontSize:
                    //                 MediaQuery.of(context).size.height * 0.018),
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.only(
                    //           left: MediaQuery.of(context).size.height * 0.01,
                    //           right: MediaQuery.of(context).size.height * 0.01,
                    //           top: MediaQuery.of(context).size.height * 0.00,
                    //           bottom:
                    //               MediaQuery.of(context).size.height * 0.005),
                    //       child: Text(
                    //         "41 YEARS Experience- MBBS, DIPLOMA IN FAMILY MEDICINE (123 Reviews)",
                    //         style: TextStyle(
                    //             color: Color(0xFF126086),
                    //             fontWeight: FontWeight.bold,
                    //             // overflow: TextOverflow.ellipsis,
                    //             fontSize:
                    //                 MediaQuery.of(context).size.height * 0.013),
                    //       ),
                    //     ),
                    //   ],
                    // ),



                    // top card
                    // Doctor Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Dr. Nutan Bhatt",
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return DoctorDetilPage(
                                            // widget.doctoridval
                                            ''
                                            );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.005,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      top: MediaQuery.of(context).size.height *
                                          0.005),
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(130.0),
                                    child: Image.asset(
                                      'assets/Infodocdetails.png',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.014, // Adjust height
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.014, // Adjust width
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(height: 4),
                        Text(
                          "General physician / Internal Medicine",
                          // completedSpecialityString,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.014,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.0,
                              right: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.008,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.00),
                          child: Text(
                            "41 YEARS Experience- MBBS, DIPLOMA IN FAMILY MEDICINE (123 Reviews)",
                            // qualificationval,
                            style: TextStyle(
                              color: Color(0xFF126086),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.012,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF126086).withOpacity(0.1),
                          borderRadius: BorderRadius.only(
                            // Add curves to the bottom sides here
                            bottomLeft:
                            Radius.circular(15), // Set the curve radius
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              width: double.infinity,
                               // Removed any padding for outer container
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Colors.black26, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height * 0.015,
                                        top : MediaQuery.of(context).size.height * 0.01,
                                        right: MediaQuery.of(context).size.height * 0.0,
                                        bottom: MediaQuery.of(context).size.height * 0.005),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Hospital Visit",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.014,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  // Top images container
                                  Container(
                                    margin: EdgeInsets.all(0),  // Removed margin
                                    padding: EdgeInsets.only(
                                      top : MediaQuery.of(context).size.height * 0.01,
                                    ),  // Removed padding
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,  // Ensures alignment starts from the left
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: InkWell(
                                            onTap: () => Navigator.pop(context),
                                            child: Container(
                                              height: screenHeight * 0.020,
                                              width: screenHeight * 0.020,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.asset(
                                                'assets/calendercard.png',
                                                height: screenHeight * 0.015,
                                                width: screenHeight * 0.015,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 12,
                                          child: Container(
                                            padding: EdgeInsets.zero,  // Removed padding
                                            margin: EdgeInsets.zero,   // Removed margin
                                            child: Text(
                                              getFormattedDateTime(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Parallel square images container
                                  Container(
                                    margin: EdgeInsets.all(0),  // Removed margin
                                    padding: EdgeInsets.all(0),  // Removed padding
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,  // Ensures alignment starts from the left
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: InkWell(
                                            onTap: () => Navigator.pop(context),
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                top: MediaQuery.of(context).size.height * 0.0,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                left: MediaQuery.of(context).size.height * 0.0,
                                                right: MediaQuery.of(context).size.height * 0.0,
                                              ),
                                              height: screenHeight * 0.025,
                                              width: screenHeight * 0.025,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.asset(
                                                'assets/location.png',
                                                height: screenHeight * 0.025,
                                                width: screenHeight * 0.025,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0),
                                            padding: EdgeInsets.all(0),  // Removed padding
                                            width: MediaQuery.of(context).size.height * 0.2,
                                            height: MediaQuery.of(context).size.height * 0.090,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child:  Container(
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
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.02,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.0),
                                                    child:

                                                    SizedBox(
                                                      height: MediaQuery.of(context).size.height * 0.045, // Ensures correct height
                                                      child: Stack(
                                                        children: myimageslist.asMap().entries.map((entry) {
                                                          int index = entry.key;
                                                          String imagePath = entry.value[0]; // First element of each sublist

                                                          return Positioned(
                                                            left: index * (MediaQuery.of(context).size.height * 0.042), // Overlaps images
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.only(
                                                                topLeft: index == 0 ? Radius.circular(8) : Radius.zero,
                                                                bottomLeft: index == 0 ? Radius.circular(8) : Radius.zero,
                                                                topRight: index == myimageslist.length - 1 ? Radius.circular(8) : Radius.zero,
                                                                bottomRight: index == myimageslist.length - 1 ? Radius.circular(8) : Radius.zero,
                                                              ),
                                                              child: Image.asset(
                                                                imagePath,
                                                                width: MediaQuery.of(context).size.height * 0.045,
                                                                height: MediaQuery.of(context).size.height * 0.045,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: MediaQuery.of(context).size.height * 0.008,
                                                        vertical: MediaQuery.of(context).size.height * 0.005,
                                                      ),
                                                      child: Text(
                                                        "+3",
                                                        style: TextStyle(
                                                          color: Color(0xFF126086),
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: MediaQuery.of(context).size.height * 0.01,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context).size.height * 0.0,
                                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Text(
                                                  "2 QuadraCyte, Qatar 560002",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: MediaQuery.of(context).size.height * 0.013,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(0),  // Removed padding
                                                child: Text(
                                                  "2 Km . From Your Location",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: MediaQuery.of(context).size.height * 0.013,
                                                  ),
                                                ),
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
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(
                                      15), // Apply curved corners here
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              child:   Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.005,
                                    right: MediaQuery.of(context).size.height * 0.005,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            left:
                                            MediaQuery.of(context).size.height * 0.00,
                                            right:
                                            MediaQuery.of(context).size.height * 0.00,
                                            top:
                                            MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height *
                                                0.00),
                                        child: Text(
                                          "Consult Fee to be paid at the hospital",
                                          style: TextStyle(
                                            color: Color(0xFF126086),
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.012,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          // color:Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        // color:Colors.green[100],
                                        padding: EdgeInsets.only(
                                            left:
                                            MediaQuery.of(context).size.height * 0.0,
                                            right:
                                            MediaQuery.of(context).size.height * 0.0,
                                            top:
                                            MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height *
                                                0.00),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                EdgeInsets.symmetric(horizontal: 2),
                                                height:
                                                MediaQuery.of(context).size.height *
                                                    0.005,
                                                width:
                                                MediaQuery.of(context).size.height *
                                                    0.005,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF126086),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Row(
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
                                                              0.00,
                                                          top: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      child: Text(
                                                        'QR 299',
                                                        style: TextStyle(
                                                          // color: Colors.blue[600],
                                                            color: Color(0xFF126086),
                                                            fontWeight: FontWeight.w500,
                                                            overflow:
                                                            TextOverflow.ellipsis,
                                                            decoration: TextDecoration
                                                                .lineThrough,
                                                            decorationThickness: 2,
                                                            fontSize:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.014),
                                                      )),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.005,
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
                                                            0.00),
                                                    child: Text(
                                                      "Free",
                                                      style: TextStyle(
                                                        // color: Colors.blue[600],
                                                          color: Color(0xFF12B76A),
                                                          fontWeight: FontWeight.w500,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.014),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),




                    // Hospital Visit
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.015,
                          right: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.00),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hospital Visit",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.014,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    // down card
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFF126086).withOpacity(0.1),
                          borderRadius: BorderRadius.only(
                            // Add curves to the bottom sides here
                            bottomLeft:
                                Radius.circular(15), // Set the curve radius
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Colors.black26, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              child: Column(children: [
                                Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.005,
                                    right: MediaQuery.of(context).size.height * 0.005,
                                    bottom: MediaQuery.of(context).size.height * 0.01),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            left:
                                            MediaQuery.of(context).size.height * 0.00,
                                            right:
                                            MediaQuery.of(context).size.height * 0.00,
                                            top:
                                            MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height *
                                                0.00),
                                        child: Text(
                                          "Consultation fees (Pay Later)",
                                          style: TextStyle(
                                            color: Color(0xFF1F1F1F),
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.012,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          // color:Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        // color:Colors.green[100],
                                        padding: EdgeInsets.only(
                                            left:
                                            MediaQuery.of(context).size.height * 0.0,
                                            right:
                                            MediaQuery.of(context).size.height * 0.0,
                                            top:
                                            MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height *
                                                0.00),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                EdgeInsets.symmetric(horizontal: 2),
                                                height:
                                                MediaQuery.of(context).size.height *
                                                    0.01,
                                                width:
                                                MediaQuery.of(context).size.height *
                                                    0.01,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF126086),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Row(
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
                                                              0.00,
                                                          top: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      child: Text(
                                                        'QR 299',
                                                        style: TextStyle(
                                                          // color: Colors.blue[600],
                                                            color: Color(0xFF126086),
                                                            fontWeight: FontWeight.w400,
                                                            overflow:
                                                            TextOverflow.ellipsis,
                                                            decoration: TextDecoration
                                                                .lineThrough,
                                                            decorationThickness: 2,
                                                            fontSize:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.012),
                                                      )),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.005,
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
                                                            0.00),
                                                    child: Text(
                                                      "Free",
                                                      style: TextStyle(
                                                        // color: Colors.blue[600],
                                                          color: Color(0xFF12B76A),
                                                          fontWeight: FontWeight.w400,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.012),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ),
                                    ]),
                              ),

                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.height * 0.005,
                                      bottom: MediaQuery.of(context).size.height * 0.00),
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              left:
                                              MediaQuery.of(context).size.height * 0.00,
                                              right:
                                              MediaQuery.of(context).size.height * 0.00,
                                              top:
                                              MediaQuery.of(context).size.height * 0.00,
                                              bottom: MediaQuery.of(context).size.height *
                                                  0.00),
                                          child: Text(
                                            "Booking Fee (Non-Refundable)",
                                            style: TextStyle(
                                              color: Color(0xFF1F1F1F),
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize:
                                              MediaQuery.of(context).size.height * 0.012,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            // color:Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          // color:Colors.green[100],
                                          padding: EdgeInsets.only(
                                              left:
                                              MediaQuery.of(context).size.height * 0.0,
                                              right:
                                              MediaQuery.of(context).size.height * 0.0,
                                              top:
                                              MediaQuery.of(context).size.height * 0.00,
                                              bottom: MediaQuery.of(context).size.height *
                                                  0.00),
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                                          0.00,
                                                      top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00),
                                                  child: Text(
                                                    "QR29",
                                                    style: TextStyle(
                                                      // color: Colors.blue[600],
                                                        color: Color(0xFF126086),
                                                        fontWeight: FontWeight.w400,
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.012),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ]),
                                ),
                              ],)

                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(
                                      15), // Apply curved corners here
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.015,
                                    right: MediaQuery.of(context).size.height *
                                        0.015,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
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
                                                0.00),
                                        child: Text(
                                          "Pay Now",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.012,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          // color:Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        // color:Colors.green[100],
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.00,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.00),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.005,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00),
                                                child: Text(
                                                  "QR 29",
                                                  style: TextStyle(
                                                      // color: Colors.blue[600],
                                                      color: Color(0xFF12B76A),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.012),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ]),
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
          ],
        ),
      ),




      bottomNavigationBar:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, -3), // Makes the shadow appear above
              blurRadius: 6,
            ),
          ],
        ),
        // height: MediaQuery.of(context).size.height * 0.150,
        // color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            // Consultation Fees
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.height * 0.05,
                right: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booking Fee",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize:
                      MediaQuery.of(context).size.height * 0.015,
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
                        bottom:
                        MediaQuery.of(context).size.height * 0.00),
                    child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            height: MediaQuery.of(context).size.height *
                                0.005,
                            width: MediaQuery.of(context).size.height *
                                0.005,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Row(
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
                                          0.00,
                                      top: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.00,
                                      bottom: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.00),
                                  child: Text(
                                    'QR 999',
                                    style: TextStyle(
                                      // color: Colors.blue[600],
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                        decoration:
                                        TextDecoration.lineThrough,
                                        decorationThickness: 2,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.014
                                    ),
                                  )),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
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
                                        0.00),
                                child: Text(
                                  "Free",
                                  style: TextStyle(
                                    // color: Colors.blue[600],
                                      color: Color(0xFF12B76A),
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ),
                ],
              ),
            ),

            // Book Appointment

            GestureDetector(
              onTap: () async {
                showPaymentmethodsBottomSheet();
              },
              child:
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height *
                          0.0,
                      bottom: MediaQuery.of(context).size.height *
                          0.00,
                      left: MediaQuery.of(context).size.height *
                          0.005,
                      right: MediaQuery.of(context).size.height *
                          0.005),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height *
                          0.04,
                      top: MediaQuery.of(context).size.height *
                          0.01,
                      bottom: MediaQuery.of(context).size.height *
                          0.01,
                      left: MediaQuery.of(context).size.height *
                          0.04),
                  child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
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
                                      Color(0xFF126086),
                                      Color(0xFF126086),
                                    ])),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 0.0),
                            child: TextButton(
                              onPressed: () async {
                                showPaymentmethodsBottomSheet();
                              },
                              child: Text("Pay & Confirm",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                      MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.02)),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // ← Adjust this
                                minimumSize: Size(0, 0), // Removes minimum button constraints
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap padding
                              ),

                            ),
                          ),
                        ),
                      ])),
            ),
          ],
        ),
      ),

    );
  }

  // Success alert bottomsheet
  void showsucessalertBottomSheet() => showModalBottomSheet(
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
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.020,
                      right: MediaQuery.of(context).size.height * 0.020,
                      top: MediaQuery.of(context).size.height * 0.030,
                      bottom: MediaQuery.of(context).size.height * 0.00),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/paymentsucess.png',
                              height: MediaQuery.of(context).size.height * 0.30,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Thank you!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.024),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                    MediaQuery.of(context).size.height * 0.00,
                              ),
                              child: Text(
                                "Payment Done Successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
                    ],
                  ),
                ),

                // Reschedule
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) {
                          return SelectTimeSlot("responselist![index].id");
                        },
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                    ),
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.03,
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.03,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF126086), // Border color
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.012),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 0.0),
                            child: TextButton(
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) {
                                      return SelectTimeSlot("responselist![index].id!");
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Reschedule",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.02,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Back to Home
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePageMain(),
                      ),
                      (Route route) => false,
                    );
                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.00),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.03,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.03),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.012),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.center,
                                        stops: [
                                          0.5,
                                          0.9
                                        ],
                                        colors: [
                                          Color(0xFF126086),
                                          Color(0xFF126086),
                                        ])),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 0.0),
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePageMain(),
                                      ),
                                      (Route route) => false,
                                    );
                                  },
                                  child: Text("Back to Home",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                ),
                              ),
                            ),
                          ])),
                ),
              ],
            ),
          ),
        ),
      );

  // Payment methods
  void showPaymentmethodsBottomSheet() => showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent, // Transparent for blur
    barrierColor: Colors.transparent, // Disable dark overlay
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white, // White background for popup
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: BottomSheetForPaymentForMedication(),
            ),
          ),
        ],
      );
    },


    //     StatefulBuilder(
    //   builder: (BuildContext context,
    //       StateSetter setState /*You can rename this!*/) =>
    //       Padding(
    //         padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(context).viewInsets.bottom),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Container(
    //               padding: EdgeInsets.only(
    //                   left: MediaQuery.of(context).size.height * 0.020,
    //                   right: MediaQuery.of(context).size.height * 0.020,
    //                   top: MediaQuery.of(context).size.height * 0.030,
    //                   bottom: MediaQuery.of(context).size.height * 0.00),
    //               child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: <Widget>[
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Text(
    //                           "Payment Methods",
    //                           style: TextStyle(
    //                               color: Colors.black,
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: MediaQuery.of(context).size.height *
    //                                   0.024),
    //                         ),
    //                         Container(
    //                           padding: EdgeInsets.only(
    //                             top: MediaQuery.of(context).size.height * 0.00,
    //                             bottom:
    //                             MediaQuery.of(context).size.height * 0.02,
    //                             left: MediaQuery.of(context).size.height * 0.00,
    //                             right:
    //                             MediaQuery.of(context).size.height * 0.00,
    //                           ),
    //                           child: Text(
    //                             "Please Select a payment method",
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                                 color: Colors.black54,
    //                                 fontSize:
    //                                 MediaQuery.of(context).size.height *
    //                                     0.018),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //
    //                   // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
    //                 ],
    //               ),
    //             ),
    //
    //             // Payment mode
    //             // 1
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/visapay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           '**** **** 3434',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Visa',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 2
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/paypalpay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           '**** **** 3434',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Paypal',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 3
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/applepay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Priya Krishamurty',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Apple Pay',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 4
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/googlepay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Priya Krishamurty',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Google Pay',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // Continue
    //             GestureDetector(
    //               onTap: () async {
    //                 showsucessalertBottomSheet();
    //               },
    //               child: Container(
    //                   alignment: Alignment.centerRight,
    //                   padding: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.00,
    //                       left: MediaQuery.of(context).size.height * 0.00,
    //                       right: MediaQuery.of(context).size.height * 0.00),
    //                   margin: EdgeInsets.only(
    //                       right: MediaQuery.of(context).size.height * 0.03,
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.03),
    //                   child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Expanded(
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(
    //                                     MediaQuery.of(context).size.height *
    //                                         0.012),
    //                                 gradient: LinearGradient(
    //                                     begin: Alignment.centerRight,
    //                                     end: Alignment.center,
    //                                     stops: [
    //                                       0.5,
    //                                       0.9
    //                                     ],
    //                                     colors: [
    //                                       Color(0xFF126086),
    //                                       Color(0xFF126086),
    //                                     ])),
    //                             alignment: Alignment.center,
    //                             padding: EdgeInsets.only(left: 0.0),
    //                             child: TextButton(
    //                               onPressed: () async {
    //                                 showsucessalertBottomSheet();
    //                               },
    //                               child: Text("Continue",
    //                                   textAlign: TextAlign.center,
    //                                   style: TextStyle(
    //                                       color: Colors.white,
    //                                       fontSize: MediaQuery.of(context)
    //                                           .size
    //                                           .height *
    //                                           0.02)),
    //                             ),
    //                           ),
    //                         ),
    //                       ])),
    //             ),
    //           ],
    //         ),
    //       ),
    // ),
  );
  // void showPaymentmethodsBottomSheet() => showModalBottomSheet(
  //   enableDrag: false,
  //   isScrollControlled: true,
  //   isDismissible: true,
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(24),
  //       topRight: Radius.circular(24),
  //     ),
  //   ),
  //   barrierColor: Colors.grey.withOpacity(0.9),
  //   context: context,
  //       builder: (context) {
  //            return BottomSheetForPayment();
  //       }
  //
  //
  //       //     StatefulBuilder(
  //       //   builder: (BuildContext context,
  //       //           StateSetter setState /*You can rename this!*/) =>
  //       //       Padding(
  //       //     padding: EdgeInsets.only(
  //       //         bottom: MediaQuery.of(context).viewInsets.bottom),
  //       //     child: Column(
  //       //       mainAxisSize: MainAxisSize.min,
  //       //       children: <Widget>[
  //       //         GestureDetector(
  //       //
  //       //
  //       //           child: Center(
  //       //             child: Container(
  //       //
  //       //               padding: EdgeInsets.only(
  //       //                 top: MediaQuery
  //       //                     .of(context)
  //       //                     .size
  //       //                     .height * 0.01 ,
  //       //                 bottom: MediaQuery
  //       //                     .of(context)
  //       //                     .size
  //       //                     .height * 0.03,
  //       //                 left: MediaQuery
  //       //                     .of(context)
  //       //                     .size
  //       //                     .height * 0.18,
  //       //                 right: MediaQuery
  //       //                     .of(context)
  //       //                     .size
  //       //                     .height * 0.18,
  //       //               ),
  //       //
  //       //
  //       //               width: MediaQuery
  //       //                   .of(context)
  //       //                   .size
  //       //                   .width * 0.23,
  //       //               // Same thickness as Divider
  //       //               height: MediaQuery
  //       //                   .of(context)
  //       //                   .size
  //       //                   .height * 0.006,
  //       //               // Same thickness as Divider
  //       //               decoration: BoxDecoration(
  //       //                 color: Color(0xFFD9D9D9), // Divider color
  //       //                 borderRadius: BorderRadius.circular(
  //       //                     10), // Rounded edges
  //       //               ),
  //       //             ),
  //       //           ),
  //       //         ),
  //       //         SizedBox(height : MediaQuery.of(context).size.height * 0.02),
  //       //
  //       //         Container(
  //       //           padding: EdgeInsets.only(
  //       //               left: MediaQuery.of(context).size.height * 0.020,
  //       //               right: MediaQuery.of(context).size.height * 0.020,
  //       //               top: MediaQuery.of(context).size.height * 0.030,
  //       //               bottom: MediaQuery.of(context).size.height * 0.00),
  //       //           child: Row(
  //       //             crossAxisAlignment: CrossAxisAlignment.center,
  //       //             mainAxisAlignment: MainAxisAlignment.start,
  //       //             children: <Widget>[
  //       //               Expanded(
  //       //                 child: Column(
  //       //                   crossAxisAlignment: CrossAxisAlignment.start,
  //       //                   mainAxisAlignment: MainAxisAlignment.center,
  //       //                   children: <Widget>[
  //       //                     Text(
  //       //                       "Payment Methods",
  //       //                       style: TextStyle(
  //       //                           color: Colors.black,
  //       //                           fontWeight: FontWeight.bold,
  //       //                           fontSize: MediaQuery.of(context).size.height *
  //       //                               0.024),
  //       //                     ),
  //       //                     Container(
  //       //                       padding: EdgeInsets.only(
  //       //                         top: MediaQuery.of(context).size.height * 0.00,
  //       //                         bottom:
  //       //                             MediaQuery.of(context).size.height * 0.02,
  //       //                         left: MediaQuery.of(context).size.height * 0.00,
  //       //                         right:
  //       //                             MediaQuery.of(context).size.height * 0.00,
  //       //                       ),
  //       //                       child: Text(
  //       //                         "Please Select a payment method",
  //       //                         textAlign: TextAlign.center,
  //       //                         style: TextStyle(
  //       //                             color: Colors.black54,
  //       //                             fontSize:
  //       //                                 MediaQuery.of(context).size.height *
  //       //                                     0.018),
  //       //                       ),
  //       //                     ),
  //       //                   ],
  //       //                 ),
  //       //               ),
  //       //
  //       //               // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
  //       //             ],
  //       //           ),
  //       //         ),
  //       //
  //       //         // Payment mode
  //       //         // 1
  //       //         Container(
  //       //           margin: EdgeInsets.only(
  //       //             top: MediaQuery.of(context).size.height * 0.00,
  //       //             bottom: MediaQuery.of(context).size.height * 0.01,
  //       //             left: MediaQuery.of(context).size.height * 0.01,
  //       //             right: MediaQuery.of(context).size.height * 0.01,
  //       //           ),
  //       //           padding: EdgeInsets.only(
  //       //             top: MediaQuery.of(context).size.height * 0.00,
  //       //             bottom: MediaQuery.of(context).size.height * 0.00,
  //       //             left: MediaQuery.of(context).size.height * 0.01,
  //       //             right: MediaQuery.of(context).size.height * 0.00,
  //       //           ),
  //       //           decoration: BoxDecoration(
  //       //             border: Border.all(
  //       //               color: Colors.grey,
  //       //               width: 1.0,
  //       //             ),
  //       //             borderRadius: BorderRadius.circular(8.0),
  //       //           ),
  //       //           child: Row(
  //       //             mainAxisAlignment: MainAxisAlignment.start,
  //       //             crossAxisAlignment: CrossAxisAlignment.center,
  //       //             children: [
  //       //               // Image from assets
  //       //               Container(
  //       //                 width: MediaQuery.of(context).size.height * 0.07,
  //       //                 height: MediaQuery.of(context).size.height * 0.07,
  //       //                 margin: EdgeInsets.only(
  //       //                   top: MediaQuery.of(context).size.height * 0.01,
  //       //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //       //                   left: MediaQuery.of(context).size.height * 0.01,
  //       //                   right: MediaQuery.of(context).size.height * 0.01,
  //       //                 ),
  //       //                 decoration: BoxDecoration(
  //       //                   borderRadius: BorderRadius.circular(4.0),
  //       //                   image: DecorationImage(
  //       //                     image: AssetImage(
  //       //                         'assets/visapay.png'), // Replace with your asset path
  //       //                     fit: BoxFit.cover,
  //       //                   ),
  //       //                 ),
  //       //               ),
  //       //               // Column with two Text widgets
  //       //               Expanded(
  //       //                 child: Column(
  //       //                   crossAxisAlignment: CrossAxisAlignment.start,
  //       //                   children: [
  //       //                     Text(
  //       //                       '**** **** 3434',
  //       //                       style: TextStyle(
  //       //                         fontWeight: FontWeight.bold,
  //       //                         fontSize:
  //       //                             MediaQuery.of(context).size.height * 0.018,
  //       //                         color: Colors.black,
  //       //                       ),
  //       //                     ),
  //       //                     Text(
  //       //                       'Visa',
  //       //                       style: TextStyle(
  //       //                         fontSize:
  //       //                             MediaQuery.of(context).size.height * 0.016,
  //       //                         color: Colors.black,
  //       //                       ),
  //       //                     ),
  //       //                   ],
  //       //                 ),
  //       //               ),
  //       //               // Circular Radio Button
  //       //               Radio<int>(
  //       //                 value: 1, // The value for this radio button
  //       //                 groupValue: 0, // The currently selected value
  //       //                 onChanged: (int? value) {
  //       //                   // Handle radio button change
  //       //                 },
  //       //               ),
  //       //             ],
  //       //           ),
  //       //         ),
  //       //
  //       //         // 2
  //       //         Container(
  //       //           margin: EdgeInsets.only(
  //       //             top: MediaQuery.of(context).size.height * 0.00,
  //       //             bottom: MediaQuery.of(context).size.height * 0.01,
  //       //             left: MediaQuery.of(context).size.height * 0.01,
  //       //             right: MediaQuery.of(context).size.height * 0.01,
  //       //           ),
  //       //           padding: EdgeInsets.only(
  //       //             top: MediaQuery.of(context).size.height * 0.00,
  //       //             bottom: MediaQuery.of(context).size.height * 0.00,
  //       //             left: MediaQuery.of(context).size.height * 0.01,
  //       //             right: MediaQuery.of(context).size.height * 0.00,
  //       //           ),
  //       //           decoration: BoxDecoration(
  //       //             border: Border.all(
  //       //               color: Colors.grey,
  //       //               width: 1.0,
  //       //             ),
  //       //             borderRadius: BorderRadius.circular(8.0),
  //       //           ),
  //       //           child: Row(
  //       //             mainAxisAlignment: MainAxisAlignment.start,
  //       //             crossAxisAlignment: CrossAxisAlignment.center,
  //       //             children: [
  //       //               // Image from assets
  //       //               Container(
  //       //                 width: MediaQuery.of(context).size.height * 0.07,
  //       //                 height: MediaQuery.of(context).size.height * 0.07,
  //       //                 margin: EdgeInsets.only(
  //       //                   top: MediaQuery.of(context).size.height * 0.01,
  //       //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //       //                   left: MediaQuery.of(context).size.height * 0.01,
  //       //                   right: MediaQuery.of(context).size.height * 0.01,
  //       //                 ),
  //       //                 decoration: BoxDecoration(
  //       //                   borderRadius: BorderRadius.circular(4.0),
  //       //                   image: DecorationImage(
  //       //                     image: AssetImage(
  //       //                         'assets/paypalpay.png'), // Replace with your asset path
  //       //                     fit: BoxFit.cover,
  //       //                   ),
  //       //                 ),
  //       //               ),
  //       //               // Column with two Text widgets
  //       //               Expanded(
  //       //                 child: Column(
  //       //                   crossAxisAlignment: CrossAxisAlignment.start,
  //       //                   children: [
  //       //                     Text(
  //       //                       '**** **** 3434',
  //       //                       style: TextStyle(
  //       //                         fontWeight: FontWeight.bold,
  //       //                         fontSize:
  //       //                             MediaQuery.of(context).size.height * 0.018,
  //       //                         color: Colors.black,
  //       //                       ),
  //       //                     ),
  //       //                     Text(
  //       //                       'Paypal',
  //       //                       style: TextStyle(
  //       //                         fontSize:
  //       //                             MediaQuery.of(context).size.height * 0.016,
  //       //                         color: Colors.black,
  //       //                       ),
  //       //                     ),
  //       //                   ],
  //       //                 ),
  //       //               ),
  //       //               // Circular Radio Button
  //       //               Radio<int>(
  //       //                 value: 1, // The value for this radio button
  //       //                 groupValue: 0, // The currently selected value
  //       //                 onChanged: (int? value) {
  //       //                   // Handle radio button change
  //       //                 },
  //       //               ),
  //       //             ],
  //       //           ),
  //       //         ),
  //       //
  //       //         // 3
  //       //         Container(
  //       //           margin: EdgeInsets.only(
  //       //             top: MediaQuery.of(context).size.height * 0.00,
  //       //             bottom: MediaQuery.of(context).size.height * 0.01,
  //       //             left: MediaQuery.of(context).size.height * 0.01,
  //       //             right: MediaQuery.of(context).size.height * 0.01,
  //       //           ),
  //       //           padding: EdgeInsets.only(
  //       //             top: MediaQuery.of(context).size.height * 0.00,
  //       //             bottom: MediaQuery.of(context).size.height * 0.00,
  //       //             left: MediaQuery.of(context).size.height * 0.01,
  //       //             right: MediaQuery.of(context).size.height * 0.00,
  //       //           ),
  //       //           decoration: BoxDecoration(
  //       //             border: Border.all(
  //       //               color: Colors.grey,
  //       //               width: 1.0,
  //       //             ),
  //       //             borderRadius: BorderRadius.circular(8.0),
  //       //           ),
  //       //           child: Row(
  //       //             mainAxisAlignment: MainAxisAlignment.start,
  //       //             crossAxisAlignment: CrossAxisAlignment.center,
  //       //             children: [
  //       //               // Image from assets
  //       //               Container(
  //       //                 width: MediaQuery.of(context).size.height * 0.07,
  //       //                 height: MediaQuery.of(context).size.height * 0.07,
  //       //                 margin: EdgeInsets.only(
  //       //                   top: MediaQuery.of(context).size.height * 0.01,
  //       //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //       //                   left: MediaQuery.of(context).size.height * 0.01,
  //       //                   right: MediaQuery.of(context).size.height * 0.01,
  //       //                 ),
  //       //                 decoration: BoxDecoration(
  //       //                   borderRadius: BorderRadius.circular(4.0),
  //       //                   image: DecorationImage(
  //       //                     image: AssetImage(
  //       //                         'assets/applepay.png'), // Replace with your asset path
  //       //                     fit: BoxFit.cover,
  //       //                   ),
  //       //                 ),
  //       //               ),
  //       //               // Column with two Text widgets
  //       //               Expanded(
  //       //                 child: Column(
  //       //                   crossAxisAlignment: CrossAxisAlignment.start,
  //       //                   children: [
  //       //                     Text(
  //       //                       'Priya Krishamurty',
  //       //                       style: TextStyle(
  //       //                         fontWeight: FontWeight.bold,
  //       //                         fontSize:
  //       //                             MediaQuery.of(context).size.height * 0.018,
  //       //                         color: Colors.black,
  //       //                       ),
  //       //                     ),
  //       //                     Text(
  //       //                       'Apple Pay',
  //       //                       style: TextStyle(
  //       //                         fontSize:
  //       //                             MediaQuery.of(context).size.height * 0.016,
  //       //                         color: Colors.black,
  //       //                       ),
  //       //                     ),
  //       //                   ],
  //       //                 ),
  //       //               ),
  //       //               // Circular Radio Button
  //       //               Radio<int>(
  //       //                 value: 1, // The value for this radio button
  //       //                 groupValue: 0, // The currently selected value
  //       //                 onChanged: (int? value) {
  //       //                   // Handle radio button change
  //       //                 },
  //       //               ),
  //       //             ],
  //       //           ),
  //       //         ),
  //       //
  //       //         // 4
  //       //         Container(
  //       //           margin: EdgeInsets.only(
  //       //             top: MediaQuery.of(context).size.height * 0.00,
  //       //             bottom: MediaQuery.of(context).size.height * 0.00,
  //       //             left: MediaQuery.of(context).size.height * 0.01,
  //       //             right: MediaQuery.of(context).size.height * 0.01,
  //       //           ),
  //       //           padding: EdgeInsets.only(
  //       //             top: MediaQuery.of(context).size.height * 0.00,
  //       //             bottom: MediaQuery.of(context).size.height * 0.00,
  //       //             left: MediaQuery.of(context).size.height * 0.01,
  //       //             right: MediaQuery.of(context).size.height * 0.00,
  //       //           ),
  //       //           decoration: BoxDecoration(
  //       //             border: Border.all(
  //       //               color: Colors.grey,
  //       //               width: 1.0,
  //       //             ),
  //       //             borderRadius: BorderRadius.circular(8.0),
  //       //           ),
  //       //           child: Row(
  //       //             mainAxisAlignment: MainAxisAlignment.start,
  //       //             crossAxisAlignment: CrossAxisAlignment.center,
  //       //             children: [
  //       //               // Image from assets
  //       //               Container(
  //       //                 width: MediaQuery.of(context).size.height * 0.07,
  //       //                 height: MediaQuery.of(context).size.height * 0.07,
  //       //                 margin: EdgeInsets.only(
  //       //                   top: MediaQuery.of(context).size.height * 0.01,
  //       //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //       //                   left: MediaQuery.of(context).size.height * 0.01,
  //       //                   right: MediaQuery.of(context).size.height * 0.01,
  //       //                 ),
  //       //                 decoration: BoxDecoration(
  //       //                   borderRadius: BorderRadius.circular(4.0),
  //       //                   image: DecorationImage(
  //       //                     image: AssetImage(
  //       //                         'assets/googlepay.png'), // Replace with your asset path
  //       //                     fit: BoxFit.cover,
  //       //                   ),
  //       //                 ),
  //       //               ),
  //       //               // Column with two Text widgets
  //       //               Expanded(
  //       //                 child: Column(
  //       //                   crossAxisAlignment: CrossAxisAlignment.start,
  //       //                   children: [
  //       //                     Text(
  //       //                       'Priya Krishamurty',
  //       //                       style: TextStyle(
  //       //                         fontWeight: FontWeight.bold,
  //       //                         fontSize:
  //       //                             MediaQuery.of(context).size.height * 0.018,
  //       //                         color: Colors.black,
  //       //                       ),
  //       //                     ),
  //       //                     Text(
  //       //                       'Google Pay',
  //       //                       style: TextStyle(
  //       //                         fontSize:
  //       //                             MediaQuery.of(context).size.height * 0.016,
  //       //                         color: Colors.black,
  //       //                       ),
  //       //                     ),
  //       //                   ],
  //       //                 ),
  //       //               ),
  //       //               // Circular Radio Button
  //       //               Radio<int>(
  //       //                 value: 1, // The value for this radio button
  //       //                 groupValue: 0, // The currently selected value
  //       //                 onChanged: (int? value) {
  //       //                   // Handle radio button change
  //       //                 },
  //       //               ),
  //       //             ],
  //       //           ),
  //       //         ),
  //       //
  //       //         // Continue
  //       //         GestureDetector(
  //       //           onTap: () async {
  //       //             showsucessalertBottomSheet();
  //       //           },
  //       //           child: Container(
  //       //               alignment: Alignment.centerRight,
  //       //               padding: EdgeInsets.only(
  //       //                   top: MediaQuery.of(context).size.height * 0.01,
  //       //                   bottom: MediaQuery.of(context).size.height * 0.00,
  //       //                   left: MediaQuery.of(context).size.height * 0.00,
  //       //                   right: MediaQuery.of(context).size.height * 0.00),
  //       //               margin: EdgeInsets.only(
  //       //                   right: MediaQuery.of(context).size.height * 0.03,
  //       //                   top: MediaQuery.of(context).size.height * 0.01,
  //       //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //       //                   left: MediaQuery.of(context).size.height * 0.03),
  //       //               child: Row(
  //       //                   crossAxisAlignment: CrossAxisAlignment.start,
  //       //                   mainAxisAlignment: MainAxisAlignment.center,
  //       //                   children: <Widget>[
  //       //                     Expanded(
  //       //                       child: Container(
  //       //                         decoration: BoxDecoration(
  //       //                             borderRadius: BorderRadius.circular(
  //       //                                 MediaQuery.of(context).size.height *
  //       //                                     0.012),
  //       //                             gradient: LinearGradient(
  //       //                                 begin: Alignment.centerRight,
  //       //                                 end: Alignment.center,
  //       //                                 stops: [
  //       //                                   0.5,
  //       //                                   0.9
  //       //                                 ],
  //       //                                 colors: [
  //       //                                   Color(0xFF126086),
  //       //                                   Color(0xFF126086),
  //       //                                 ])),
  //       //                         alignment: Alignment.center,
  //       //                         padding: EdgeInsets.only(left: 0.0),
  //       //                         child: TextButton(
  //       //                           onPressed: () async {
  //       //                             showsucessalertBottomSheet();
  //       //                           },
  //       //                           child: Text("Continue",
  //       //                               textAlign: TextAlign.center,
  //       //                               style: TextStyle(
  //       //                                   color: Colors.white,
  //       //                                   fontSize: MediaQuery.of(context)
  //       //                                           .size
  //       //                                           .height *
  //       //                                       0.02)),
  //       //                         ),
  //       //                       ),
  //       //                     ),
  //       //                   ])),
  //       //         ),
  //       //       ],
  //       //     ),
  //       //   ),
  //       // ),
  //     );

  void getBookingDetails() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        /* progressDialog.showMaterial(
            title: "Loading Data", message: "Please wait");*/
        progressDialog.show();
        dynamic user = await apiService.findDocAppTimedetails("Date", "");

        if (user.message != null) {
          progressDialog.hide();
          final snackBar = SnackBar(content: Text(user.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        // Get the list data and show it

        else if (user.response != null) {
          progressDialog.hide();

          setState(() {
            responsedetails = user.response;

          });

           final snackBar = SnackBar(
            content: Text("Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        } else {
          progressDialog.hide();
          final snackBar = SnackBar(
            content: Text("Specialities Not Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // customalert.showError(context, user.error);
        }
      } else {
        // No-Internet Case
        final snackBar = SnackBar(
          content: Text("No Internet, Check Connectivity!"),
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
