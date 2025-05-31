import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/LabTests/healthcondiviewall.dart';
import 'package:newfolder/Screens/LabTests/healthpackages.dart';
import 'package:newfolder/Screens/LabTests/labsmartreportslist.dart';
import 'package:newfolder/Screens/LabTests/labviewreportslist.dart';
import 'package:newfolder/Screens/LabTests/previousorderviewall.dart';
import 'package:newfolder/Screens/LabTests/recomendtestviewall.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';

import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';

class LabTestsMain extends StatefulWidget {
  int selectedIndex = 0;
  LabTestsMain({
    super.key,
  });
  @override
  State<LabTestsMain> createState() => LabTestsMainstate();
}

class LabTestsMainstate extends State<LabTestsMain> {
  String usernameValue = "Lab test";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final mybrowsebyhealthcond = [
    ["assets/Harmone.png", "Harmone"],
    ["assets/Diabetes.png", "Diabetes"],
    ["assets/JointPain.png", "Joint Pain"],
    ["assets/Thyroid.png", "Thyroid"],
    ["assets/Heart.png", "Heart"],
    ["assets/Bone.png", "Bone"],
    ["assets/BloodSugar.png", "Blood Sugar"],
    ["assets/Vitamin.png", "Vitamin"],
    ["assets/HairFall.png", "Hair Fall"],
    ["assets/Liver.png", "Liver"],
    ["assets/Kidney.png", "Kidney"],
    ["assets/Fever.png", "Fever"],
  ];

