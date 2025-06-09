import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/Models/doctordetailsres.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/appointmentsmainfindDoctors.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
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

class DoctorDetilPage extends StatefulWidget {
  final String? doctoridval;

  DoctorDetilPage(this.doctoridval, {Key? key}) : super(key: key);

  @override
  State<DoctorDetilPage> createState() => DoctorDetilPagestate();
}

class DoctorDetilPagestate extends State<DoctorDetilPage> {
  String usernameValue = "Hello, Priya Krishnamurty";
  String useraddressValue = "Reg: TSMC/FMR/09823";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  String doctornameval = "";
  String completedSpecialityString = "";
  String qualificationval = "";
  String workingTimeval = "";
  String aboutdoctorval = "";

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;
  DoctorDetailsResponse? responsedetails;

  @override
  void initState() {

    super.initState();
    getSharedPrefs();
  }

  Future getSharedPrefs() async {
    // CheckSession();
    getDoctorDetails();
    print("After API call ${aboutdoctorval}");

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
              padding: EdgeInsets.only(
                top: screenHeight * 0.07,
                left: screenWidth * 0.0,
                right: screenWidth * 0.0,
                bottom: screenWidth * 0.0,
              ),
              margin: EdgeInsets.only(
                right: screenHeight * 0.0,
                top: screenHeight * 0.0,
                bottom: screenHeight * 0.0,
                left: screenHeight * 0.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.height * 0.03,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.01,
                        top: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.01,
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
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.05,
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
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                              0.012
                                      ),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  // Navigator.pop(context);
                                  ShareToOtherApp.share();
                                },
                                onDoubleTap: (){
                                },
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.01,
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.00),
                          child: Text(
                            doctornameval,
                            style: TextStyle(
                                color: Color(0xFF126086),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.016),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.01,
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.00),
                          child: Text(
                            completedSpecialityString,
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.014),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.01,
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.00),
                          child: Text(
                            qualificationval,
                            style: TextStyle(
                                color: Color(0xFF126086),
                                fontWeight: FontWeight.bold,
                                // overflow: TextOverflow.ellipsis,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.013),
                          ),
                        ),
                      ],
                    ),

                    // About Doctor
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.015,
                          bottom: MediaQuery.of(context).size.height * 0.00),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "About Doctor",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.016,
                            color: Color(0xFF1F1F1F),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.00),
                      // child: DescriptionTextWidget(text: aboutdoctorval),
                      child : DescriptionTextWidget(text : widget.doctoridval),

                    ),

                    // Working time
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.015,
                          bottom: MediaQuery.of(context).size.height * 0.00),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Working time",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.016,
                            color: Color(0xFF1F1F1F),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.01),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          workingTimeval,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.014,
                            color: Color(0x99000000),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    // Reviews
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.015,
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
                                "Reviews",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.016,
                                  color: Color(0xFF1F1F1F),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
                                "View All",
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.012,
                                ),
                              ),
                            ),
                          ]),
                    ),

                    // Reviews Section
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Provide a width constraint using SizedBox or Expanded
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              top: MediaQuery.of(context).size.height * 0.01),
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            // Ensures scrolling
                            shrinkWrap: true,
                            // Prevents ListView from taking up extra space
                            scrollDirection: Axis.horizontal,
                            // Makes the ListView horizontal
                            itemCount: 3,
                            // You can adjust the item count
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // Add your onTap logic here
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.01,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      top: MediaQuery.of(context).size.height *
                                          0.0,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        // Shadow color
                                        offset: Offset(0, 0),
                                        // Shadow offset (all sides)
                                        blurRadius: 1,
                                        // How blurry the shadow is
                                        spreadRadius:
                                            1, // How much the shadow expands outside the card
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.00,
                                          right:
                                              MediaQuery.of(context)
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
                                      // color: Colors.white,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              // color: Colors.red,
                                              // height: MediaQuery.of(context).size.height * 0.12,
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                        right:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01,
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      // Adjust border radius as needed
                                                      child: Container(
                                                        width: 50.0,
                                                        // Set width to define the square's size
                                                        height: 50.0,
                                                        // Set height to make it a square
                                                        child: Image.asset(
                                                          'assets/Reviewsimg.png',
                                                          fit: BoxFit
                                                              .fill, // Use BoxFit.cover to maintain aspect ratio and fill the square
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
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
                                                              top: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.0,
                                                              bottom: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.00),
                                                          child: Text(
                                                            "Abishan.t",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.014
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height:  screenHeight * 0.01,),
                                                        Container(
                                                          width : screenHeight * 0.05,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                                color : Color(0x08000000),
                                                          ),
                                                          padding: EdgeInsets.only(
                                                              left: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.005,
                                                              right: MediaQuery
                                                                          .of(
                                                                              context)
                                                                      .size
                                                                      .height *
                                                                  0.012,
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
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.012,
                                                              ),
                                                              SizedBox(width : screenHeight * 0.005),
                                                              Text(
                                                                "4.3",
                                                                style: TextStyle(
                                                                    color: Color(0xFF1F1F1F),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.01),
                                                              )
                                                            ],
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
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
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00),
                                              child: Text(
                                                "Dr Faseeh Km is a General Physician/lnternal Medicine specialist in Bengaluru with over ten years of experience. ",
                                                style: TextStyle(
                                                    color: Color(0x99000000),
                                                    fontWeight: FontWeight.w400,
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.012),
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


                  ],
                ),
              ),
            ),
          ],
        ),
      ),


      // Bottom Navigation with another  positioned on the right
      // bottomNavigationBar:Container(
      //   // height: MediaQuery.of(context).size.height * 0.150,
      //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //
      //       // Consultation Fees
      //       Padding(
      //         padding: EdgeInsets.only(
      //             left: MediaQuery.of(context).size.height * 0.015,
      //             right: MediaQuery.of(context).size.height * 0.015,
      //             bottom: MediaQuery.of(context).size.height * 0.00),
      //         child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: <Widget>[
      //               Container(
      //                 padding: EdgeInsets.only(
      //                     left:
      //                     MediaQuery.of(context).size.height * 0.00,
      //                     right:
      //                     MediaQuery.of(context).size.height * 0.00,
      //                     top:
      //                     MediaQuery.of(context).size.height * 0.00,
      //                     bottom: MediaQuery.of(context).size.height *
      //                         0.00),
      //                 child: Text(
      //                   "Consultation Fees",
      //                   style: TextStyle(
      //                     color: Colors.black,
      //                     fontWeight: FontWeight.bold,
      //                     overflow: TextOverflow.ellipsis,
      //                     fontSize:
      //                     MediaQuery.of(context).size.height * 0.016,
      //                   ),
      //                 ),
      //               ),
      //               Container(
      //                 decoration: BoxDecoration(
      //                   // color:Colors.white,
      //                   borderRadius: BorderRadius.circular(15),
      //                 ),
      //                 // color:Colors.green[100],
      //                 padding: EdgeInsets.only(
      //                     left:
      //                     MediaQuery.of(context).size.height * 0.0,
      //                     right:
      //                     MediaQuery.of(context).size.height * 0.0,
      //                     top:
      //                     MediaQuery.of(context).size.height * 0.00,
      //                     bottom: MediaQuery.of(context).size.height *
      //                         0.00),
      //                 child: Row(
      //                     mainAxisAlignment:
      //                     MainAxisAlignment.spaceBetween,
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: <Widget>[
      //                       Container(
      //                         margin:
      //                         EdgeInsets.symmetric(horizontal: 2),
      //                         height:
      //                         MediaQuery.of(context).size.height *
      //                             0.01,
      //                         width:
      //                         MediaQuery.of(context).size.height *
      //                             0.01,
      //                         decoration: BoxDecoration(
      //                           color: Colors.black,
      //                           shape: BoxShape.circle,
      //                         ),
      //                       ),
      //                       Row(
      //                         children: <Widget>[
      //                           Container(
      //                               padding: EdgeInsets.only(
      //                                   left: MediaQuery.of(context)
      //                                       .size
      //                                       .height *
      //                                       0.005,
      //                                   right: MediaQuery.of(context)
      //                                       .size
      //                                       .height *
      //                                       0.00,
      //                                   top: MediaQuery.of(context)
      //                                       .size
      //                                       .height *
      //                                       0.00,
      //                                   bottom: MediaQuery.of(context)
      //                                       .size
      //                                       .height *
      //                                       0.00),
      //                               child: Text(
      //                                 'QR 999',
      //                                 style: TextStyle(
      //                                   // color: Colors.blue[600],
      //                                     color: Colors.black,
      //                                     fontWeight: FontWeight.bold,
      //                                     overflow:
      //                                     TextOverflow.ellipsis,
      //                                     decoration: TextDecoration
      //                                         .lineThrough,
      //                                     decorationThickness: 2,
      //                                     fontSize:
      //                                     MediaQuery.of(context)
      //                                         .size
      //                                         .height *
      //                                         0.016),
      //                               )),
      //                           Container(
      //                             padding: EdgeInsets.only(
      //                                 left: MediaQuery.of(context)
      //                                     .size
      //                                     .height *
      //                                     0.005,
      //                                 right: MediaQuery.of(context)
      //                                     .size
      //                                     .height *
      //                                     0.00,
      //                                 top: MediaQuery.of(context)
      //                                     .size
      //                                     .height *
      //                                     0.00,
      //                                 bottom: MediaQuery.of(context)
      //                                     .size
      //                                     .height *
      //                                     0.00),
      //                             child: Text(
      //                               "Free",
      //                               style: TextStyle(
      //                                 // color: Colors.blue[600],
      //                                   color: Color(0xFF12B76A),
      //                                   fontWeight: FontWeight.bold,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   fontSize: MediaQuery.of(context)
      //                                       .size
      //                                       .height *
      //                                       0.016),
      //                             ),
      //                           ),
      //                         ],
      //                       )
      //                     ]),
      //               ),
      //             ]),
      //       ),
      //
      //       // Next Button
      //
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (BuildContext context) {
      //                 return SelectTimeSlot(widget.doctoridval);
      //               },
      //             ),
      //           );
      //         },
      //         child: Padding(
      //           padding:
      //           EdgeInsets.symmetric(horizontal: screenWidth * 0.0),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               // Login Button
      //               Container(
      //                   alignment: Alignment.centerRight,
      //                   padding: EdgeInsets.only(
      //                       top: MediaQuery.of(context).size.height *
      //                           0.01,
      //                       bottom: MediaQuery.of(context).size.height *
      //                           0.00,
      //                       left: MediaQuery.of(context).size.height *
      //                           0.00,
      //                       right: MediaQuery.of(context).size.height *
      //                           0.00),
      //                   margin: EdgeInsets.only(
      //                       right: MediaQuery.of(context).size.height *
      //                           0.04,
      //                       top: MediaQuery.of(context).size.height *
      //                           0.01,
      //                       bottom: MediaQuery.of(context).size.height *
      //                           0.01,
      //                       left: MediaQuery.of(context).size.height *
      //                           0.04),
      //                   child: Row(
      //                       crossAxisAlignment:
      //                       CrossAxisAlignment.start,
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: <Widget>[
      //                         Expanded(
      //                           child: Container(
      //                             decoration: BoxDecoration(
      //                                 borderRadius:
      //                                 BorderRadius.circular(
      //                                     MediaQuery.of(context)
      //                                         .size
      //                                         .height *
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
      //                                 Navigator.of(context).push(
      //                                   MaterialPageRoute(
      //                                     builder:
      //                                         (BuildContext context) {
      //                                       return SelectTimeSlot(
      //                                           widget.doctoridval);
      //                                     },
      //                                   ),
      //                                 );
      //                               },
      //                               child: Text("Book Appointment",
      //                                   textAlign: TextAlign.center,
      //                                   style: TextStyle(
      //                                       color: Colors.white,
      //                                       fontSize:
      //                                       MediaQuery.of(context)
      //                                           .size
      //                                           .height *
      //                                           0.02)),
      //                             ),
      //                           ),
      //                         ),
      //                       ])),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
                    "Consultation Fees",
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SelectTimeSlot(widget.doctoridval),
                  ),
                );
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SelectTimeSlot(widget.doctoridval),
                                  ),
                                );
                              },
                              child: Text("Book Appointment",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                      MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.02)
                              ),
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

  void getDoctorDetails() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        /* progressDialog.showMaterial(
            title: "Loading Data", message: "Please wait");*/
        progressDialog.show();
        dynamic user = await apiService.findDoctorsdetails(widget.doctoridval);

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

            doctornameval =
                responsedetails!.doctorName != null ? responsedetails!.doctorName! : "";
            qualificationval = responsedetails!.qualification != null
                ? responsedetails!.qualification!
                : "";
            workingTimeval = responsedetails!.workingTime != null
                ? responsedetails!.workingTime!
                : "10:00 am - 07:00 pm";

            aboutdoctorval =
                responsedetails!.about != null ? responsedetails!.about! : "";
            print("About : ${responsedetails!.about}");
            print("About Docotr: ${aboutdoctorval}");

            setText(aboutdoctorval);

            if (responsedetails!.speciality != null &&
                responsedetails!.speciality!.isNotEmpty) {
              completedSpecialityString = responsedetails!.speciality!;
              print('Speciality: $completedSpecialityString');
            } else {
              print('No specialities available.');
            }
          });



          /* final snackBar = SnackBar(
            content: Text("Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );*/
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

  late String firstHalf = "";
  late String secondHalf = "";

  bool flag = false;
  void setText(String text) {
    if (text != null) {
      List<String> words = text!.split(" ");

      // Setting approximately 4-5 lines in firstHalf
      if (words.length > 40) {
        firstHalf = words.sublist(0, 40).join(" ");
        secondHalf = words.sublist(40).join(" ");
      } else {
        firstHalf = text!;
        secondHalf = "";
      }
    } else {
      firstHalf = "";
      secondHalf = "";
    }
  }
}
