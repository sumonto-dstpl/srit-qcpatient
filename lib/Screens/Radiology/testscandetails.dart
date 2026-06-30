import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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


import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:share_plus/share_plus.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';

class TestScanDetails extends StatefulWidget {
  int selectedIndex = 0;

  TestScanDetails({
    super.key,
  });

  @override
  State<TestScanDetails> createState() => TestScanDetailsstate();
}

class TestScanDetailsstate extends State<TestScanDetails> {
  String usernameValue = "Radiology";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final List<String> myopinions = [
    "Fatty liver.",
    "Colonic gaseous distension.",
  ];

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
                  Header(userName: usernameValue),

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
                          Container(
                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.015,
                                right:
                                    MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.00,
                                top: MediaQuery.of(context).size.height * 0.04),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // Center image
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(130.0),
                                      child: Image.asset(
                                        'assets/Radiologytestdetails.png',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.075, // Adjust height
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.075, // Adjust width
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),

                                // Top-right image
                                // Positioned(
                                //   top: 0,
                                //   right: 0,
                                //   child: Container(
                                //     margin: EdgeInsets.only(
                                //         left:
                                //             MediaQuery.of(context).size.height *
                                //                 0.0,
                                //         right:
                                //             MediaQuery.of(context).size.height *
                                //                 0.02,
                                //         bottom:
                                //             MediaQuery.of(context).size.height *
                                //                 0.00,
                                //         top:
                                //             MediaQuery.of(context).size.height *
                                //                 0.0),
                                //     padding: EdgeInsets.only(
                                //       left: MediaQuery.of(context).size.height *
                                //           0.00,
                                //     ),
                                //     child: ClipRRect(
                                //       borderRadius:
                                //           BorderRadius.circular(130.0),
                                //       child: Image.asset(
                                //         'assets/radiologyShare.png',
                                //         height:
                                //             MediaQuery.of(context).size.height *
                                //                 0.03, // Adjust height
                                //         width:
                                //             MediaQuery.of(context).size.height *
                                //                 0.03, // Adjust width
                                //         fit: BoxFit.fill,
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                Positioned(
                                  top: -10,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Share.share(
                                        'Check out this awesome report!',
                                        subject: 'Radiology Report',
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: MediaQuery.of(context).size.height * 0.02,
                                      ),

                                      decoration: BoxDecoration(
                                        color: Colors.transparent, // transparent to keep tap area visible
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        width: MediaQuery.of(context).size.height * 0.05,
                                        decoration: BoxDecoration(

                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.03,
                                            width: MediaQuery.of(context).size.height * 0.03,
                                            decoration: const BoxDecoration(

                                              shape: BoxShape.circle,
                                            ),
                                            padding: EdgeInsets.all(
                                              MediaQuery.of(context).size.height * 0.00, // 🔹 inner spacing
                                            ),
                                            child: Image.asset(
                                              'assets/radiologyShare.png',
                                              fit: BoxFit.fill,
                                              height: MediaQuery.of(context).size.height * 0.03,
                                              width: MediaQuery.of(context).size.height * 0.03,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin : EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01,
                                ),
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "US ABDOMEN COMPLETE",
                                  style: TextStyle(
                                      color: Color(0xFF1F1F1F),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016
                                  ),
                                ),
                              ),
                              Container(
                                margin : EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Prepared by: Dr. AHMED ALAWADHI ",
                                  style: TextStyle(
                                      color: Color(0x80000000),
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014),
                                ),
                              ),
                            ],
                          ),

                          // Date Time
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFA8B1CE).withOpacity(0.1),

                              borderRadius: BorderRadius.circular(
                                  8), // Optional: Rounded corners
                            ),
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.002,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.01),
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.07,
                                right:
                                    MediaQuery.of(context).size.height * 0.07,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                                top: MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // First row: Image and column with 2 texts
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/calendercard.png',
                                        // Replace with your image path
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.01,
                                        width: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.01,
                                        fit: BoxFit.cover,
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.002,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.002,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00),
                                              child: Text(
                                                "December, 20  2023",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.002,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.002,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00),
                                              child: Text(
                                                "7:30 AM",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Divider or custom container
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.002,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        color: Colors.grey[400],
                                        // Divider color
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                      ),
                                    ]),

                                // Second row: Image and column with 2 texts
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/calendercard.png',
                                        // Replace with your image path
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.01,
                                        width: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.01,
                                        fit: BoxFit.cover,
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.002,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.002,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00),
                                              child: Text(
                                                "December, 20  2023",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.01),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.002,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.002,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00),
                                              child: Text(
                                                "7:30 AM",
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.01),
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

                          // ABDOMINAL ULTRASOUND
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.015,
                                    right: MediaQuery.of(context).size.height *
                                        0.015,
                                    top: MediaQuery.of(context).size.height *
                                        0.0,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "ABDOMINAL ULTRASOUND",
                                  style: TextStyle(
                                      color: Color(0xFF1F1F1F),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.015,
                                    right: MediaQuery.of(context).size.height *
                                        0.015,
                                    top: MediaQuery.of(context).size.height *
                                        0.035,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "LIVER: average Size shows brjght echogenicity Ot its parenchyma No focal lesions or gross masses detected. No intra hepatic biliary radicals dilatation. Average caliber Of main PV measuring 8 mm. GALL BLADDER: No visible stones or mud. thin walt Average caliber Of the C.B.D. SPLEEN: Average size with normal echogenicity and no focal lesions, PANCREAS: the visualized parts are unremarkable. KIDNEYS Average size of both kidneys With normal parenchymal thickness. Normal parenchymal echogenicity and good cortico-medullary differentiation No stones or back pressure changes could be seen. No cysts or solid masses. URINARY BLADDER : Not full yet no stones or solid masses are seen. NO intraabdominal free fluid could be seen. cou e seen. o cysts or so masses. URINARY BLADDER :Not full. yet no stones or solid masses are seen. No intraabdominal free fluid could be seen.",
                                  style: TextStyle(
                                    height : MediaQuery.of(context).size.height * 0.0017,
                                      color: Color(0xCC1F1F1F),
                                      fontWeight: FontWeight.w500,
                                      // overflow: TextOverflow.ellipsis,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014),
                                ),
                              ),
                            ],
                          ),

                          // Opinion :
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.015,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.03,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Opinion :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016),
                                ),
                              ),
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
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  // Prevents infinite height
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: myopinions.length,
                                  // Use the length of the string list
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.002,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                      ),
                                      child: Text(
                                        ' -${myopinions[index]}',
                                        // Display the string at the current index
                                        style: TextStyle(
                                          color: Color(0xCC1F1F1F),
                                          fontWeight: FontWeight.w500,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.014,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.015,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Row(
                                  children: [
                                    Text(
                                      "Approved By",
                                      style: TextStyle(
                                          color: Color(0xFF1F1F1F),
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016),
                                    ),
                                    SizedBox(width : MediaQuery.of(context).size.height * 0.005),
                                    Text(
                                      ": Mohammad Farouk",
                                      style: TextStyle(
                                          color: Color(0xCC1F1F1F),
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height  : MediaQuery.of(context).size.height * 0.09),
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


}
