

import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/Appointments/mybockingsmain.dart';
import 'package:newfolder/Screens/HRecommendedDoctors/home_selecttimeslot.dart';
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
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Widgets/tab_item.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
import 'dart:async';


class AppointmentsFootMain extends StatefulWidget {
  int selectedIndex = 3;

  AppointmentsFootMain({
    super.key,
  });

  @override
  State<AppointmentsFootMain> createState() => AppointmentsFootMainstate();
}

class AppointmentsFootMainstate extends State<AppointmentsFootMain> {
  String usernameValue = "My appointments";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 3;
  final mytopspecialities = [
    ["assets/Diagnostic.png", "Diagnostic"],
    ["assets/Doctor.png", "Doctor"],
    ["assets/Nurse.png", "Nurse"],
    ["assets/Physio.png", "Physio"],
    ["assets/MedicalEquipment.png", "Medical Equipment's"],
  ];
  final List<String> uploadfilestime = [
    "Now",
    "15 min ago",
    "24 hours ago",
  ];

  List<String> activePrescriptions = [
    "Active Prescription 1",
    "Active Prescription 2",
    "Active Prescription 3"
  ];
  List<String> previousPrescriptions = [
    "Previous Prescription 1",
    "Previous Prescription 2",
    "Previous Prescription 3"
  ];

  final myspecialities = [
    ["assets/Hematology.png", "Hematology"],
    ["assets/Oncology.png", "Oncology"],
    ["assets/OrganTransplant.png", "Organ Transplant"],
    ["assets/SupportSpecialties.png", "Support Specialties"],
  ];

  bool _isExpandeduploadedfiles = true;


  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  bool _isLoading = true;
  double rating = 3;

  @override
  void initState() {

    super.initState();

    checkGuestUser();
  }

