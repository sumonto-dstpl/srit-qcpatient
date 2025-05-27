import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dotted_border/dotted_border.dart';
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

class MedicalEquipHCMain extends StatefulWidget {
  int selectedIndex = 0;
  MedicalEquipHCMain({
    super.key,
  });
  @override
  State<MedicalEquipHCMain> createState() => MedicalEquipHCMainstate();
}

class MedicalEquipHCMainstate extends State<MedicalEquipHCMain> {
  String usernameValue = "Medical Equipments";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  bool _isExpandedtime = true;
  bool _isExpandedlocation = true;

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  // @override
  // Widget build(BuildContext context) {
  //   final screenHeight = MediaQuery.of(context).size.height;
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   TextEditingController SearchEditTextController = TextEditingController();
  //
  //   return Scaffold(
  //     body: Container(
  //       width: double.infinity,
  //       decoration: const BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage("assets/patternbackground.png"), // Replace with your image path
  //           fit: BoxFit.cover, // Adjusts how the image fills the container
  //         ),
  //       ),
  //       child: Stack(children: [
  //         Column(
  //           children: <Widget>[
  //             Container(
  //               padding: EdgeInsets.only(
  //                 top: screenHeight * 0.05,
  //                 left: screenWidth * 0.02,
  //                 right: screenWidth * 0.02,
  //                 bottom: screenWidth * 0.02,
  //               ),
  //               margin: EdgeInsets.only(
  //                 right: screenHeight * 0.0,
  //                 top: screenHeight * 0.0,
  //                 bottom: screenHeight * 0.01,
  //                 left: screenHeight * 0.0,
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //
  //                   InkWell(
  //                     onTap: () => Navigator.pop(context),
  //                     child: Container(
  //                       height: MediaQuery.of(context).size.height *
  //                           0.035,
  //                       width: MediaQuery.of(context).size.height *
  //                           0.035,
  //                       margin: EdgeInsets.only(
  //                         left: MediaQuery.of(context).size.height * 0.00,
  //                         top: MediaQuery.of(context).size.height * 0.00,
  //                         right: MediaQuery.of(context).size.height * 0.01,
  //                         bottom: MediaQuery.of(context).size.height * 0.00,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color:Color(0xFF126086).withOpacity(0.2),
  //                         shape: BoxShape.circle,
  //                         border: Border.all(
  //                             width: 0.0,
  //                             color:Color(0xFF126086)
  //                         ),
  //                       ),
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(130.0),
  //                         child: Image.asset(
  //                           'assets/medicationBack.png',
  //                           fit: BoxFit.fill,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   Expanded(
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Container(
  //                           padding: EdgeInsets.only(
  //                             top: MediaQuery.of(context).size.height * 0.00,
  //                             bottom: MediaQuery.of(context).size.height * 0.00,
  //                             left: MediaQuery.of(context).size.height * 0.00,
  //                             right: MediaQuery.of(context).size.height * 0.00,
  //                           ),
  //                           child: Text(
  //                             usernameValue,
  //                             style: TextStyle(
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.018,
  //                               color: Colors.white,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                             overflow: TextOverflow.ellipsis,
  //                             textAlign: TextAlign.left,
  //                           ),
  //                         ),
  //                         Container(
  //                           padding: EdgeInsets.only(
  //                             top: MediaQuery.of(context).size.height * 0.00,
  //                             bottom: MediaQuery.of(context).size.height * 0.00,
  //                             left: MediaQuery.of(context).size.height * 0.00,
  //                             right: MediaQuery.of(context).size.height * 0.00,
  //                           ),
  //                           child: Text(
  //                             useraddressValue,
  //                             style: TextStyle(
  //                               overflow: TextOverflow.ellipsis,
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.014,
  //                               color: Colors.white,
  //                             ),
  //                             textAlign: TextAlign.left,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   // Action Bar 2nd half
  //                   Expanded(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //
  //                         // Cart
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.of(context).push(
  //                               MaterialPageRoute(
  //                                 builder:
  //                                     (BuildContext context) {
  //                                   return AddToCartMain();
  //                                 },
  //                               ),
  //                             );
  //                           },
  //                           child:
  //                           AppointmentIconBadge(
  //                             appointmentcount: "",
  //                           ),
  //                         ),
  //
  //                         // Notification
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.of(context).push(
  //                               MaterialPageRoute(
  //                                 builder:
  //                                     (BuildContext context) {
  //                                   return NotificationMain();
  //                                 },
  //                               ),
  //                             );
  //                           },
  //                           child:
  //                           IconBadge(
  //                             notificationcount: "",
  //                           ),
  //                         ),
  //
  //
  //                         // Profile Image
  //                         userprofilepValue != "NA"
  //                             ?
  //
  //                         GestureDetector(
  //                             onTap: () async {
  //                               Navigator.of(context).push(
  //                                 MaterialPageRoute(
  //                                   builder: (BuildContext context) {
  //                                     return ProfileMain();
  //                                   },
  //                                 ),
  //                               );
  //                             }, child:
  //                         Container(
  //                           height: MediaQuery
  //                               .of(context)
  //                               .size
  //                               .height *
  //                               0.050,
  //                           width: MediaQuery
  //                               .of(context)
  //                               .size
  //                               .height *
  //                               0.050,
  //                           decoration: BoxDecoration(
  //                             border: Border.all(
  //                               width: 1.0,
  //                               color: Colors.white,
  //                             ),
  //                             shape: BoxShape.circle,
  //                             image: new DecorationImage(
  //                               fit: BoxFit.fill,
  //                               image: Image
  //                                   .memory(
  //                                   base64Decode(userprofilepValue))
  //                                   .image,
  //                             ),
  //                           ),
  //                         )
  //                         )
  //                             : GestureDetector(
  //                           onTap: () async {
  //                             Navigator.of(context).push(
  //                               MaterialPageRoute(
  //                                 builder: (BuildContext context) {
  //                                   return ProfileMain();
  //                                 },
  //                               ),
  //                             );
  //                           }, child: Container(
  //                           height: MediaQuery
  //                               .of(context)
  //                               .size
  //                               .height *
  //                               0.045,
  //                           width: MediaQuery
  //                               .of(context)
  //                               .size
  //                               .height *
  //                               0.045,
  //                           padding: EdgeInsets.only(
  //                             left: MediaQuery
  //                                 .of(context)
  //                                 .size
  //                                 .height *
  //                                 0.00,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: Colors.green,
  //                             shape: BoxShape.circle,
  //                             border: Border.all(
  //                               width: 1.0,
  //                               color: Colors.white,
  //                             ),
  //                           ),
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(130.0),
  //                             child: Image.asset(
  //                               'assets/drsujeet.png',
  //                               fit: BoxFit.fill,
  //                             ),
  //                           ),
  //                         ),
  //                         )
  //
  //
  //
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             // Main Content Section
  //             Expanded(
  //               child: Container(
  //                 padding: EdgeInsets.only(
  //                     left: MediaQuery.of(context).size.height * 0.00,
  //                     right: MediaQuery.of(context).size.height * 0.00,
  //                     top: MediaQuery.of(context).size.height * 0.00,
  //                     bottom: MediaQuery.of(context).size.height * 0.00),
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(screenHeight * 0.03),
  //                     topRight: Radius.circular(screenHeight * 0.03),
  //                   ),
  //                 ),
  //                 child: ListView(
  //                   children: [
  //                     Container(
  //                       width: double.infinity,
  //                       padding: EdgeInsets.only(
  //                         top: 0,
  //                         bottom: MediaQuery.of(context).size.height * 0.0,
  //                         right: MediaQuery.of(context).size.height * 0.020,
  //                         left: MediaQuery.of(context).size.height * 0.02,
  //                       ),
  //                       // height: MediaQuery.of(context).size.height * 0.150,
  //                       child: DottedBorder(
  //                         color: Color(0xFF343434).withOpacity(0.3),
  //                         strokeWidth: 1,
  //                         borderType: BorderType.RRect,
  //                         radius: Radius.circular(8),
  //                         child: Center(
  //                           // Ensures the content is centered within the border
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment
  //                                 .center, // Aligns content vertically
  //                             crossAxisAlignment: CrossAxisAlignment
  //                                 .center, // Aligns content horizontally
  //                             children: <Widget>[
  //                               Container(
  //                                 margin: EdgeInsets.only(
  //                                     left: MediaQuery.of(context).size.height *
  //                                         0.00,
  //                                     right:
  //                                     MediaQuery.of(context).size.height *
  //                                         0.00,
  //                                     top: MediaQuery.of(context).size.height *
  //                                         0.01,
  //                                     bottom:
  //                                     MediaQuery.of(context).size.height *
  //                                         0.01),
  //                                 width: screenHeight * 0.05,
  //                                 height: screenHeight * 0.05,
  //                                 decoration: BoxDecoration(
  //                                   image: DecorationImage(
  //                                     image: AssetImage("assets/homecare.png"),
  //                                     fit: BoxFit.contain,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Column(
  //                                 children: <Widget>[
  //                                   Container(
  //                                     padding:
  //                                     EdgeInsets.only(
  //                                         left: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         right: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         top: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         bottom: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.006),
  //                                     child: Text(
  //                                       "choose file to upload",
  //                                       style: TextStyle(
  //                                           fontWeight: FontWeight.bold,
  //                                           color: Color(0xFF1F1F1F),
  //                                           fontSize: MediaQuery.of(context)
  //                                               .size
  //                                               .height *
  //                                               0.016),
  //                                       overflow: TextOverflow.ellipsis,
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     padding:
  //                                     EdgeInsets.only(
  //                                         left: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         right: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         top: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         bottom: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.01),
  //                                     child: RichText(
  //                                       text: TextSpan(
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .headline6!
  //                                             .merge(
  //                                           TextStyle(
  //                                               color: Theme.of(context)
  //                                                   .primaryColor),
  //                                         ),
  //                                         children: [
  //                                           TextSpan(
  //                                             text:
  //                                             'image or pdf Should be less than',
  //                                             style: TextStyle(
  //                                               color: Color(0xFF000000)
  //                                                   .withOpacity(0.4),
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: screenHeight * 0.014,
  //                                             ),
  //                                           ),
  //                                           TextSpan(
  //                                             text: ' 10MB',
  //                                             style: TextStyle(
  //                                               fontWeight: FontWeight.w700,
  //                                               fontSize: screenHeight * 0.016,
  //                                               color: Color(0xFF126086),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //
  //                     // 1st Expansion Tile
  //                     Container(
  //                       padding: EdgeInsets.only(
  //                         top: MediaQuery.of(context).size.height * 0.005,
  //                         bottom: MediaQuery.of(context).size.height * 0.0,
  //                         right: MediaQuery.of(context).size.height * 0.010,
  //                         left: MediaQuery.of(context).size.height * 0.01,
  //                       ),
  //                       child: Card(
  //                         elevation: 0.0,
  //                         shape: RoundedRectangleBorder(
  //                           side: BorderSide(color: Colors.white),
  //                           borderRadius: BorderRadius.circular(
  //                             MediaQuery.of(context).size.height *
  //                                 0.01, // Dynamic border radius for top
  //                           ),
  //                         ),
  //                         child: Column(
  //                           children: [
  //                             InkWell(
  //                               onTap: () {
  //                                 setState(() {
  //                                   _isExpandedtime = !_isExpandedtime;
  //                                 });
  //                               },
  //                               child: Container(
  //                                 decoration: BoxDecoration(
  //                                   color: Colors
  //                                       .white, // Background color (optional)
  //                                   border: Border(
  //                                     top: BorderSide(
  //                                       color: Colors.grey, // Top border color
  //                                       width: 2.0, // Top border thickness
  //                                     ),
  //                                     right: BorderSide(
  //                                       color:
  //                                       Colors.grey, // Right border color
  //                                       width: 2.0, // Right border thickness
  //                                     ),
  //                                     bottom: BorderSide(
  //                                       color:
  //                                       Colors.grey, // Bottom border color
  //                                       width: _isExpandedtime
  //                                           ? 1.0
  //                                           : 2.0, // Reduced bottom border thickness on expansion
  //                                     ),
  //                                     left: BorderSide(
  //                                       color: Colors.grey, // Left border color
  //                                       width: 2.0, // Left border thickness
  //                                     ),
  //                                   ),
  //                                   borderRadius: BorderRadius.only(
  //                                     topLeft: Radius.circular(
  //                                         MediaQuery.of(context).size.height *
  //                                             0.01), // Dynamic top left radius
  //                                     topRight: Radius.circular(
  //                                         MediaQuery.of(context).size.height *
  //                                             0.01), // Dynamic top right radius
  //                                     bottomLeft: Radius.circular(
  //                                         MediaQuery.of(context).size.height *
  //                                             0.01), // Bottom-left curve radius
  //                                     bottomRight: Radius.circular(MediaQuery
  //                                         .of(context)
  //                                         .size
  //                                         .height *
  //                                         0.01), // Bottom-right curve radius
  //                                   ),
  //                                 ),
  //                                 padding: EdgeInsets.only(
  //                                   top: MediaQuery.of(context).size.height *
  //                                       0.01, // Dynamic top padding
  //                                   bottom: MediaQuery.of(context).size.height *
  //                                       0.01, // Dynamic bottom padding
  //                                   left: MediaQuery.of(context).size.height *
  //                                       0.015, // Dynamic left padding
  //                                   right: MediaQuery.of(context).size.height *
  //                                       0.015, // Dynamic right padding
  //                                 ),
  //                                 child: Row(
  //                                   mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text(
  //                                       "Select Time",
  //                                       style: TextStyle(
  //                                         fontSize: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.016, // Dynamic font size
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                     Icon(
  //                                       _isExpandedtime
  //                                           ? Icons.keyboard_arrow_up
  //                                           : Icons.keyboard_arrow_down,
  //                                       size:
  //                                       MediaQuery.of(context).size.height *
  //                                           0.02, // Dynamic icon size
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                             if (_isExpandedtime)
  //                               Container(
  //                                 padding: EdgeInsets.only(
  //                                   top: MediaQuery.of(context).size.height *
  //                                       0.005, // Dynamic top padding
  //                                   bottom: MediaQuery.of(context).size.height *
  //                                       0.0, // Dynamic bottom padding
  //                                   left: MediaQuery.of(context).size.height *
  //                                       0.0, // Dynamic left padding
  //                                   right: MediaQuery.of(context).size.height *
  //                                       0.0, // Dynamic right padding
  //                                 ),
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                   CrossAxisAlignment.start,
  //                                   children: [
  //                                     Padding(
  //                                       padding: EdgeInsets.only(
  //                                           left: MediaQuery.of(context)
  //                                               .size
  //                                               .height *
  //                                               0.015,
  //                                           right: MediaQuery.of(context)
  //                                               .size
  //                                               .height *
  //                                               0.015,
  //                                           bottom: MediaQuery.of(context)
  //                                               .size
  //                                               .height *
  //                                               0.016),
  //                                       child: Row(
  //                                           crossAxisAlignment:
  //                                           CrossAxisAlignment.center,
  //                                           mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                           children: <Widget>[
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                   left: MediaQuery.of(context)
  //                                                       .size
  //                                                       .height *
  //                                                       0.00,
  //                                                   right:
  //                                                   MediaQuery.of(context)
  //                                                       .size
  //                                                       .height *
  //                                                       0.00,
  //                                                   top: MediaQuery.of(context)
  //                                                       .size
  //                                                       .height *
  //                                                       0.005,
  //                                                   bottom:
  //                                                   MediaQuery.of(context)
  //                                                       .size
  //                                                       .height *
  //                                                       0.00),
  //                                               child: Text(
  //                                                 "Pick Data",
  //                                                 style: TextStyle(
  //                                                   color: Color(0xFF126086),
  //                                                   fontWeight: FontWeight.bold,
  //                                                   overflow:
  //                                                   TextOverflow.ellipsis,
  //                                                   fontSize:
  //                                                   MediaQuery.of(context)
  //                                                       .size
  //                                                       .height *
  //                                                       0.016,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             GestureDetector(
  //                                               onTap: () async {},
  //                                               child: Container(
  //                                                 padding: EdgeInsets.only(
  //                                                     left:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.00,
  //                                                     right:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.00,
  //                                                     top:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.005,
  //                                                     bottom:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.00),
  //                                                 child: Text(
  //                                                   "August 10 2024",
  //                                                   style: TextStyle(
  //                                                     color: Color(0xFF126086),
  //                                                     fontWeight:
  //                                                     FontWeight.w400,
  //                                                     overflow:
  //                                                     TextOverflow.ellipsis,
  //                                                     fontSize:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.014,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ]),
  //                                     ),
  //
  //                                     // 1st row
  //                                     Container(
  //                                       padding: EdgeInsets.only(
  //                                         top: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         bottom: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.005,
  //                                         left: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         right: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                       ),
  //                                       child: Row(
  //                                           mainAxisAlignment:
  //                                           MainAxisAlignment.spaceEvenly,
  //                                           crossAxisAlignment:
  //                                           CrossAxisAlignment.center,
  //                                           children: [
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF999999)
  //                                                           .withOpacity(0.1),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "06:00",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF999999)
  //                                                           .withOpacity(0.1),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "06:30",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color:
  //                                                       Color(0xFF126086),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "07:00",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color:
  //                                                             Colors.white,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color:
  //                                                             Colors.white,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF13668E)
  //                                                           .withOpacity(0.2),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                       border: Border.all(
  //                                                         color: Color(
  //                                                             0xFF126086)
  //                                                             .withOpacity(
  //                                                             0.4), // Black border
  //                                                         width:
  //                                                         1.0, // Set the border width
  //                                                       ),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "07:30",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Color(
  //                                                                 0xFF126086),
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Color(
  //                                                                 0xFF126086),
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ]),
  //                                     ),
  //
  //                                     // 2nd row
  //                                     Container(
  //                                       padding: EdgeInsets.only(
  //                                         top: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         bottom: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.005,
  //                                         left: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         right: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                       ),
  //                                       child: Row(
  //                                           mainAxisAlignment:
  //                                           MainAxisAlignment.spaceEvenly,
  //                                           crossAxisAlignment:
  //                                           CrossAxisAlignment.center,
  //                                           children: [
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF13668E)
  //                                                           .withOpacity(0.2),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                       border: Border.all(
  //                                                         color: Color(
  //                                                             0xFF126086)
  //                                                             .withOpacity(
  //                                                             0.4), // Black border
  //                                                         width:
  //                                                         1.0, // Set the border width
  //                                                       ),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "07:30",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Color(
  //                                                                 0xFF126086),
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Color(
  //                                                                 0xFF126086),
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF999999)
  //                                                           .withOpacity(0.1),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "06:00",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF13668E)
  //                                                           .withOpacity(0.2),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                       border: Border.all(
  //                                                         color: Color(
  //                                                             0xFF126086)
  //                                                             .withOpacity(
  //                                                             0.4), // Black border
  //                                                         width:
  //                                                         1.0, // Set the border width
  //                                                       ),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "07:30",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Color(
  //                                                                 0xFF126086),
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Color(
  //                                                                 0xFF126086),
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF999999)
  //                                                           .withOpacity(0.1),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "06:00",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ]),
  //                                     ),
  //
  //                                     // 3rd row
  //                                     Container(
  //                                       padding: EdgeInsets.only(
  //                                         top: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         bottom: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.005,
  //                                         left: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                         right: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.00,
  //                                       ),
  //                                       child: Row(
  //                                           mainAxisAlignment:
  //                                           MainAxisAlignment.spaceEvenly,
  //                                           crossAxisAlignment:
  //                                           CrossAxisAlignment.center,
  //                                           children: [
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF999999)
  //                                                           .withOpacity(0.1),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "06:00",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF999999)
  //                                                           .withOpacity(0.1),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "06:00",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF999999)
  //                                                           .withOpacity(0.1),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "06:00",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Colors
  //                                                                 .black38,
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Container(
  //                                               padding: EdgeInsets.only(
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                               ),
  //                                               child: Row(
  //                                                 mainAxisSize: MainAxisSize
  //                                                     .max, // Ensure the Row takes up the full available width
  //                                                 children: <Widget>[
  //                                                   Container(
  //                                                     height:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.06,
  //                                                     width: MediaQuery.of(
  //                                                         context)
  //                                                         .size
  //                                                         .width *
  //                                                         0.20, // Increase width
  //                                                     decoration: BoxDecoration(
  //                                                       color: Color(0xFF13668E)
  //                                                           .withOpacity(0.2),
  //                                                       borderRadius:
  //                                                       BorderRadius
  //                                                           .circular(5),
  //                                                       border: Border.all(
  //                                                         color: Color(
  //                                                             0xFF126086)
  //                                                             .withOpacity(
  //                                                             0.4), // Black border
  //                                                         width:
  //                                                         1.0, // Set the border width
  //                                                       ),
  //                                                     ),
  //                                                     child: Column(
  //                                                       mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center, // Center the content
  //                                                       children: <Widget>[
  //                                                         Text(
  //                                                           "07:30",
  //                                                           textAlign: TextAlign
  //                                                               .center,
  //                                                           style: TextStyle(
  //                                                             color: Color(
  //                                                                 0xFF126086),
  //                                                             fontWeight:
  //                                                             FontWeight
  //                                                                 .bold,
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.014,
  //                                                           ),
  //                                                         ),
  //                                                         SizedBox(height: 0),
  //                                                         Text(
  //                                                           "PM",
  //                                                           style: TextStyle(
  //                                                             color: Color(
  //                                                                 0xFF126086),
  //                                                             fontSize: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.012,
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ]),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //
  //                     // 2nd Expansion Tile
  //                     Container(
  //                       padding: EdgeInsets.only(
  //                         top: MediaQuery.of(context).size.height * 0.005,
  //                         bottom: MediaQuery.of(context).size.height * 0.0,
  //                         right: MediaQuery.of(context).size.height * 0.010,
  //                         left: MediaQuery.of(context).size.height * 0.01,
  //                       ),
  //                       child: Card(
  //                         elevation: 0.0,
  //                         shape: RoundedRectangleBorder(
  //                           side: BorderSide(color: Colors.white),
  //                           borderRadius: BorderRadius.circular(
  //                             MediaQuery.of(context).size.height *
  //                                 0.01, // Dynamic border radius for top
  //                           ),
  //                         ),
  //                         child: Column(
  //                           children: [
  //                             InkWell(
  //                               onTap: () {
  //                                 setState(() {
  //                                   _isExpandedlocation = !_isExpandedlocation;
  //                                 });
  //                               },
  //                               child: Container(
  //                                 decoration: BoxDecoration(
  //                                   color: Colors
  //                                       .white, // Background color (optional)
  //                                   border: Border(
  //                                     top: BorderSide(
  //                                       color: Colors.grey, // Top border color
  //                                       width: 2.0, // Top border thickness
  //                                     ),
  //                                     right: BorderSide(
  //                                       color:
  //                                       Colors.grey, // Right border color
  //                                       width: 2.0, // Right border thickness
  //                                     ),
  //                                     bottom: BorderSide(
  //                                       color:
  //                                       Colors.grey, // Bottom border color
  //                                       width: _isExpandedlocation
  //                                           ? 1.0
  //                                           : 2.0, // Reduced bottom border thickness on expansion
  //                                     ),
  //                                     left: BorderSide(
  //                                       color: Colors.grey, // Left border color
  //                                       width: 2.0, // Left border thickness
  //                                     ),
  //                                   ),
  //                                   borderRadius: BorderRadius.only(
  //                                     topLeft: Radius.circular(
  //                                         MediaQuery.of(context).size.height *
  //                                             0.01), // Dynamic top left radius
  //                                     topRight: Radius.circular(
  //                                         MediaQuery.of(context).size.height *
  //                                             0.01), // Dynamic top right radius
  //                                     bottomLeft: Radius.circular(
  //                                         MediaQuery.of(context).size.height *
  //                                             0.01), // Bottom-left curve radius
  //                                     bottomRight: Radius.circular(MediaQuery
  //                                         .of(context)
  //                                         .size
  //                                         .height *
  //                                         0.01), // Bottom-right curve radius
  //                                   ),
  //                                 ),
  //                                 padding: EdgeInsets.only(
  //                                   top: MediaQuery.of(context).size.height *
  //                                       0.01, // Dynamic top padding
  //                                   bottom: MediaQuery.of(context).size.height *
  //                                       0.01, // Dynamic bottom padding
  //                                   left: MediaQuery.of(context).size.height *
  //                                       0.015, // Dynamic left padding
  //                                   right: MediaQuery.of(context).size.height *
  //                                       0.015, // Dynamic right padding
  //                                 ),
  //                                 child: Row(
  //                                   mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text(
  //                                       "Select Location",
  //                                       style: TextStyle(
  //                                         fontSize: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.016, // Dynamic font size
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                     Icon(
  //                                       _isExpandedlocation
  //                                           ? Icons.keyboard_arrow_up
  //                                           : Icons.keyboard_arrow_down,
  //                                       size:
  //                                       MediaQuery.of(context).size.height *
  //                                           0.02, // Dynamic icon size
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                             if (_isExpandedlocation)
  //                               Container(
  //                                 padding: EdgeInsets.only(
  //                                   top: MediaQuery.of(context).size.height *
  //                                       0.005, // Dynamic top padding
  //                                   bottom: MediaQuery.of(context).size.height *
  //                                       0.0, // Dynamic bottom padding
  //                                   left: MediaQuery.of(context).size.height *
  //                                       0.0, // Dynamic left padding
  //                                   right: MediaQuery.of(context).size.height *
  //                                       0.0, // Dynamic right padding
  //                                 ),
  //                                 child: ListView.builder(
  //                                   shrinkWrap:
  //                                   true, // Prevents infinite height
  //                                   physics: NeverScrollableScrollPhysics(),
  //                                   itemCount: 2,
  //                                   itemBuilder: (context, index) {
  //                                     return GestureDetector(
  //                                       onTap: () {},
  //                                       child: Card(
  //                                         elevation: 0.0,
  //                                         color: Colors.white,
  //                                         child: Container(
  //                                           decoration: BoxDecoration(
  //                                             color: Colors
  //                                                 .white, // Background color of the container
  //                                             boxShadow: [
  //                                               BoxShadow(
  //                                                 color: Colors.black
  //                                                     .withOpacity(
  //                                                     0.1), // Shadow color
  //                                                 blurRadius:
  //                                                 5, // Spread of the shadow
  //                                                 offset: Offset(0,
  //                                                     0), // Offset in x and y direction
  //                                               ),
  //                                             ],
  //                                             borderRadius: BorderRadius.circular(
  //                                                 8), // Optional: Rounded corners
  //                                           ),
  //
  //                                           padding: EdgeInsets.only(
  //                                               left: MediaQuery.of(context)
  //                                                   .size
  //                                                   .height *
  //                                                   0.00,
  //                                               right: MediaQuery.of(context)
  //                                                   .size
  //                                                   .height *
  //                                                   0.00,
  //                                               bottom: MediaQuery.of(context)
  //                                                   .size
  //                                                   .height *
  //                                                   0.0,
  //                                               top: MediaQuery.of(context)
  //                                                   .size
  //                                                   .height *
  //                                                   0.00),
  //                                           // color: Colors.white,
  //                                           child: Container(
  //                                             // color: Colors.white,
  //
  //                                             decoration: BoxDecoration(
  //                                                 borderRadius:
  //                                                 BorderRadius.circular(10),
  //                                                 gradient: LinearGradient(
  //                                                     begin:
  //                                                     Alignment.centerLeft,
  //                                                     end:
  //                                                     Alignment.centerRight,
  //                                                     stops: [
  //                                                       0.5,
  //                                                       0.9
  //                                                     ],
  //                                                     colors: [
  //                                                       Color(0xFFffffff),
  //                                                       Color(0xFFffffff)
  //                                                     ])),
  //                                             margin: EdgeInsets.only(
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00,
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.00),
  //                                             padding: EdgeInsets.only(
  //                                                 left: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.005,
  //                                                 right: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.005,
  //                                                 bottom: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.005,
  //                                                 top: MediaQuery.of(context)
  //                                                     .size
  //                                                     .height *
  //                                                     0.005),
  //                                             child: Column(
  //                                               crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                               children: <Widget>[
  //                                                 Container(
  //                                                   padding: EdgeInsets.only(
  //                                                     left:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.005,
  //                                                     right:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.005,
  //                                                     top:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.00,
  //                                                     bottom:
  //                                                     MediaQuery.of(context)
  //                                                         .size
  //                                                         .height *
  //                                                         0.00,
  //                                                   ),
  //                                                   child: Row(
  //                                                     crossAxisAlignment:
  //                                                     CrossAxisAlignment
  //                                                         .center,
  //                                                     mainAxisAlignment:
  //                                                     MainAxisAlignment
  //                                                         .start,
  //                                                     children: <Widget>[
  //                                                       Expanded(
  //                                                         flex: 1,
  //                                                         child: Container(
  //                                                           padding:
  //                                                           EdgeInsets.only(
  //                                                             left: MediaQuery.of(
  //                                                                 context)
  //                                                                 .size
  //                                                                 .height *
  //                                                                 0.00,
  //                                                           ),
  //                                                           child: ClipRRect(
  //                                                             borderRadius:
  //                                                             BorderRadius
  //                                                                 .circular(
  //                                                                 130.0),
  //                                                             child:
  //                                                             Image.asset(
  //                                                               'assets/Homehomecare.png',
  //                                                               fit:
  //                                                               BoxFit.fill,
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                       ),
  //                                                       SizedBox(
  //                                                           width: MediaQuery.of(
  //                                                               context)
  //                                                               .size
  //                                                               .height *
  //                                                               0.010),
  //                                                       Expanded(
  //                                                         flex: 8,
  //                                                         child: Column(
  //                                                           crossAxisAlignment:
  //                                                           CrossAxisAlignment
  //                                                               .start,
  //                                                           mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .center,
  //                                                           children: <Widget>[
  //                                                             Container(
  //                                                               padding:
  //                                                               EdgeInsets
  //                                                                   .only(
  //                                                                 left: MediaQuery.of(
  //                                                                     context)
  //                                                                     .size
  //                                                                     .height *
  //                                                                     0.00,
  //                                                                 right: MediaQuery.of(
  //                                                                     context)
  //                                                                     .size
  //                                                                     .height *
  //                                                                     0.00,
  //                                                                 top: MediaQuery.of(
  //                                                                     context)
  //                                                                     .size
  //                                                                     .height *
  //                                                                     0.0,
  //                                                                 bottom: MediaQuery.of(
  //                                                                     context)
  //                                                                     .size
  //                                                                     .height *
  //                                                                     0.00,
  //                                                               ),
  //                                                               child: Text(
  //                                                                 "Home Address",
  //                                                                 style:
  //                                                                 TextStyle(
  //                                                                   color: Colors
  //                                                                       .black87,
  //                                                                   overflow:
  //                                                                   TextOverflow
  //                                                                       .ellipsis,
  //                                                                   fontWeight:
  //                                                                   FontWeight
  //                                                                       .bold,
  //                                                                   fontSize: MediaQuery.of(context)
  //                                                                       .size
  //                                                                       .height *
  //                                                                       0.014,
  //                                                                 ),
  //                                                               ),
  //                                                             ),
  //                                                             Container(
  //                                                               padding:
  //                                                               EdgeInsets
  //                                                                   .only(
  //                                                                 left: MediaQuery.of(
  //                                                                     context)
  //                                                                     .size
  //                                                                     .height *
  //                                                                     0.00,
  //                                                                 right: MediaQuery.of(
  //                                                                     context)
  //                                                                     .size
  //                                                                     .height *
  //                                                                     0.00,
  //                                                                 top: MediaQuery.of(
  //                                                                     context)
  //                                                                     .size
  //                                                                     .height *
  //                                                                     0.00,
  //                                                                 bottom: MediaQuery.of(
  //                                                                     context)
  //                                                                     .size
  //                                                                     .height *
  //                                                                     0.00,
  //                                                               ),
  //                                                               child: Text(
  //                                                                 "65 Mohamed Bin Al Qassim St, Doha, Qatar",
  //                                                                 style:
  //                                                                 TextStyle(
  //                                                                   color: Colors
  //                                                                       .black54,
  //                                                                   fontWeight:
  //                                                                   FontWeight
  //                                                                       .bold,
  //                                                                   overflow:
  //                                                                   TextOverflow
  //                                                                       .ellipsis,
  //                                                                   fontSize: MediaQuery.of(context)
  //                                                                       .size
  //                                                                       .height *
  //                                                                       0.012,
  //                                                                 ),
  //                                                               ),
  //                                                             ),
  //                                                           ],
  //                                                         ),
  //                                                       ),
  //                                                       // Adding the side arrow at the end
  //                                                       Icon(
  //                                                         Icons
  //                                                             .arrow_forward_ios,
  //                                                         size: MediaQuery.of(
  //                                                             context)
  //                                                             .size
  //                                                             .height *
  //                                                             0.018, // Dynamic icon size
  //                                                         color:
  //                                                         Color(0xFF5F5F5F),
  //                                                       ),
  //                                                     ],
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //
  //                     //
  //                     Padding(
  //                       padding: EdgeInsets.only(
  //                         left: MediaQuery.of(context).size.height * 0.015,
  //                         right: MediaQuery.of(context).size.height * 0.015,
  //                         bottom: MediaQuery.of(context).size.height * 0.016,
  //                       ),
  //                       child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         mainAxisAlignment: MainAxisAlignment
  //                             .start, // Align them to the start
  //                         children: <Widget>[
  //                           Icon(
  //                             Icons.add, // The add icon
  //                             color: Color(
  //                                 0xFF126086), // Set the color for the icon
  //                             size: MediaQuery.of(context).size.height *
  //                                 0.02, // Set icon size
  //                           ),
  //                           SizedBox(
  //                               width: MediaQuery.of(context).size.height *
  //                                   0.005), // Space between the icon and text
  //                           Container(
  //                             padding: EdgeInsets.only(
  //                               left: MediaQuery.of(context).size.height * 0.00,
  //                               right:
  //                               MediaQuery.of(context).size.height * 0.00,
  //                               top: MediaQuery.of(context).size.height * 0.005,
  //                               bottom:
  //                               MediaQuery.of(context).size.height * 0.00,
  //                             ),
  //                             child: Text(
  //                               "Add new Address",
  //                               style: TextStyle(
  //                                 color: Color(0xFF126086),
  //                                 fontWeight: FontWeight.bold,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 fontSize: MediaQuery.of(context).size.height *
  //                                     0.016,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //
  //                     // Add service button
  //                     GestureDetector(
  //                       onTap: () async {},
  //                       child: Container(
  //                           alignment: Alignment.centerRight,
  //                           padding: EdgeInsets.only(
  //                               top: MediaQuery.of(context).size.height * 0.01,
  //                               bottom:
  //                               MediaQuery.of(context).size.height * 0.00,
  //                               left: MediaQuery.of(context).size.height * 0.00,
  //                               right:
  //                               MediaQuery.of(context).size.height * 0.00),
  //                           margin: EdgeInsets.only(
  //                               right:
  //                               MediaQuery.of(context).size.height * 0.04,
  //                               top: MediaQuery.of(context).size.height * 0.00,
  //                               bottom:
  //                               MediaQuery.of(context).size.height * 0.07,
  //                               left:
  //                               MediaQuery.of(context).size.height * 0.04),
  //                           child: Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: <Widget>[
  //                                 Expanded(
  //                                   child: Container(
  //                                     decoration: BoxDecoration(
  //                                         borderRadius: BorderRadius.circular(
  //                                             MediaQuery.of(context)
  //                                                 .size
  //                                                 .height *
  //                                                 0.012),
  //                                         gradient: LinearGradient(
  //                                             begin: Alignment.centerRight,
  //                                             end: Alignment.center,
  //                                             stops: [
  //                                               0.5,
  //                                               0.9
  //                                             ],
  //                                             colors: [
  //                                               Color(0xFFA8B1CE),
  //                                               Color(0xFFA8B1CE),
  //                                             ])),
  //                                     alignment: Alignment.center,
  //                                     padding: EdgeInsets.only(left: 0.0),
  //                                     child: TextButton(
  //                                       onPressed: () async {},
  //                                       child: Text("Book Service",
  //                                           textAlign: TextAlign.center,
  //                                           style: TextStyle(
  //                                               color: Colors.white,
  //                                               fontSize: MediaQuery.of(context)
  //                                                   .size
  //                                                   .height *
  //                                                   0.024)),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ])),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ]),
  //     ),
  //
  //     // First  - Center Docked
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //     floatingActionButton: Container(
  //       height: screenHeight * 0.08, // Outer circle height (adjust as needed)
  //       width: screenHeight * 0.08, // Outer circle width (adjust as needed)
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.white, // Padding color (background ring)
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.all(
  //             screenHeight * 0.008), // Padding inside the outer circle
  //         child: FloatingActionButton(
  //           heroTag: null,
  //           backgroundColor: Color(0xFF126086),
  //           // Button color
  //           onPressed: () {
  //             Navigator.of(context).push(
  //               MaterialPageRoute(
  //                 builder: (BuildContext context) {
  //                   return UploadPrescriptionMain();
  //                 },
  //               ),
  //             );
  //           },
  //           child: Container(
  //             padding: EdgeInsets.all(screenHeight * 0.008),
  //             width: screenHeight * 0.04, // Adjust image width
  //             height: screenHeight * 0.04, // Adjust image height
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: AssetImage(
  //                     'assets/Upload.png'), // Replace with your asset path
  //                 fit: BoxFit.contain,
  //               ),
  //             ),
  //           ),
  //
  //           elevation: 0.0,
  //           shape: CircleBorder(), // Ensures the button remains circular
  //         ),
  //       ),
  //     ),
  //
  //     // Bottom Navigation with another  positioned on the right
  //     bottomNavigationBar: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.2), // Shadow color
  //                 blurRadius: 20, // Spread of the shadow
  //                 offset: Offset(
  //                     0, -4), // Position the shadow above the BottomAppBar
  //               ),
  //             ],
  //           ),
  //           child: Theme(
  //             data: Theme.of(context).copyWith(
  //               splashColor: Colors.transparent, // Remove splash color
  //               highlightColor: Colors.transparent, // Remove highlight color
  //             ),
  //             child: BottomNavigationBar(
  //               type: BottomNavigationBarType
  //                   .fixed,
  //               // Set fixed type for equal spacing
  //               currentIndex: _selectedIndex,
  //               // Track the selected tab
  //               onTap: _onItemTapped,
  //               backgroundColor: Colors.white,
  //               selectedItemColor:
  //               Color(0xFF126086),
  //               // Color for the selected item
  //               unselectedItemColor:
  //               Color(0xFF484C52),
  //               // Color for unselected items
  //               selectedFontSize: MediaQuery
  //                   .of(context)
  //                   .size
  //                   .height *
  //                   0.014,
  //               // Hide the label font for selected items
  //               unselectedFontSize: MediaQuery
  //                   .of(context)
  //                   .size
  //                   .height *
  //                   0.012,
  //               // Hide the label font for unselected items
  //               elevation: 0,
  //               // Disable elevation
  //               items: [
  //                 BottomNavigationBarItem(
  //                   icon: Container(
  //                     padding: EdgeInsets.only(
  //                       left: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       right: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       top: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       bottom: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.005,
  //                     ), // Add padding
  //                     child: Image.asset(
  //                       'assets/Homeactive.png',
  //                       width: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.038,
  //                       height: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.038,
  //                     ),
  //                   ),
  //                   label: 'Home',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Container(
  //                     padding: EdgeInsets.only(
  //                       left: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       right: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       top: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       bottom: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.005,
  //                     ), // Add padding
  //                     child: Image.asset(
  //                       'assets/MyReports.png',
  //                       width: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.034,
  //                       height: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.034,
  //                     ),
  //                   ),
  //                   label: 'My Reports',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Container(
  //                     padding: EdgeInsets.only(
  //                       left: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       right: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       top: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       bottom: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.025,
  //                     ), // Add padding
  //                     child: Image.asset(
  //                       'assets/Appoinments.png',
  //                       width: 0,
  //                       height: 0,
  //                     ),
  //                   ),
  //                   label: 'Upload',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Container(
  //                     padding: EdgeInsets.only(
  //                       left: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       right: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       top: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       bottom: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.005,
  //                     ), // Add padding
  //                     child: Image.asset(
  //                       'assets/Appoinments.png',
  //                       width: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.034,
  //                       height: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.034,
  //                     ),
  //                   ),
  //                   label: 'Appointments',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Container(
  //                     padding: EdgeInsets.only(
  //                       left: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       right: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       top: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.00,
  //                       bottom: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.005,
  //                     ), // Add padding
  //                     child: Image.asset(
  //                       'assets/MyHealth.png',
  //                       width: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.034,
  //                       height: MediaQuery
  //                           .of(context)
  //                           .size
  //                           .height * 0.034,
  //                     ),
  //                   ),
  //                   label: 'My Health',
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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


                        GestureDetector(
                          onTap: () {
                            /* Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) {
                                      return GoogleMapScreen();
                                    },
                                  ),
                                );*/
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
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 0,
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

                      // 1st Expansion Tile
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.015,
                          left: MediaQuery.of(context).size.height * 0.015,
                        ),
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height *
                                  0.01, // Dynamic border radius for top
                            ),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isExpandedtime = !_isExpandedtime;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .white, // Background color (optional)
                                    border: Border(
                                      top: BorderSide(
                                        color: Color(0x24000000), // Top border color
                                        width: 2.0, // Top border thickness
                                      ),
                                      right: BorderSide(
                                        color:
                                        Color(0x24000000),  // Right border color
                                        width: 2.0, // Right border thickness
                                      ),
                                      bottom: BorderSide(
                                        color:
                                        Color(0x24000000), // Bottom border color
                                        width: _isExpandedtime
                                            ? 1.0
                                            : 2.0, // Reduced bottom border thickness on expansion
                                      ),
                                      left: BorderSide(
                                        color: Color(0x24000000),  // Left border color
                                        width: 2.0, // Left border thickness
                                      ),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top left radius
                                      topRight: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top right radius
                                      bottomLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Bottom-left curve radius
                                      bottomRight: Radius.circular(MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.01), // Bottom-right curve radius
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic bottom padding
                                    left: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic left padding
                                    right: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic right padding
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Time",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.014, // Dynamic font size
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        _isExpandedtime
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        size:
                                        MediaQuery.of(context).size.height *
                                            0.02, // Dynamic icon size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_isExpandedtime)
                                Container(
                                  color : Colors.white,
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.0, // Dynamic bottom padding
                                    left: MediaQuery.of(context).size.height *
                                        0.0, // Dynamic left padding
                                    right: MediaQuery.of(context).size.height *
                                        0.0, // Dynamic right padding
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.015,
                                            right: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.015,
                                            bottom: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.016),
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
                                                    right:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.005,
                                                    bottom:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00),
                                                child: Text(
                                                  "Pick Data",
                                                  style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.012,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {},
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      right:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      top:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      bottom:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00),
                                                  child: Text(
                                                    "August 10 2024",
                                                    style: TextStyle(
                                                      color: Color(0xFF126086),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      fontSize:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.012,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),

                                      // 1st row
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          bottom: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.015,
                                          left: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          right: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x1A999999),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "06:00",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x1A999999),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "06:30",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF126086),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "07:00",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                              fontWeight: FontWeight.w400,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x0D13668E),
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(
                                                          color:
                                                          Color(0x4D13668E), // Black border
                                                          width: 1.0, // Set the border width
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "07:30",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0xFF126086),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0xFF126086),
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                              fontWeight: FontWeight.w400,
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

                                      // 2nd row
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          bottom: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.015,
                                          left: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          right: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x0D13668E),
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(
                                                          color:
                                                          Color(0x4D13668E), // Black border
                                                          width: 1.0, // Set the border width
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "08:00",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0xFF126086),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0xFF126086),
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                              fontWeight: FontWeight.w400,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x1A999999),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "06:00",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x0D13668E),
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(
                                                          color:
                                                          Color(0x4D13668E), // Black border
                                                          width: 1.0, // Set the border width
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "07:30",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0xFF126086),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0xFF126086),
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                              fontWeight: FontWeight.w400,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x1A999999),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "06:00",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
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

                                      // 3rd row
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          bottom: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.005,
                                          left: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          right: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x1A999999),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "06:00",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x1A999999),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "06:00",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x1A999999),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "06:00",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0x99333333),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
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
                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                  bottom:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                  left: MediaQuery.of(context).size.height * 0.00,
                                                  right:
                                                  MediaQuery.of(context).size.height * 0.00,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .max, // Ensure the Row takes up the full available width
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height *
                                                          0.045,
                                                      width: MediaQuery.of(context).size.width *
                                                          0.17, // Increase width
                                                      decoration: BoxDecoration(
                                                        color: Color(0x0D13668E),
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(
                                                          color:
                                                          Color(0x4D13668E), // Black border
                                                          width: 1.0, // Set the border width
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .center, // Center the content
                                                        children: <Widget>[
                                                          Text(
                                                            "07:30",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              color: Color(0xFF126086),
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                          SizedBox(height: 0),
                                                          Text(
                                                            "PM",
                                                            style: TextStyle(
                                                              color: Color(0xFF126086),
                                                              fontSize: MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.012,
                                                              fontWeight: FontWeight.w400,
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
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // 2nd Expansion Tile
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.015,
                          left: MediaQuery.of(context).size.height * 0.015,
                        ),
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height *
                                  0.01, // Dynamic border radius for top
                            ),
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _isExpandedlocation = !_isExpandedlocation;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .white, // Background color (optional)
                                    border: Border(
                                      top: BorderSide(
                                        color: Color(0x24000000),  // Top border color
                                        width: 2.0, // Top border thickness
                                      ),
                                      right: BorderSide(
                                        color:
                                        Color(0x24000000),
                                        width: 2.0, // Right border thickness
                                      ),
                                      bottom: BorderSide(
                                        color:
                                        Color(0x24000000),
                                        width: _isExpandedlocation
                                            ? 1.0
                                            : 2.0, // Reduced bottom border thickness on expansion
                                      ),
                                      left: BorderSide(
                                        color: Color(0x24000000),
                                        width: 2.0, // Left border thickness
                                      ),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top left radius
                                      topRight: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Dynamic top right radius
                                      bottomLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01), // Bottom-left curve radius
                                      bottomRight: Radius.circular(MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.01), // Bottom-right curve radius
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic bottom padding
                                    left: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic left padding
                                    right: MediaQuery.of(context).size.height *
                                        0.015, // Dynamic right padding
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Location",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.014, // Dynamic font size
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        _isExpandedlocation
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        size:
                                        MediaQuery.of(context).size.height *
                                            0.02, // Dynamic icon size
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_isExpandedlocation)
                                Container(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic top padding
                                    bottom: MediaQuery.of(context).size.height *
                                        0.0, // Dynamic bottom padding
                                    left: MediaQuery.of(context).size.height *
                                        0.0, // Dynamic left padding
                                    right: MediaQuery.of(context).size.height *
                                        0.0, // Dynamic right padding
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap:
                                    true, // Prevents infinite height
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          elevation: 0.0,
                                          color: Colors.white,
                                          child: Container(
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
                                                    padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      right:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      top:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      bottom:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.01,
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
                                                            child: ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  130.0),
                                                              child:
                                                              Image.asset(
                                                                'assets/Homehomecare.png',
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
                                                                0.02),
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
                                                                  "Home Address",
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                    fontSize: MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                        0.014,
                                                                  ),
                                                                ),
                                                              ),
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
                                                                      0.00,
                                                                  bottom: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.00,
                                                                ),
                                                                child: Text(
                                                                  "65 Mohamed Bin Al Qassim St, Doha, Qatar",
                                                                  style:
                                                                  TextStyle(
                                                                    color: Color(0x99000000),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                          Color(0xFF5F5F5F),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      //
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.015,
                          bottom: MediaQuery.of(context).size.height * 0.016,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Align them to the start
                          children: <Widget>[
                            Icon(
                              Icons.add, // The add icon
                              color: Color(
                                  0xFF126086), // Set the color for the icon
                              size: MediaQuery.of(context).size.height *
                                  0.02, // Set icon size
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.height *
                                    0.005), // Space between the icon and text
                            Container(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                MediaQuery.of(context).size.height * 0.00,
                                top: MediaQuery.of(context).size.height * 0.005,
                                bottom:
                                MediaQuery.of(context).size.height * 0.00,
                              ),
                              child: Text(
                                "Add new Address",
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.01,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Add service button
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (BuildContext context) {
                                return HomePageMain();
                              },
                            ),
                          );
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
                                MediaQuery.of(context).size.height * 0.04,
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                MediaQuery.of(context).size.height * 0.07,
                                left:
                                MediaQuery.of(context).size.height * 0.04),
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
                                                Color(0xFFBDBDBD),
                                                Color(0xFFBDBDBD),
                                              ])),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 0.0),
                                      child: TextButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return HomePageMain();
                                              },
                                            ),
                                          );
                                        },
                                        child: Text("Book Service",
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
                                          padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 12.0), // ← Adjust this
                                          minimumSize: Size(0, 0), // Removes minimum button constraints
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap padding
                                        ),

                                      ),
                                    ),
                                  ),
                                ])),
                      )
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
