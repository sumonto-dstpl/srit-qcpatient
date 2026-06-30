import 'dart:convert';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/finddoctorslist.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithdata.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/HomeCare/diagnosticmain.dart';
import 'package:newfolder/Screens/HomeCare/doctorhcmain.dart';
import 'package:newfolder/Screens/HomeCare/homecaremain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Medications/medicationselecttime.dart';
import 'package:newfolder/Screens/Medications/medicationsmybook.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/PaymentHistory/paymenthistory.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Widgets/tab_item.dart';
import 'package:newfolder/utils/UploadBoxExpanded.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';

class ProfileMyUploadMain extends StatefulWidget {
  int selectedIndex = 0;

  ProfileMyUploadMain({
    super.key,
  });

  @override
  State<ProfileMyUploadMain> createState() => ProfileMyUploadMainstate();
}

class ProfileMyUploadMainstate extends State<ProfileMyUploadMain> {
  String usernameValue = "My Uploads";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final List<String> uploadfilestime = [
    "Now",
    "15 min ago",
  ];

  List<Map<String, dynamic>> selectedFiles = [];

  void handleFilesChanged(List<Map<String, dynamic>> files) {
    setState(() {
      selectedFiles = files;
    });
    print("📂 Updated files count: ${files.length}");
  }




  TextEditingController? reviewtextcontroller = TextEditingController();
  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          /*decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color(0xFF126086),
                Color(0xFF126086),
                Color(0xFF126086),
              ],
            ),
          ),*/

          decoration: const BoxDecoration(
            image: DecorationImage(
              // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
              image: AssetImage("assets/Background Pattern.png"),
              fit: BoxFit.cover, // Adjusts how the image fills the container
            ),
          ),

          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  // Top Section
                  Header(userName: usernameValue, showProfile: false,),

