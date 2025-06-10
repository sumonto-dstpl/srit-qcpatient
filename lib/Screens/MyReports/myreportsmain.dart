import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
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
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Widgets/tab_item.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
import 'dart:async';

import '../Address/address_screen.dart';

class MyReportsMain extends StatefulWidget {
  int selectedIndex = 1;

  MyReportsMain({
    super.key,
  });

  @override
  State<MyReportsMain> createState() => MyReportsMainstate();
}

class MyReportsMainstate extends State<MyReportsMain>
    with TickerProviderStateMixin {
  String usernameValue = "My Reports";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 1;
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
  late TabController _tabController;

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

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();



  @override
  void initState() {

    super.initState();

    checkGuestUser();
  }

  void checkGuestUser() async {
    final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";
    if (isLoggedIn == "YES") {
      Timer(Duration(seconds: 0), () {
        LoginBottomSheet.show(context,false);
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: 2, vsync: this); // 2 tabs
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
                                // if(!_isLoading)
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (BuildContext context) {
                                        // return GoogleMapScreen();
                                        return AddressScreen();
                                      },
                                    ),
                                  );
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
                                    .height * 0.03),
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
                                        "Prescriptions",
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
                                        "Medical Reports",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // TabBarView Section
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Active Prescription List
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
                                  margin: EdgeInsets.only(
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.005,

                                     ),
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
                                                    0.00),
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
                                              2,
                                              // You can adjust the item count
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                    elevation: 0.0,
                                                    color: Colors.white,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .white,
                                                        // Background color of the container
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                0.1),
                                                            // Shadow color
                                                            blurRadius:
                                                            5,
                                                            // Spread of the shadow
                                                            offset: Offset(0,
                                                                0), // Offset in x and y direction
                                                          ),
                                                        ],
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8), // Optional: Rounded corners
                                                      ),
                                                      width:
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.450,
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
                                                          bottom: MediaQuery
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
                                                              0.00),
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.02,
                                                          right: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.02,
                                                          bottom: MediaQuery
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
                                                              0.00),
                                                      // color: Colors.white,
                                                      child: Container(
                                                        // color: Colors.white,

                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10),
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .centerLeft,
                                                                end: Alignment
                                                                    .centerRight,
                                                                stops: [
                                                                  0.5,
                                                                  0.9
                                                                ],
                                                                colors: [
                                                                  Color(
                                                                      0xFFffffff),
                                                                  Color(
                                                                      0xFFffffff)
                                                                ])),
                                                        margin: EdgeInsets.only(
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
                                                                0.00,
                                                            bottom: MediaQuery
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
                                                                0.00),
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
                                                            bottom: MediaQuery
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
                                                                0.005),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Container(

                                                                padding: EdgeInsets
                                                                    .only(
                                                                    left: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.015,
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
                                                                        0.015,
                                                                    bottom: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.00),

                                                                /*  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),*/
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: <
                                                                      Widget>[
                                                                    // Expanded(
                                                                    //   flex: 2,
                                                                    //   child:
                                                                    //   Container(
                                                                    //     padding:
                                                                    //     EdgeInsets
                                                                    //         .only(
                                                                    //       left: MediaQuery
                                                                    //           .of(
                                                                    //           context)
                                                                    //           .size
                                                                    //           .height *
                                                                    //           0.00,
                                                                    //     ),
                                                                    //     child:
                                                                    //     ClipRRect(
                                                                    //       borderRadius:
                                                                    //       BorderRadius
                                                                    //           .circular(
                                                                    //           130.0),
                                                                    //       child:
                                                                    //       Image
                                                                    //           .asset(
                                                                    //         'assets/NutanBhatt.png',
                                                                    //         fit:
                                                                    //         BoxFit
                                                                    //             .fill,
                                                                    //       ),
                                                                    //     ),
                                                                    //   ),
                                                                    //
                                                                    //
                                                                    // ),
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
                                                                        width: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.015),
                                                                    Expanded(
                                                                      flex: 8,
                                                                      child:
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
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
                                                                                    0.00),
                                                                            child:
                                                                            Text(
                                                                              "Dr. Nutan Bhatt",
                                                                              style: TextStyle(
                                                                                  color: Colors
                                                                                      .black87,
                                                                                  overflow: TextOverflow
                                                                                      .ellipsis,
                                                                                  fontWeight: FontWeight
                                                                                      .w600,
                                                                                  fontSize: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.016),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding: EdgeInsets
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
                                                                                    0.00,
                                                                                bottom: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .height *
                                                                                    0.00),
                                                                            child:
                                                                            Text(
                                                                              "General physician / Internal Medicine",
                                                                              style: TextStyle(
                                                                                  color: Colors
                                                                                      .black54,
                                                                                  fontWeight: FontWeight
                                                                                      .w500,
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
                                                                          Container(
                                                                            padding: EdgeInsets
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
                                                                                    0.00,
                                                                                bottom: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .height *
                                                                                    0.00),
                                                                            child:
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  "August 20 2024",
                                                                                  style: TextStyle(
                                                                                      color: Color(
                                                                                          0xFF126086),
                                                                                      fontWeight: FontWeight
                                                                                          .w600,
                                                                                      overflow: TextOverflow
                                                                                          .ellipsis,
                                                                                      fontSize: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.012),
                                                                                ),
                                                                                Container(
                                                                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                                                                  height: MediaQuery.of(context).size.height * 0.004,
                                                                                  width: MediaQuery.of(context).size.height * 0.004,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF126086),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),

                                                                                Text(
                                                                                  "Priya Krishnamurty ",
                                                                                  style: TextStyle(
                                                                                      color: Color(
                                                                                          0xFF126086),
                                                                                      fontWeight: FontWeight
                                                                                          .w600,
                                                                                      overflow: TextOverflow
                                                                                          .ellipsis,
                                                                                      fontSize: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.012),
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
                                                                margin: EdgeInsets.only(
                                                                  left: MediaQuery.of(context).size.height * 0.02,
                                                                  top: MediaQuery.of(context).size.height * 0.01,
                                                                  bottom: MediaQuery.of(context).size.height * 0.005,
                                                                  right: MediaQuery.of(context).size.height * 0.02,
                                                                ),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    left: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    right: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    bottom: MediaQuery
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
                                                                        0.01),
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      5),
                                                                  gradient:
                                                                  LinearGradient(
                                                                    begin: Alignment
                                                                        .centerLeft,
                                                                    end: Alignment
                                                                        .centerRight,
                                                                    stops: [
                                                                      0.5,
                                                                      0.9
                                                                    ],
                                                                    colors: [
                                                                      Color(0x0F7F7F7F)

                                                                      ,
                                                                      Color(0x0F7F7F7F)


                                                                    ],
                                                                  ),
                                                                ),
                                                                child: Row(

                                                                  children: [

                                                                    Text(
                                                                      "3 MEDICINES INCLUDED",
                                                                      style: TextStyle(
                                                                        color: Color(
                                                                            0xFF126086),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontSize: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.012,
                                                                      ),
                                                                    ),
                                                                    // Spacer to push "Order Now" to the end
                                                                    Spacer(),
                                                                    // Right-aligned text
                                                                    Text(
                                                                      "Order Now",
                                                                      style: TextStyle(
                                                                        color: Color(
                                                                            0xFF126086),
                                                                        fontWeight: FontWeight
                                                                            .w600,
                                                                        fontSize: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.012,
                                                                      ),
                                                                    ),


                                                                  ],
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
                                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                                margin : EdgeInsets.only(

                                                                    top: MediaQuery.of(context).size.height * 0.007,
                                                                    bottom: MediaQuery.of(context).size.height * 0.015
                                                                ),
                                                                child:

                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceEvenly,
                                                                  children: <
                                                                      Widget>[
                                                                    GestureDetector(
                                                                      onTap: () async {},
                                                                      child: Container(
                                                                        padding: new EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.025,
                                                                            right: MediaQuery.of(context).size.height * 0.025,
                                                                            top: MediaQuery.of(context).size.height * 0.007,
                                                                            bottom: MediaQuery.of(context).size.height * 0.007),
                                                                        decoration: BoxDecoration(
                                                                          // color: Colors.grey[300],
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          border: Border.all(
                                                                            color: Color(0xFF126086),// Border color
                                                                            width: 0.5,            // Border width
                                                                          ),
                                                                        ),


                                                                        // margin: EdgeInsets.only(
                                                                        //   left: MediaQuery.of(context).size.height * 0.02,
                                                                        //   top: MediaQuery.of(context).size.height * 0.00,
                                                                        //   bottom: MediaQuery.of(context).size.height * 0.00,
                                                                        //   right: MediaQuery.of(context).size.height * 0.02,
                                                                        // ),
                                                                        // color: Colors.grey[300],
                                                                        alignment: Alignment.center,
                                                                        // height:
                                                                        // MediaQuery.of(context).size.height * 0.070,
                                                                        child: Text(
                                                                            "View Prescription",
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: TextStyle(color: Color(0xFF126086),
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize:  MediaQuery.of(context).size.height * 0.014)),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () async {
                                                                        Navigator
                                                                            .of(
                                                                            context)
                                                                            .push(
                                                                          MaterialPageRoute(
                                                                            builder:
                                                                                (
                                                                                BuildContext context) {
                                                                              return MedicatiSelectTimeSlot(
                                                                                  "widget.doctoridval");
                                                                            },
                                                                          ),
                                                                        );
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


                                                                        // margin: EdgeInsets.only(
                                                                        //   left: MediaQuery.of(context).size.height * 0.00,
                                                                        //   top: MediaQuery.of(context).size.height * 0.00,
                                                                        //   bottom: MediaQuery.of(context).size.height * 0.00,
                                                                        //   right: MediaQuery.of(context).size.height * 0.02,
                                                                        // ),
                                                                        // color: Colors.grey[300],
                                                                        alignment: Alignment.center,
                                                                        // height:
                                                                        // MediaQuery.of(context).size.height * 0.070,
                                                                        child: Text(
                                                                            "Book Follow -Up",
                                                                            textAlign: TextAlign
                                                                                .center,
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize:  MediaQuery.of(context).size.height * 0.014)),
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
                                    ],
                                  ),
                                ),

                                // Medical Reports List
                                Container(
                                  height: double
                                      .infinity,
                                  // Ensures it occupies full height
                                  width: double
                                      .infinity,
                                  // Ensures it occupies full width
                                  color: Colors
                                      .white,
                                  // You can change the background color
                                  child: Column(
                                    children: [

                                      // TabBar

                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.040,
                                        margin: EdgeInsets.only(
                                            left: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.03,
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00,
                                            bottom: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.015,
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.02),
                                        color: Colors.white,
                                        child:

                                        TabBar(
                                          tabAlignment: TabAlignment.start,
                                          isScrollable: true,
                                          labelPadding: EdgeInsets.zero,
                                          padding: EdgeInsets.zero,
                                          physics: ScrollPhysics(),
                                          indicatorPadding: EdgeInsets.only(
                                              left: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.00,
                                              right: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.02,
                                              bottom: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.00,
                                              top: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.00),
                                          dividerColor: Colors.transparent,
                                          controller: _tabController,
                                          indicatorColor: Color(0xFF00C5BB),
                                            // indicatorColor : Colors.red,
                                          labelColor: Color(0xFF00C5BB),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height *
                                                  0.014),
                                          unselectedLabelColor: Colors.black,
                                          unselectedLabelStyle:
                                          TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height *
                                                  0.012
                                          ),
                                          tabs: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00,
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.02,
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.0,
                                                  top: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00),
                                              // Add space after the first tab
                                              child: Tab(text: 'Laboratory'),
                                            ),


                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00,
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.02,
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.0,
                                                  top: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00),
                                              // Add space after the first tab
                                              child:
                                              Tab(text: 'Radiology Reports'),
                                            ),
                                          ],
                                        ),
                                      ),


                                      // TabBar content
                                      Expanded(
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: [
                                            // Tab 1 List
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: 4,
                                              itemBuilder: (context, index) {
                                                return Stack(
                                                  children: [
                                                    GestureDetector(
                                                    onTap: () {


                                                    },
                                                    child: Card(
                                                    elevation: 0.0,
                                                    color: Colors.white,
                                                    child:

                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white, // Background color of the container
                                                        border: Border.all(
                                                          color: Colors.black.withOpacity(0.1), // Border color
                                                          width: 1, // Border width
                                                        ),
                                                        borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
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
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                          right: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.015,

                                                      ),                                                        // color: Colors.white,
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
                                                                0.01,
                                                            right: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.02,
                                                            bottom: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            top: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.015),
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
                                                                  Container(
                                                                    height : MediaQuery.of(context).size.height * 0.05,
                                                                    width : MediaQuery.of(context).size.height * 0.05,
                                                                    decoration: BoxDecoration(
                                                                      color : Color(0x1A126086),
                                                                      shape: BoxShape.circle,
                                                                    ),
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
                                                                        'assets/myreportsLaboratory.png',
                                                                        fit:
                                                                        BoxFit.fill,

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
                                                                            "Calcium Score Screening",
                                                                            style:
                                                                            TextStyle(
                                                                              color: Color(0xFF1F1F1F),
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
                                                                            "Dr. Priya, Gastroenterology",
                                                                            style:
                                                                            TextStyle(
                                                                              color: Color(0x80000000),
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
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start, // Adjust alignment as needed
                                                                          children: [
                                                                            Container(
                                                                              padding: EdgeInsets.only(
                                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                                              ),
                                                                              child: Text(
                                                                                "December, 20  2023",
                                                                                style: TextStyle(
                                                                                  color: Color(0xFF126086),
                                                                                  fontWeight: FontWeight.w600,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            Container(
                                                                              margin: EdgeInsets.only(
                                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                                                right: MediaQuery.of(context).size.height * 0.005,
                                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                                              ),
                                                                              height: 9,
                                                                              width: 1.0, // Same as border width
                                                                              color:  Color(0xFF126086), // Border color
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.only(
                                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                                              ),
                                                                              child: Text(
                                                                                "11 : 11 AM",
                                                                                style: TextStyle(
                                                                                  color: Color(0xFF126086),
                                                                                  fontWeight: FontWeight.w600,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
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
                                                  ),
                                                    Positioned(

                                                      right : 15,
                                                      top : -6,

                                                      child: Container(
                                                        height: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.04,
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.04,

                                                        child: IconButton(
                                                          icon: Image.asset(
                                                            'assets/myreportsOP.png',
                                                            // Replace with your asset path
                                                            fit: BoxFit
                                                                .contain, // Ensure the image fits within the circle
                                                          ),
                                                          onPressed: () {

                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ]
                                                );
                                              },
                                            ),
                                            // Tab 2 List
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: 4,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {


                                                  },
                                                  child: Card(
                                                    elevation: 0.0,
                                                    color: Colors.white,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white, // Background color of the container
                                                        border: Border.all(
                                                          color: Colors.black.withOpacity(0.1), // Border color
                                                          width: 1, // Border width
                                                        ),
                                                        borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
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
                                                      margin: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.015,
                                                        right: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.015,

                                                      ),
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
                                                                0.01,
                                                            right: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.02,
                                                            bottom: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            top: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.015),
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
                                                                  Container(
                                                                    height : MediaQuery.of(context).size.height * 0.05,
                                                                    width : MediaQuery.of(context).size.height * 0.05,

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
                                                                        // 'assets/myreportsLaboratory.png',
                                                                        'assets/Radiologytestdetails.png',
                                                                        fit:
                                                                        BoxFit.fill,
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
                                                                            "X - ray Bone",
                                                                            style:
                                                                            TextStyle(
                                                                              color: Color(0xFF1F1F1F),
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
                                                                            "US ABDOMEN COMPLETE",
                                                                            style:
                                                                            TextStyle(
                                                                              color: Color(0x80000000),
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
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start, // Adjust alignment as needed
                                                                          children: [
                                                                            Container(
                                                                              padding: EdgeInsets.only(
                                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                                              ),
                                                                              child: Text(
                                                                                "December, 20  2023",
                                                                                style: TextStyle(
                                                                                  color: Color(0xFF126086),
                                                                                  fontWeight: FontWeight.w600,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            Container(
                                                                              margin: EdgeInsets.only(
                                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                                                right: MediaQuery.of(context).size.height * 0.005,
                                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                                              ),
                                                                              height: 9,
                                                                              width: 1.0, // Same as border width
                                                                              color:  Color(0xFF126086), // Border color
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.only(
                                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                                              ),
                                                                              child: Text(
                                                                                "11 : 11 AM",
                                                                                style: TextStyle(
                                                                                  color: Color(0xFF126086),
                                                                                  fontWeight: FontWeight.w600,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
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
                                          ],
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
                          'assets/MyReportsactive.png',
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
      } else if (selected == 1) {} else if (selected == 2) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return UploadPrescriptionMain();
            },
          ),
        );
      }  else if (selected == 3) {
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

      /*  widget.selectedIndex = index;
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
                                                                      'assets/Appointments_ls.png',
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