  void checkGuestUser() async {
    final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";
    if (isLoggedIn == "YES") {
      Timer(Duration(seconds: 0), () {
        LoginBottomSheet.show(context,true);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    TextEditingController SearchEditTextController = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          width: double.infinity,
         /* decoration: const BoxDecoration(
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
                  Container(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.055,
                      left: screenWidth * 0.045,
                      right: screenWidth * 0.02,
                      bottom: screenWidth * 0.02,
                    ),
                    margin: EdgeInsets.only(
                      right: screenHeight * 0.0,
                      top: screenHeight * 0.01,
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

                        Padding(
                          padding: EdgeInsets.only(left : MediaQuery.of(context).size.height * 0.00),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top:
                                  MediaQuery.of(context).size.height * 0.00,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.00,
                                  left:
                                  MediaQuery.of(context).size.height * 0.00,
                                  right:
                                  MediaQuery.of(context).size.height * 0.00,
                                ),
                                child: Text(
                                  usernameValue,
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.018,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

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
                      padding: EdgeInsets.zero,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.03),
                          topRight: Radius.circular(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.03),
                        ),
                      ),
                      child: Column(
                        children: [
                          // TabBar Section
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       left: MediaQuery
                          //           .of(context)
                          //           .size
                          //           .height * 0.02,
                          //       right:
                          //       MediaQuery
                          //           .of(context)
                          //           .size
                          //           .height * 0.02,
                          //       bottom:
                          //       MediaQuery
                          //           .of(context)
                          //           .size
                          //           .height * 0.00,
                          //       top: MediaQuery
                          //           .of(context)
                          //           .size
                          //           .height * 0.03),
                          //   height: MediaQuery
                          //       .of(context)
                          //       .size
                          //       .height * 0.045,
                          //   decoration: BoxDecoration(
                          //     borderRadius:
                          //     const BorderRadius.all(Radius.circular(10)),
                          //     color: Color(0xFFA8B1CE).withOpacity(0.4),
                          //     border: Border.all(
                          //       // Add a red border
                          //       color: Color(0xFFD9D9D9).withOpacity(
                          //           0.4), // Red color for the border
                          //       width: 2, // Border width
                          //     ),
                          //   ),
                          //   child: TabBar(
                          //     indicatorSize: TabBarIndicatorSize.tab,
                          //     dividerColor: Colors.transparent,
                          //     indicator: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius:
                          //       BorderRadius.all(Radius.circular(10)),
                          //     ),
                          //     labelColor: Color(0xFF126086),
                          //     labelStyle: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: MediaQuery
                          //             .of(context)
                          //             .size
                          //             .height *
                          //             0.014),
                          //     unselectedLabelColor: Colors.black,
                          //     unselectedLabelStyle:
                          //     TextStyle(fontWeight: FontWeight.w500),
                          //     tabs: [
                          //       Tab(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text(
                          //               "Past Appointments",
                          //               overflow: TextOverflow.ellipsis,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Tab(
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text(
                          //               "Upcoming Appointments",
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // TabBarView Section
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.04,
                                right:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.04,
                                bottom:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.015,
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.045,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                              color: Color(0x66D9D9D9).withOpacity(0.4),
                              border: Border.all(
                                // Add a red border
                                color: Color(0x66D9D9D9),// Red color for the border
                                width: 1, // Border width
                              ),
                            ),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              dividerColor: Colors.transparent,
                              indicator: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              labelColor: Color(0xFF126086),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.013),
                              unselectedLabelColor: Colors.black,
                              unselectedLabelStyle:
                              TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.013
                              ),
                              tabs: [
                                Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Past Appoinments",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Upcoming Appoinments",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Past Appointments
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery
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
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.00,
                                      bottom:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.00),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                      Radius.circular(screenHeight * 0.03),
                                      topRight:
                                      Radius.circular(screenHeight * 0.03),
                                    ),
                                  ),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [


                                      // Doctors
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // Provide a width constraint using SizedBox or Expanded
                                          Container(
                                            margin: EdgeInsets.only(
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
                                                    0.010,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.01),
                                            // height: MediaQuery.of(context).size.height * 0.190,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                              ScrollPhysics(),
                                              // Ensures scrolling
                                              shrinkWrap:
                                              true,
                                              // Prevents ListView from taking up extra space
                                              scrollDirection: Axis
                                                  .vertical,
                                              // Makes the ListView horizontal
                                              itemCount:
                                              3,
                                              // You can adjust the item count
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.00,
                                                        right: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.00,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.00,
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.00),
                                                    color: Colors.white,
                          //                           child: Card(
                          //                             elevation: 0,
                          //                             color: Colors.white,
                          //                             // color: Colors.blueGrey[50],
                          //                             // color:    [Colors.green[400], Colors.green[300]],
                          //                             child:
                          //                             Container(
                          //                               // color: Colors.white,
                          //
                          //                               decoration: BoxDecoration(
                          //                                   borderRadius: BorderRadius.circular(10),
                          //                                   gradient: LinearGradient(
                          //                                       begin: Alignment.centerLeft,
                          //                                       end: Alignment.centerRight,
                          //                                       stops: [0.5, 0.9],
                          //                                       colors: [
                          //                                         Color(0xFFE8F0F3),
                          //                                         Color(0xFFE8F0F3)
                          //                                       ])),
                          //                               margin: EdgeInsets.only(
                          //                                   left: MediaQuery
                          //                                       .of(context)
                          //                                       .size
                          //                                       .height * 0.006,
                          //                                   right: MediaQuery
                          //                                       .of(context)
                          //                                       .size
                          //                                       .height * 0.006,
                          //                                   bottom: MediaQuery
                          //                                       .of(context)
                          //                                       .size
                          //                                       .height * 0.003,
                          //                                   top: MediaQuery
                          //                                       .of(context)
                          //                                       .size
                          //                                       .height * 0.003),
                          //                               padding: EdgeInsets.only(
                          //                                   left: MediaQuery
                          //                                       .of(context)
                          //                                       .size
                          //                                       .height * 0.005,
                          //                                   right: MediaQuery
                          //                                       .of(context)
                          //                                       .size
                          //                                       .height * 0.005,
                          //                                   bottom: MediaQuery
                          //                                       .of(context)
                          //                                       .size
                          //                                       .height * 0.005,
                          //                                   top: MediaQuery
                          //                                       .of(context)
                          //                                       .size
                          //                                       .height * 0.005),
                          //                               child: Column(
                          //                                   crossAxisAlignment: CrossAxisAlignment
                          //                                       .start,
                          //                                   children: <Widget>[
                          //
                          //
                          //                                     Container(
                          //                                       // color: Colors.red,
                          //                                       // height: MediaQuery.of(context).size.height * 0.12,
                          //                                       padding: EdgeInsets.only(
                          //                                           left: MediaQuery
                          //                                               .of(context)
                          //                                               .size
                          //                                               .height * 0.005,
                          //                                           right: MediaQuery
                          //                                               .of(context)
                          //                                               .size
                          //                                               .height * 0.005,
                          //                                           top: MediaQuery
                          //                                               .of(context)
                          //                                               .size
                          //                                               .height * 0.00,
                          //                                           bottom: MediaQuery
                          //                                               .of(context)
                          //                                               .size
                          //                                               .height * 0.00),
                          //                                       // width: double.infinity,
                          //                                       // height: SizeConfig.blockSizeVertical * 15,
                          //                                       /* decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(
                          //       MediaQuery.of(context).size.height * 0.045),
                          //      color: Colors.blueGrey[50],
                          //   border: Border.all(
                          //     color: Colors.blueGrey[50]!,
                          //     width: MediaQuery.of(context).size.height * 0.001,
                          //   ),
                          // ),*/
                          //                                       /*  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),*/
                          //                                       child: Row(
                          //                                         crossAxisAlignment: CrossAxisAlignment
                          //                                             .center,
                          //                                         mainAxisAlignment: MainAxisAlignment
                          //                                             .start,
                          //                                         children: <Widget>[
                          //                                           Expanded(
                          //                                             flex: 2,
                          //                                             child:
                          //                                             Container(
                          //
                          //                                               padding: EdgeInsets.only(
                          //                                                 left:
                          //                                                 MediaQuery
                          //                                                     .of(context)
                          //                                                     .size
                          //                                                     .height * 0.00,
                          //                                               ),
                          //
                          //                                               child: ClipRRect(
                          //                                                 borderRadius: BorderRadius
                          //                                                     .circular(130.0),
                          //                                                 child: Image.asset(
                          //                                                   'assets/drsujeet.png',
                          //                                                   fit: BoxFit.fill,
                          //                                                 ),
                          //                                               ),
                          //                                             ),
                          //
                          //
                          //                                             // with Custom circle around img
                          //                                             /*    CircleAvatar(
                          //       minRadius: MediaQuery.of(context).size.height * 0.082,
                          //       backgroundColor: Colors.blue,
                          //       child:
                          //       FinalProfileimageURI == null ?
                          //       Image.asset('assets/ic_profile_edit.png',
                          //         height: MediaQuery.of(context).size.height * 0.10,
                          //         width: MediaQuery.of(context).size.height * 0.10,) :
                          //       new CircleAvatar(backgroundImage: new FileImage(FinalProfileimageURI!), radius: MediaQuery.of(context).size.height * 0.05),
                          //     ),*/
                          //
                          //
                          //                                           ),
                          //
                          //                                           SizedBox(
                          //                                               width: MediaQuery
                          //                                                   .of(context)
                          //                                                   .size
                          //                                                   .height *
                          //                                                   0.010),
                          //
                          //                                           Expanded(
                          //                                             flex: 8,
                          //                                             child: Column(
                          //                                               crossAxisAlignment: CrossAxisAlignment
                          //                                                   .start,
                          //                                               mainAxisAlignment: MainAxisAlignment
                          //                                                   .center,
                          //                                               children: <Widget>[
                          //
                          //
                          //                                                 Container(
                          //
                          //                                                   padding: EdgeInsets.only(
                          //                                                       left: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.00,
                          //                                                       right: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.00,
                          //                                                       top: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.00,
                          //                                                       bottom: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.00),
                          //                                                   child:
                          //                                                   Text(
                          //                                                     "Dr. Sujeet Kumar",
                          //                                                     style: TextStyle(
                          //                                                         color: Colors.black87,
                          //                                                         fontWeight: FontWeight
                          //                                                             .bold,
                          //                                                         fontSize: MediaQuery
                          //                                                             .of(context)
                          //                                                             .size
                          //                                                             .height *
                          //                                                             0.016),
                          //                                                   ),
                          //                                                 ),
                          //
                          //
                          //
                          //
                          //                                                 Container(
                          //
                          //                                                   padding: EdgeInsets.only(
                          //                                                       left: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.00,
                          //                                                       right: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.00,
                          //                                                       top: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.00,
                          //                                                       bottom: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.005),
                          //                                                   child:
                          //                                                   Text(
                          //                                                     "Therapist",
                          //                                                     style: TextStyle(
                          //                                                         color: Colors.black87,
                          //                                                         fontWeight: FontWeight
                          //                                                             .bold,
                          //                                                         overflow: TextOverflow
                          //                                                             .ellipsis,
                          //                                                         fontSize: MediaQuery
                          //                                                             .of(context)
                          //                                                             .size
                          //                                                             .height *
                          //                                                             0.014),
                          //                                                   ),
                          //                                                 ),
                          //
                          //                                                 Container(
                          //
                          //                                                   decoration: BoxDecoration(
                          //                                                     color: Colors.white,
                          //                                                     borderRadius: BorderRadius
                          //                                                         .circular(16),
                          //                                                   ),
                          //
                          //                                                   padding: EdgeInsets.only(
                          //                                                       left: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.001,
                          //                                                       right: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.001,
                          //                                                       top: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.001,
                          //                                                       bottom: MediaQuery
                          //                                                           .of(context)
                          //                                                           .size
                          //                                                           .height * 0.00),
                          //                                                   child:
                          //                                                   RatingBar(
                          //                                                     initialRating: 1,
                          //                                                     direction: Axis
                          //                                                         .horizontal,
                          //                                                     allowHalfRating: true,
                          //                                                     itemCount: 5,
                          //                                                     itemSize: MediaQuery.of(context).size.height * 0.02,
                          //                                                     ratingWidget: RatingWidget(
                          //                                                       full: Icon(
                          //                                                         Icons
                          //                                                             .star_rate_rounded,
                          //                                                         color: Color(
                          //                                                             0xFFFFD700),
                          //                                                       ),
                          //                                                       half: Icon(
                          //                                                         Icons
                          //                                                             .star_half_rounded,
                          //                                                         color: Color(
                          //                                                             0xFFFFD700),
                          //                                                       ),
                          //                                                       empty: Icon(
                          //                                                         Icons
                          //                                                             .star_border_rounded,
                          //                                                         color: Color(
                          //                                                             0xFFFFD700),
                          //                                                       ),
                          //                                                     ),
                          //                                                     itemPadding:
                          //                                                     EdgeInsets.zero,
                          //                                                     onRatingUpdate: (rating) {
                          //                                                       print(rating);
                          //                                                     },
                          //                                                   ),
                          //                                                 ),
                          //                                               ],
                          //                                             ),
                          //                                           ),
                          //
                          //
                          //                                         ],
                          //                                       ),
                          //                                     ),
                          //
                          //
                          //                                     // Date and Time
                          //                                     Container(
                          //                                       padding: EdgeInsets.only(
                          //                                           left: MediaQuery
                          //                                               .of(context)
                          //                                               .size
                          //                                               .height * 0.005,
                          //                                           right: MediaQuery
                          //                                               .of(context)
                          //                                               .size
                          //                                               .height * 0.005,
                          //                                           top: MediaQuery
                          //                                               .of(context)
                          //                                               .size
                          //                                               .height * 0.005,
                          //                                           bottom: MediaQuery
                          //                                               .of(context)
                          //                                               .size
                          //                                               .height * 0.005),
                          //                                       width: double.infinity,
                          //                                       child: Column(
                          //                                           crossAxisAlignment: CrossAxisAlignment
                          //                                               .start,
                          //                                           mainAxisAlignment: MainAxisAlignment
                          //                                               .start,
                          //                                           children: <Widget>[
                          //                                             Container(
                          //                                               decoration: BoxDecoration(
                          //                                                 color: Color(0xFF126086),
                          //                                                 borderRadius: BorderRadius
                          //                                                     .circular(06),
                          //                                               ),
                          //                                               padding: EdgeInsets.only(
                          //                                                 left: MediaQuery
                          //                                                     .of(context)
                          //                                                     .size
                          //                                                     .height * 0.01,
                          //                                                 right: MediaQuery
                          //                                                     .of(context)
                          //                                                     .size
                          //                                                     .height * 0.01,
                          //                                                 top: MediaQuery
                          //                                                     .of(context)
                          //                                                     .size
                          //                                                     .height * 0.015,
                          //                                                 bottom: MediaQuery
                          //                                                     .of(context)
                          //                                                     .size
                          //                                                     .height * 0.015,),
                          //                                               child: Row(
                          //                                                 // mainAxisSize: MainAxisSize.max,
                          //                                                   mainAxisAlignment: MainAxisAlignment
                          //                                                       .start,
                          //                                                   crossAxisAlignment: CrossAxisAlignment
                          //                                                       .end,
                          //                                                   children: <Widget>[
                          //                                                     Expanded(
                          //                                                       child:
                          //                                                       Row(
                          //                                                           mainAxisAlignment: MainAxisAlignment
                          //                                                               .spaceBetween,
                          //                                                           crossAxisAlignment: CrossAxisAlignment
                          //                                                               .center,
                          //                                                           children: <Widget>[
                          //                                                             // Date
                          //                                                             Container(
                          //                                                               decoration: BoxDecoration(
                          //                                                                 // color:Colors.white,
                          //                                                                 borderRadius: BorderRadius
                          //                                                                     .circular(
                          //                                                                     15),
                          //                                                               ),
                          //                                                               // color:Colors.green[100],
                          //                                                               padding: EdgeInsets
                          //                                                                   .only(
                          //                                                                   left: MediaQuery
                          //                                                                       .of(
                          //                                                                       context)
                          //                                                                       .size
                          //                                                                       .height *
                          //                                                                       0.0,
                          //                                                                   right: MediaQuery
                          //                                                                       .of(
                          //                                                                       context)
                          //                                                                       .size
                          //                                                                       .height *
                          //                                                                       0.0,
                          //                                                                   top: MediaQuery
                          //                                                                       .of(
                          //                                                                       context)
                          //                                                                       .size
                          //                                                                       .height *
                          //                                                                       0.00,
                          //                                                                   bottom: MediaQuery
                          //                                                                       .of(
                          //                                                                       context)
                          //                                                                       .size
                          //                                                                       .height *
                          //                                                                       0.00),
                          //                                                               child:
                          //
                          //                                                               Row(
                          //                                                                   mainAxisAlignment: MainAxisAlignment
                          //                                                                       .spaceBetween,
                          //                                                                   crossAxisAlignment: CrossAxisAlignment
                          //                                                                       .center,
                          //                                                                   children: <
                          //                                                                       Widget>[
                          //
                          //                                                                     Icon(Icons
                          //                                                                         .calendar_month,
                          //                                                                         color: Colors
                          //                                                                             .white,
                          //                                                                         size: MediaQuery
                          //                                                                             .of(
                          //                                                                             context)
                          //                                                                             .size
                          //                                                                             .height *
                          //                                                                             0.025),
                          //
                          //                                                                     /* IconButton(
                          //                                             padding: EdgeInsets.zero,
                          //                                             icon: Icon(Icons.directions,
                          //                                               color: Colors.orangeAccent,
                          //                                               size: MediaQuery.of(context).size.height * 0.042,),
                          //                                             onPressed: () async {
                          //                                             }
                          //                                         ),*/
                          //
                          //                                                                     /* Icon(brightness_1_rounded,
                          //                                             color: Color(0xff036c33),
                          //                                             size:  MediaQuery.of(context).size.height * 0.015),*/
                          //
                          //                                                                     // SizedBox(width: width * 0.02), // give it width
                          //                                                                     Column(
                          //                                                                       children: <
                          //                                                                           Widget>[
                          //                                                                         Container(
                          //                                                                           padding: EdgeInsets
                          //                                                                               .only(
                          //                                                                               left: MediaQuery
                          //                                                                                   .of(
                          //                                                                                   context)
                          //                                                                                   .size
                          //                                                                                   .height *
                          //                                                                                   0.005,
                          //                                                                               right: MediaQuery
                          //                                                                                   .of(
                          //                                                                                   context)
                          //                                                                                   .size
                          //                                                                                   .height *
                          //                                                                                   0.00,
                          //                                                                               top: MediaQuery
                          //                                                                                   .of(
                          //                                                                                   context)
                          //                                                                                   .size
                          //                                                                                   .height *
                          //                                                                                   0.00,
                          //                                                                               bottom: MediaQuery
                          //                                                                                   .of(
                          //                                                                                   context)
                          //                                                                                   .size
                          //                                                                                   .height *
                          //                                                                                   0.00),
                          //                                                                           child:
                          //                                                                           Text(
                          //                                                                             "Today, December 17",
                          //                                                                             style: TextStyle(
                          //                                                                               // color: Colors.blue[600],
                          //                                                                                 color: Colors
                          //                                                                                     .white,
                          //                                                                                 fontWeight: FontWeight
                          //                                                                                     .bold,
                          //                                                                                 overflow: TextOverflow
                          //                                                                                     .ellipsis,
                          //                                                                                 fontSize: MediaQuery
                          //                                                                                     .of(
                          //                                                                                     context)
                          //                                                                                     .size
                          //                                                                                     .height *
                          //                                                                                     0.016),
                          //                                                                           ),
                          //                                                                         ),
                          //
                          //                                                                       ],
                          //                                                                     )
                          //
                          //
                          //                                                                   ]
                          //                                                               ),
                          //
                          //                                                             ),
                          //
                          //                                                             // Time
                          //                                                             Container(
                          //                                                               decoration: BoxDecoration(
                          //                                                                 // color:Colors.white,
                          //                                                                 borderRadius: BorderRadius
                          //                                                                     .circular(
                          //                                                                     15),
                          //                                                               ),
                          //                                                               // color:Colors.green[100],
                          //                                                               padding: EdgeInsets
                          //                                                                   .only(
                          //                                                                   left: MediaQuery
                          //                                                                       .of(
                          //                                                                       context)
                          //                                                                       .size
                          //                                                                       .height *
                          //                                                                       0.0,
                          //                                                                   right: MediaQuery
                          //                                                                       .of(
                          //                                                                       context)
                          //                                                                       .size
                          //                                                                       .height *
                          //                                                                       0.0,
                          //                                                                   top: MediaQuery
                          //                                                                       .of(
                          //                                                                       context)
                          //                                                                       .size
                          //                                                                       .height *
                          //                                                                       0.00,
                          //                                                                   bottom: MediaQuery
                          //                                                                       .of(
                          //                                                                       context)
                          //                                                                       .size
                          //                                                                       .height *
                          //                                                                       0.00),
                          //                                                               child:
                          //
                          //                                                               Row(
                          //                                                                   mainAxisAlignment: MainAxisAlignment
                          //                                                                       .spaceBetween,
                          //                                                                   crossAxisAlignment: CrossAxisAlignment
                          //                                                                       .center,
                          //                                                                   children: <
                          //                                                                       Widget>[
                          //
                          //                                                                     Icon(Icons
                          //                                                                         .access_time_sharp,
                          //                                                                         color: Colors
                          //                                                                             .white,
                          //                                                                         size: MediaQuery
                          //                                                                             .of(
                          //                                                                             context)
                          //                                                                             .size
                          //                                                                             .height *
                          //                                                                             0.025),
                          //
                          //                                                                     /* IconButton(
                          //                                             padding: EdgeInsets.zero,
                          //                                             icon: Icon(Icons.directions,
                          //                                               color: Colors.orangeAccent,
                          //                                               size: MediaQuery.of(context).size.height * 0.042,),
                          //                                             onPressed: () async {
                          //                                             }
                          //                                         ),*/
                          //
                          //                                                                     /* Icon(brightness_1_rounded,
                          //                                             color: Color(0xff036c33),
                          //                                             size:  MediaQuery.of(context).size.height * 0.015),*/
                          //
                          //                                                                     // SizedBox(width: width * 0.02), // give it width
                          //                                                                     Column(
                          //                                                                       children: <
                          //                                                                           Widget>[
                          //                                                                         Container(
                          //                                                                           padding: EdgeInsets
                          //                                                                               .only(
                          //                                                                               left: MediaQuery
                          //                                                                                   .of(
                          //                                                                                   context)
                          //                                                                                   .size
                          //                                                                                   .height *
                          //                                                                                   0.00,
                          //                                                                               right: MediaQuery
                          //                                                                                   .of(
                          //                                                                                   context)
                          //                                                                                   .size
                          //                                                                                   .height *
                          //                                                                                   0.005,
                          //                                                                               top: MediaQuery
                          //                                                                                   .of(
                          //                                                                                   context)
                          //                                                                                   .size
                          //                                                                                   .height *
                          //                                                                                   0.00,
                          //                                                                               bottom: MediaQuery
                          //                                                                                   .of(
                          //                                                                                   context)
                          //                                                                                   .size
                          //                                                                                   .height *
                          //                                                                                   0.00),
                          //                                                                           child:
                          //                                                                           Text(
                          //                                                                             "10:00 - 11:00 AM",
                          //                                                                             style: TextStyle(
                          //                                                                               // color: Colors.blue[600],
                          //                                                                                 color: Colors
                          //                                                                                     .white,
                          //                                                                                 fontWeight: FontWeight
                          //                                                                                     .bold,
                          //                                                                                 overflow: TextOverflow
                          //                                                                                     .ellipsis,
                          //                                                                                 fontSize: MediaQuery
                          //                                                                                     .of(
                          //                                                                                     context)
                          //                                                                                     .size
                          //                                                                                     .height *
                          //                                                                                     0.016),
                          //                                                                           ),
                          //                                                                         ),
                          //
                          //                                                                       ],
                          //                                                                     )
                          //
                          //
                          //                                                                   ]
                          //                                                               ),
                          //
                          //                                                             ),
                          //
                          //
                          //                                                           ]
                          //                                                       ),
                          //                                                     ),
                          //                                                   ]),
                          //                                             ),
                          //                                           ]),
                          //                                     ),
                          //
                          //
                          //                                   ]),
                          //                             ),
                          //                           ),

                                                     child: Card(
                                                      elevation: 0,
                                                      color: Colors.white,
                                                      // color: Colors.blueGrey[50],
                                                      // color:    [Colors.green[400], Colors.green[300]],
                                                      child:
                                                      Container(
                                                        // color: Colors.white,

                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            // gradient: LinearGradient(
                                                            //     begin: Alignment.centerLeft,
                                                            //     end: Alignment.centerRight,
                                                            //     stops: [0.5, 0.9],
                                                            //     colors: [
                                                            //       Color(0x66E7EFF3),
                                                            //       Color(0x66E7EFF3)
                                                            //     ])),
                                                        color : Color(0x66E7EFF3),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            left: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.01,
                                                            right: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.01,
                                                            bottom: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.003,
                                                            top: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.003),
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005,
                                                            right: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005,
                                                            bottom: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005,
                                                            top: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[


                                                              Container(
                                                                // color: Colors.red,
                                                                // height: MediaQuery.of(context).size.height * 0.12,
                                                                padding: EdgeInsets.only(
                                                                    left: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.01,
                                                                    right: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005,
                                                                    top: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005,
                                                                    bottom: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.00),

                                                                /*  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),*/
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(

                                                                        padding: EdgeInsets.only(
                                                                          left:
                                                                          MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.00,
                                                                        ),

                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius
                                                                              .circular(130.0),
                                                                          child: Image.asset(
                                                                            'assets/drsujeet.png',
                                                                            fit: BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),



                                                                    ),

                                                                    SizedBox(
                                                                        width: MediaQuery
                                                                            .of(context)
                                                                            .size
                                                                            .height *
                                                                            0.015),

                                                                    Expanded(
                                                                      flex: 8,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        mainAxisAlignment: MainAxisAlignment
                                                                            .center,
                                                                        children: <Widget>[
                                                                          Container(

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
                                                                                    .height * 0.005),
                                                                            child:
                                                                            Text(
                                                                              "Dr. Sujeet Kumar",
                                                                              style: TextStyle(
                                                                                  color: Colors.black87,
                                                                                  fontWeight: FontWeight
                                                                                      .bold,
                                                                                  fontSize: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.013),
                                                                            ),
                                                                          ),


                                                                          Container(

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
                                                                                    .height * 0.005,
                                                                                bottom: MediaQuery
                                                                                    .of(context)
                                                                                    .size
                                                                                    .height * 0.005),
                                                                            child:
                                                                            Text(
                                                                              "Therapist",
                                                                              style: TextStyle(
                                                                                  color: Colors.black87,
                                                                                  fontWeight: FontWeight
                                                                                      .bold,
                                                                                  overflow: TextOverflow
                                                                                      .ellipsis,
                                                                                  fontSize: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.01),
                                                                            ),
                                                                          ),

                                                                          Container(

                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius
                                                                                    .circular(16),
                                                                              ),

                                                                              padding: EdgeInsets.only(
                                                                                  left: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height * 0.001,
                                                                                  right: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height * 0.001,
                                                                                  top: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height * 0.001,
                                                                                  bottom: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height * 0.00),
                                                                              child:
                                                                              // RatingBar(
                                                                              //   initialRating: 1,
                                                                              //   direction: Axis
                                                                              //       .horizontal,
                                                                              //   allowHalfRating: true,
                                                                              //   itemCount: 5,
                                                                              //   itemSize: MediaQuery
                                                                              //       .of(context)
                                                                              //       .size
                                                                              //       .height * 0.015,
                                                                              //   ratingWidget: RatingWidget(
                                                                              //     full: Icon(
                                                                              //       Icons
                                                                              //           .star_rate_rounded,
                                                                              //       color: Color(
                                                                              //           0xFFFFD700),
                                                                              //     ),
                                                                              //     half: Icon(
                                                                              //       Icons
                                                                              //           .star_half_rounded,
                                                                              //       color: Color(
                                                                              //           0xFFFFD700),
                                                                              //     ),
                                                                              //     empty: Icon(
                                                                              //       Icons
                                                                              //           .star_border_rounded,
                                                                              //       color: Color(
                                                                              //           0xFFFFD700),
                                                                              //     ),
                                                                              //   ),
                                                                              //   itemPadding:
                                                                              //   EdgeInsets.zero,
                                                                              //   onRatingUpdate: (rating) {
                                                                              //     print(rating);
                                                                              //   },
                                                                              // ),

                                                                              // RatingBarIndicator(
                                                                              //   rating: 3.5,  // Fixed rating, non-interactive
                                                                              //   itemCount: 5, // Number of stars
                                                                              //   itemSize: MediaQuery.of(context).size.height * 0.015, // Adjust size
                                                                              //   direction: Axis.horizontal,
                                                                              //   itemBuilder: (context, index) => Icon(
                                                                              //     Icons.star_rate_rounded,
                                                                              //     color: Color(0xFFFFD700),  // Gold color
                                                                              //   ),
                                                                              // )

                                                                              RatingBarIndicator(
                                                                                rating: rating,  // Fixed rating (non-clickable)
                                                                                itemCount: 5,  // Number of stars
                                                                                itemSize: MediaQuery.of(context).size.height * 0.015,  // Adjust size
                                                                                direction: Axis.horizontal,
                                                                                itemBuilder: (context, index) {
                                                                                  // Dynamic logic for full, half, and empty stars based on the rating
                                                                                  if (index < rating) {
                                                                                    // Display gold (full star) if the index is less than the rating
                                                                                    return Icon(
                                                                                      Icons.star_rate_rounded,
                                                                                      color: Color(0xFFFFD700),  // Gold color for filled stars
                                                                                    );
                                                                                  } else if (index == rating.floor() && rating != rating.floor()) {
                                                                                    // Display half star if the index is equal to the floor value of rating and rating is a decimal
                                                                                    return Icon(
                                                                                      Icons.star_half_rounded,
                                                                                      color: Color(0xFFFFD700),  // Gold color for half star
                                                                                    );
                                                                                  } else {
                                                                                    // Display empty star if the index is greater than the rating
                                                                                    return Icon(
                                                                                      Icons.star_border_rounded,
                                                                                      color: Colors.white,  // White color for empty stars
                                                                                    );
                                                                                  }
                                                                                },
                                                                              )





                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),


                                                                  ],
                                                                ),
                                                              ),

                                                              SizedBox(height : MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.007,),
                                                              // Date and Time
                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                    left: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.01,
                                                                    right: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005,
                                                                    top: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005,
                                                                    bottom: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005),
                                                                width: double.infinity,
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .start,
                                                                    children: <Widget>[
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xFF126086),
                                                                          borderRadius: BorderRadius
                                                                              .circular(09),
                                                                        ),
                                                                        padding: EdgeInsets.only(
                                                                          left: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.015,
                                                                          right: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.015,
                                                                          top: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.01,
                                                                          bottom: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.01,),
                                                                        child: Row(
                                                                          // mainAxisSize: MainAxisSize.max,
                                                                            mainAxisAlignment: MainAxisAlignment
                                                                                .start,
                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                .end,
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child:
                                                                                Row(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment
                                                                                        .center,
                                                                                    children: <Widget>[
                                                                                      // Date
                                                                                      Container(
                                                                                        decoration: BoxDecoration(
                                                                                          // color:Colors.white,
                                                                                          borderRadius: BorderRadius
                                                                                              .circular(
                                                                                              15),
                                                                                        ),
                                                                                        // color:Colors.green[100],
                                                                                        padding: EdgeInsets
                                                                                            .only(
                                                                                            left: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.0,
                                                                                            right: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.0,
                                                                                            top: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.00,
                                                                                            bottom: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.00),
                                                                                        child:

                                                                                        Row(
                                                                                            mainAxisAlignment: MainAxisAlignment
                                                                                                .spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .center,
                                                                                            children: <
                                                                                                Widget>[

                                                                                              Icon(Icons
                                                                                                  .calendar_month,
                                                                                                  color: Colors
                                                                                                      .white,
                                                                                                  size: MediaQuery
                                                                                                      .of(
                                                                                                      context)
                                                                                                      .size
                                                                                                      .height *
                                                                                                      0.02),




                                                                                              Column(
                                                                                                children: <
                                                                                                    Widget>[
                                                                                                  Container(
                                                                                                    padding: EdgeInsets
                                                                                                        .only(
                                                                                                        left: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.005,
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
                                                                                                            0.00,
                                                                                                        bottom: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.00),
                                                                                                    child:
                                                                                                    Text(
                                                                                                      "Today, December 17",
                                                                                                      style: TextStyle(
                                                                                                        // color: Colors.blue[600],
                                                                                                          color: Colors
                                                                                                              .white,
                                                                                                          fontWeight: FontWeight
                                                                                                              .w600,
                                                                                                          overflow: TextOverflow
                                                                                                              .ellipsis,
                                                                                                          fontSize: MediaQuery
                                                                                                              .of(
                                                                                                              context)
                                                                                                              .size
                                                                                                              .height *
                                                                                                              0.014),
                                                                                                    ),
                                                                                                  ),

                                                                                                ],
                                                                                              )


                                                                                            ]
                                                                                        ),

                                                                                      ),

                                                                                      // Time
                                                                                      Container(
                                                                                        decoration: BoxDecoration(
                                                                                          // color:Colors.white,
                                                                                          borderRadius: BorderRadius
                                                                                              .circular(
                                                                                              15),
                                                                                        ),
                                                                                        // color:Colors.green[100],
                                                                                        padding: EdgeInsets
                                                                                            .only(
                                                                                            left: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.0,
                                                                                            right: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.0,
                                                                                            top: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.00,
                                                                                            bottom: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.00),
                                                                                        child:

                                                                                        Row(
                                                                                            mainAxisAlignment: MainAxisAlignment
                                                                                                .spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .center,
                                                                                            children: <
                                                                                                Widget>[

                                                                                              Icon(Icons
                                                                                                  .access_time_sharp,
                                                                                                  color: Colors
                                                                                                      .white,
                                                                                                  size: MediaQuery
                                                                                                      .of(
                                                                                                      context)
                                                                                                      .size
                                                                                                      .height *
                                                                                                      0.022),

                                                                                              /* IconButton(
                                                                      padding: EdgeInsets.zero,
                                                                      icon: Icon(Icons.directions,
                                                                        color: Colors.orangeAccent,
                                                                        size: MediaQuery.of(context).size.height * 0.042,),
                                                                      onPressed: () async {
                                                                      }
                                                                  ),*/

                                                                                              /* Icon(brightness_1_rounded,
                                                                      color: Color(0xff036c33),
                                                                      size:  MediaQuery.of(context).size.height * 0.015),*/

                                                                                              // SizedBox(width: width * 0.02), // give it width
                                                                                              Column(
                                                                                                children: <
                                                                                                    Widget>[
                                                                                                  Container(
                                                                                                    padding: EdgeInsets
                                                                                                        .only(
                                                                                                        left: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.005,
                                                                                                        right: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.005,
                                                                                                        top: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.00,
                                                                                                        bottom: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.00),
                                                                                                    child:
                                                                                                    Text(
                                                                                                      "10:00 - 11:00 AM",
                                                                                                      style: TextStyle(
                                                                                                        // color: Colors.blue[600],
                                                                                                          color: Colors
                                                                                                              .white,
                                                                                                          fontWeight: FontWeight
                                                                                                              .w600,
                                                                                                          overflow: TextOverflow
                                                                                                              .ellipsis,
                                                                                                          fontSize: MediaQuery
                                                                                                              .of(
                                                                                                              context)
                                                                                                              .size
                                                                                                              .height *
                                                                                                              0.014),
                                                                                                    ),
                                                                                                  ),

                                                                                                ],
                                                                                              )


                                                                                            ]
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
                                    ],
                                  ),
                                ),

                                // Upcoming Appointments
                                Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery
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
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.00,
                                      bottom:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.00),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                      Radius.circular(screenHeight * 0.03),
                                      topRight:
                                      Radius.circular(screenHeight * 0.03),
                                    ),
                                  ),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [


                                      // Doctors
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // Provide a width constraint using SizedBox or Expanded
                                          Container(
                                            margin: EdgeInsets.only(
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
                                                    0.010,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.01),
                                            // height: MediaQuery.of(context).size.height * 0.190,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                              ScrollPhysics(),
                                              // Ensures scrolling
                                              shrinkWrap:
                                              true,
                                              // Prevents ListView from taking up extra space
                                              scrollDirection: Axis
                                                  .vertical,
                                              // Makes the ListView horizontal
                                              itemCount:
                                              3,
                                              // You can adjust the item count
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.00,
                                                        right: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.00,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.00,
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.00),
                                                    color: Colors.white,
                                                    // child: Card(
                                                    //   elevation: 0,
                                                    //   color: Colors.white,
                                                    //   // color: Colors.blueGrey[50],
                                                    //   // color:    [Colors.green[400], Colors.green[300]],
                                                    //   child:
                                                    //   Container(
                                                    //     // color: Colors.white,
                                                    //
                                                    //     decoration: BoxDecoration(
                                                    //         borderRadius: BorderRadius.circular(10),
                                                    //         gradient: LinearGradient(
                                                    //             begin: Alignment.centerLeft,
                                                    //             end: Alignment.centerRight,
                                                    //             stops: [0.5, 0.9],
                                                    //             colors: [
                                                    //               Color(0xFFE8F0F3),
                                                    //               Color(0xFFE8F0F3)
                                                    //             ])),
                                                    //     margin: EdgeInsets.only(
                                                    //         left: MediaQuery
                                                    //             .of(context)
                                                    //             .size
                                                    //             .height * 0.006,
                                                    //         right: MediaQuery
                                                    //             .of(context)
                                                    //             .size
                                                    //             .height * 0.006,
                                                    //         bottom: MediaQuery
                                                    //             .of(context)
                                                    //             .size
                                                    //             .height * 0.003,
                                                    //         top: MediaQuery
                                                    //             .of(context)
                                                    //             .size
                                                    //             .height * 0.003),
                                                    //     padding: EdgeInsets.only(
                                                    //         left: MediaQuery
                                                    //             .of(context)
                                                    //             .size
                                                    //             .height * 0.005,
                                                    //         right: MediaQuery
                                                    //             .of(context)
                                                    //             .size
                                                    //             .height * 0.005,
                                                    //         bottom: MediaQuery
                                                    //             .of(context)
                                                    //             .size
                                                    //             .height * 0.005,
                                                    //         top: MediaQuery
                                                    //             .of(context)
                                                    //             .size
                                                    //             .height * 0.005),
                                                    //     child: Column(
                                                    //         crossAxisAlignment: CrossAxisAlignment
                                                    //             .start,
                                                    //         children: <Widget>[
                                                    //
                                                    //
                                                    //           Container(
                                                    //             // color: Colors.red,
                                                    //             // height: MediaQuery.of(context).size.height * 0.12,
                                                    //             padding: EdgeInsets.only(
                                                    //                 left: MediaQuery
                                                    //                     .of(context)
                                                    //                     .size
                                                    //                     .height * 0.005,
                                                    //                 right: MediaQuery
                                                    //                     .of(context)
                                                    //                     .size
                                                    //                     .height * 0.005,
                                                    //                 top: MediaQuery
                                                    //                     .of(context)
                                                    //                     .size
                                                    //                     .height * 0.00,
                                                    //                 bottom: MediaQuery
                                                    //                     .of(context)
                                                    //                     .size
                                                    //                     .height * 0.00),
                                                    //             child: Row(
                                                    //               crossAxisAlignment: CrossAxisAlignment
                                                    //                   .center,
                                                    //               mainAxisAlignment: MainAxisAlignment
                                                    //                   .start,
                                                    //               children: <Widget>[
                                                    //                 Expanded(
                                                    //                   flex: 2,
                                                    //                   child:
                                                    //                   Container(
                                                    //
                                                    //                     padding: EdgeInsets.only(
                                                    //                       left:
                                                    //                       MediaQuery
                                                    //                           .of(context)
                                                    //                           .size
                                                    //                           .height * 0.00,
                                                    //                     ),
                                                    //
                                                    //                     child: ClipRRect(
                                                    //                       borderRadius: BorderRadius
                                                    //                           .circular(130.0),
                                                    //                       child: Image.asset(
                                                    //                         'assets/drsujeet.png',
                                                    //                         fit: BoxFit.fill,
                                                    //                       ),
                                                    //                     ),
                                                    //                   ),
                                                    //
                                                    //                 ),
                                                    //
                                                    //                 SizedBox(
                                                    //                     width: MediaQuery
                                                    //                         .of(context)
                                                    //                         .size
                                                    //                         .height *
                                                    //                         0.010),
                                                    //
                                                    //                 Expanded(
                                                    //                   flex: 8,
                                                    //                   child: Column(
                                                    //                     crossAxisAlignment: CrossAxisAlignment
                                                    //                         .start,
                                                    //                     mainAxisAlignment: MainAxisAlignment
                                                    //                         .center,
                                                    //                     children: <Widget>[
                                                    //                       Row(
                                                    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Centers the button
                                                    //                           children: [
                                                    //
                                                    //                             Container(
                                                    //
                                                    //                               padding: EdgeInsets.only(
                                                    //                                   left: MediaQuery
                                                    //                                       .of(context)
                                                    //                                       .size
                                                    //                                       .height * 0.00,
                                                    //                                   right: MediaQuery
                                                    //                                       .of(context)
                                                    //                                       .size
                                                    //                                       .height * 0.00,
                                                    //                                   top: MediaQuery
                                                    //                                       .of(context)
                                                    //                                       .size
                                                    //                                       .height * 0.00,
                                                    //                                   bottom: MediaQuery
                                                    //                                       .of(context)
                                                    //                                       .size
                                                    //                                       .height * 0.00),
                                                    //                               child:
                                                    //                               Text(
                                                    //                                 "Dr. Sujeet Kumar",
                                                    //                                 style: TextStyle(
                                                    //                                     color: Colors.black87,
                                                    //                                     fontWeight: FontWeight
                                                    //                                         .bold,
                                                    //                                     fontSize: MediaQuery
                                                    //                                         .of(context)
                                                    //                                         .size
                                                    //                                         .height *
                                                    //                                         0.016),
                                                    //                               ),
                                                    //                             ),
                                                    //
                                                    //                             GestureDetector(
                                                    //                                 onTap: () async {
                                                    //                                   appointmentcancelalert.showticket(context);
                                                    //                                 },
                                                    //                                 child:
                                                    //                             Container(
                                                    //                                 padding: EdgeInsets.only(
                                                    //                                   left: MediaQuery.of(context).size.height * 0.005,
                                                    //                                   right: MediaQuery.of(context).size.height * 0.005,
                                                    //                                   top: MediaQuery.of(context).size.height * 0.005,
                                                    //                                   bottom: MediaQuery.of(context).size.height * 0.005,
                                                    //                                 ),
                                                    //                                 margin: EdgeInsets.only(
                                                    //                                   left: MediaQuery.of(context).size.height * 0.00,
                                                    //                                   top: MediaQuery.of(context).size.height * 0.0,
                                                    //                                   bottom: MediaQuery.of(context).size.height * 0.00,
                                                    //                                   right: MediaQuery.of(context).size.height * 0.00,
                                                    //                                 ),
                                                    //                                 decoration: BoxDecoration(
                                                    //                                   color: Colors.white,
                                                    //                                   borderRadius: BorderRadius.circular(10),
                                                    //                                 ),
                                                    //                                 child:
                                                    //                             Row(
                                                    //                               mainAxisAlignment: MainAxisAlignment.center,
                                                    //                               children: List.generate(
                                                    //                                 3, // Number of dots
                                                    //                                     (index) => Padding(
                                                    //                                       padding: EdgeInsets.only(
                                                    //                                         left: MediaQuery.of(context).size.height * 0.002,
                                                    //                                         right: MediaQuery.of(context).size.height * 0.002,
                                                    //                                         top: MediaQuery.of(context).size.height * 0.0,
                                                    //                                         bottom: MediaQuery.of(context).size.height * 0.0,
                                                    //                                       ), // Spacing between dots
                                                    //                                   child: Container(
                                                    //                                     width: MediaQuery.of(context).size.height * 0.007, // Diameter of the dot
                                                    //                                     height: MediaQuery.of(context).size.height * 0.007,
                                                    //                                     decoration: BoxDecoration(
                                                    //                                       color: Colors.grey, // Dot color
                                                    //                                       shape: BoxShape.circle, // Makes it circular
                                                    //                                     ),
                                                    //                                   ),
                                                    //                                 ),
                                                    //                               ),
                                                    //                             ),
                                                    //                             ),
                                                    //                             ),
                                                    //
                                                    //                           ]
                                                    //                       ),
                                                    //
                                                    //
                                                    //                       Container(
                                                    //
                                                    //                         padding: EdgeInsets.only(
                                                    //                             left: MediaQuery
                                                    //                                 .of(context)
                                                    //                                 .size
                                                    //                                 .height * 0.00,
                                                    //                             right: MediaQuery
                                                    //                                 .of(context)
                                                    //                                 .size
                                                    //                                 .height * 0.00,
                                                    //                             top: MediaQuery
                                                    //                                 .of(context)
                                                    //                                 .size
                                                    //                                 .height * 0.00,
                                                    //                             bottom: MediaQuery
                                                    //                                 .of(context)
                                                    //                                 .size
                                                    //                                 .height * 0.005),
                                                    //                         child:
                                                    //                         Text(
                                                    //                           "Therapist",
                                                    //                           style: TextStyle(
                                                    //                               color: Colors.black87,
                                                    //                               fontWeight: FontWeight
                                                    //                                   .bold,
                                                    //                               overflow: TextOverflow
                                                    //                                   .ellipsis,
                                                    //                               fontSize: MediaQuery
                                                    //                                   .of(context)
                                                    //                                   .size
                                                    //                                   .height *
                                                    //                                   0.014),
                                                    //                         ),
                                                    //                       ),
                                                    //
                                                    //                       Container(
                                                    //
                                                    //                         decoration: BoxDecoration(
                                                    //                           color: Colors.white,
                                                    //                           borderRadius: BorderRadius
                                                    //                               .circular(16),
                                                    //                         ),
                                                    //
                                                    //                         padding: EdgeInsets.only(
                                                    //                             left: MediaQuery
                                                    //                                 .of(context)
                                                    //                                 .size
                                                    //                                 .height * 0.001,
                                                    //                             right: MediaQuery
                                                    //                                 .of(context)
                                                    //                                 .size
                                                    //                                 .height * 0.001,
                                                    //                             top: MediaQuery
                                                    //                                 .of(context)
                                                    //                                 .size
                                                    //                                 .height * 0.001,
                                                    //                             bottom: MediaQuery
                                                    //                                 .of(context)
                                                    //                                 .size
                                                    //                                 .height * 0.00),
                                                    //                         child:
                                                    //                         RatingBar(
                                                    //                           initialRating: 1,
                                                    //                           direction: Axis
                                                    //                               .horizontal,
                                                    //                           allowHalfRating: true,
                                                    //                           itemCount: 5,
                                                    //                           itemSize: MediaQuery.of(context).size.height * 0.02,
                                                    //                           ratingWidget: RatingWidget(
                                                    //                             full: Icon(
                                                    //                               Icons
                                                    //                                   .star_rate_rounded,
                                                    //                               color: Color(
                                                    //                                   0xFFFFD700),
                                                    //                             ),
                                                    //                             half: Icon(
                                                    //                               Icons
                                                    //                                   .star_half_rounded,
                                                    //                               color: Color(
                                                    //                                   0xFFFFD700),
                                                    //                             ),
                                                    //                             empty: Icon(
                                                    //                               Icons
                                                    //                                   .star_border_rounded,
                                                    //                               color: Color(
                                                    //                                   0xFFFFD700),
                                                    //                             ),
                                                    //                           ),
                                                    //                           itemPadding:
                                                    //                           EdgeInsets.zero,
                                                    //                           onRatingUpdate: (rating) {
                                                    //                             print(rating);
                                                    //                           },
                                                    //                         ),
                                                    //                       ),
                                                    //                     ],
                                                    //                   ),
                                                    //                 ),
                                                    //
                                                    //
                                                    //               ],
                                                    //             ),
                                                    //           ),
                                                    //
                                                    //
                                                    //           // Date and Time
                                                    //           Container(
                                                    //             padding: EdgeInsets.only(
                                                    //                 left: MediaQuery
                                                    //                     .of(context)
                                                    //                     .size
                                                    //                     .height * 0.005,
                                                    //                 right: MediaQuery
                                                    //                     .of(context)
                                                    //                     .size
                                                    //                     .height * 0.005,
                                                    //                 top: MediaQuery
                                                    //                     .of(context)
                                                    //                     .size
                                                    //                     .height * 0.005,
                                                    //                 bottom: MediaQuery
                                                    //                     .of(context)
                                                    //                     .size
                                                    //                     .height * 0.005),
                                                    //             width: double.infinity,
                                                    //             child: Column(
                                                    //                 crossAxisAlignment: CrossAxisAlignment
                                                    //                     .start,
                                                    //                 mainAxisAlignment: MainAxisAlignment
                                                    //                     .start,
                                                    //                 children: <Widget>[
                                                    //                   Container(
                                                    //                     decoration: BoxDecoration(
                                                    //                       color: Color(0xFF126086),
                                                    //                       borderRadius: BorderRadius
                                                    //                           .circular(06),
                                                    //                     ),
                                                    //                     padding: EdgeInsets.only(
                                                    //                       left: MediaQuery
                                                    //                           .of(context)
                                                    //                           .size
                                                    //                           .height * 0.01,
                                                    //                       right: MediaQuery
                                                    //                           .of(context)
                                                    //                           .size
                                                    //                           .height * 0.01,
                                                    //                       top: MediaQuery
                                                    //                           .of(context)
                                                    //                           .size
                                                    //                           .height * 0.015,
                                                    //                       bottom: MediaQuery
                                                    //                           .of(context)
                                                    //                           .size
                                                    //                           .height * 0.015,),
                                                    //                     child: Row(
                                                    //                       // mainAxisSize: MainAxisSize.max,
                                                    //                         mainAxisAlignment: MainAxisAlignment
                                                    //                             .start,
                                                    //                         crossAxisAlignment: CrossAxisAlignment
                                                    //                             .end,
                                                    //                         children: <Widget>[
                                                    //                           Expanded(
                                                    //                             child:
                                                    //                             Row(
                                                    //                                 mainAxisAlignment: MainAxisAlignment
                                                    //                                     .spaceBetween,
                                                    //                                 crossAxisAlignment: CrossAxisAlignment
                                                    //                                     .center,
                                                    //                                 children: <Widget>[
                                                    //                                   // Date
                                                    //                                   Container(
                                                    //                                     decoration: BoxDecoration(
                                                    //                                       // color:Colors.white,
                                                    //                                       borderRadius: BorderRadius
                                                    //                                           .circular(
                                                    //                                           15),
                                                    //                                     ),
                                                    //                                     // color:Colors.green[100],
                                                    //                                     padding: EdgeInsets
                                                    //                                         .only(
                                                    //                                         left: MediaQuery
                                                    //                                             .of(
                                                    //                                             context)
                                                    //                                             .size
                                                    //                                             .height *
                                                    //                                             0.0,
                                                    //                                         right: MediaQuery
                                                    //                                             .of(
                                                    //                                             context)
                                                    //                                             .size
                                                    //                                             .height *
                                                    //                                             0.0,
                                                    //                                         top: MediaQuery
                                                    //                                             .of(
                                                    //                                             context)
                                                    //                                             .size
                                                    //                                             .height *
                                                    //                                             0.00,
                                                    //                                         bottom: MediaQuery
                                                    //                                             .of(
                                                    //                                             context)
                                                    //                                             .size
                                                    //                                             .height *
                                                    //                                             0.00),
                                                    //                                     child:
                                                    //
                                                    //                                     Row(
                                                    //                                         mainAxisAlignment: MainAxisAlignment
                                                    //                                             .spaceBetween,
                                                    //                                         crossAxisAlignment: CrossAxisAlignment
                                                    //                                             .center,
                                                    //                                         children: <
                                                    //                                             Widget>[
                                                    //
                                                    //                                           Icon(Icons
                                                    //                                               .calendar_month,
                                                    //                                               color: Colors
                                                    //                                                   .white,
                                                    //                                               size: MediaQuery
                                                    //                                                   .of(
                                                    //                                                   context)
                                                    //                                                   .size
                                                    //                                                   .height *
                                                    //                                                   0.025),
                                                    //
                                                    //                                           /* IconButton(
                                                    //                   padding: EdgeInsets.zero,
                                                    //                   icon: Icon(Icons.directions,
                                                    //                     color: Colors.orangeAccent,
                                                    //                     size: MediaQuery.of(context).size.height * 0.042,),
                                                    //                   onPressed: () async {
                                                    //                   }
                                                    //               ),*/
                                                    //
                                                    //                                           /* Icon(brightness_1_rounded,
                                                    //                   color: Color(0xff036c33),
                                                    //                   size:  MediaQuery.of(context).size.height * 0.015),*/
                                                    //
                                                    //                                           // SizedBox(width: width * 0.02), // give it width
                                                    //                                           Column(
                                                    //                                             children: <
                                                    //                                                 Widget>[
                                                    //                                               Container(
                                                    //                                                 padding: EdgeInsets
                                                    //                                                     .only(
                                                    //                                                     left: MediaQuery
                                                    //                                                         .of(
                                                    //                                                         context)
                                                    //                                                         .size
                                                    //                                                         .height *
                                                    //                                                         0.005,
                                                    //                                                     right: MediaQuery
                                                    //                                                         .of(
                                                    //                                                         context)
                                                    //                                                         .size
                                                    //                                                         .height *
                                                    //                                                         0.00,
                                                    //                                                     top: MediaQuery
                                                    //                                                         .of(
                                                    //                                                         context)
                                                    //                                                         .size
                                                    //                                                         .height *
                                                    //                                                         0.00,
                                                    //                                                     bottom: MediaQuery
                                                    //                                                         .of(
                                                    //                                                         context)
                                                    //                                                         .size
                                                    //                                                         .height *
                                                    //                                                         0.00),
                                                    //                                                 child:
                                                    //                                                 Text(
                                                    //                                                   "Today, December 17",
                                                    //                                                   style: TextStyle(
                                                    //                                                     // color: Colors.blue[600],
                                                    //                                                       color: Colors
                                                    //                                                           .white,
                                                    //                                                       fontWeight: FontWeight
                                                    //                                                           .bold,
                                                    //                                                       overflow: TextOverflow
                                                    //                                                           .ellipsis,
                                                    //                                                       fontSize: MediaQuery
                                                    //                                                           .of(
                                                    //                                                           context)
                                                    //                                                           .size
                                                    //                                                           .height *
                                                    //                                                           0.016),
                                                    //                                                 ),
                                                    //                                               ),
                                                    //
                                                    //                                             ],
                                                    //                                           )
                                                    //
                                                    //
                                                    //                                         ]
                                                    //                                     ),
                                                    //
                                                    //                                   ),
                                                    //
                                                    //                                   // Time
                                                    //                                   Container(
                                                    //                                     decoration: BoxDecoration(
                                                    //                                       // color:Colors.white,
                                                    //                                       borderRadius: BorderRadius
                                                    //                                           .circular(
                                                    //                                           15),
                                                    //                                     ),
                                                    //                                     // color:Colors.green[100],
                                                    //                                     padding: EdgeInsets
                                                    //                                         .only(
                                                    //                                         left: MediaQuery
                                                    //                                             .of(
                                                    //                                             context)
                                                    //                                             .size
                                                    //                                             .height *
                                                    //                                             0.0,
                                                    //                                         right: MediaQuery
                                                    //                                             .of(
                                                    //                                             context)
                                                    //                                             .size
                                                    //                                             .height *
                                                    //                                             0.0,
                                                    //                                         top: MediaQuery
                                                    //                                             .of(
                                                    //                                             context)
                                                    //                                             .size
                                                    //                                             .height *
                                                    //                                             0.00,
                                                    //                                         bottom: MediaQuery
                                                    //                                             .of(
                                                    //                                             context)
                                                    //                                             .size
                                                    //                                             .height *
                                                    //                                             0.00),
                                                    //                                     child:
                                                    //
                                                    //                                     Row(
                                                    //                                         mainAxisAlignment: MainAxisAlignment
                                                    //                                             .spaceBetween,
                                                    //                                         crossAxisAlignment: CrossAxisAlignment
                                                    //                                             .center,
                                                    //                                         children: <
                                                    //                                             Widget>[
                                                    //
                                                    //                                           Icon(Icons
                                                    //                                               .access_time_sharp,
                                                    //                                               color: Colors
                                                    //                                                   .white,
                                                    //                                               size: MediaQuery
                                                    //                                                   .of(
                                                    //                                                   context)
                                                    //                                                   .size
                                                    //                                                   .height *
                                                    //                                                   0.025),
                                                    //
                                                    //                                           /* IconButton(
                                                    //                   padding: EdgeInsets.zero,
                                                    //                   icon: Icon(Icons.directions,
                                                    //                     color: Colors.orangeAccent,
                                                    //                     size: MediaQuery.of(context).size.height * 0.042,),
                                                    //                   onPressed: () async {
                                                    //                   }
                                                    //               ),*/
                                                    //
                                                    //                                           /* Icon(brightness_1_rounded,
                                                    //                   color: Color(0xff036c33),
                                                    //                   size:  MediaQuery.of(context).size.height * 0.015),*/
                                                    //
                                                    //                                           // SizedBox(width: width * 0.02), // give it width
                                                    //                                           Column(
                                                    //                                             children: <
                                                    //                                                 Widget>[
                                                    //                                               Container(
                                                    //                                                 padding: EdgeInsets
                                                    //                                                     .only(
                                                    //                                                     left: MediaQuery
                                                    //                                                         .of(
                                                    //                                                         context)
                                                    //                                                         .size
                                                    //                                                         .height *
                                                    //                                                         0.00,
                                                    //                                                     right: MediaQuery
                                                    //                                                         .of(
                                                    //                                                         context)
                                                    //                                                         .size
                                                    //                                                         .height *
                                                    //                                                         0.005,
                                                    //                                                     top: MediaQuery
                                                    //                                                         .of(
                                                    //                                                         context)
                                                    //                                                         .size
                                                    //                                                         .height *
                                                    //                                                         0.00,
                                                    //                                                     bottom: MediaQuery
                                                    //                                                         .of(
                                                    //                                                         context)
                                                    //                                                         .size
                                                    //                                                         .height *
                                                    //                                                         0.00),
                                                    //                                                 child:
                                                    //                                                 Text(
                                                    //                                                   "10:00 - 11:00 AM",
                                                    //                                                   style: TextStyle(
                                                    //                                                     // color: Colors.blue[600],
                                                    //                                                       color: Colors
                                                    //                                                           .white,
                                                    //                                                       fontWeight: FontWeight
                                                    //                                                           .bold,
                                                    //                                                       overflow: TextOverflow
                                                    //                                                           .ellipsis,
                                                    //                                                       fontSize: MediaQuery
                                                    //                                                           .of(
                                                    //                                                           context)
                                                    //                                                           .size
                                                    //                                                           .height *
                                                    //                                                           0.016),
                                                    //                                                 ),
                                                    //                                               ),
                                                    //
                                                    //                                             ],
                                                    //                                           )
                                                    //
                                                    //
                                                    //                                         ]
                                                    //                                     ),
                                                    //
                                                    //                                   ),
                                                    //
                                                    //
                                                    //                                 ]
                                                    //                             ),
                                                    //                           ),
                                                    //                         ]),
                                                    //                   ),
                                                    //                 ]),
                                                    //           ),
                                                    //
                                                    //
                                                    //         ]),
                                                    //   ),
                                                    // ),

                                                    child: Card(
                                                      elevation: 0,
                                                      color: Colors.white,
                                                      // color: Colors.blueGrey[50],
                                                      // color:    [Colors.green[400], Colors.green[300]],
                                                      child:
                                                      Container(
                                                        // color: Colors.white,

                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          // gradient: LinearGradient(
                                                          //     begin: Alignment.centerLeft,
                                                          //     end: Alignment.centerRight,
                                                          //     stops: [0.5, 0.9],
                                                          //     colors: [
                                                          //       Color(0x66E7EFF3),
                                                          //       Color(0x66E7EFF3)
                                                          //     ])),
                                                          color : Color(0x66E7EFF3),
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            left: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.01,
                                                            right: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.01,
                                                            bottom: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.003,
                                                            top: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.003),
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005,
                                                            right: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005,
                                                            bottom: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005,
                                                            top: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[


                                                              Container(
                                                                // color: Colors.red,
                                                                // height: MediaQuery.of(context).size.height * 0.12,
                                                                padding: EdgeInsets.only(
                                                                    left: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.01,
                                                                    right: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005,
                                                                    top: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005,
                                                                    bottom: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.00),

                                                                /*  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),*/
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(

                                                                        padding: EdgeInsets.only(
                                                                          left:
                                                                          MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.00,
                                                                        ),

                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius
                                                                              .circular(130.0),
                                                                          child: Image.asset(
                                                                            'assets/drsujeet.png',
                                                                            fit: BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),



                                                                    ),

                                                                    SizedBox(
                                                                        width: MediaQuery
                                                                            .of(context)
                                                                            .size
                                                                            .height *
                                                                            0.015),

                                                                    Expanded(
                                                                      flex: 8,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        mainAxisAlignment: MainAxisAlignment
                                                                            .center,
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Container(

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
                                                                                        .height * 0.005),
                                                                                child:
                                                                                Text(
                                                                                  "Dr. Sujeet Kumar",
                                                                                  style: TextStyle(
                                                                                      color: Colors.black87,
                                                                                      fontWeight: FontWeight
                                                                                          .bold,
                                                                                      fontSize: MediaQuery
                                                                                          .of(context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.013),
                                                                                ),
                                                                              ),

                                                                              GestureDetector(
                                                                                onTap: () async {
                                                                                  // appointmentcancelalert.showticket(context);
                                                                                  showBottomSheet();

                                                                                },
                                                                                child:
                                                                                Container(
                                                                                  padding: EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                                                    top: MediaQuery.of(context).size.height * 0.005,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.005,
                                                                                  ),
                                                                                  margin: EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.00,
                                                                                    top: MediaQuery.of(context).size.height * 0.0,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                    right: MediaQuery.of(context).size.height * 0.01,
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child:
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: List.generate(
                                                                                      3, // Number of dots
                                                                                          (index) => Padding(
                                                                                        padding: EdgeInsets.only(
                                                                                          left: MediaQuery.of(context).size.height * 0.001,
                                                                                          right: MediaQuery.of(context).size.height * 0.001,
                                                                                          top: MediaQuery.of(context).size.height * 0.0,
                                                                                          bottom: MediaQuery.of(context).size.height * 0.0,
                                                                                        ), // Spacing between dots
                                                                                        child: Container(
                                                                                          width: MediaQuery.of(context).size.height * 0.004, // Diameter of the dot
                                                                                          height: MediaQuery.of(context).size.height * 0.004,
                                                                                          decoration: BoxDecoration(
                                                                                            color: Color(0x85116A94), // Dot color
                                                                                            shape: BoxShape.circle, // Makes it circular
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),


                                                                          Container(

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
                                                                                    .height * 0.005,
                                                                                bottom: MediaQuery
                                                                                    .of(context)
                                                                                    .size
                                                                                    .height * 0.005),
                                                                            child:
                                                                            Text(
                                                                              "Therapist",
                                                                              style: TextStyle(
                                                                                  color: Colors.black87,
                                                                                  fontWeight: FontWeight
                                                                                      .bold,
                                                                                  overflow: TextOverflow
                                                                                      .ellipsis,
                                                                                  fontSize: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.01),
                                                                            ),
                                                                          ),

                                                                          Container(

                                                                              decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius
                                                                                    .circular(16),
                                                                              ),

                                                                              padding: EdgeInsets.only(
                                                                                  left: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height * 0.001,
                                                                                  right: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height * 0.001,
                                                                                  top: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height * 0.001,
                                                                                  bottom: MediaQuery
                                                                                      .of(context)
                                                                                      .size
                                                                                      .height * 0.00),
                                                                              child:
                                                                              // RatingBar(
                                                                              //   initialRating: 1,
                                                                              //   direction: Axis
                                                                              //       .horizontal,
                                                                              //   allowHalfRating: true,
                                                                              //   itemCount: 5,
                                                                              //   itemSize: MediaQuery
                                                                              //       .of(context)
                                                                              //       .size
                                                                              //       .height * 0.015,
                                                                              //   ratingWidget: RatingWidget(
                                                                              //     full: Icon(
                                                                              //       Icons
                                                                              //           .star_rate_rounded,
                                                                              //       color: Color(
                                                                              //           0xFFFFD700),
                                                                              //     ),
                                                                              //     half: Icon(
                                                                              //       Icons
                                                                              //           .star_half_rounded,
                                                                              //       color: Color(
                                                                              //           0xFFFFD700),
                                                                              //     ),
                                                                              //     empty: Icon(
                                                                              //       Icons
                                                                              //           .star_border_rounded,
                                                                              //       color: Color(
                                                                              //           0xFFFFD700),
                                                                              //     ),
                                                                              //   ),
                                                                              //   itemPadding:
                                                                              //   EdgeInsets.zero,
                                                                              //   onRatingUpdate: (rating) {
                                                                              //     print(rating);
                                                                              //   },
                                                                              // ),

                                                                              // RatingBarIndicator(
                                                                              //   rating: 3.5,  // Fixed rating, non-interactive
                                                                              //   itemCount: 5, // Number of stars
                                                                              //   itemSize: MediaQuery.of(context).size.height * 0.015, // Adjust size
                                                                              //   direction: Axis.horizontal,
                                                                              //   itemBuilder: (context, index) => Icon(
                                                                              //     Icons.star_rate_rounded,
                                                                              //     color: Color(0xFFFFD700),  // Gold color
                                                                              //   ),
                                                                              // )

                                                                              RatingBarIndicator(
                                                                                rating: rating,  // Fixed rating (non-clickable)
                                                                                itemCount: 5,  // Number of stars
                                                                                itemSize: MediaQuery.of(context).size.height * 0.015,  // Adjust size
                                                                                direction: Axis.horizontal,
                                                                                itemBuilder: (context, index) {
                                                                                  // Dynamic logic for full, half, and empty stars based on the rating
                                                                                  if (index < rating) {
                                                                                    // Display gold (full star) if the index is less than the rating
                                                                                    return Icon(
                                                                                      Icons.star_rate_rounded,
                                                                                      color: Color(0xFFFFD700),  // Gold color for filled stars
                                                                                    );
                                                                                  } else if (index == rating.floor() && rating != rating.floor()) {
                                                                                    // Display half star if the index is equal to the floor value of rating and rating is a decimal
                                                                                    return Icon(
                                                                                      Icons.star_half_rounded,
                                                                                      color: Color(0xFFFFD700),  // Gold color for half star
                                                                                    );
                                                                                  } else {
                                                                                    // Display empty star if the index is greater than the rating
                                                                                    return Icon(
                                                                                      Icons.star_border_rounded,
                                                                                      color: Colors.white,  // White color for empty stars
                                                                                    );
                                                                                  }
                                                                                },
                                                                              )





                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),


                                                                  ],
                                                                ),
                                                              ),

                                                              SizedBox(height : MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.007,),
                                                              // Date and Time
                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                    left: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.01,
                                                                    right: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005,
                                                                    top: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005,
                                                                    bottom: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.005),
                                                                width: double.infinity,
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .start,
                                                                    children: <Widget>[
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xFF126086),
                                                                          borderRadius: BorderRadius
                                                                              .circular(09),
                                                                        ),
                                                                        padding: EdgeInsets.only(
                                                                          left: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.015,
                                                                          right: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.015,
                                                                          top: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.01,
                                                                          bottom: MediaQuery
                                                                              .of(context)
                                                                              .size
                                                                              .height * 0.01,),
                                                                        child: Row(
                                                                          // mainAxisSize: MainAxisSize.max,
                                                                            mainAxisAlignment: MainAxisAlignment
                                                                                .start,
                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                .end,
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child:
                                                                                Row(
                                                                                    mainAxisAlignment: MainAxisAlignment
                                                                                        .spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment
                                                                                        .center,
                                                                                    children: <Widget>[
                                                                                      // Date
                                                                                      Container(
                                                                                        decoration: BoxDecoration(
                                                                                          // color:Colors.white,
                                                                                          borderRadius: BorderRadius
                                                                                              .circular(
                                                                                              15),
                                                                                        ),
                                                                                        // color:Colors.green[100],
                                                                                        padding: EdgeInsets
                                                                                            .only(
                                                                                            left: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.0,
                                                                                            right: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.0,
                                                                                            top: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.00,
                                                                                            bottom: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.00),
                                                                                        child:

                                                                                        Row(
                                                                                            mainAxisAlignment: MainAxisAlignment
                                                                                                .spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .center,
                                                                                            children: <
                                                                                                Widget>[

                                                                                              Icon(Icons
                                                                                                  .calendar_month,
                                                                                                  color: Colors
                                                                                                      .white,
                                                                                                  size: MediaQuery
                                                                                                      .of(
                                                                                                      context)
                                                                                                      .size
                                                                                                      .height *
                                                                                                      0.02),




                                                                                              Column(
                                                                                                children: <
                                                                                                    Widget>[
                                                                                                  Container(
                                                                                                    padding: EdgeInsets
                                                                                                        .only(
                                                                                                        left: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.005,
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
                                                                                                            0.00,
                                                                                                        bottom: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.00),
                                                                                                    child:
                                                                                                    Text(
                                                                                                      "Today, December 17",
                                                                                                      style: TextStyle(
                                                                                                        // color: Colors.blue[600],
                                                                                                          color: Colors
                                                                                                              .white,
                                                                                                          fontWeight: FontWeight
                                                                                                              .w600,
                                                                                                          overflow: TextOverflow
                                                                                                              .ellipsis,
                                                                                                          fontSize: MediaQuery
                                                                                                              .of(
                                                                                                              context)
                                                                                                              .size
                                                                                                              .height *
                                                                                                              0.014),
                                                                                                    ),
                                                                                                  ),

                                                                                                ],
                                                                                              )


                                                                                            ]
                                                                                        ),

                                                                                      ),

                                                                                      // Time
                                                                                      Container(
                                                                                        decoration: BoxDecoration(
                                                                                          // color:Colors.white,
                                                                                          borderRadius: BorderRadius
                                                                                              .circular(
                                                                                              15),
                                                                                        ),
                                                                                        // color:Colors.green[100],
                                                                                        padding: EdgeInsets
                                                                                            .only(
                                                                                            left: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.0,
                                                                                            right: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.0,
                                                                                            top: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.00,
                                                                                            bottom: MediaQuery
                                                                                                .of(
                                                                                                context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.00),
                                                                                        child:

                                                                                        Row(
                                                                                            mainAxisAlignment: MainAxisAlignment
                                                                                                .spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .center,
                                                                                            children: <
                                                                                                Widget>[

                                                                                              Icon(Icons
                                                                                                  .access_time_sharp,
                                                                                                  color: Colors
                                                                                                      .white,
                                                                                                  size: MediaQuery
                                                                                                      .of(
                                                                                                      context)
                                                                                                      .size
                                                                                                      .height *
                                                                                                      0.022),

                                                                                              /* IconButton(
                                                                      padding: EdgeInsets.zero,
                                                                      icon: Icon(Icons.directions,
                                                                        color: Colors.orangeAccent,
                                                                        size: MediaQuery.of(context).size.height * 0.042,),
                                                                      onPressed: () async {
                                                                      }
                                                                  ),*/

                                                                                              /* Icon(brightness_1_rounded,
                                                                      color: Color(0xff036c33),
                                                                      size:  MediaQuery.of(context).size.height * 0.015),*/

                                                                                              // SizedBox(width: width * 0.02), // give it width
                                                                                              Column(
                                                                                                children: <
                                                                                                    Widget>[
                                                                                                  Container(
                                                                                                    padding: EdgeInsets
                                                                                                        .only(
                                                                                                        left: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.005,
                                                                                                        right: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.005,
                                                                                                        top: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.00,
                                                                                                        bottom: MediaQuery
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .size
                                                                                                            .height *
                                                                                                            0.00),
                                                                                                    child:
                                                                                                    Text(
                                                                                                      "10:00 - 11:00 AM",
                                                                                                      style: TextStyle(
                                                                                                        // color: Colors.blue[600],
                                                                                                          color: Colors
                                                                                                              .white,
                                                                                                          fontWeight: FontWeight
                                                                                                              .w600,
                                                                                                          overflow: TextOverflow
                                                                                                              .ellipsis,
                                                                                                          fontSize: MediaQuery
                                                                                                              .of(
                                                                                                              context)
                                                                                                              .size
                                                                                                              .height *
                                                                                                              0.014),
                                                                                                    ),
                                                                                                  ),

                                                                                                ],
                                                                                              )


                                                                                            ]
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
                                    ],
                                  ),
                                ),
                              ],
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
                          'assets/Home.png',
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
                          'assets/Appoinmentsactive.png',
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
      } else
      if (selected == 2) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return UploadPrescriptionMain();
            },
          ),
        );
      } else if (selected == 3) {

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

      /*widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;*/

      // Fluttertoast.showToast(msg: "test", toastLength: Toast.LENGTH_LONG);
      print(selected);
    });
  }

  void showBottomSheet() =>
      showModalBottomSheet(
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
        builder: (context) =>
            StatefulBuilder(
              builder: (BuildContext context,
                  StateSetter setState /*You can rename this!*/) =>
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery
                            .of(context)
                            .viewInsets
                            .bottom),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: Color(0xFFD9D9D9), // Divider color
                                          borderRadius: BorderRadius.circular(
                                              10), // Rounded edges
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height : MediaQuery.of(context).size.height * 0.02),





                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (BuildContext context) {
                                      //       return AppointmentsFootMain();
                                      //     },
                                      //   ),
                                      // );
                                      appointmentcancelalert.showticket(context);

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
                                        color: Color(0xFFA8B1CE).withOpacity(
                                            0.1),

                                        borderRadius: BorderRadius.circular(
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
                                              padding: EdgeInsets.only(
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
                                                      EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                      ),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          right: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          bottom: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                        ),
                                                        height: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.025,
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.025,
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
                                                      children: <Widget>[
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
                                                            "Cancel Appointments",
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
                                                                  .of(context)
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
                                            return MedicatiSelectTimeSlot( "");
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
                                        color: Color(0xFFA8B1CE).withOpacity(
                                            0.1),

                                        borderRadius: BorderRadius.circular(
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
                                              padding: EdgeInsets.only(
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
                                                      EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                      ),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          right: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          bottom: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                        ),
                                                        height: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.025,
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.025,
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
                                                      children: <Widget>[
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
                                                            "Rescheduled Appoinment",
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
                                                                  .of(context)
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