                  // Main Content Section
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.height * 0.03),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.height * 0.03),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          // Container(
                          //   width: double.infinity,
                          //   height : MediaQuery.of(context).size.height * 0.32,
                          //   margin: EdgeInsets.only(
                          //     top: MediaQuery.of(context).size.height * 0.03,
                          //     bottom: MediaQuery.of(context).size.height * 0.0,
                          //     right: MediaQuery.of(context).size.height * 0.00,
                          //     left: MediaQuery.of(context).size.height * 0.0,
                          //   ),
                          //   padding: EdgeInsets.only(
                          //     top: MediaQuery.of(context).size.height * 0.0,
                          //     bottom: MediaQuery.of(context).size.height * 0.0,
                          //     right: MediaQuery.of(context).size.height * 0.020,
                          //     left: MediaQuery.of(context).size.height * 0.02,
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
                          //                     0.07,
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
                          //                       fontWeight: FontWeight.w600,
                          //                       color: Color(0xFF1F1F1F),
                          //                       fontSize: MediaQuery.of(context)
                          //                           .size
                          //                           .height *
                          //                           0.014
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
                          //                         0.07),
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
                          //
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
                          //     shrinkWrap:
                          //     true, // Prevents infinite height
                          //     physics: NeverScrollableScrollPhysics(),
                          //     itemCount: uploadfilestime.length,
                          //     itemBuilder: (context, index) {
                          //
                          //
                          //       final file = uploadfilestime[index];
                          //
                          //       return
                          //
                          //         Dismissible(
                          //             key: Key(file), // Unique key for each item
                          //             direction: DismissDirection.endToStart, // Allow swipe from right to left
                          //             background: Container(
                          //               color: Colors.white,
                          //               alignment: Alignment.centerRight,
                          //               padding: EdgeInsets.symmetric(horizontal: 20),
                          //               child: Icon(
                          //                 Icons.delete,
                          //                 color: Colors.red,
                          //               ),
                          //             ),
                          //             onDismissed: (direction) {
                          //               // Remove the item immediately from the list
                          //               setState(() {
                          //                 uploadfilestime.removeAt(index);
                          //               });
                          //
                          //
                          //             },
                          //             child:
                          //
                          //             GestureDetector(
                          //               onTap: () {},
                          //               child: Card(
                          //                 elevation: 0.0,
                          //                 color: Colors.white,
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                     color: Colors.white, // Background color of the container
                          //                     border: Border.all(
                          //                       color: Colors.black.withOpacity(0.1), // Border color
                          //                       width: 1, // Border width
                          //                     ),
                          //                     borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
                          //                   ),
                          //
                          //                   padding: EdgeInsets.only(
                          //                       left: MediaQuery.of(context)
                          //                           .size
                          //                           .height *
                          //                           0.00,
                          //                       right: MediaQuery.of(context)
                          //                           .size
                          //                           .height *
                          //                           0.00,
                          //                       bottom: MediaQuery.of(context)
                          //                           .size
                          //                           .height *
                          //                           0.0,
                          //                       top: MediaQuery.of(context)
                          //                           .size
                          //                           .height *
                          //                           0.00),
                          //                   // color: Colors.white,
                          //                   child: Container(
                          //                     // color: Colors.white,
                          //
                          //                     decoration: BoxDecoration(
                          //                         borderRadius:
                          //                         BorderRadius.circular(10),
                          //                         gradient: LinearGradient(
                          //                             begin:
                          //                             Alignment.centerLeft,
                          //                             end:
                          //                             Alignment.centerRight,
                          //                             stops: [
                          //                               0.5,
                          //                               0.9
                          //                             ],
                          //                             colors: [
                          //                               Color(0xFFffffff),
                          //                               Color(0xFFffffff)
                          //                             ])),
                          //                     margin: EdgeInsets.only(
                          //                         left: MediaQuery.of(context)
                          //                             .size
                          //                             .height *
                          //                             0.00,
                          //                         right: MediaQuery.of(context)
                          //                             .size
                          //                             .height *
                          //                             0.00,
                          //                         bottom: MediaQuery.of(context)
                          //                             .size
                          //                             .height *
                          //                             0.00,
                          //                         top: MediaQuery.of(context)
                          //                             .size
                          //                             .height *
                          //                             0.00),
                          //                     padding: EdgeInsets.only(
                          //                         left: MediaQuery.of(context)
                          //                             .size
                          //                             .height *
                          //                             0.005,
                          //                         right: MediaQuery.of(context)
                          //                             .size
                          //                             .height *
                          //                             0.005,
                          //                         bottom: MediaQuery.of(context)
                          //                             .size
                          //                             .height *
                          //                             0.005,
                          //                         top: MediaQuery.of(context)
                          //                             .size
                          //                             .height *
                          //                             0.005),
                          //                     child: Column(
                          //                       crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                       children: <Widget>[
                          //                         Container(
                          //                           padding: EdgeInsets.only(
                          //                             left:
                          //                             MediaQuery.of(context)
                          //                                 .size
                          //                                 .height *
                          //                                 0.005,
                          //                             right:
                          //                             MediaQuery.of(context)
                          //                                 .size
                          //                                 .height *
                          //                                 0.005,
                          //                             top:
                          //                             MediaQuery.of(context)
                          //                                 .size
                          //                                 .height *
                          //                                 0.00,
                          //                             bottom:
                          //                             MediaQuery.of(context)
                          //                                 .size
                          //                                 .height *
                          //                                 0.00,
                          //                           ),
                          //                           child: Row(
                          //                             crossAxisAlignment:
                          //                             CrossAxisAlignment
                          //                                 .center,
                          //                             mainAxisAlignment:
                          //                             MainAxisAlignment
                          //                                 .start,
                          //                             children: <Widget>[
                          //                               Container(
                          //                                 height : screenHeight * 0.06,
                          //                                 width : screenHeight * 0.06,
                          //                                 padding:
                          //                                 EdgeInsets.only(
                          //                                   left: MediaQuery.of(
                          //                                       context)
                          //                                       .size
                          //                                       .height *
                          //                                       0.00,
                          //                                 ),
                          //                                 margin: EdgeInsets.only(
                          //                                   left: screenHeight * 0.01,
                          //                                   top: screenHeight * 0.005,
                          //                                   bottom: screenHeight * 0.005,
                          //                                   right: screenHeight * 0.01,
                          //                                 ),
                          //                                 child: ClipRRect(
                          //                                   borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(
                          //                                       130.0),
                          //                                   child:
                          //                                   Image.asset(
                          //                                     'assets/medicationjpg.png',
                          //                                     fit:
                          //                                     BoxFit.fill,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                               SizedBox(
                          //                                   width: MediaQuery.of(
                          //                                       context)
                          //                                       .size
                          //                                       .height *
                          //                                       0.010),
                          //                               Expanded(
                          //                                 flex: 6,
                          //                                 child: Column(
                          //                                   crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                                   mainAxisAlignment:
                          //                                   MainAxisAlignment
                          //                                       .center,
                          //                                   children: <Widget>[
                          //                                     Container(
                          //                                       padding:
                          //                                       EdgeInsets
                          //                                           .only(
                          //                                         left: MediaQuery.of(
                          //                                             context)
                          //                                             .size
                          //                                             .height *
                          //                                             0.00,
                          //                                         right: MediaQuery.of(
                          //                                             context)
                          //                                             .size
                          //                                             .height *
                          //                                             0.00,
                          //                                         top: MediaQuery.of(
                          //                                             context)
                          //                                             .size
                          //                                             .height *
                          //                                             0.0,
                          //                                         bottom: MediaQuery.of(
                          //                                             context)
                          //                                             .size
                          //                                             .height *
                          //                                             0.00,
                          //                                       ),
                          //                                       child: Text(
                          //                                         "Prescription_1.jpg",
                          //                                         style:
                          //                                         TextStyle(
                          //                                           color: Colors
                          //                                               .black87,
                          //                                           overflow:
                          //                                           TextOverflow
                          //                                               .ellipsis,
                          //                                           fontWeight:
                          //                                           FontWeight
                          //                                               .bold,
                          //                                           fontSize: MediaQuery.of(context)
                          //                                               .size
                          //                                               .height *
                          //                                               0.014,
                          //                                         ),
                          //                                       ),
                          //                                     ),
                          //                                     Container(
                          //                                       padding:
                          //                                       EdgeInsets
                          //                                           .only(
                          //                                         left: MediaQuery.of(
                          //                                             context)
                          //                                             .size
                          //                                             .height *
                          //                                             0.00,
                          //                                         right: MediaQuery.of(
                          //                                             context)
                          //                                             .size
                          //                                             .height *
                          //                                             0.00,
                          //                                         top: MediaQuery.of(
                          //                                             context)
                          //                                             .size
                          //                                             .height *
                          //                                             0.00,
                          //                                         bottom: MediaQuery.of(
                          //                                             context)
                          //                                             .size
                          //                                             .height *
                          //                                             0.00,
                          //                                       ),
                          //                                       child: Text(
                          //                                         "5 Mb",
                          //                                         style:
                          //                                         TextStyle(
                          //                                           color: Colors
                          //                                               .black54,
                          //                                           fontWeight:
                          //                                           FontWeight
                          //                                               .bold,
                          //                                           overflow:
                          //                                           TextOverflow
                          //                                               .ellipsis,
                          //                                           fontSize: MediaQuery.of(context)
                          //                                               .size
                          //                                               .height *
                          //                                               0.012,
                          //                                         ),
                          //                                       ),
                          //                                     ),
                          //                                   ],
                          //                                 ),
                          //                               ),
                          //                               Container(
                          //                                 margin: EdgeInsets.only(
                          //
                          //                                 right: screenHeight * 0.01,
                          //                               ),
                          //                                 child: Text(
                          //                                   uploadfilestime[index],
                          //                                   style: TextStyle(
                          //                                     fontSize: screenHeight * 0.011,
                          //                                     color: Color(0xFF126086),
                          //                                     fontWeight: FontWeight.w500,
                          //                                   ),
                          //                                 ),
                          //                               )
                          //
                          //
                          //
                          //
                          //                             ],
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             )
                          //
                          //         );
                          //     },
                          //   ),
                          // ),

                          UploadBoxExpanded(onFilesChanged: handleFilesChanged),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  CustomFloatingActionButton(),
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
      ),
    );
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
}
