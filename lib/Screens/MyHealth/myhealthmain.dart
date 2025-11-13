import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Medications/medicationsmain.dart';
import 'package:newfolder/Screens/MyHealth/helpscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/PaymentHistory/paymenthistory.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Radiology/pastupcomingtestscan.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/Timeline/timelinemain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';

class MyHealthMain extends StatefulWidget {
  int selectedIndex = 4;
  MyHealthMain({
    super.key,
  });
  @override
  State<MyHealthMain> createState() => MyHealthMainstate();
}

class MyHealthMainstate extends State<MyHealthMain> {
  String usernameValue = "My Health";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 4;

  final mytopspecialities = [
    ["assets/myhealthMyPrescription.png", "My Prescription"],
    ["assets/myhealthTestReports.png", "Test Reports"],
    ["assets/Medications_ls.png", "My Medications"],
    ["assets/myhealthmyhealthHealthRecords.png", "Health Records"],
    ["assets/myhealthRadiology.png", "Radiology"],
    ["assets/myhealthTimeline.png", "Timeline"],
    ["assets/myhealthHospitalInvoice.png", "Hospital Invoice"],
  ];

  final List<String> uploadfilestime = [
    "Now",
    "15 min ago",
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _loadData();
  }

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating API call
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: !_isLoading
            ? const BoxDecoration(
                image: DecorationImage(
                  // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
                  image: AssetImage("assets/Background Pattern.png"),
                  fit:
                      BoxFit.cover, // Adjusts how the image fills the container
                ),
              )
            : const BoxDecoration(
                color: Colors.white,
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
                    !_isLoading
                        ? InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              width: MediaQuery.of(context).size.height * 0.035,
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                top: MediaQuery.of(context).size.height * 0.00,
                                right:
                                    MediaQuery.of(context).size.height * 0.02,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.00,
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
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.035,
                            width: MediaQuery.of(context).size.height * 0.035,
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                            ),
                            decoration: BoxDecoration(
                              // color : Colors.red,
                              // borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                tileMode: TileMode.clamp,
                                colors: [
                                  Color(0xFFCCCCCC),
                                  Color(0x99E8E8E8),
                                  Color(0xFFC4C4C4),
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.005,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                          ),
                          child: !_isLoading
                              ? Text(
                                  usernameValue,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                )
                              : Container(
                                  height: screenHeight * 0.012,
                                  width: screenWidth * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      tileMode: TileMode.clamp,
                                      colors: [
                                        Color(0xFFCCCCCC),
                                        Color(0x99E8E8E8),
                                        Color(0xFFC4C4C4),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!_isLoading)
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    // return GoogleMapScreen();
                                    return AddressScreen();
                                  },
                                ),
                              );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // Align items to the start
                            children: [
                              if (!_isLoading)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.00,
                                    horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.00,
                                  ),
                                  child: Text(
                                    useraddressValue,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.012,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              if (!_isLoading)
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  // Downward pointing arrow
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.height *
                                      0.02, // Responsive size
                                ),
                              if (_isLoading)
                                Container(
                                  margin: EdgeInsets.only(
                                    top: screenHeight * 0.01,
                                  ),
                                  height: screenHeight * 0.005,
                                  width: screenWidth * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      tileMode: TileMode.clamp,
                                      colors: [
                                        Color(0xFFCCCCCC),
                                        Color(0x99E8E8E8),
                                        Color(0xFFC4C4C4),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Action Bar 2nd half
                    Expanded(
                      child: !_isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Cart
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return AddToCartMain();
                                        },
                                      ),
                                    );
                                  },
                                  child: AppointmentIconBadge(
                                    appointmentcount: "",
                                  ),
                                ),

                                // Notification
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return NotificationMain();
                                        },
                                      ),
                                    );
                                  },
                                  child: IconBadge(
                                    notificationcount: "",
                                  ),
                                ),

                                // Profile Image
                                userprofilepValue != "NA"
                                    ? GestureDetector(
                                        onTap: () async {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return ProfileMain();
                                              },
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.050,
                                          width: MediaQuery.of(context)
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
                                              image: Image.memory(base64Decode(
                                                      userprofilepValue))
                                                  .image,
                                            ),
                                          ),
                                        ))
                                    : GestureDetector(
                                        onTap: () async {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return ProfileMain();
                                              },
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
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
                                            borderRadius:
                                                BorderRadius.circular(130.0),
                                            child: Image.asset(
                                              'assets/drsujeet.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.height *
                                        0.015,
                                    top: MediaQuery.of(context).size.height *
                                        0.005,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                    left: MediaQuery.of(context).size.height *
                                        0.0,
                                  ),
                                  height: screenHeight * 0.025,
                                  width: screenHeight * 0.025,
                                  decoration: BoxDecoration(
                                    // color : Colors.red,
                                    // borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      tileMode: TileMode.clamp,
                                      colors: [
                                        Color(0xFFCCCCCC),
                                        Color(0x99E8E8E8),
                                        Color(0xFFC4C4C4),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.height *
                                        0.015,
                                    top: MediaQuery.of(context).size.height *
                                        0.005,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                    left: MediaQuery.of(context).size.height *
                                        0.0,
                                  ),
                                  height: screenHeight * 0.025,
                                  width: screenHeight * 0.025,
                                  decoration: BoxDecoration(
                                    // color : Colors.red,
                                    // borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      tileMode: TileMode.clamp,
                                      colors: [
                                        Color(0xFFCCCCCC),
                                        Color(0x99E8E8E8),
                                        Color(0xFFC4C4C4),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  height: screenHeight * 0.04,
                                  width: screenHeight * 0.04,
                                  decoration: BoxDecoration(
                                    // color : Colors.red,
                                    // borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      tileMode: TileMode.clamp,
                                      colors: [
                                        Color(0xFFCCCCCC),
                                        Color(0x99E8E8E8),
                                        Color(0xFFC4C4C4),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                    )
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
                      // Container(
                      //   width: double.infinity,
                      //   padding: EdgeInsets.only(
                      //     top: 0,
                      //     bottom: MediaQuery.of(context).size.height * 0.0,
                      //     right: MediaQuery.of(context).size.height * 0.025,
                      //     left: MediaQuery.of(context).size.height * 0.025,
                      //   ),
                      //   // height: MediaQuery.of(context).size.height * 0.150,
                      //   child: DottedBorder(
                      //     color: Color(0xFF343434).withOpacity(0.3),
                      //     strokeWidth: 1,
                      //     borderType: BorderType.RRect,
                      //     radius: Radius.circular(8),
                      //     child: Center(
                      //       // Ensures the content is centered within the border
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment
                      //             .center, // Aligns content vertically
                      //         crossAxisAlignment: CrossAxisAlignment
                      //             .center, // Aligns content horizontally
                      //         children: <Widget>[
                      //           Container(
                      //             margin: EdgeInsets.only(
                      //                 left: MediaQuery.of(context).size.height *
                      //                     0.00,
                      //                 right:
                      //                 MediaQuery.of(context).size.height *
                      //                     0.00,
                      //                 top: MediaQuery.of(context).size.height *
                      //                     0.02,
                      //                 bottom:
                      //                 MediaQuery.of(context).size.height *
                      //                     0.01),
                      //             width: screenHeight * 0.04,
                      //             height: screenHeight * 0.04,
                      //             decoration: BoxDecoration(
                      //               image: DecorationImage(
                      //                 image: AssetImage("assets/homecare.png"),
                      //                 fit: BoxFit.contain,
                      //               ),
                      //             ),
                      //           ),
                      //           Column(
                      //             children: <Widget>[
                      //               Container(
                      //                 padding:
                      //                 EdgeInsets.only(
                      //                     left: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.00,
                      //                     right: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.00,
                      //                     top: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.00,
                      //                     bottom: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.006),
                      //                 child: Text(
                      //                   "choose file to upload",
                      //                   style: TextStyle(
                      //                     fontWeight: FontWeight.w600,
                      //                     color: Color(0xFF1F1F1F),
                      //                     fontSize: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.014,
                      //
                      //                   ),
                      //                   overflow: TextOverflow.ellipsis,
                      //                 ),
                      //               ),
                      //               Container(
                      //                 padding:
                      //                 EdgeInsets.only(
                      //                     left: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.00,
                      //                     right: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.00,
                      //                     top: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.00,
                      //                     bottom: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.02),
                      //                 child: RichText(
                      //                   text: TextSpan(
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .titleLarge!
                      //                         .merge(
                      //                       TextStyle(
                      //                           color: Theme.of(context)
                      //                               .primaryColor),
                      //                     ),
                      //                     children: [
                      //                       TextSpan(
                      //                         text:
                      //                         'image or pdf Should be less than',
                      //                         style: TextStyle(
                      //                           color: Color(0xFF000000)
                      //                               .withOpacity(0.4),
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: screenHeight * 0.012,
                      //                         ),
                      //                       ),
                      //                       TextSpan(
                      //                         text: ' 10MB',
                      //                         style: TextStyle(
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: screenHeight * 0.012,
                      //                           color: Color(0xFF126086),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      !_isLoading
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.025,
                                  right:
                                      MediaQuery.of(context).size.height * 0.0,
                                  top: MediaQuery.of(context).size.height *
                                      0.015,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.00),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Your health at your fingertips",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.014,
                                    color: Color(0xFF1F1F1F),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                  right:
                                      MediaQuery.of(context).size.height * 0.02,
                                  left:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                height: screenHeight * 0.008,
                                width: screenWidth * 0.4,
                                decoration: BoxDecoration(
                                  // color : Colors.red,
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    tileMode: TileMode.clamp,
                                    colors: [
                                      Color(0xFFCCCCCC),
                                      Color(0x99E8E8E8),
                                      Color(0xFFC4C4C4),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                      //
                      // Container(
                      //   color: Colors.white,
                      //   padding: EdgeInsets.only(
                      //       left: MediaQuery
                      //           .of(context)
                      //           .size
                      //           .height * 0.02,
                      //       top: MediaQuery.of(context).size.height *
                      //           0.00,
                      //       right: MediaQuery
                      //           .of(context)
                      //           .size
                      //           .height * 0.0,
                      //       bottom: MediaQuery
                      //           .of(context)
                      //           .size
                      //           .height * 0.005
                      //   ),
                      //   child: GridView.count(
                      //     shrinkWrap:
                      //     true, // GridView takes only as much space as needed
                      //     physics:
                      //     NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                      //     padding: EdgeInsets.only(
                      //       left: MediaQuery
                      //           .of(context)
                      //           .size
                      //           .height * 0.00,
                      //       right: MediaQuery
                      //           .of(context)
                      //           .size
                      //           .height * 0.00,
                      //       top: MediaQuery
                      //           .of(context)
                      //           .size
                      //           .height * 0.007,
                      //       bottom: MediaQuery
                      //           .of(context)
                      //           .size
                      //           .height * 0.00,
                      //     ),
                      //     crossAxisCount: 4,
                      //     crossAxisSpacing: screenHeight * 0.02,
                      //     mainAxisSpacing: screenHeight * 0.015,
                      //     children: List.generate(
                      //       mytopspecialities.length,
                      //           (index) => Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           TextButton(
                      //             onPressed: () {
                      //               // Add specific actions for each index
                      //
                      //             },
                      //             style: TextButton.styleFrom(
                      //               backgroundColor: Color(0xFFE8F0F3),
                      //               padding: EdgeInsets.all(
                      //                   screenHeight * 0.01),
                      //               minimumSize: Size(
                      //                 screenHeight * 0.04,
                      //                 screenHeight * 0.04,
                      //               ),
                      //             ),
                      //             child: Container(
                      //               width: screenHeight * 0.03,
                      //               height: screenHeight * 0.03,
                      //               decoration: BoxDecoration(
                      //                 image: DecorationImage(
                      //                   image: AssetImage(
                      //                       mytopspecialities[index][0]),
                      //                   fit: BoxFit.contain,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           SizedBox(height :screenHeight * 0.005 ),
                      //           Expanded(
                      //             child: Padding(
                      //               padding: EdgeInsets.only(
                      //                   left: MediaQuery
                      //                       .of(context)
                      //                       .size
                      //                       .height * 0.005,
                      //                   right: MediaQuery
                      //                       .of(context)
                      //                       .size
                      //                       .height * 0.005,
                      //                   ),
                      //               child: Text(
                      //                 mytopspecialities[index][1],
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                   color: Color(0xFF000000),
                      //                   fontSize: MediaQuery
                      //                       .of(context)
                      //                       .size
                      //                       .height * 0.012,
                      //                   fontWeight: FontWeight.w400,
                      //                   // overflow: TextOverflow.ellipsis,
                      //                 ),
                      //
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Upload your Health Records

                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.height * 0.02,
                            // ⬇️ पहली row–container gap कम करने के लिए 0 कर सकते हैं
                            mainAxisSpacing: 0,
                            childAspectRatio: 0.9,
                          ),
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.02,
                          ),
                          itemCount: mytopspecialities.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  // ---------- Icon Button ----------
                                  TextButton(
                                    onPressed: () async {
                                      print("index : $index");
                                        if (index == 0) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return MyReportsMain(initialTabIndex: 0,);
                                              },
                                            ),
                                          );
                                        } else if (index == 1) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return MyReportsMain(initialTabIndex: 1,);
                                              },
                                            ),
                                          );
                                        } else if (index == 2) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return MedicationsMain();
                                              },
                                            ),
                                          );
                                        } else if (index == 3) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return MyReportsMain(initialTabIndex: 1,);
                                              },
                                            ),
                                          );
                                        } else if (index == 4) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return PastUpcomingscanMain();
                                              },
                                            ),
                                          );
                                        }
                                        else if (index == 5) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return TimelineMain();
                                              },
                                            ),
                                          );
                                        } else if (index == 6) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) {
                                                    return PaymentHistoryMain();
                                                  },
                                              )
                                          );
                                        }
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFFE8F0F3),
                                      // backgroundColor : Colors.red,
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
                                              mytopspecialities[index][0]),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: screenHeight * 0.008),

                                  // ---------- Label ----------
                                  Expanded(
                                    child: Text(
                                      mytopspecialities[index][1],
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        height: 0.95,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // ✅ Only show the title if there are uploaded prescriptions
                      if (uploadfilestime.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.025,
                              right: MediaQuery.of(context).size.height * 0.0,
                              top: MediaQuery.of(context).size.height * 0.015,
                              bottom: MediaQuery.of(context).size.height * 0.00),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Uploaded Health Records",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                color: Color(0xFF1F1F1F),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),

                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.015,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: uploadfilestime.length,
                          itemBuilder: (context, index) {
                            final file = uploadfilestime[index];

                            return Dismissible(
                              key: Key(file),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.white,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.red),
                              ),
                              onDismissed: (direction) {
                                setState(() {
                                  uploadfilestime.removeAt(index);
                                });
                                showTopNotification(
                                  context,
                                  title: "Deleted Successfully",
                                  message: "The prescription has been removed.",
                                  type: NotificationType.error,
                                );
                              },
                              child: GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 0.0,
                                  color: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.00,
                                      right: MediaQuery.of(context).size.height * 0.00,
                                      bottom: MediaQuery.of(context).size.height * 0.0,
                                      top: MediaQuery.of(context).size.height * 0.00,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          stops: [0.5, 0.9],
                                          colors: [Color(0xFFffffff), Color(0xFFffffff)],
                                        ),
                                      ),
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context).size.height * 0.005,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: screenHeight * 0.06,
                                                  width: screenHeight * 0.06,
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: screenHeight * 0.01,
                                                    vertical: screenHeight * 0.005,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(130.0),
                                                    child: Image.asset(
                                                      'assets/medicationjpg.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.height * 0.010,
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        "Prescription_1.jpg",
                                                        style: TextStyle(
                                                          color: Colors.black87,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: MediaQuery.of(context).size.height * 0.014,
                                                        ),
                                                      ),
                                                      Text(
                                                        "5 Mb",
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight: FontWeight.bold,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: MediaQuery.of(context).size.height * 0.012,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(right: screenHeight * 0.01),
                                                  child: Text(
                                                    uploadfilestime[index],
                                                    style: TextStyle(
                                                      fontSize: screenHeight * 0.011,
                                                      color: Color(0xFF126086),
                                                      fontWeight: FontWeight.w500,
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
                            );
                          },
                        ),
                      ),

                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       left: MediaQuery.of(context).size.height * 0.025,
                      //       right: MediaQuery.of(context).size.height * 0.0,
                      //       top: MediaQuery.of(context).size.height * 0.015,
                      //       bottom: MediaQuery.of(context).size.height * 0.00),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       "Uploaded Health Records",
                      //       style: TextStyle(
                      //         fontSize:
                      //             MediaQuery.of(context).size.height * 0.014,
                      //         color: Color(0xFF1F1F1F),
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //       textAlign: TextAlign.start,
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   padding: EdgeInsets.only(
                      //     top: MediaQuery.of(context).size.height *
                      //         0.015, // Dynamic top padding
                      //     bottom: MediaQuery.of(context).size.height *
                      //         0.0, // Dynamic bottom padding
                      //     left: MediaQuery.of(context).size.height *
                      //         0.01, // Dynamic left padding
                      //     right: MediaQuery.of(context).size.height *
                      //         0.01, // Dynamic right padding
                      //   ),
                      //   child: ListView.builder(
                      //     padding: EdgeInsets.zero,
                      //     shrinkWrap: true, // Prevents infinite height
                      //     physics: NeverScrollableScrollPhysics(),
                      //     itemCount: uploadfilestime.length,
                      //     itemBuilder: (context, index) {
                      //       final file = uploadfilestime[index];
                      //
                      //       return Dismissible(
                      //           key: Key(file), // Unique key for each item
                      //           direction: DismissDirection
                      //               .endToStart, // Allow swipe from right to left
                      //           background: Container(
                      //             color: Colors.white,
                      //             alignment: Alignment.centerRight,
                      //             padding: EdgeInsets.symmetric(horizontal: 20),
                      //             child: Icon(
                      //               Icons.delete,
                      //               color: Colors.red,
                      //             ),
                      //           ),
                      //           onDismissed: (direction) {
                      //             // Remove the item immediately from the list
                      //             setState(() {
                      //               uploadfilestime.removeAt(index);
                      //             });
                      //             showTopNotification(
                      //               context,
                      //               title: "Deleted Successfully",
                      //               message: "The prescription has been removed.",
                      //               type: NotificationType.error, // You can change to .success if needed
                      //             );
                      //           },
                      //           child: GestureDetector(
                      //             onTap: () {},
                      //             child: Card(
                      //               elevation: 0.0,
                      //               color: Colors.white,
                      //               child: Container(
                      //                 decoration: BoxDecoration(
                      //                   color: Colors
                      //                       .white, // Background color of the container
                      //                   border: Border.all(
                      //                     color: Colors.black
                      //                         .withOpacity(0.1), // Border color
                      //                     width: 1, // Border width
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(
                      //                       8), // Optional: Rounded corners
                      //                 ),
                      //
                      //                 padding:
                      //                     EdgeInsets.only(
                      //                         left: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                             0.00,
                      //                         right: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                             0.00,
                      //                         bottom: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                             0.0,
                      //                         top: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                             0.00),
                      //                 // color: Colors.white,
                      //                 child: Container(
                      //                   // color: Colors.white,
                      //
                      //                   decoration: BoxDecoration(
                      //                       borderRadius:
                      //                           BorderRadius.circular(10),
                      //                       gradient: LinearGradient(
                      //                           begin: Alignment.centerLeft,
                      //                           end: Alignment.centerRight,
                      //                           stops: [
                      //                             0.5,
                      //                             0.9
                      //                           ],
                      //                           colors: [
                      //                             Color(0xFFffffff),
                      //                             Color(0xFFffffff)
                      //                           ])),
                      //                   margin: EdgeInsets.only(
                      //                       left: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.00,
                      //                       right: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.00,
                      //                       bottom: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.00,
                      //                       top: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.00),
                      //                   padding: EdgeInsets.only(
                      //                       left: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.005,
                      //                       right: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.005,
                      //                       bottom: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.005,
                      //                       top: MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                           0.005),
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: <Widget>[
                      //                       Container(
                      //                         padding: EdgeInsets.only(
                      //                           left: MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                               0.005,
                      //                           right: MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                               0.005,
                      //                           top: MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                               0.00,
                      //                           bottom: MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                               0.00,
                      //                         ),
                      //                         child: Row(
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.center,
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment.start,
                      //                           children: <Widget>[
                      //                             Container(
                      //                               height: screenHeight * 0.06,
                      //                               width: screenHeight * 0.06,
                      //                               padding: EdgeInsets.only(
                      //                                 left:
                      //                                     MediaQuery.of(context)
                      //                                             .size
                      //                                             .height *
                      //                                         0.00,
                      //                               ),
                      //                               margin: EdgeInsets.only(
                      //                                 left: screenHeight * 0.01,
                      //                                 top: screenHeight * 0.005,
                      //                                 bottom:
                      //                                     screenHeight * 0.005,
                      //                                 right:
                      //                                     screenHeight * 0.01,
                      //                               ),
                      //                               child: ClipRRect(
                      //                                 borderRadius:
                      //                                     BorderRadius.circular(
                      //                                         130.0),
                      //                                 child: Image.asset(
                      //                                   'assets/medicationjpg.png',
                      //                                   fit: BoxFit.fill,
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             SizedBox(
                      //                                 width:
                      //                                     MediaQuery.of(context)
                      //                                             .size
                      //                                             .height *
                      //                                         0.010),
                      //                             Expanded(
                      //                               flex: 6,
                      //                               child: Column(
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .start,
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment
                      //                                         .center,
                      //                                 children: <Widget>[
                      //                                   Container(
                      //                                     padding:
                      //                                         EdgeInsets.only(
                      //                                       left: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.00,
                      //                                       right: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.00,
                      //                                       top: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.0,
                      //                                       bottom: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.00,
                      //                                     ),
                      //                                     child: Text(
                      //                                       "Prescription_1.jpg",
                      //                                       style: TextStyle(
                      //                                         color: Colors
                      //                                             .black87,
                      //                                         overflow:
                      //                                             TextOverflow
                      //                                                 .ellipsis,
                      //                                         fontWeight:
                      //                                             FontWeight
                      //                                                 .bold,
                      //                                         fontSize: MediaQuery.of(
                      //                                                     context)
                      //                                                 .size
                      //                                                 .height *
                      //                                             0.014,
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                   Container(
                      //                                     padding:
                      //                                         EdgeInsets.only(
                      //                                       left: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.00,
                      //                                       right: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.00,
                      //                                       top: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.00,
                      //                                       bottom: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.00,
                      //                                     ),
                      //                                     child: Text(
                      //                                       "5 Mb",
                      //                                       style: TextStyle(
                      //                                         color: Colors
                      //                                             .black54,
                      //                                         fontWeight:
                      //                                             FontWeight
                      //                                                 .bold,
                      //                                         overflow:
                      //                                             TextOverflow
                      //                                                 .ellipsis,
                      //                                         fontSize: MediaQuery.of(
                      //                                                     context)
                      //                                                 .size
                      //                                                 .height *
                      //                                             0.012,
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             Container(
                      //                               margin: EdgeInsets.only(
                      //                                 right:
                      //                                     screenHeight * 0.01,
                      //                               ),
                      //                               child: Text(
                      //                                 uploadfilestime[index],
                      //                                 style: TextStyle(
                      //                                   fontSize: screenHeight *
                      //                                       0.011,
                      //                                   color:
                      //                                       Color(0xFF126086),
                      //                                   fontWeight:
                      //                                       FontWeight.w500,
                      //                                 ),
                      //                               ),
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ));
                      //     },
                      //   ),
                      // ),

                      // Gradient card
                      // GestureDetector(
                      //   onTap: () {
                      //     // Add your onTap logic here
                      //   },
                      //   child: Card(
                      //     elevation: 0,
                      //     child: Container(
                      //
                      //       padding: EdgeInsets.only(
                      //           left: MediaQuery.of(context).size.height * 0.00,
                      //           right:
                      //           MediaQuery.of(context).size.height * 0.005,
                      //           bottom:
                      //           MediaQuery.of(context).size.height * 0.00,
                      //           top: MediaQuery.of(context).size.height * 0.00),
                      //       color: Colors.white,
                      //       child: Container(
                      //         margin: EdgeInsets.only(
                      //             left: MediaQuery.of(context).size.height * 0.02,
                      //             right: MediaQuery.of(context).size.height * 0.02,
                      //             bottom: MediaQuery.of(context).size.height * 0.01,
                      //             top: MediaQuery.of(context).size.height * 0.0),
                      //         // height: MediaQuery.of(context).size.height * 0.22,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           gradient: LinearGradient(
                      //             begin: Alignment.centerLeft,
                      //             end: Alignment.centerRight,
                      //             colors: [Color(0xFF056390), Color(0xFFCF55CD)],
                      //           ),
                      //         ),
                      //         child: Row(
                      //           children: <Widget>[
                      //             Flexible(
                      //               child: Padding(
                      //                 padding: EdgeInsets.all(
                      //                     MediaQuery.of(context).size.height *
                      //                         0.01),
                      //                 child: Column(
                      //                   mainAxisAlignment:
                      //                   MainAxisAlignment.start,
                      //                   crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //                   children: <Widget>[
                      //
                      //                     Container(
                      //                       padding: EdgeInsets.only(
                      //                           left: MediaQuery.of(context).size.height * 0.015,
                      //                           right: MediaQuery.of(context).size.height * 0.00,
                      //                           bottom: MediaQuery.of(context).size.height * 0.00,
                      //                           top: MediaQuery.of(context).size.height * 0.01
                      //                       ),
                      //                       child:
                      //                       Text(
                      //                         "Get started by uploading old test reports to know about your health pattens",
                      //                         style: TextStyle(
                      //                           // overflow: TextOverflow.ellipsis,
                      //                           fontSize: MediaQuery.of(context).size.height * 0.014,
                      //                           color: Colors.white,
                      //                         ),
                      //                         textAlign: TextAlign.left,
                      //                       ),
                      //                     ),
                      //
                      //
                      //
                      //                     GestureDetector(
                      //                       onTap: () {
                      //
                      //                       },
                      //                       child:Container(
                      //                         margin: EdgeInsets.only(
                      //                             left: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.02,
                      //                             right: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.02,
                      //                             bottom: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.01,
                      //                             top: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.015),
                      //                         decoration: BoxDecoration(
                      //                           color: Color(0xFFA8B1CE).withOpacity(0.1), // Background color of the container
                      //                           /*  boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.black
                      //                     .withOpacity(
                      //                     0.1), // Shadow color
                      //                 blurRadius:
                      //                 5, // Spread of the shadow
                      //                 offset: Offset(0,
                      //                     0), // Offset in x and y direction
                      //               ),
                      //             ],*/
                      //                           borderRadius: BorderRadius.circular(
                      //                               8), // Optional: Rounded corners
                      //                         ),
                      //
                      //                         padding: EdgeInsets.only(
                      //                             left: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.00,
                      //                             right: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.00,
                      //                             bottom: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.0,
                      //                             top: MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.00),
                      //                         // color: Colors.white,
                      //                         child: Container(
                      //                           // color: Colors.white,
                      //
                      //                           decoration: BoxDecoration(
                      //                               borderRadius:
                      //                               BorderRadius.circular(10),
                      //                               gradient: LinearGradient(
                      //                                   begin:
                      //                                   Alignment.centerLeft,
                      //                                   end:
                      //                                   Alignment.centerRight,
                      //                                   stops: [
                      //                                     0.5,
                      //                                     0.9
                      //                                   ],
                      //                                   colors: [
                      //                                     Color(0xFFA8B1CE).withOpacity(0.1),
                      //                                     Color(0xFFA8B1CE).withOpacity(0.1),
                      //                                   ])),
                      //
                      //                           padding: EdgeInsets.only(
                      //                               left: MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                                   0.005,
                      //                               right: MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                                   0.005,
                      //                               bottom: MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                                   0.005,
                      //                               top: MediaQuery.of(context)
                      //                                   .size
                      //                                   .height *
                      //                                   0.005),
                      //                           child: Column(
                      //                             crossAxisAlignment:
                      //                             CrossAxisAlignment.start,
                      //                             children: <Widget>[
                      //                               Container(
                      //                                 padding: EdgeInsets.only(
                      //                                   left:
                      //                                   MediaQuery.of(context)
                      //                                       .size
                      //                                       .height *
                      //                                       0.005,
                      //                                   right:
                      //                                   MediaQuery.of(context)
                      //                                       .size
                      //                                       .height *
                      //                                       0.005,
                      //                                   top:
                      //                                   MediaQuery.of(context)
                      //                                       .size
                      //                                       .height *
                      //                                       0.00,
                      //                                   bottom:
                      //                                   MediaQuery.of(context)
                      //                                       .size
                      //                                       .height *
                      //                                       0.00,
                      //                                 ),
                      //                                 child: Row(
                      //                                   crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .center,
                      //                                   mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .start,
                      //                                   children: <Widget>[
                      //                                     Expanded(
                      //                                       flex: 1,
                      //                                       child: Container(
                      //                                         padding:
                      //                                         EdgeInsets.only(
                      //                                           left: MediaQuery.of(
                      //                                               context)
                      //                                               .size
                      //                                               .height *
                      //                                               0.00,
                      //                                         ),
                      //                                         child:   Container(
                      //                                           margin: EdgeInsets.only(
                      //                                             left: MediaQuery.of(context).size.height * 0.008,
                      //                                             right: MediaQuery.of(context).size.height * 0.008,
                      //                                             top: MediaQuery.of(context).size.height * 0.01,
                      //                                             bottom: MediaQuery.of(context).size.height * 0.01,
                      //                                           ),
                      //                                           height: MediaQuery.of(context).size.height * 0.025,
                      //                                           width: MediaQuery.of(context).size.height * 0.035,
                      //                                           child:
                      //                                           Image.asset(
                      //                                             'assets/myhealthupload.png',
                      //                                             fit:
                      //                                             BoxFit.fill,
                      //                                           ),
                      //                                         ),
                      //
                      //                                       ),
                      //                                     ),
                      //                                     SizedBox(
                      //                                         width: MediaQuery.of(
                      //                                             context)
                      //                                             .size
                      //                                             .height *
                      //                                             0.010),
                      //                                     Expanded(
                      //                                       flex: 8,
                      //                                       child: Column(
                      //                                         crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .start,
                      //                                         mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .center,
                      //                                         children: <Widget>[
                      //                                           Container(
                      //                                             padding:
                      //                                             EdgeInsets
                      //                                                 .only(
                      //                                               left: MediaQuery.of(
                      //                                                   context)
                      //                                                   .size
                      //                                                   .height *
                      //                                                   0.00,
                      //                                               right: MediaQuery.of(
                      //                                                   context)
                      //                                                   .size
                      //                                                   .height *
                      //                                                   0.00,
                      //                                               top: MediaQuery.of(
                      //                                                   context)
                      //                                                   .size
                      //                                                   .height *
                      //                                                   0.0,
                      //                                               bottom: MediaQuery.of(
                      //                                                   context)
                      //                                                   .size
                      //                                                   .height *
                      //                                                   0.00,
                      //                                             ),
                      //                                             child: Text(
                      //                                               "Upload Test Reports",
                      //                                               style:
                      //                                               TextStyle(
                      //                                                 color: Colors.white,
                      //                                                 overflow:
                      //                                                 TextOverflow
                      //                                                     .ellipsis,
                      //                                                 fontWeight:
                      //                                                 FontWeight
                      //                                                     .bold,
                      //                                                 fontSize: MediaQuery.of(context)
                      //                                                     .size
                      //                                                     .height *
                      //                                                     0.014,
                      //                                               ),
                      //                                             ),
                      //                                           ),
                      //
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                     // Adding the side arrow at the end
                      //                                     Icon(
                      //                                       Icons
                      //                                           .arrow_forward_ios,
                      //                                       size: MediaQuery.of(
                      //                                           context)
                      //                                           .size
                      //                                           .height *
                      //                                           0.018, // Dynamic icon size
                      //                                       color:
                      //                                       Colors.white,
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //
                      //
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //  Help & Support
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return HelpscreenMain();
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.025,
                              right: MediaQuery.of(context).size.height * 0.025,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005,
                              top: MediaQuery.of(context).size.height * 0.015),
                          decoration: BoxDecoration(
                            color: Color(0xFFA8B1CE).withOpacity(
                                0.1), // Background color of the container
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
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.0,
                              top: MediaQuery.of(context).size.height * 0.00),
                          // color: Colors.white,
                          child: Container(
                            // color: Colors.white,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [
                                      0.5,
                                      0.9
                                    ],
                                    colors: [
                                      Color(0xFFA8B1CE).withOpacity(0.1),
                                      Color(0xFFA8B1CE).withOpacity(0.1),
                                    ])),

                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.005,
                                right:
                                    MediaQuery.of(context).size.height * 0.005,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.005,
                                top:
                                    MediaQuery.of(context).size.height * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.005,
                                    right: MediaQuery.of(context).size.height *
                                        0.025,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.00,
                                          ),
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
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            child: Image.asset(
                                              'assets/myhealthhelp.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.010),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                    0.0,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00,
                                              ),
                                              child: Text(
                                                "Help & Support",
                                                style: TextStyle(
                                                  color: Color(0xFF126086),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.0135,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Adding the side arrow at the end
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.014, // Dynamic icon size
                                        color: Color(0xFF126086),
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
            ],
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: screenHeight * 0.07, // Outer circle height (adjust as needed)
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
                type: BottomNavigationBarType.fixed,
                // Set fixed type for equal spacing
                currentIndex: _selectedIndex,
                // Track the selected tab
                // Track the selected tab
                onTap: _onItemTapped,

                backgroundColor: Colors.white,
                selectedItemColor: Color(0xFF126086),
                // Color for the selected item
                unselectedItemColor: Color(0xFF484C52),
                // Color for unselected items
                selectedFontSize: MediaQuery.of(context).size.height * 0.014,
                // Hide the label font for selected items
                unselectedFontSize: MediaQuery.of(context).size.height * 0.012,
                // Hide the label font for unselected items
                elevation: 0,
                // Disable elevation
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.005,
                      ), // Add padding
                      child: Image.asset(
                        'assets/Home.png',
                        width: MediaQuery.of(context).size.height * 0.027,
                        height: MediaQuery.of(context).size.height * 0.027,
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.005,
                      ), // Add padding
                      child: Image.asset(
                        'assets/MyReports.png',
                        width: MediaQuery.of(context).size.height * 0.027,
                        height: MediaQuery.of(context).size.height * 0.027,
                      ),
                    ),
                    label: 'My Reports',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.025,
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
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.005,
                      ), // Add padding
                      child: Image.asset(
                        'assets/Appoinments.png',
                        width: MediaQuery.of(context).size.height * 0.027,
                        height: MediaQuery.of(context).size.height * 0.027,
                      ),
                    ),
                    label: 'Appointments',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.005,
                      ), // Add padding
                      child: Image.asset(
                        'assets/MyHealthactive.png',
                        width: MediaQuery.of(context).size.height * 0.027,
                        height: MediaQuery.of(context).size.height * 0.027,
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
      } else if (selected == 4) {
        /*  Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyHealthMain();
            },
          ),
        );*/
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
          enableDrag: true,
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
}