  final myhealthpackages = [
    ["assets/Harmone.png", "Full Body Checkup"],
    ["assets/Diabetes.png", "Men’s Wellness"],
    ["assets/JointPain.png", "Women’s Health"],
    ["assets/Thyroid.png", "Thyroid Package"],
    ["assets/Heart.png", "Heart Package"],
    ["assets/Bone.png", "Diabetes package"],
    ["assets/BloodSugar.png", "Blood Studies Package"],
    ["assets/Vitamin.png", "Vitamin package"],
    ["assets/HairFall.png", "Hairfall package"],
    ["assets/Liver.png", "Liver Package"],
    ["assets/Kidney.png", "Kidney Package"],
    ["assets/Fever.png", "Fever Package"],
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();
  bool new30 = true;
  bool new20 = false;
  bool new10 = false;
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
      Expanded(

        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenHeight * 0.03),
                topRight: Radius.circular(screenHeight * 0.03),
                bottomLeft: Radius.circular(screenHeight * 0.0),
                bottomRight: Radius.circular(screenHeight * 0.00),
                // bottomCenter: 0,
              ),
            ),
            child : Column(
              children: [

              // Main Content Section
              Container(
                padding: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        right: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .height * 0.01),
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
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return QuickSearchWithoutData();
                              },
                            ),
                          );
                        },
                        child:
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.05,
                          decoration: BoxDecoration(
                            color: Color(0xFFA8B1CE).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          alignment: Alignment.centerRight,
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
                          margin: EdgeInsets.only(
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
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
                                .height * 0.0,
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.02,
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
                                        0.0),
                                child: Text(
                                  "Search for lab results",
                                  style: TextStyle(
                                      color: Color(0xFF999999),
                                      // overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.014
                                  ),
                                ),
                              ),


                              // Container(
                              //   padding: EdgeInsets.only(
                              //       left: MediaQuery
                              //           .of(context)
                              //           .size
                              //           .height *
                              //           0.008,
                              //       right: MediaQuery
                              //           .of(context)
                              //           .size
                              //           .height *
                              //           0.00,
                              //       top: MediaQuery
                              //           .of(context)
                              //           .size
                              //           .height *
                              //           0.00,
                              //       bottom: MediaQuery
                              //           .of(context)
                              //           .size
                              //           .height *
                              //           0.0),
                              //   child:
                              //   DefaultTextStyle(
                              //     style: TextStyle(
                              //         color: Color(0xFF126086),
                              //         overflow: TextOverflow.ellipsis,
                              //         fontWeight: FontWeight.bold,
                              //         fontSize:
                              //         MediaQuery
                              //             .of(context)
                              //             .size
                              //             .height * 0.016),
                              //     child: AnimatedTextKit(
                              //       animatedTexts: [
                              //         RotateAnimatedText(
                              //           'Doctor',
                              //           textStyle: TextStyle(
                              //               color: Color(0xFF126086),
                              //               overflow: TextOverflow.ellipsis,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize:
                              //               MediaQuery
                              //                   .of(context)
                              //                   .size
                              //                   .height *
                              //                   0.014), // Red text
                              //         ),
                              //         RotateAnimatedText(
                              //           'Speciality',
                              //           textStyle: TextStyle(
                              //               color: Color(0xFF126086),
                              //               overflow: TextOverflow.ellipsis,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize:
                              //               MediaQuery
                              //                   .of(context)
                              //                   .size
                              //                   .height *
                              //                   0.014),
                              //         ),
                              //
                              //         RotateAnimatedText(
                              //           'Symptoms',
                              //           textStyle: TextStyle(
                              //               color: Color(0xFF126086),
                              //               overflow: TextOverflow.ellipsis,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize:
                              //               MediaQuery
                              //                   .of(context)
                              //                   .size
                              //                   .height *
                              //                   0.014),
                              //         ),
                              //       ],
                              //       repeatForever: true,
                              //       pause: Duration(milliseconds: 500),
                              //       onTap: () {
                              //         Navigator.of(context).push(
                              //           MaterialPageRoute(
                              //             builder: (BuildContext context) {
                              //               return QuickSearchWithoutData();
                              //             },
                              //           ),
                              //         );
                              //         print("Tap Event");
                              //       },
                              //     ),
                              //   ),
                              // ),

                              Spacer(),
                              // Pushes the search icon to the end of the Row
                              Padding(
                                padding: EdgeInsets.only(
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black45,
                                  size: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
              ),


              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                      top: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.025),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(screenHeight * 0.03),
                    //   topRight: Radius.circular(screenHeight * 0.03),
                    // ),
                  ),
                  child: ListView(
                      padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      // Search Input Field

                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(
                      //         builder: (BuildContext context) {
                      //           return QuickSearchWithoutData();
                      //         },
                      //       ),
                      //     );
                      //     print('Navigating to QuickSearchWithData!');
                      //   },
                      //   child: Container(
                      //     alignment: Alignment.centerRight,
                      //     padding: EdgeInsets.only(
                      //       top: MediaQuery.of(context).size.height * 0.0,
                      //       bottom: MediaQuery.of(context).size.height * 0.00,
                      //       left: MediaQuery.of(context).size.height * 0.00,
                      //       right: MediaQuery.of(context).size.height * 0.00,
                      //     ),
                      //     margin: EdgeInsets.only(
                      //       right: MediaQuery.of(context).size.height * 0.02,
                      //       top: MediaQuery.of(context).size.height * 0.0,
                      //       bottom: MediaQuery.of(context).size.height * 0.01,
                      //       left: MediaQuery.of(context).size.height * 0.02,
                      //     ),
                      //     child: AbsorbPointer(
                      //       // Prevents the field from gaining focus or triggering gestures
                      //       child: TextFormField(
                      //         readOnly: true,
                      //         controller: SearchEditTextController,
                      //         inputFormatters: [
                      //           LengthLimitingTextInputFormatter(15),
                      //           FilteringTextInputFormatter.allow(
                      //               RegExp('[a-zA-Z0-9]')),
                      //         ],
                      //         textCapitalization: TextCapitalization.characters,
                      //         style: TextStyle(color: Colors.black45),
                      //         keyboardType: TextInputType.emailAddress,
                      //         validator: (input) => input!.length < 3
                      //             ? "Search should be more than 3 characters"
                      //             : null,
                      //         decoration: InputDecoration(
                      //           isDense: true,
                      //           contentPadding:
                      //           EdgeInsets.all(screenHeight * 0.012),
                      //           filled: true,
                      //           fillColor: Colors.grey[200],
                      //           hintText: "Search for Lab tests",
                      //           hintStyle: TextStyle(
                      //             color: Colors.black26,
                      //             fontSize: screenHeight * 0.016,
                      //           ),
                      //           focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(5.0),
                      //             borderSide: BorderSide(color: Colors.grey),
                      //           ),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderRadius:
                      //             BorderRadius.all(Radius.circular(5.0)),
                      //             borderSide: BorderSide(color: Colors.white),
                      //           ),
                      //           suffixIcon: IconButton(
                      //             icon: Icon(
                      //               Icons.search,
                      //               color: Colors.black45,
                      //               size: MediaQuery
                      //                   .of(context)
                      //                   .size
                      //                   .height * 0.02,
                      //             ),
                      //             onPressed: () {
                      //               Navigator.of(context).push(
                      //                 MaterialPageRoute(
                      //                   builder: (BuildContext context) {
                      //                     return QuickSearchWithData();
                      //                   },
                      //                 ),
                      //               );
                      //               print('Search icon clicked!');
                      //             },
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),


                      // Previous Orders

                     

                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            top: MediaQuery.of(context).size.height *
                                0.015,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.015),
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
                                  "Previous Orders",
                                  style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.014,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return PreviousOrderViewAll();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.00),
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Color(0xFF126086),
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.012,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      // Previous Orders List
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Provide a width constraint using SizedBox or Expanded
                          Container(

                            margin:EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right: MediaQuery.of(context).size.height * 0.0,
                                bottom: MediaQuery.of(context).size.height * 0.0,
                                top: MediaQuery.of(context).size.height * 0.00),
                            height: MediaQuery.of(context).size.height * 0.160,
                            child: ListView.builder(
                              physics: ScrollPhysics(),  // Ensures scrolling
                              shrinkWrap: true,  // Prevents ListView from taking up extra space
                              scrollDirection: Axis.horizontal,  // Makes the ListView horizontal
                              itemCount: 3,  // You can adjust the item count
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Add your onTap logic here
                                  },
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child:  Container(
                                      width:MediaQuery.of(context).size.height * 0.35,
                                      padding:EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height * 0.00,
                                          right: MediaQuery.of(context).size.height * 0.00,
                                          bottom: MediaQuery.of(context).size.height * 0.00,
                                          top: MediaQuery.of(context).size.height * 0.00),
                                      color: Colors.white,
                                      child:
                                      Container(
                                        // color: Colors.white,

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
                                        margin:EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.00,
                                            right: MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                            top: MediaQuery.of(context).size.height * 0.00),
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.005,
                                            right: MediaQuery.of(context).size.height * 0.005,
                                            bottom: MediaQuery.of(context).size.height * 0.005,
                                            top: MediaQuery.of(context).size.height * 0.005),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              Container(
                                                // color: Colors.red,
                                                // height: MediaQuery.of(context).size.height * 0.12,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                    top: MediaQuery.of(context).size.height * 0.01,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),

                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      height : MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.055,
                                                      margin: EdgeInsets.only(
                                                        left:
                                                        MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.005,
                                                      ),

                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(130.0),
                                                        child: Image.asset(
                                                          'assets/Harmonebackground.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.height *
                                                            0.015),

                                                    Expanded(
                                                      flex: 8,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[


                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.0,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "QCT Full Body Checkup Female ",
                                                              style: TextStyle(
                                                                  color: Colors.black87,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.014),
                                                            ),
                                                          ),

                                                          Container(

                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "Booking ID : 10329847982",
                                                              style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012),
                                                            ),
                                                          ),

                                                          Container(

                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "Report Received Date : April 30, 2024",
                                                              style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w600,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
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


                                              // Bottom Row
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                    top: MediaQuery.of(context).size.height * 0.00,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                width: double.infinity,
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(06),
                                                        ),
                                                        padding: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.height * 0.01,
                                                          right: MediaQuery.of(context).size.height * 0.01,
                                                          top: MediaQuery.of(context).size.height * 0.01,
                                                          bottom: MediaQuery.of(context).size.height * 0.01,),
                                                        child: Row(
                                                          // mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[

                                                                      // More Details
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
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:

                                                                        Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: <Widget>[



                                                                              Container(
                                                                                padding: EdgeInsets.only(
                                                                                  left: MediaQuery.of(context).size.height * 0.005,
                                                                                  right: MediaQuery.of(context).size.height * 0.00,
                                                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                ),
                                                                                child: Stack(
                                                                                  alignment: Alignment.bottomLeft,
                                                                                  children: [
                                                                                    Text(
                                                                                      "More Details",
                                                                                      style: TextStyle(
                                                                                        color: Color(0xFF12B76A), // Text color
                                                                                        fontWeight: FontWeight.w500, // Bold text
                                                                                        overflow: TextOverflow.ellipsis, // Handles overflow with ellipsis
                                                                                        fontSize: MediaQuery.of(context).size.height * 0.01, // Dynamic font size
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                      bottom: 0, // Position the underline at the bottom of the text
                                                                                      left: 0,
                                                                                      right: 0,
                                                                                      child: Container(
                                                                                        height: 1, // Thickness of the underline
                                                                                        color: Color(0xFF12B76A),// Color of the underline
                                                                                        margin: EdgeInsets.symmetric(horizontal: 0.0), // Adds padding to the underline
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),


                                                                            ]
                                                                        ),

                                                                      ),

                                                                      // Buttons
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
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:

                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          children: <Widget>[
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                Navigator.of(context).push(
                                                                                  MaterialPageRoute(
                                                                                    builder: (BuildContext context) {
                                                                                      return LabSmartReports();
                                                                                    },
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                padding: new EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.015,
                                                                                    right: MediaQuery.of(context).size.height * 0.015,
                                                                                    top: MediaQuery.of(context).size.height * 0.007,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.007),
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFF126086),
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),


                                                                                margin: EdgeInsets.only(
                                                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                  right: MediaQuery.of(context).size.height * 0.01,
                                                                                ),
                                                                                // color: Colors.grey[300],
                                                                                alignment: Alignment.center,
                                                                                // height:
                                                                                // MediaQuery.of(context).size.height * 0.070,
                                                                                child: Text("Smart Report",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () async {

                                                                                Navigator.of(context).push(
                                                                                  MaterialPageRoute(
                                                                                    builder: (BuildContext context) {
                                                                                      return LabViewReports();
                                                                                    },
                                                                                  ),
                                                                                );

                                                                                // Navigator.of(context, rootNavigator: true).pop();
                                                                              },
                                                                              child: Container(
                                                                                padding: new EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.015,
                                                                                    right: MediaQuery.of(context).size.height * 0.015,
                                                                                    top: MediaQuery.of(context).size.height * 0.007,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.007),
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFF126086),
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),


                                                                                margin: EdgeInsets.only(
                                                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                  right: MediaQuery.of(context).size.height * 0.005,
                                                                                ),
                                                                                // color: Colors.grey[300],
                                                                                alignment: Alignment.center,
                                                                                // height:
                                                                                // MediaQuery.of(context).size.height * 0.070,
                                                                                child: Text("View Reports",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                                                              ),
                                                                            ),

                                                                          ],
                                                                        ),

                                                                      ),


                                                                    ]
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ]),
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

                      // Browse by health condition
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            top: MediaQuery.of(context).size.height *
                                0.015,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.015),
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
                                  "Browse by health condition",
                                  style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.014,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return HealthCondiViewall();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.00),
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Color(0xFF126086),
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.012,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      // Browse by health condition Grid
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            top: MediaQuery.of(context).size.height *
                                0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00
                        ),
                        child: GridView.count(
                          shrinkWrap:
                          true, // GridView takes only as much space as needed
                          physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                          ),
                          crossAxisCount: 4,
                          // crossAxisSpacing: screenHeight * 0.02,
                          // mainAxisSpacing: screenHeight * 0.01,
                          children: List.generate(
                            mybrowsebyhealthcond.length,
                                (index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Add specific actions for each index
                                    if (index == 0) {
                                    /*  Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return DiagnosticMain();
                                          },
                                        ),
                                      );*/
                                    } else if (index == 1) {
                                     /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return DoctorHCMain();
                                          },
                                        ),
                                      );*/
                                    }else if (index == 2) {
                                     /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return NurseHCMain();
                                          },
                                        ),
                                      );*/
                                    }else if (index == 3) {
                                     /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PhysioHCMain();
                                          },
                                        ),
                                      );*/
                                    } else if (index == 4) {
                                    /*  Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return MedicalEquipHCMain();
                                          },
                                        ),
                                      );*/
                                    }
                                    // Add more cases as needed
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFE8F0F3),
                                    padding:
                                    EdgeInsets.all(screenHeight * 0.01),
                                    minimumSize: Size(screenHeight * 0.04,
                                        screenHeight * 0.04),
                                  ),
                                  child: Container(
                                    width: screenHeight * 0.03,
                                    height: screenHeight * 0.03,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            mybrowsebyhealthcond[index][0]),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height :screenHeight * 0.01 ),
                                Expanded(
                                  child:  Container(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.00,
                                      bottom: MediaQuery.of(context).size.height * 0.00,
                                      left: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.height * 0.005,
                                    ),
                                    child: Text(
                                      mybrowsebyhealthcond[index][1],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.012,
                                        fontWeight: FontWeight.w400,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Recommended Test
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            top: MediaQuery.of(context).size.height *
                                0.015,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.015),
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
                                  "Recommended Test",
                                  style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.014,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                 ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return RecommendedViewAll();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.00),
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Color(0xFF126086),
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.012,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      // Recommended Test List
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Provide a width constraint using SizedBox or Expanded
                          Container(

                            margin:EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right: MediaQuery.of(context).size.height * 0.0,
                                bottom: MediaQuery.of(context).size.height * 0.0,
                                top: MediaQuery.of(context).size.height * 0.00),
                            height: MediaQuery.of(context).size.height * 0.135,
                            child: ListView.builder(
                              physics: ScrollPhysics(),  // Ensures scrolling
                              shrinkWrap: true,  // Prevents ListView from taking up extra space
                              scrollDirection: Axis.horizontal,  // Makes the ListView horizontal
                              itemCount: 3,  // You can adjust the item count
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {

                                  },
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child:  Container(
                                      width:MediaQuery.of(context).size.height * 0.38,
                                      padding:EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height * 0.00,
                                          right: MediaQuery.of(context).size.height * 0.00,
                                          bottom: MediaQuery.of(context).size.height * 0.00,
                                          top: MediaQuery.of(context).size.height * 0.00),
                                      color: Colors.white,
                                      child:
                                      Container(
                                        // color: Colors.white,

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
                                          border: Border.all(
                                            color: Colors.black12, // Border color
                                            width: 1.0, // Border width
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Rounded corners
                                        ),
                                        margin:EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.00,
                                            right: MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                            top: MediaQuery.of(context).size.height * 0.00),
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.005,
                                            right: MediaQuery.of(context).size.height * 0.005,
                                            bottom: MediaQuery.of(context).size.height * 0.005,
                                            top: MediaQuery.of(context).size.height * 0.005),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              Container(
                                                // color: Colors.red,
                                                // height: MediaQuery.of(context).size.height * 0.12,
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                    top: MediaQuery.of(context).size.height * 0.001,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      height : MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.055,
                                                      margin: EdgeInsets.only(
                                                        left:
                                                        MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.005,
                                                      ),

                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(130.0),
                                                        child: Image.asset(
                                                          'assets/Harmonebackground.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.height *
                                                            0.015),

                                                    Expanded(
                                                      flex: 8,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[


                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.0,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "QCT Superior Health Plan",
                                                              style: TextStyle(
                                                                  color: Colors.black87,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.014),
                                                            ),
                                                          ),

                                                          Container(

                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "100 Tests Included : Complete Blood Count",
                                                              style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012),
                                                            ),
                                                          ),

                                                          Container(

                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "Reports With in 24 Hours",
                                                              style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w600,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
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


                                              // Bottom Row
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                    top: MediaQuery.of(context).size.height * 0.00,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                width: double.infinity,
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(06),
                                                        ),
                                                        padding: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.height * 0.01,
                                                          right: MediaQuery.of(context).size.height * 0.01,
                                                          top: MediaQuery.of(context).size.height * 0.01,
                                                          bottom: MediaQuery.of(context).size.height * 0.01,),
                                                        child: Row(
                                                          // mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[

                                                                      // More Details
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
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:

                                                                        Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: <Widget>[



                                                                              Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: 2),
                                                                                height: MediaQuery.of(context).size.height * 0.004,
                                                                                width: MediaQuery.of(context).size.height * 0.004,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                              ),

                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                      padding: EdgeInsets.only(
                                                                                          left: MediaQuery.of(context).size.height * 0.005,
                                                                                          right: MediaQuery.of(context).size.height * 0.00,
                                                                                          top: MediaQuery.of(context).size.height * 0.00,
                                                                                          bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                      child:
                                                                                      Text(
                                                                                        'QR 2999',
                                                                                        style: TextStyle(
                                                                                          // color: Colors.blue[600],
                                                                                            color: Colors.black,
                                                                                            fontWeight: FontWeight.w500,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            decoration: TextDecoration.lineThrough,
                                                                                            decorationThickness: 2,
                                                                                            fontSize: MediaQuery.of(context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.014),
                                                                                      )


                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                                                        right: MediaQuery.of(context).size.height * 0.00,
                                                                                        top: MediaQuery.of(context).size.height * 0.00,
                                                                                        bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                    child:
                                                                                    Text( "QR 1999",
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

                                                                                  Container(
                                                                                    margin: EdgeInsets.only(
                                                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                                                        right: MediaQuery.of(context).size.height * 0.00,
                                                                                        top: MediaQuery.of(context).size.height * 0.00,
                                                                                        bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                    height: screenHeight * 0.01,
                                                                                    width: screenHeight * 0.01,
                                                                                    decoration: BoxDecoration(
                                                                                      // color: Colors.blue[100]!.withOpacity(0.9),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Center( // Ensures the image is centered
                                                                                      child: Image.asset(
                                                                                        'assets/Offersicon.png', // Replace with your actual asset path
                                                                                        // color: Color(0xFF126086), // Optional: Apply color tint
                                                                                        height: screenHeight * 0.015,
                                                                                        width: screenHeight * 0.015,
                                                                                      ),
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              )


                                                                            ]
                                                                        ),

                                                                      ),

                                                                      // Buttons
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
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:

                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          children: <Widget>[
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                // Navigator.of(context, rootNavigator: true).pop();
                                                                              },
                                                                              child: Container(
                                                                                padding: new EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.025,
                                                                                    right: MediaQuery.of(context).size.height * 0.025,
                                                                                    top: MediaQuery.of(context).size.height * 0.007,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.007),
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFF126086),
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),


                                                                                margin: EdgeInsets.only(
                                                                                  left: MediaQuery.of(context).size.height * 0.0,
                                                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                  right: MediaQuery.of(context).size.height * 0.005,
                                                                                ),
                                                                                // color: Colors.grey[300],
                                                                                alignment: Alignment.center,
                                                                                // height:
                                                                                // MediaQuery.of(context).size.height * 0.070,
                                                                                child: Text("Add",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                                                              ),
                                                                            ),


                                                                          ],
                                                                        ),

                                                                      ),


                                                                    ]
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ]),
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

                      // Health Package
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            top: MediaQuery.of(context).size.height *
                                0.015,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.015),
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
                                  "Health Package",
                                  style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.014,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return HealthPackagesViewall();
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.00),
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Color(0xFF126086),
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.012,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      // Health Package Grid
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            top: MediaQuery.of(context).size.height *
                                0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00
                        ),
                        child: GridView.count(
                          shrinkWrap:
                          true, // GridView takes only as much space as needed
                          physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                          ),
                          crossAxisCount: 4,
                          // crossAxisSpacing: 10,
                          // mainAxisSpacing: 10,
                          children: List.generate(
                            myhealthpackages.length,
                                (index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Add specific actions for each index
                                    if (index == 0) {
                                      /*  Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return DiagnosticMain();
                                          },
                                        ),
                                      );*/
                                    } else if (index == 1) {
                                      /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return DoctorHCMain();
                                          },
                                        ),
                                      );*/
                                    }else if (index == 2) {
                                      /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return NurseHCMain();
                                          },
                                        ),
                                      );*/
                                    }else if (index == 3) {
                                      /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PhysioHCMain();
                                          },
                                        ),
                                      );*/
                                    } else if (index == 4) {
                                      /*  Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return MedicalEquipHCMain();
                                          },
                                        ),
                                      );*/
                                    }
                                    // Add more cases as needed
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFE8F0F3),
                                    padding:
                                    EdgeInsets.all(screenHeight * 0.01),
                                    minimumSize: Size(screenHeight * 0.04,
                                        screenHeight * 0.04),
                                  ),
                                  child: Container(
                                    width: screenHeight * 0.03,
                                    height: screenHeight * 0.03,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            myhealthpackages[index][0]),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.00,
                                      bottom: MediaQuery.of(context).size.height * 0.00,
                                      left: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.height * 0.005,
                                    ),
                                    child: Text(
                                      myhealthpackages[index][1],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            (10 /
                                                MediaQuery.of(context)
                                                    .size
                                                    .height),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Available Offers
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            top: MediaQuery.of(context).size.height *
                                0.015,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.015),
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
                                  "Available Offers",
                                  style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.014,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                 Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return NotificationMain(initialTabIndex: 1);
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.00),
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Color(0xFF126086),
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.012,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),

                     Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0,
                    bottom: MediaQuery.of(context).size.height * 0.0,
                    left: MediaQuery.of(context).size.height * 0.015,
                    right: MediaQuery.of(context).size.height * 0.015,
                  ),
                  child:

                      Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Aligns content vertically
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  // alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[


                    if(new30)
                      Dismissible(
                        key: UniqueKey(), // Unique key for each item
                        direction: DismissDirection.endToStart, // Allow swipe from right to left
                        background: Container(
                          color: Colors.white,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          // child: Icon(
                          //   Icons.delete,
                          //   color: Colors.red,
                          // ),
                        ),
                        onDismissed: (direction) {
                          // Remove the item immediately from the list
                          setState(() {
                            new30 = false;
                            new20 = true;
                          });


                        },
                        child : Container(
                      width: double.infinity,
                      // height: 195,
                      // decoration: BoxDecoration(
                      //   color: Theme.of(context).primaryColor,
                      //   borderRadius: BorderRadius.circular(10),
                      //   boxShadow: [
                      //     BoxShadow(
                      //         color: Theme.of(context).hintColor.withOpacity(0.15),
                      //         blurRadius: 20,
                      //         offset: Offset(0, 5)),
                      //   ],
                      // ),
                      child:  Container(
                        // color: Colors.white,

                        decoration: BoxDecoration(
                          color: Colors.white, // Background color of the container
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.1), // Shadow color
                          //     blurRadius: 5, // Spread of the shadow
                          //     offset: Offset(0, 0), // Offset in x and y direction
                          //   ),
                          // ],

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,

                              offset: Offset(0, 1),
                            ),
                          ],

                          borderRadius: BorderRadius.circular(8), // Rounded corners
                          border: Border.all(
                            color: Colors.black12, // Border color
                            width: 0.5, // Border width
                          ),
                        ),
                        margin:EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.00),
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.005,
                            right: MediaQuery.of(context).size.height * 0.005,
                            bottom: MediaQuery.of(context).size.height * 0.005,
                            top: MediaQuery.of(context).size.height * 0.005),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(

                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.005,
                                    right: MediaQuery.of(context).size.height * 0.005,
                                    top: MediaQuery.of(context).size.height * 0.00,
                                    bottom: MediaQuery.of(context).size.height * 0.00),


                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: MediaQuery.of(context).size.height *
                                          0.04,
                                      width: MediaQuery.of(context).size.height *
                                          0.04,
                                      margin: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height * 0.015,
                                        top: MediaQuery.of(context).size.height * 0.01,
                                        right: MediaQuery.of(context).size.height * 0.015,
                                        bottom: MediaQuery.of(context).size.height * 0.01,
                                      ),

                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(130.0),
                                        child: Image.asset(
                                          'assets/Offersicon.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),



                                    Expanded(
                                      flex: 10,
                                      child:
                                      Padding(
                                        padding: EdgeInsets.zero, // Ensure no extra padding from the parent
                                        child:
                                          Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[


                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.00,
                                                right: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.0,
                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                            child:
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.00,
                                                        right: MediaQuery.of(context).size.height * 0.00,
                                                        top: MediaQuery.of(context).size.height * 0.0,
                                                        bottom: MediaQuery.of(context).size.height * 0.00),
                                                    child:
                                                    Text(
                                                      "New 30",
                                                      style: TextStyle(
                                                          color: Color(0xFF1F1F1F),
                                                          overflow: TextOverflow.ellipsis,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.016),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                        right: MediaQuery.of(context).size.height * 0.012,
                                                        top: MediaQuery.of(context).size.height * 0.00,
                                                        bottom: MediaQuery.of(context).size.height * 0.00),
                                                    child:
                                                    Row(
                                                      children: <Widget>[

                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: MediaQuery.of(context).size.height * 0.025,
                                                        ),

                                                      ],
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),





                                          Container(

                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.00,
                                                right: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00,
                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                            child:
                                            Text(
                                              "Get 30% OFF upto ₹600 on 1st Lab-Test Order. Min Order Value of ₹1000",
                                              style: TextStyle(
                                                  color: Color(0xCC000000),
                                                  fontWeight: FontWeight.w500,
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.009),
                                            ),
                                          ),




                                        ],
                                      ),
                                      ),
                                    ),



                                  ],
                                ),
                              ),

                            ]),
                      ),
                    ),
                      ),
                    if(new30)
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.01,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                        left: MediaQuery.of(context).size.height * 0.015,
                        right: MediaQuery.of(context).size.height * 0.015,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white, // Background color of the container
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.1), // Shadow color
                        //     blurRadius: 5, // Spread of the shadow
                        //     offset: Offset(0, 0), // Offset in x and y direction
                        //   ),
                        // ],

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,

                            offset: Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10), // Radius for bottom-left corner
                          bottomRight: Radius.circular(10), // Radius for bottom-right corner
                        ),// Rounded corners
                        border: Border.all(
                          color: Colors.black12, // Border color
                          width: 1.0, // Border width
                        ),
                      ),


                    ),
                    if(new30)
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.01,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                        left: MediaQuery.of(context).size.height * 0.025,
                        right: MediaQuery.of(context).size.height * 0.025,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white, // Background color of the container
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2), // Shadow color
                            blurRadius: 5, // Spread of the shadow
                            offset: Offset(0, 1), // Offset in x and y direction
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10), // Radius for bottom-left corner
                          bottomRight: Radius.circular(10), // Radius for bottom-right corner
                        ),// Rounded corners
                        border: Border.all(
                          color: Colors.black12, // Border color
                          width: 1.0, // Border width
                        ),
                      ),


                    ),

                    if(new20)
                      Dismissible(
                        key: UniqueKey(), // Unique key for each item
                        direction: DismissDirection.endToStart, // Allow swipe from right to left
                        background: Container(
                          color: Colors.white,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          // child: Icon(
                          //   Icons.delete,
                          //   color: Colors.red,
                          // ),
                        ),
                        onDismissed: (direction) {
                          // Remove the item immediately from the list
                          setState(() {
                            new20 = false;
                            new10 = true;
                          });


                        },
                        child : Container(
                          width: double.infinity,
                          // height: 195,
                          // decoration: BoxDecoration(
                          //   color: Theme.of(context).primaryColor,
                          //   borderRadius: BorderRadius.circular(10),
                          //   boxShadow: [
                          //     BoxShadow(
                          //         color: Theme.of(context).hintColor.withOpacity(0.15),
                          //         blurRadius: 20,
                          //         offset: Offset(0, 5)),
                          //   ],
                          // ),
                          child:  Container(
                            // color: Colors.white,

                            decoration: BoxDecoration(
                              color: Colors.white, // Background color of the container
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black.withOpacity(0.1), // Shadow color
                              //     blurRadius: 5, // Spread of the shadow
                              //     offset: Offset(0, 0), // Offset in x and y direction
                              //   ),
                              // ],

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,

                                  offset: Offset(0, 1),
                                ),
                              ],

                              borderRadius: BorderRadius.circular(8), // Rounded corners
                              border: Border.all(
                                color: Colors.black12, // Border color
                                width: 0.5, // Border width
                              ),
                            ),
                            margin:EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                                top: MediaQuery.of(context).size.height * 0.00),
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.005,
                                right: MediaQuery.of(context).size.height * 0.005,
                                bottom: MediaQuery.of(context).size.height * 0.005,
                                top: MediaQuery.of(context).size.height * 0.005),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Container(

                                    padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height * 0.005,
                                        right: MediaQuery.of(context).size.height * 0.005,
                                        top: MediaQuery.of(context).size.height * 0.00,
                                        bottom: MediaQuery.of(context).size.height * 0.00),


                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: MediaQuery.of(context).size.height *
                                              0.04,
                                          width: MediaQuery.of(context).size.height *
                                              0.04,
                                          margin: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.015,
                                            top: MediaQuery.of(context).size.height * 0.01,
                                            right: MediaQuery.of(context).size.height * 0.015,
                                            bottom: MediaQuery.of(context).size.height * 0.01,
                                          ),

                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(130.0),
                                            child: Image.asset(
                                              'assets/Offersicon.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),



                                        Expanded(
                                          flex: 10,
                                          child:
                                          Padding(
                                            padding: EdgeInsets.zero, // Ensure no extra padding from the parent
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[


                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery.of(context).size.height * 0.00,
                                                      right: MediaQuery.of(context).size.height * 0.00,
                                                      top: MediaQuery.of(context).size.height * 0.0,
                                                      bottom: MediaQuery.of(context).size.height * 0.00),
                                                  child:
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              left: MediaQuery.of(context).size.height * 0.00,
                                                              right: MediaQuery.of(context).size.height * 0.00,
                                                              top: MediaQuery.of(context).size.height * 0.0,
                                                              bottom: MediaQuery.of(context).size.height * 0.00),
                                                          child:
                                                          Text(
                                                            "New 20",
                                                            style: TextStyle(
                                                                color: Color(0xFF1F1F1F),
                                                                overflow: TextOverflow.ellipsis,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.016),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          padding: EdgeInsets.only(
                                                              left: MediaQuery.of(context).size.height * 0.005,
                                                              right: MediaQuery.of(context).size.height * 0.012,
                                                              top: MediaQuery.of(context).size.height * 0.00,
                                                              bottom: MediaQuery.of(context).size.height * 0.00),
                                                          child:
                                                          Row(
                                                            children: <Widget>[

                                                              Icon(
                                                                Icons.star,
                                                                color: Colors.amber,
                                                                size: MediaQuery.of(context).size.height * 0.025,
                                                              ),

                                                            ],
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                          ),
                                                        ),
                                                      ]
                                                  ),
                                                ),





                                                Container(

                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery.of(context).size.height * 0.00,
                                                      right: MediaQuery.of(context).size.height * 0.00,
                                                      top: MediaQuery.of(context).size.height * 0.00,
                                                      bottom: MediaQuery.of(context).size.height * 0.00),
                                                  child:
                                                  Text(
                                                    "Get 30% OFF upto ₹600 on 1st Lab-Test Order. Min Order Value of ₹1000",
                                                    style: TextStyle(
                                                        color: Color(0xCC000000),
                                                        fontWeight: FontWeight.w500,
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.009),
                                                  ),
                                                ),




                                              ],
                                            ),
                                          ),
                                        ),



                                      ],
                                    ),
                                  ),

                                ]),
                          ),
                        ),
                      ),
                    if(new20)
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.01,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.015,
                          right: MediaQuery.of(context).size.height * 0.015,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white, // Background color of the container
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.1), // Shadow color
                          //     blurRadius: 5, // Spread of the shadow
                          //     offset: Offset(0, 0), // Offset in x and y direction
                          //   ),
                          // ],

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,

                              offset: Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10), // Radius for bottom-left corner
                            bottomRight: Radius.circular(10), // Radius for bottom-right corner
                          ),// Rounded corners
                          border: Border.all(
                            color: Colors.black12, // Border color
                            width: 1.0, // Border width
                          ),
                        ),


                      ),

                    if(new10)
                      Container(
                        width: double.infinity,
                        // height: 195,
                        // decoration: BoxDecoration(
                        //   color: Theme.of(context).primaryColor,
                        //   borderRadius: BorderRadius.circular(10),
                        //   boxShadow: [
                        //     BoxShadow(
                        //         color: Theme.of(context).hintColor.withOpacity(0.15),
                        //         blurRadius: 20,
                        //         offset: Offset(0, 5)),
                        //   ],
                        // ),
                        child:  Container(
                          // color: Colors.white,

                          decoration: BoxDecoration(
                            color: Colors.white, // Background color of the container
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.1), // Shadow color
                            //     blurRadius: 5, // Spread of the shadow
                            //     offset: Offset(0, 0), // Offset in x and y direction
                            //   ),
                            // ],

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5,

                                offset: Offset(0, 1),
                              ),
                            ],

                            borderRadius: BorderRadius.circular(8), // Rounded corners
                            border: Border.all(
                              color: Colors.black12, // Border color
                              width: 0.5, // Border width
                            ),
                          ),
                          margin:EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.00),
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.005,
                              right: MediaQuery.of(context).size.height * 0.005,
                              bottom: MediaQuery.of(context).size.height * 0.005,
                              top: MediaQuery.of(context).size.height * 0.005),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Container(

                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.height * 0.005,
                                      top: MediaQuery.of(context).size.height * 0.00,
                                      bottom: MediaQuery.of(context).size.height * 0.00),


                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: MediaQuery.of(context).size.height *
                                            0.04,
                                        width: MediaQuery.of(context).size.height *
                                            0.04,
                                        margin: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height * 0.015,
                                          top: MediaQuery.of(context).size.height * 0.01,
                                          right: MediaQuery.of(context).size.height * 0.015,
                                          bottom: MediaQuery.of(context).size.height * 0.01,
                                        ),

                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(130.0),
                                          child: Image.asset(
                                            'assets/Offersicon.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),



                                      Expanded(
                                        flex: 10,
                                        child:
                                        Padding(
                                          padding: EdgeInsets.zero, // Ensure no extra padding from the parent
                                          child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[


                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.00,
                                                    right: MediaQuery.of(context).size.height * 0.00,
                                                    top: MediaQuery.of(context).size.height * 0.0,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                child:
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                            top: MediaQuery.of(context).size.height * 0.0,
                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                        child:
                                                        Text(
                                                          "New 10",
                                                          style: TextStyle(
                                                              color: Color(0xFF1F1F1F),
                                                              overflow: TextOverflow.ellipsis,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.016),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(context).size.height * 0.005,
                                                            right: MediaQuery.of(context).size.height * 0.012,
                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                        child:
                                                        Row(
                                                          children: <Widget>[

                                                            Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                              size: MediaQuery.of(context).size.height * 0.025,
                                                            ),

                                                          ],
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                              ),





                                              Container(

                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.00,
                                                    right: MediaQuery.of(context).size.height * 0.00,
                                                    top: MediaQuery.of(context).size.height * 0.00,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                child:
                                                Text(
                                                  "Get 30% OFF upto ₹600 on 1st Lab-Test Order. Min Order Value of ₹1000",
                                                  style: TextStyle(
                                                      color: Color(0xCC000000),
                                                      fontWeight: FontWeight.w500,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.009),
                                                ),
                                              ),




                                            ],
                                          ),
                                        ),
                                      ),



                                    ],
                                  ),
                                ),

                              ]),
                        ),
                      ),

                  ],
                ),

                ),





                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.005,
                          top: MediaQuery.of(context).size.height * 0.005,
                          right: MediaQuery.of(context).size.height * 0.005,
                          bottom: MediaQuery.of(context).size.height * 0.005,
                        ),
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.00,
                          top: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.05,
                        ),
                        child: Image.asset(
                          'assets/safetyqualitycertificate.png', // Replace with your image path
                          width: MediaQuery.of(context).size.height * 0.170, // Adjust size as needed
                          // height: MediaQuery.of(context).size.height * 0.2,
                          height: MediaQuery.of(context).size.height * 0.155,
                          fit: BoxFit.fill, // Adjust the fit based on your design
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
        ]),
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
