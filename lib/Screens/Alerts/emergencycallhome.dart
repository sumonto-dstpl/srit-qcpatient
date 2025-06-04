import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
//
//
// class EmergencyHomeCall {
//   showticket(context) async {
//     await Future.delayed(Duration(microseconds: 1));
//
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     showGeneralDialog(
//       barrierLabel: "EmergencyCallDialog",
//       barrierDismissible: true, // tap outside to dismiss
//       barrierColor: Colors.transparent, // Needed for blur effect
//       transitionDuration: Duration(milliseconds: 200),
//       context: context,
//       pageBuilder: (context, animation, secondaryAnimation) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // blur intensity
//           child: GestureDetector(
//             onTap: () => Navigator.of(context).pop(), // dismiss on tap outside
//             child: Material(
//               type: MaterialType.transparency,
//               child: Center(
//                 child: GestureDetector(
//                   onTap: () {}, // prevent dialog from closing when tapping inside
//                   child: Dialog(
//                   backgroundColor: Colors.transparent,
//                   // backgroundColor : Colors.black12,
//                   insetPadding: EdgeInsets.all(
//                       MediaQuery.of(context).size.height * 0.010),
//                   child:
//
//                   Container(
//                     child: Stack(children: <Widget>[
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.500,
//                         margin: EdgeInsets.all(
//                             MediaQuery.of(context).size.height * 0.00),
//                         padding: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height * 0.060,
//                             left: MediaQuery.of(context).size.height * 0.01,
//                             right: MediaQuery.of(context).size.height * 0.01,
//                             bottom: MediaQuery.of(context).size.height * 0.0),
//                         child: Material(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                           elevation: 5.0,
//                           color: Colors.white,
//                           child: Column(
//                             // mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Expanded(
//                                 child:
//
//                                 // ListView.builder(
//
//                                 ListView(
//                                     shrinkWrap: true,
//                                     children: <Widget>[
//                                       // Container(
//                                       //   decoration: BoxDecoration(
//                                       //     borderRadius:
//                                       //         BorderRadius.circular(10),
//                                       //   ),
//                                       //   padding: EdgeInsets.only(
//                                       //       left: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00,
//                                       //       right: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00,
//                                       //       bottom: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00,
//                                       //       top: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00),
//                                       //   // color: Colors.white,
//                                       //   child: Card(
//                                       //     elevation: 0.0,
//                                       //     color: Colors.white,
//                                       //     // color: Colors.blueGrey[50],
//                                       //     // color:    [Colors.green[400], Colors.green[300]],
//                                       //     child: Container(
//                                       //       // color: Colors.white,
//                                       //
//                                       //       decoration: BoxDecoration(
//                                       //           borderRadius:
//                                       //               BorderRadius.circular(10),
//                                       //           gradient: LinearGradient(
//                                       //               begin:
//                                       //                   Alignment.centerLeft,
//                                       //               end:
//                                       //                   Alignment.centerRight,
//                                       //               stops: [
//                                       //                 0.5,
//                                       //                 0.9
//                                       //               ],
//                                       //               colors: [
//                                       //                 Colors.white,
//                                       //                 Colors.white
//                                       //               ])),
//                                       //       margin: EdgeInsets.only(
//                                       //           left: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.006,
//                                       //           right: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.006,
//                                       //           bottom: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.003,
//                                       //           top: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.003),
//                                       //       padding: EdgeInsets.only(
//                                       //           left: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.005,
//                                       //           right: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.005,
//                                       //           bottom: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.005,
//                                       //           top: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.005),
//                                       //       child: Column(
//                                       //           crossAxisAlignment:
//                                       //               CrossAxisAlignment.start,
//                                       //           children: <Widget>[
//                                       //             Container(
//                                       //               // color: Colors.red,
//                                       //               /* height:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.16,*/
//                                       //               padding: EdgeInsets.only(
//                                       //                   left: MediaQuery.of(
//                                       //                               context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.010,
//                                       //                   right: MediaQuery.of(
//                                       //                               context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.010,
//                                       //                   top: MediaQuery.of(
//                                       //                               context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.030,
//                                       //                   bottom: MediaQuery.of(
//                                       //                               context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.00),
//                                       //               child: Row(
//                                       //                 crossAxisAlignment:
//                                       //                     CrossAxisAlignment
//                                       //                         .center,
//                                       //                 mainAxisAlignment:
//                                       //                     MainAxisAlignment
//                                       //                         .start,
//                                       //                 children: <Widget>[
//                                       //                   Expanded(
//                                       //                     child: Column(
//                                       //                       crossAxisAlignment:
//                                       //                           CrossAxisAlignment
//                                       //                               .center,
//                                       //                       mainAxisAlignment:
//                                       //                           MainAxisAlignment
//                                       //                               .center,
//                                       //                       children: <Widget>[
//                                       //                         Image.asset(
//                                       //                           'assets/ambulancealert.png',
//                                       //                           height: MediaQuery.of(
//                                       //                                       context)
//                                       //                                   .size
//                                       //                                   .height *
//                                       //                               0.10,
//                                       //                           fit: BoxFit
//                                       //                               .fill,
//                                       //                         ),
//                                       //                         Text(
//                                       //                           "Emergency Call",
//                                       //                           style: TextStyle(
//                                       //                               color: Color(
//                                       //                                   0xFFD42620),
//                                       //                               fontWeight:
//                                       //                                   FontWeight
//                                       //                                       .w800,
//                                       //                               fontSize: MediaQuery.of(context)
//                                       //                                       .size
//                                       //                                       .height *
//                                       //                                   0.026),
//                                       //                         ),
//                                       //                         Container(
//                                       //                           padding:
//                                       //                               EdgeInsets
//                                       //                                   .only(
//                                       //                             top: MediaQuery.of(context)
//                                       //                                     .size
//                                       //                                     .height *
//                                       //                                 0.00,
//                                       //                             bottom: MediaQuery.of(context)
//                                       //                                     .size
//                                       //                                     .height *
//                                       //                                 0.02,
//                                       //                             left: MediaQuery.of(context)
//                                       //                                     .size
//                                       //                                     .height *
//                                       //                                 0.00,
//                                       //                             right: MediaQuery.of(context)
//                                       //                                     .size
//                                       //                                     .height *
//                                       //                                 0.00,
//                                       //                           ),
//                                       //                           child: Text(
//                                       //                             "You are about to call ambulance for an emergency. Are you sure you want to proceed?",
//                                       //                             textAlign:
//                                       //                                 TextAlign
//                                       //                                     .center,
//                                       //                             style: TextStyle(
//                                       //                                 color: Colors.black54,
//                                       //                                  fontWeight:
//                                       //                                     FontWeight
//                                       //                                         .w500,
//                                       //                                 fontSize: MediaQuery.of(context).size.height * 0.018),
//                                       //                           ),
//                                       //                         ),
//                                       //                         /*  Text(
//                                       //                           "applicant Successfully",
//                                       //                           style: TextStyle(
//                                       //                               color: Colors
//                                       //                                   .black54,
//                                       //                               fontWeight:
//                                       //                                   FontWeight
//                                       //                                       .bold,
//                                       //                               fontSize: MediaQuery.of(context)
//                                       //                                       .size
//                                       //                                       .height *
//                                       //                                   0.024),
//                                       //                         ),*/
//                                       //                       ],
//                                       //                     ),
//                                       //                   ),
//                                       //
//                                       //                   // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
//                                       //                 ],
//                                       //               ),
//                                       //             ),
//                                       //           ]),
//                                       //     ),
//                                       //   ),
//                                       // ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10),
//                                         ),
//                                         padding: EdgeInsets.zero,
//                                         child: Card(
//                                           elevation: 0.0,
//                                           color: Colors.white,
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(10),
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.centerLeft,
//                                                 end: Alignment.centerRight,
//                                                 stops: [0.5, 0.9],
//                                                 colors: [Colors.white, Colors.white],
//                                               ),
//                                             ),
//                                             margin: EdgeInsets.symmetric(
//                                               horizontal: screenWidth * 0.015,
//                                               vertical: screenHeight * 0.003,
//                                             ),
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: screenWidth * 0.02,
//                                               vertical: screenHeight * 0.005,
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Container(
//                                                   padding: EdgeInsets.only(
//                                                     left: screenWidth * 0.025,
//                                                     right: screenWidth * 0.025,
//                                                     top: screenHeight * 0.03,
//                                                   ),
//                                                   child: Row(
//                                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                                     mainAxisAlignment: MainAxisAlignment.start,
//                                                     children: <Widget>[
//                                                       Expanded(
//                                                         child: Column(
//                                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           children: <Widget>[
//                                                             Image.asset(
//                                                               'assets/ambulancealert.png',
//                                                               height: screenHeight * 0.10,
//                                                               fit: BoxFit.fill,
//                                                             ),
//                                                             Text(
//                                                               "Emergency Call",
//                                                               style: TextStyle(
//                                                                 color: Color(0xFFD42620),
//                                                                 fontWeight: FontWeight.w800,
//                                                                 fontSize: screenHeight * 0.026,
//                                                               ),
//                                                             ),
//                                                             Padding(
//                                                               padding: EdgeInsets.only(
//                                                                 top: screenHeight * 0.00,
//                                                                 bottom: screenHeight * 0.02,
//                                                               ),
//                                                               child: Text(
//                                                                 "You are about to call ambulance for an emergency. Are you sure you want to proceed?",
//                                                                 textAlign: TextAlign.center,
//                                                                 style: TextStyle(
//                                                                   color: Colors.black54,
//                                                                   fontWeight: FontWeight.w500,
//                                                                   fontSize: screenHeight * 0.018,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//
//                                       // Container(
//                                       //   decoration: BoxDecoration(
//                                       //     // color:Colors.white,
//                                       //     borderRadius:
//                                       //         BorderRadius.circular(15),
//                                       //   ),
//                                       //   // color:Colors.green[100],
//                                       //   padding: EdgeInsets.only(
//                                       //       left: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.0,
//                                       //       right: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.0,
//                                       //       top: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00,
//                                       //       bottom: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00),
//                                       //   child: Row(
//                                       //     mainAxisAlignment:
//                                       //         MainAxisAlignment.spaceEvenly,
//                                       //     children: <Widget>[
//                                       //       GestureDetector(
//                                       //         onTap: () async {
//                                       //           Navigator.of(context,
//                                       //                   rootNavigator: true)
//                                       //               .pop();
//                                       //         },
//                                       //         child: Container(
//                                       //           height: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.050,
//                                       //           width: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.130,
//                                       //           padding: new EdgeInsets.only(
//                                       //               left:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.015,
//                                       //               right:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.015,
//                                       //               top:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.01,
//                                       //               bottom:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.01),
//                                       //           decoration: BoxDecoration(
//                                       //             // color: Colors.grey[300],
//                                       //             borderRadius:
//                                       //                 BorderRadius.circular(
//                                       //                     8),
//                                       //             border: Border.all(
//                                       //               color: Color(
//                                       //                   0xFF126086), // Border color
//                                       //               width: 1, // Border width
//                                       //             ),
//                                       //           ),
//                                       //
//                                       //           margin: EdgeInsets.only(
//                                       //             left: MediaQuery.of(context)
//                                       //                     .size
//                                       //                     .height *
//                                       //                 0.00,
//                                       //             top: MediaQuery.of(context)
//                                       //                     .size
//                                       //                     .height *
//                                       //                 0.00,
//                                       //             bottom:
//                                       //                 MediaQuery.of(context)
//                                       //                         .size
//                                       //                         .height *
//                                       //                     0.00,
//                                       //             right:
//                                       //                 MediaQuery.of(context)
//                                       //                         .size
//                                       //                         .height *
//                                       //                     0.01,
//                                       //           ),
//                                       //           // color: Colors.grey[300],
//                                       //           alignment: Alignment.center,
//                                       //           // height:
//                                       //           // MediaQuery.of(context).size.height * 0.070,
//                                       //           child: Text("Close",
//                                       //               textAlign:
//                                       //                   TextAlign.center,
//                                       //               style: TextStyle(
//                                       //                   color: Colors.black,
//                                       //                   fontWeight:
//                                       //                       FontWeight.bold,
//                                       //                   fontSize: MediaQuery.of(
//                                       //                               context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.015)),
//                                       //         ),
//                                       //       ),
//                                       //       GestureDetector(
//                                       //         onTap: () async {
//                                       //           // Navigator.of(context,
//                                       //           //         rootNavigator: true)
//                                       //           //     .pop();
//                                       //           _makePhoneCall('1234567890');
//                                       //
//                                       //         },
//                                       //         child: Container(
//                                       //           height: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.050,
//                                       //           width: MediaQuery.of(context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.131,
//                                       //           padding: new EdgeInsets.only(
//                                       //               left:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.015,
//                                       //               right:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.015,
//                                       //               top:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.01,
//                                       //               bottom:
//                                       //                   MediaQuery.of(context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.01),
//                                       //           decoration: BoxDecoration(
//                                       //             color: Color(0xFFD42620),
//                                       //             borderRadius:
//                                       //                 BorderRadius.circular(
//                                       //                     8),
//                                       //           ),
//                                       //
//                                       //           margin: EdgeInsets.only(
//                                       //             left: MediaQuery.of(context)
//                                       //                     .size
//                                       //                     .height *
//                                       //                 0.00,
//                                       //             top: MediaQuery.of(context)
//                                       //                     .size
//                                       //                     .height *
//                                       //                 0.00,
//                                       //             bottom:
//                                       //                 MediaQuery.of(context)
//                                       //                         .size
//                                       //                         .height *
//                                       //                     0.00,
//                                       //             right:
//                                       //                 MediaQuery.of(context)
//                                       //                         .size
//                                       //                         .height *
//                                       //                     0.005,
//                                       //           ),
//                                       //           // color: Colors.grey[300],
//                                       //           alignment: Alignment.center,
//                                       //           // height:
//                                       //           // MediaQuery.of(context).size.height * 0.070,
//                                       //           child: Text("Call Now",
//                                       //               textAlign:
//                                       //                   TextAlign.center,
//                                       //               style: TextStyle(
//                                       //                   color: Colors.white,
//                                       //                   fontWeight:
//                                       //                       FontWeight.bold,
//                                       //                   fontSize: MediaQuery.of(
//                                       //                               context)
//                                       //                           .size
//                                       //                           .height *
//                                       //                       0.018)),
//                                       //         ),
//                                       //       ),
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(15),
//                                         ),
//                                         padding: EdgeInsets.zero,
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: <Widget>[
//                                             // Close Button
//                                             GestureDetector(
//                                               onTap: () async {
//                                                 Navigator.of(context, rootNavigator: true).pop();
//                                               },
//                                               child: Container(
//                                                 height: screenHeight * 0.050,
//                                                 width: screenHeight * 0.130,
//                                                 padding: EdgeInsets.symmetric(
//                                                   vertical: screenHeight * 0.01,
//                                                   horizontal: screenWidth * 0.03,
//                                                 ),
//                                                 margin: EdgeInsets.only(
//                                                   right: screenWidth * 0.01,
//                                                 ),
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                     color: Color(0xFF126086),
//                                                     width: 1,
//                                                   ),
//                                                 ),
//                                                 child: Text(
//                                                   "Close",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: screenHeight * 0.015,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//
//                                             // Call Now Button
//                                             GestureDetector(
//                                               onTap: () async {
//                                                 _makePhoneCall('1234567890');
//                                               },
//                                               child: Container(
//                                                 height: screenHeight * 0.050,
//                                                 width: screenHeight * 0.131,
//                                                 padding: EdgeInsets.symmetric(
//                                                   vertical: screenHeight * 0.01,
//                                                   horizontal: screenWidth * 0.03,
//                                                 ),
//                                                 margin: EdgeInsets.only(
//                                                   right: screenWidth * 0.005,
//                                                 ),
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                   color: Color(0xFFD42620),
//                                                   borderRadius: BorderRadius.circular(8),
//                                                 ),
//                                                 child: Text(
//                                                   "Call Now",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: screenHeight * 0.018,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//
//                                       // Container(
//                                       //   padding: EdgeInsets.only(
//                                       //       left: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00,
//                                       //       right: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00,
//                                       //       bottom: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.00,
//                                       //       top: MediaQuery.of(context)
//                                       //               .size
//                                       //               .height *
//                                       //           0.03),
//                                       //   child: Row(
//                                       //     mainAxisAlignment:
//                                       //         MainAxisAlignment.center,
//                                       //     children: <Widget>[
//                                       //       Text(
//                                       //         "*",
//                                       //         style: TextStyle(
//                                       //           fontSize: MediaQuery.of(
//                                       //                       context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.02, // Adjust size based on screen height
//                                       //           color: Colors
//                                       //               .red, // Color of the asterisk
//                                       //         ),
//                                       //       ),
//                                       //       Text(
//                                       //         " This service might be Chargeable",
//                                       //         style: TextStyle(
//                                       //           fontSize: MediaQuery.of(
//                                       //                       context)
//                                       //                   .size
//                                       //                   .height *
//                                       //               0.016, // Adjust size based on screen height
//                                       //           color: Colors
//                                       //               .black54, // Color of the text
//                                       //         ),
//                                       //       ),
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                       Container(
//                                         padding: EdgeInsets.only(
//                                           left: 0,
//                                           right: 0,
//                                           bottom: 0,
//                                           top: screenHeight * 0.03,
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: <Widget>[
//                                             Text(
//                                               "*",
//                                               style: TextStyle(
//                                                 fontSize: screenHeight * 0.02,
//                                                 color: Colors.red,
//                                               ),
//                                             ),
//                                             Text(
//                                               " This service might be Chargeable",
//                                               style: TextStyle(
//                                                 fontSize: screenHeight * 0.016,
//                                                 color: Colors.black54,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//
//                                     ]),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ]),
//                   )
//                 /* ),
//                     ),*/
//
//                 // ),
//               ),
//             ),
//             ),
//             ),
//             ),
//             );
//           },
//           );
//   }
//
//   void _makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     if (await canLaunchUrl(launchUri)) {
//       await launchUrl(launchUri);
//     } else {
//       // Show error message or fallback UI
//       print("Cannot make phone call");
//     }
//   }
// }

class EmergencyHomeCall {
  showticket(context) async {
    await Future.delayed(Duration(microseconds: 1));

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    showGeneralDialog(
      barrierLabel: "EmergencyCallDialog",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent tap-through
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.all(screenHeight * 0.015),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: screenHeight * 0.9,
                        maxWidth: screenWidth * 0.95,
                      ),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5.0,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(), // Prevents scrolling
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 🔻 Emergency Info Card
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.015,
                                  vertical: screenHeight * 0.003,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.005,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/ambulancealert.png',
                                      height: screenHeight * 0.10,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(height: screenHeight * 0.015),
                                    Text(
                                      "Emergency Call",
                                      style: TextStyle(
                                        color: Color(0xFFD42620),
                                        fontWeight: FontWeight.w800,
                                        fontSize: screenHeight * 0.026,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.02,
                                        top: screenHeight * 0.02,
                                      ),
                                      child: Text(
                                        "You are about to call ambulance for an emergency. Are you sure you want to proceed?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: screenHeight * 0.018,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 🔻 Action Buttons (Add your continue button here too)
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: screenHeight * 0.015),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: screenHeight * 0.050,
                                        width: screenHeight * 0.130,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color(0xFFA8B1CE),
                                            width: 1,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.01,
                                          horizontal: screenWidth * 0.03,
                                        ),
                                        margin: EdgeInsets.only(
                                          right: screenWidth * 0.01,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Close",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: screenHeight * 0.016,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _makePhoneCall('1234567890');
                                      },
                                      child: Container(
                                        height: screenHeight * 0.050,
                                        width: screenHeight * 0.131,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFD42620),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.01,
                                          horizontal: screenWidth * 0.03,
                                        ),
                                        margin: EdgeInsets.only(
                                          right: screenWidth * 0.005,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Call Now",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenHeight * 0.018,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 🔻 Optional: Third container
                              Padding(
                                padding: EdgeInsets.only(top: screenHeight * 0.01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "*",
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.02,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      " This service might be Chargeable",
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.016,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

void _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    // Show error message or fallback UI
    print("Cannot make phone call");
  }
}
}