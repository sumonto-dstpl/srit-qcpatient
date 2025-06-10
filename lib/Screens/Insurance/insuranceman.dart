import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
import 'package:newfolder/Screens/Insurance/filter.dart';
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
import 'package:newfolder/Screens/Insurance/addinsurance.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Medications/medicationselecttime.dart';
import 'package:newfolder/Screens/Medications/medicationsmybook.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
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
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';

class InsuranceMain extends StatefulWidget {
  int selectedIndex = 0;

  InsuranceMain({
    super.key,
  });

  @override
  State<InsuranceMain> createState() => InsuranceMainstate();
}

class InsuranceMainstate extends State<InsuranceMain> {
  String usernameValue = "Insurance";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final mytopspecialities = [
    ["assets/Diagnostic.png", "Diagnostic"],
    ["assets/Doctor.png", "Doctor"],
    ["assets/Nurse.png", "Nurse"],
    ["assets/Physio.png", "Physio"],
    ["assets/MedicalEquipment.png", "Medical Equipment's"],
  ];
  final List<List<dynamic>>  uploadfilestime = [
    ["Balsam Gold", Color(0xFFFFD700).withOpacity(0.8) ],
    ["Balsam Silver", Color(0xFFADD8E6).withOpacity(0.8) ],
    ["Balsam Bronze", Color(0xFFB5B5B5).withOpacity(0.8) ]
  ];

  final List<List<Color>> gradientColorOptions = [
    [Color(0xFFFFD700), Colors.black], // Gold to Black
    [Color(0xFFADD8E6), Colors.black],
    [Color(0xFFB5B5B5), Colors.black], // Cement to Black
  ];

  // List of filter categories
  final List<String> categories = [
    'Category',
  ];

  // Tracks the selected category
  int selectedCategoryIndex = 0;

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



                        Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // TabBar Section
                          Expanded(
                              child:
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02,
                                right:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.01,
                                bottom:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02,
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
                                      0.016),
                              unselectedLabelColor: Colors.black,
                              unselectedLabelStyle:
                              TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.015
                              ),
                              tabs: [
                                Tab(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "My insurance",
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
                                        "Approvals",
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                          ),



                          Visibility(
                              visible: uploadfilestime.length > 0, // Toggle this value to show/hide
                              child:
                              InkWell(
                                onTap: () {

                                  showBottomSheet();


                                },
                                child:
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.0015,
                                right: MediaQuery.of(context).size.height * 0.025,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                                top: MediaQuery.of(context).size.height * 0.01
                            ),
                            width: screenHeight * 0.022, // Adjust image width
                            height: screenHeight * 0.022, // Adjust image height
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/scansearch.png'), // Replace with your asset path
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                              ),
                          ),


                          ]
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
                                          shrinkWrap:
                                          true, // Prevents infinite height
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: gradientColorOptions.length,
                                          itemBuilder: (context, index) {



                                            return

                                              Dismissible(
                                                  key: Key(index.toString()), // Unique key for each item
                                                  direction: DismissDirection.endToStart, // Swipe right to left
                                                  confirmDismiss: (direction) async {
                                                  // Show confirmation dialog
                                                    return await showGeneralDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                                      barrierColor: Colors.black.withOpacity(0.1),
                                                      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                                                        return BackdropFilter(
                                                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                                                          child: Center(
                                                            child: LayoutBuilder(
                                                              builder: (context, constraints) {
                                                                final bool isSmallScreen = constraints.maxHeight < 600;
                                                                final double dialogWidth = constraints.maxWidth * 0.9;
                                                                final double dialogHeight = constraints.maxHeight * (isSmallScreen ? 0.32 : 0.3);

                                                                return Dialog(
                                                                  backgroundColor: Colors.transparent,
                                                                  insetPadding: EdgeInsets.zero,
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(20),
                                                                    child: Container(
                                                                      width: dialogWidth,
                                                                      height: dialogHeight,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(20),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          // First Container (Image + Text)
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(
                                                                              horizontal: constraints.maxHeight * (isSmallScreen ? 0.015 : 0.02),
                                                                              vertical: constraints.maxHeight * (isSmallScreen ? 0.015 : 0.03),
                                                                            ),
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Image.asset(
                                                                                  'assets/insurancealert.png',
                                                                                  height: constraints.maxHeight * 0.07,
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                                SizedBox(height: constraints.maxHeight * (isSmallScreen ? 0.015 : 0.035)),
                                                                                Padding(
                                                                                  padding: EdgeInsets.symmetric(
                                                                                    horizontal: constraints.maxHeight * (isSmallScreen ? 0.025 : 0.04),
                                                                                  ),
                                                                                  child: Text(
                                                                                    "Are you sure to Remove the Selected Insurance ?",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54,
                                                                                      fontSize: constraints.maxHeight * 0.017,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),

                                                                          // Second Container (Buttons)
                                                                          const Spacer(),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(
                                                                              bottom: constraints.maxHeight * (isSmallScreen ? 0.025 : 0.015),
                                                                              left: constraints.maxHeight * 0.025,
                                                                              right: constraints.maxHeight * 0.025,
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () => Navigator.of(context).pop(false),
                                                                                  child: Container(
                                                                                    height: constraints.maxHeight * 0.050,
                                                                                    width: constraints.maxHeight * 0.120,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                      border: Border.all(color: Color(0xFF126086), width: 1),
                                                                                    ),
                                                                                    alignment: Alignment.center,
                                                                                    child: Text(
                                                                                      "Close",
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: constraints.maxHeight * 0.014,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () => Navigator.of(context).pop(true),
                                                                                  child: Container(
                                                                                    height: constraints.maxHeight * 0.050,
                                                                                    width: constraints.maxHeight * 0.120,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFD42620),
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                    ),
                                                                                    alignment: Alignment.center,
                                                                                    child: Text(
                                                                                      "Okay",
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: constraints.maxHeight * 0.014,
                                                                                      ),
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
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );

                                                  },
                                                  background: Container(
                                                    // color: Colors.red,

                                                    alignment: Alignment.centerRight,
                                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size : 16

                                                    ),
                                                  ),
                                                  onDismissed: (direction) {
                                                    gradientColorOptions.removeAt(index); // Remove gradient when dismissed

                                                   /* setState(() {

                                                    });*/

                                                  /*  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text("Gradient $index deleted"),
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );*/
                                                  },
                                                  child:

                                                  // Insurance card Data
                                                  GestureDetector(
                                                    onTap: () {
                                                      // Add your onTap logic here
                                                    },
                                                    child: Card(
                                                      elevation: 0,
                                                      child: Container(
                                                        // width: MediaQuery.of(context).size.height * 0.490,
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                            right:
                                                            MediaQuery.of(context).size.height * 0.005,
                                                            bottom:
                                                            MediaQuery.of(context).size.height * 0.00,
                                                            top: MediaQuery.of(context).size.height * 0.00),
                                                        color: Colors.white,
                                                        child: Container(
                                                          margin: EdgeInsets.only(
                                                              left: MediaQuery.of(context).size.height * 0.01,
                                                              right: MediaQuery.of(context).size.height * 0.01,
                                                              bottom: MediaQuery.of(context).size.height * 0.01,
                                                              top: MediaQuery.of(context).size.height * 0.0),
                                                          // height: MediaQuery.of(context).size.height * 0.22,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            gradient: LinearGradient(
                                                              begin: Alignment.centerLeft,
                                                              end: Alignment.centerRight,
                                                              colors: gradientColorOptions[index],
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      MediaQuery.of(context).size.height *
                                                                          0.02),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                    children: <Widget>[

                                                                      Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[


                                                                          Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  padding: EdgeInsets.only(
                                                                                      left: MediaQuery.of(context).size.height * 0.00,
                                                                                      right: MediaQuery.of(context).size.height * 0.00,
                                                                                      bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                      top: MediaQuery.of(context).size.height * 0.00
                                                                                  ),
                                                                                  child:
                                                                                  Text(
                                                                                    "Miss. Anni Duff",
                                                                                    style: TextStyle(
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      fontSize: MediaQuery.of(context).size.height * 0.014,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w500
                                                                                    ),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  padding: EdgeInsets.only(
                                                                                      left: MediaQuery.of(context).size.height * 0.01,
                                                                                      right: MediaQuery.of(context).size.height * 0.00,
                                                                                      bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                      top: MediaQuery.of(context).size.height * 0.00
                                                                                  ),
                                                                                  child:
                                                                                  Text(
                                                                                    "QID: 26264739222",
                                                                                    style: TextStyle(
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w700,
                                                                                    ),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                ),
                                                                              ]
                                                                          ),

                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              GestureDetector(
                                                                                onTap: () async {

                                                                                },
                                                                                child: Container(
                                                                                  padding: new EdgeInsets.only(
                                                                                      left: MediaQuery.of(context).size.height * 0.007,
                                                                                      right: MediaQuery.of(context).size.height * 0.007,
                                                                                      top: MediaQuery.of(context).size.height * 0.003,
                                                                                      bottom: MediaQuery.of(context).size.height * 0.003),
                                                                                  decoration: BoxDecoration(
                                                                                    color: uploadfilestime[index][1],
                                                                                    borderRadius: BorderRadius.circular(35),
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
                                                                                  child: Text(uploadfilestime[index][0],
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          fontSize:  MediaQuery.of(context).size.height * 0.01,

                                                                                      )),
                                                                                ),
                                                                              ),


                                                                              GestureDetector(
                                                                                onTap: () {

                                                                                /*  Navigator.of(context).push(
                                                                                    MaterialPageRoute(
                                                                                      builder: (BuildContext context) {
                                                                                        return AddInsuranceMain();
                                                                                      },
                                                                                    ),
                                                                                  );*/
                                                                                },
                                                                                child:
                                                                                Container(
                                                                                  margin: EdgeInsets.only(
                                                                                      left: MediaQuery.of(context).size.height * 0.005,
                                                                                      right: MediaQuery.of(context).size.height * 0.01,
                                                                                      bottom: MediaQuery.of(context).size.height * 0.005,
                                                                                      top: MediaQuery.of(context).size.height * 0.005
                                                                                  ),
                                                                                  width: screenHeight * 0.015, // Adjust image width
                                                                                  height: screenHeight * 0.015, // Adjust image height
                                                                                  decoration: BoxDecoration(
                                                                                    image: DecorationImage(
                                                                                      image: AssetImage(
                                                                                          'assets/insuranceEdit.png'), // Replace with your asset path
                                                                                      fit: BoxFit.contain,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),

                                                                      Container(
                                                                        margin :  EdgeInsets.only(
                                                                          top : MediaQuery.of(context).size.height * 0.005
                                                                        ),
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
                                                                                0.0),
                                                                        child: Text(
                                                                          "Qatar Islamic Insurance ",
                                                                          style: TextStyle(
                                                                              color: Color(0xFFFFFFFF),

                                                                              // overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize:
                                                                              MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.016),
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
                                                                                0.01),
                                                                        child: Text(
                                                                          "Group",
                                                                          style: TextStyle(
                                                                              color: Color(0xFFFFFFFF),
                                                                              // overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize:
                                                                              MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.016),
                                                                        ),
                                                                      ),


                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                                            right: MediaQuery.of(context).size.height * 0.005,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                            top: MediaQuery.of(context).size.height * 0.00
                                                                        ),
                                                                        child:
                                                                        Row(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[


                                                                            Expanded(
                                                                              flex : 1,
                                                                              child:
                                                                              Container(
                                                                                padding: EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                    top: MediaQuery.of(context).size.height * 0.00
                                                                                ),
                                                                                child:
                                                                                Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                            top: MediaQuery.of(context).size.height * 0.00
                                                                                        ),
                                                                                        child:
                                                                                        Text(
                                                                                          "Policy Number:",
                                                                                          style: TextStyle(
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w400,
                                                                                          ),
                                                                                          // textAlign: TextAlign.left,
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: MediaQuery.of(context).size.height * 0.0,
                                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                            top: MediaQuery.of(context).size.height * 0.00
                                                                                        ),
                                                                                        child:
                                                                                        Text(
                                                                                          "QII48932701987",
                                                                                          style: TextStyle(
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                          // textAlign: TextAlign.left,
                                                                                        ),
                                                                                      ),
                                                                                    ]
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            Expanded(
                                                                              flex : 1,
                                                                              child:
                                                                              Container(
                                                                                padding: EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                    top: MediaQuery.of(context).size.height * 0.00
                                                                                ),
                                                                                child:
                                                                                Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                            top: MediaQuery.of(context).size.height * 0.00
                                                                                        ),
                                                                                        child:
                                                                                        Text(
                                                                                          "MemberShip No:",
                                                                                          style: TextStyle(
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w400,
                                                                                          ),
                                                                                          // textAlign: TextAlign.left,
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: MediaQuery.of(context).size.height * 0.0,
                                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                            top: MediaQuery.of(context).size.height * 0.00
                                                                                        ),
                                                                                        child:
                                                                                        Text(
                                                                                          "QII48932701987",
                                                                                          style: TextStyle(
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                          // textAlign: TextAlign.left,
                                                                                        ),
                                                                                      ),
                                                                                    ]
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            Expanded(
                                                                              flex : 1,
                                                                              child:
                                                                              Container(
                                                                                padding: EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                    top: MediaQuery.of(context).size.height * 0.00
                                                                                ),
                                                                                child:
                                                                                Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                            top: MediaQuery.of(context).size.height * 0.00
                                                                                        ),
                                                                                        child:
                                                                                        Text(
                                                                                          "Validity:",
                                                                                          style: TextStyle(
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w400,
                                                                                          ),
                                                                                          // textAlign: TextAlign.left,
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: MediaQuery.of(context).size.height * 0.0,
                                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                            top: MediaQuery.of(context).size.height * 0.00
                                                                                        ),
                                                                                        child:
                                                                                        Text(
                                                                                          "28/09",
                                                                                          style: TextStyle(
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                          // textAlign: TextAlign.left,
                                                                                        ),
                                                                                      ),
                                                                                    ]
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

                                    ],
                                  ),
                                ),

                                // Approvals
                                Container(
                                  height: double
                                      .infinity,
                                  // Ensures it occupies full height
                                  width: double
                                      .infinity,
                                      // width: 100,
                                   padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.025,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02),
                                  // Ensures it occupies full width
                                  color: Colors
                                      .white,
                                 child: SingleChildScrollView(
                                  // You can change the background color
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, // Center vertically
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Center horizontally
                                    children: [



                                      GestureDetector(
                                        onTap: () {},
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

                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.0,
                                                right: MediaQuery.of(context).size.height * 0.0,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00
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
                                                      0.015,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01),
                                              child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                                //  Wrap(
                                                                // spacing: 4.0, // horizontal space between children
                                                                // runSpacing: 4.0, // vertical space between runs (if needed)
                                                        Expanded(
                                                          flex: 4,                                                          
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
                                                                  "US ABDOMEN COMPLETE",
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
                                                                      0.005,
                                                                ),
                                                                child: Text(
                                                                  "Qatar Islamic Insurance Group",
                                                                  style:
                                                                  TextStyle(
                                                                    color:Color(0x80000000), 
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
                                                             Wrap(
                                                                spacing: 4.0, // horizontal space between children
                                                                runSpacing: 4.0, // vertical space between runs (if needed)
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.zero,
                                                                    child: Text(
                                                                      "December, 20  2023",
                                                                      style: TextStyle(
                                                                        color: Color(0xFF126086),
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                      left: MediaQuery.of(context).size.height * 0.005,
                                                                    ),
                                                                    child: Text(
                                                                      "(Claim Number : 832787203098)",
                                                                      style: TextStyle(
                                                                        color: Color(0xFF126086),
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                            
                                                            ],
                                                          ),
                                                          
                                                        ),
                                          // ),
                                                        // Adding the side arrow at the end

                                                        Expanded(
                                                          flex: 2,

                                                          child:
                                                          Column(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment : CrossAxisAlignment.end,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                   color:Color(0xFFECFDF3),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                ),
                                                                // color:Colors.green[100],
                                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                                margin : EdgeInsets.only(
                                                                  right : MediaQuery.of(context).size.height * 0.01,
                                                                ),
                                                                child: Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Container(
                                                                        width: 6,
                                                                        height: 6,
                                                                        decoration: BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          color: Color(0xFF12B76A), // Same color as text
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 6),
                                                                      Text(  
                                                                        "Approved",
                                                                        style: TextStyle(color:Color(0xFF027A48) , fontSize: 12, fontWeight: FontWeight.w500),
                                                                      ),
                                                                    ]),
                                                              ),

                                                              SizedBox(height :MediaQuery.of(context).size.height * 0.01, ),
                                                              Container(
                                                                  margin : EdgeInsets.only(
                                                                  right : MediaQuery.of(context).size.height * 0.015,
                                                                ),
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
                                                                    MainAxisAlignment.end,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Container(
                                                                        margin:
                                                                        EdgeInsets.symmetric(horizontal: 2),
                                                                        height:
                                                                        MediaQuery.of(context).size.height *
                                                                            0.003,
                                                                        width:
                                                                        MediaQuery.of(context).size.height *
                                                                            0.003,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.black,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                      ),
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
                                                                            'QR 1009',
                                                                            style: TextStyle(
                                                                              // color: Colors.blue[600],
                                                                                color: Color(0xFF000000),
                                                                                fontWeight: FontWeight.w500,
                                                                                overflow:
                                                                                TextOverflow.ellipsis,

                                                                                fontSize:
                                                                                MediaQuery.of(context)
                                                                                    .size
                                                                                    .height *
                                                                                    0.014),
                                                                          )),
                                                                    ]),
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
                                      GestureDetector(
                                        onTap: () {},
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

                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.0,
                                                right: MediaQuery.of(context).size.height * 0.0,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00
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
                                                      0.015,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: <Widget>[

                                                  Expanded(
                                                    flex: 4,
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
                                                            "US ABDOMEN COMPLETE",
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
                                                                0.005,
                                                          ),
                                                          child: Text(
                                                            "Qatar Islamic Insurance Group",
                                                            style:
                                                            TextStyle(
                                                              color:Color(0x80000000),
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
                                                         Wrap(
                                                          spacing: 4.0, // horizontal space between children
                                                          runSpacing: 4.0, // vertical space between runs (if needed)
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
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                              ),
                                                              child: Text(
                                                                "(Claim Number : 832787203098)",
                                                                style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Adding the side arrow at the end

                                                  Expanded(
                                                    flex: 2,
                                                    child:
                                                    Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment : CrossAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color:Color(0xFFECFDF3),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          // color:Colors.green[100],
                                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.01,
                                                          ),
                                                          child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  width: 6,
                                                                  height: 6,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Color(0xFF12B76A), // Same color as text
                                                                  ),
                                                                ),
                                                                SizedBox(width: 6),
                                                                Text(
                                                                  "Approved",
                                                                  style: TextStyle(color:Color(0xFF027A48) , fontSize: 12, fontWeight: FontWeight.w500),
                                                                ),
                                                              ]),
                                                        ),

                                                        SizedBox(height :MediaQuery.of(context).size.height * 0.01, ),
                                                        Container(
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.015,
                                                          ),
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
                                                              MainAxisAlignment.end,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  margin:
                                                                  EdgeInsets.symmetric(horizontal: 2),
                                                                  height:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  width:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.black,
                                                                    shape: BoxShape.circle,
                                                                  ),
                                                                ),
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
                                                                      'QR 1009',
                                                                      style: TextStyle(
                                                                        // color: Colors.blue[600],
                                                                          color: Color(0xFF000000),
                                                                          fontWeight: FontWeight.w500,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,

                                                                          fontSize:
                                                                          MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.014),
                                                                    )),
                                                              ]),
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
                                      GestureDetector(
                                        onTap: () {},
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

                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.0,
                                                right: MediaQuery.of(context).size.height * 0.0,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00
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
                                                      0.015,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: <Widget>[

                                                  Expanded(
                                                    flex: 4,
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
                                                            "US ABDOMEN COMPLETE",
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
                                                                0.005,
                                                          ),
                                                          child: Text(
                                                            "Qatar Islamic Insurance Group",
                                                            style:
                                                            TextStyle(
                                                              color:Color(0x80000000),
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
                                                         Wrap(
                                                          spacing: 4.0, // horizontal space between children
                                                          runSpacing: 4.0, // vertical space between runs (if needed)
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
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                              ),
                                                              child: Text(
                                                                "(Claim Number : 832787203098)",
                                                                style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Adding the side arrow at the end

                                                  Expanded(
                                                    flex: 2,
                                                    child:
                                                    Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment : CrossAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color:Color(0xFFFDECEC),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          // color:Colors.green[100],
                                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.01,
                                                          ),
                                                          child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  width: 6,
                                                                  height: 6,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Color(0xFFFF0000), // Same color as text
                                                                  ),
                                                                ),
                                                                SizedBox(width: 6), 
                                                                Text(
                                                                  "Rejected",
                                                                  style: TextStyle(color:Color(0xFFFF0000) , fontSize: 12, fontWeight: FontWeight.w500),
                                                                ),
                                                              ]),
                                                        ),

                                                        SizedBox(height :MediaQuery.of(context).size.height * 0.01, ),
                                                        Container(
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.015,
                                                          ),
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
                                                              MainAxisAlignment.end,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  margin:
                                                                  EdgeInsets.symmetric(horizontal: 2),
                                                                  height:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  width:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.black,
                                                                    shape: BoxShape.circle,
                                                                  ),
                                                                ),
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
                                                                      'QR 1009',
                                                                      style: TextStyle(
                                                                        // color: Colors.blue[600],
                                                                          color: Color(0xFF000000),
                                                                          fontWeight: FontWeight.w500,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,

                                                                          fontSize:
                                                                          MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.014),
                                                                    )),
                                                              ]),
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
                                      GestureDetector(
                                        onTap: () {},
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

                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.0,
                                                right: MediaQuery.of(context).size.height * 0.0,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00
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
                                                      0.015,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: <Widget>[

                                                  Expanded(
                                                    flex: 4,
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
                                                            "US ABDOMEN COMPLETE",
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
                                                                0.005,
                                                          ),
                                                          child: Text(
                                                            "Qatar Islamic Insurance Group",
                                                            style:
                                                            TextStyle(
                                                              color:Color(0x80000000),
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
                                                        Wrap(
                                                          spacing: 4.0, // horizontal space between children
                                                          runSpacing: 4.0, // vertical space between runs (if needed)
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
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                              ),
                                                              child: Text(
                                                                "(Claim Number : 832787203098)",
                                                                style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Adding the side arrow at the end

                                                  Expanded(
                                                    flex: 2,
                                                    child:
                                                    Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment : CrossAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color:Color(0x1AFF9500),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          // color:Colors.green[100],
                                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.01,
                                                          ),
                                                          child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  width: 6,
                                                                  height: 6,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Color(0xFFFF9500), // Same color as text
                                                                  ),
                                                                ),
                                                                SizedBox(width: 6),
                                                                Text(
                                                                  "Pending",
                                                                  style: TextStyle(color:Color(0xFFFF9500) , fontSize: 12, fontWeight: FontWeight.w500),
                                                                ),
                                                              ]),
                                                        ),

                                                        SizedBox(height :MediaQuery.of(context).size.height * 0.01, ),
                                                        Container(
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.015,
                                                          ),
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
                                                              MainAxisAlignment.end,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  margin:
                                                                  EdgeInsets.symmetric(horizontal: 2),
                                                                  height:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  width:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.black,
                                                                    shape: BoxShape.circle,
                                                                  ),
                                                                ),
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
                                                                      'QR 1009',
                                                                      style: TextStyle(
                                                                        // color: Colors.blue[600],
                                                                          color: Color(0xFF000000),
                                                                          fontWeight: FontWeight.w500,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,

                                                                          fontSize:
                                                                          MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.014),
                                                                    )),
                                                              ]),
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
                                      GestureDetector(
                                        onTap: () {},
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

                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.0,
                                                right: MediaQuery.of(context).size.height * 0.0,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00
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
                                                      0.015,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: <Widget>[

                                                  Expanded(
                                                    flex: 4,
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
                                                            "US ABDOMEN COMPLETE",
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
                                                                0.005,
                                                          ),
                                                          child: Text(
                                                            "Qatar Islamic Insurance Group",
                                                            style:
                                                            TextStyle(
                                                              color:Color(0x80000000),
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
                                                        Wrap(
                                                          spacing: 4.0, // horizontal space between children
                                                          runSpacing: 4.0, // vertical space between runs (if needed)
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
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                              ),
                                                              child: Text(
                                                                "(Claim Number : 832787203098)",
                                                                style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Adding the side arrow at the end

                                                  Expanded(
                                                    flex: 2,
                                                    child:
                                                    Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment : CrossAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color:Color(0xFFECFDF3),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          // color:Colors.green[100],
                                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.01,
                                                          ),
                                                          child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  width: 6,
                                                                  height: 6,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Color(0xFF12B76A), // Same color as text
                                                                  ),
                                                                ),
                                                                SizedBox(width: 6),
                                                                Text(
                                                                  "Approved",
                                                                  style: TextStyle(color:Color(0xFF027A48) , fontSize: 12, fontWeight: FontWeight.w500),
                                                                ),
                                                              ]),
                                                        ),

                                                        SizedBox(height :MediaQuery.of(context).size.height * 0.01, ),
                                                        Container(
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.015,
                                                          ),
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
                                                              MainAxisAlignment.end,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  margin:
                                                                  EdgeInsets.symmetric(horizontal: 2),
                                                                  height:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  width:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.black,
                                                                    shape: BoxShape.circle,
                                                                  ),
                                                                ),
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
                                                                      'QR 1009',
                                                                      style: TextStyle(
                                                                        // color: Colors.blue[600],
                                                                          color: Color(0xFF000000),
                                                                          fontWeight: FontWeight.w500,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,

                                                                          fontSize:
                                                                          MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.014),
                                                                    )),
                                                              ]),
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
                                      GestureDetector(
                                        onTap: () {},
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

                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.0,
                                                right: MediaQuery.of(context).size.height * 0.0,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00
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
                                                      0.015,
                                                  right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: <Widget>[

                                                  Expanded(
                                                    flex: 4,
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
                                                            "US ABDOMEN COMPLETE",
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
                                                                0.005,
                                                          ),
                                                          child: Text(
                                                            "Qatar Islamic Insurance Group",
                                                            style:
                                                            TextStyle(
                                                              color:Color(0x80000000),
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
                                                         Wrap(
                                                          spacing: 4.0, // horizontal space between children
                                                          runSpacing: 4.0, // vertical space between runs (if needed)
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
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                              ),
                                                              child: Text(
                                                                "(Claim Number : 832787203098)",
                                                                style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Adding the side arrow at the end

                                                  Expanded(
                                                    flex: 2,
                                                    child:
                                                    Column(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment : CrossAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color:Color(0xFFECFDF3),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          // color:Colors.green[100],
                                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.01,
                                                          ),
                                                          child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  width: 6,
                                                                  height: 6,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Color(0xFF12B76A), // Same color as text
                                                                  ),
                                                                ),
                                                                SizedBox(width: 6),
                                                                Text(
                                                                  "Approved",
                                                                  style: TextStyle(color:Color(0xFF027A48) , fontSize: 12, fontWeight: FontWeight.w500),
                                                                ),
                                                              ]),
                                                        ),

                                                        SizedBox(height :MediaQuery.of(context).size.height * 0.01, ),
                                                        Container(
                                                          margin : EdgeInsets.only(
                                                            right : MediaQuery.of(context).size.height * 0.015,
                                                          ),
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
                                                              MainAxisAlignment.end,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  margin:
                                                                  EdgeInsets.symmetric(horizontal: 2),
                                                                  height:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  width:
                                                                  MediaQuery.of(context).size.height *
                                                                      0.003,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.black,
                                                                    shape: BoxShape.circle,
                                                                  ),
                                                                ),
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
                                                                      'QR 1009',
                                                                      style: TextStyle(
                                                                        // color: Colors.blue[600],
                                                                          color: Color(0xFF000000),
                                                                          fontWeight: FontWeight.w500,
                                                                          overflow:
                                                                          TextOverflow.ellipsis,

                                                                          fontSize:
                                                                          MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.014),
                                                                    )),
                                                              ]),
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


                                    ],
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
                ],
              ),


              Positioned(
                bottom: 30.0, // Position it at the bottom of the screen
                right: 15.0, // Position it towards the right
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                      bottom: MediaQuery.of(context).size.height * 0.005,
                      left: MediaQuery.of(context).size.height * 0.005,
                      right: MediaQuery.of(context).size.height * 0.005),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.06,
                  width: MediaQuery
                      .of(context)
                      .size
                      .height * 0.06,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF126086), // Button color
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/AddInsurance.png',
                      // Replace with your asset path
                      fit: BoxFit
                          .contain, // Ensure the image fits within the circle
                    ),
                    onPressed: () {


                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return AddInsuranceMain();
                          },
                        ),
                      );

                    },
                  ),
                ),
              )


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
        showBottomSheetappointment();
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

  void showBottomSheetappointment() =>
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
    builder: (context) {
      return FilterForImsurance();
    }


    //     StatefulBuilder(
    //   builder: (BuildContext context,
    //       StateSetter setState /*You can rename this!*/) =>
    //       Padding(
    //         padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(context).viewInsets.bottom),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Padding(
    //               padding: EdgeInsets.only(
    //                   left: MediaQuery.of(context).size.height * 0.025,
    //                   right: MediaQuery.of(context).size.height * 0.0,
    //                   bottom: MediaQuery.of(context).size.height * 0.015),
    //               child: Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Container(
    //                   margin: EdgeInsets.only(
    //                     top: MediaQuery.of(context).size.height * 0.01,
    //                     bottom: MediaQuery.of(context).size.height * 0.0,
    //                     left: MediaQuery.of(context).size.height * 0.00,
    //                     right: MediaQuery.of(context).size.height * 0.00,
    //                   ),
    //                   padding: EdgeInsets.only(
    //                     top: MediaQuery.of(context).size.height * 0.0,
    //                     bottom: MediaQuery.of(context).size.height * 0.0,
    //                     left: MediaQuery.of(context).size.height * 0.00,
    //                     right: MediaQuery.of(context).size.height * 0.00,
    //                   ),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Container(
    //                         padding: EdgeInsets.only(
    //                           top: MediaQuery.of(context).size.height * 0.0,
    //                           bottom: MediaQuery.of(context).size.height * 0.04,
    //                           left: MediaQuery.of(context).size.height * 0.18,
    //                           right: MediaQuery.of(context).size.height * 0.18,
    //                         ),
    //                         child: Divider(
    //                           height: 0,
    //                           indent: 0,
    //                           thickness: MediaQuery.of(context).size.height * 0.008,
    //                           color:Color(0xFF95C8D6).withOpacity(0.3),
    //                         ),
    //                       ),
    //
    //                       // Add Filters (1)
    //                       Padding(
    //                         padding: EdgeInsets.only(
    //                             left: MediaQuery.of(context).size.height * 0.0,
    //                             right: MediaQuery.of(context).size.height * 0.02,
    //                             bottom: MediaQuery.of(context).size.height * 0.00),
    //                         child: Row(
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             children: <Widget>[
    //                               Container(
    //                                 padding: EdgeInsets.only(
    //                                     left: MediaQuery.of(context).size.height *
    //                                         0.00,
    //                                     right: MediaQuery.of(context).size.height *
    //                                         0.00,
    //                                     top: MediaQuery.of(context).size.height *
    //                                         0.00,
    //                                     bottom: MediaQuery.of(context).size.height *
    //                                         0.00),
    //                                 child: Text(
    //                                   "Add Filters (1)",
    //                                   style: TextStyle(
    //                                     color: Colors.black,
    //                                     fontWeight: FontWeight.bold,
    //                                     overflow: TextOverflow.ellipsis,
    //                                     fontSize:
    //                                     MediaQuery.of(context).size.height *
    //                                         0.02,
    //                                   ),
    //                                 ),
    //                               ),
    //                               GestureDetector(
    //                                 onTap: () async {
    //
    //                                 },
    //                                 child: Container(
    //                                   padding: EdgeInsets.only(
    //                                       left: MediaQuery.of(context).size.height *
    //                                           0.00,
    //                                       right:
    //                                       MediaQuery.of(context).size.height *
    //                                           0.00,
    //                                       top: MediaQuery.of(context).size.height *
    //                                           0.00,
    //                                       bottom:
    //                                       MediaQuery.of(context).size.height *
    //                                           0.00),
    //                                   child: Text(
    //                                     "Clear all",
    //                                     style: TextStyle(
    //                                       color: Color(0xFF126086),
    //                                       fontWeight: FontWeight.bold,
    //                                       overflow: TextOverflow.ellipsis,
    //                                       fontSize:
    //                                       MediaQuery.of(context).size.height *
    //                                           0.018,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ]),
    //                       ),
    //
    //
    //
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //
    //
    //
    //             Row(
    //               children: [
    //
    //                 // Left Side: Categories List
    //                 Expanded(
    //                   flex : 2,
    //                   child:
    //                   Container(
    //                     decoration: BoxDecoration(
    //                       color: Color(0xFF95C8D6).withOpacity(0.2),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                     margin: EdgeInsets.only(
    //                         left: MediaQuery.of(context).size.height * 0.020,
    //                         right: MediaQuery.of(context).size.height * 0.0,
    //                         top: MediaQuery.of(context).size.height * 0.0,
    //                         bottom: MediaQuery.of(context).size.height * 0.02),
    //                     // width: MediaQuery.of(context).size.height * 0.2,
    //                     height: MediaQuery.of(context).size.height * 0.35,
    //                     child: ListView.builder(
    //                       itemCount: categories.length,
    //                       itemBuilder: (context, index) {
    //                         return GestureDetector(
    //                           onTap: () {
    //                             setState(() {
    //                               selectedCategoryIndex = index;
    //                             });
    //                           },
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               color: selectedCategoryIndex == index
    //                                   ? Colors.white
    //                                   : Colors.transparent,
    //                               borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(8),
    //                                 bottomLeft: Radius.circular(8),
    //                               ),
    //                             ),
    //                             child: Stack(
    //                               children: [
    //                                 if (selectedCategoryIndex ==
    //                                     index) // Show the side line only for the selected cell
    //                                   Positioned(
    //                                     top: 6, // Gap from the top
    //                                     left: 0,
    //                                     bottom: 6, // Gap from the bottom
    //                                     child: Container(
    //                                       width: 2.0, // Same as border width
    //                                       color:  Color(0xFF126086), // Border color
    //                                     ),
    //                                   ),
    //                                 Container(
    //                                   padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
    //                                   child: Text(
    //                                     categories[index],
    //                                     style: TextStyle(
    //                                       color: selectedCategoryIndex == index
    //                                           ? Color(0xFF126086) : Colors.black87,
    //                                       fontSize: MediaQuery.of(context).size.height * 0.018,
    //                                       fontWeight: selectedCategoryIndex == index
    //                                           ? FontWeight.bold
    //                                           : FontWeight.normal,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                   ),
    //                 ),
    //
    //                 // Right Side: Filter Options
    //                 Expanded(
    //                   flex : 3,
    //                   child:
    //                   Container(
    //                     // width: MediaQuery.of(context).size.height * 0.28,
    //                     height: MediaQuery.of(context).size.height * 0.35,
    //                     padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
    //                     child: _getFilterWidget(categories[selectedCategoryIndex], context),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //
    //
    //
    //             GestureDetector(
    //               onTap: () async {
    //
    //               },
    //               child: Container(
    //                   alignment: Alignment.centerRight,
    //                   padding: EdgeInsets.only(
    //                       top:
    //                       MediaQuery.of(context).size.height * 0.01,
    //                       bottom:
    //                       MediaQuery.of(context).size.height * 0.00,
    //                       left:
    //                       MediaQuery.of(context).size.height * 0.00,
    //                       right: MediaQuery.of(context).size.height *
    //                           0.00),
    //                   margin: EdgeInsets.only(
    //                       right:
    //                       MediaQuery.of(context).size.height * 0.02,
    //                       top:
    //                       MediaQuery.of(context).size.height * 0.01,
    //                       bottom:
    //                       MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height *
    //                           0.02),
    //                   child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Expanded(
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(
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
    //                                       Color(0xFFA8B1CE),
    //                                       Color(0xFFA8B1CE),
    //                                     ])),
    //                             alignment: Alignment.center,
    //                             padding: EdgeInsets.only(left: 0.0),
    //                             child: TextButton(
    //                               onPressed: () async {
    //
    //                               },
    //                               child: Text("Apply Filters",
    //                                   textAlign: TextAlign.center,
    //                                   style: TextStyle(
    //                                       color: Colors.white,
    //                                       fontSize:
    //                                       MediaQuery.of(context)
    //                                           .size
    //                                           .height *
    //                                           0.026)),
    //                             ),
    //                           ),
    //                         ),
    //                       ])),
    //             )
    //
    //
    //
    //           ],
    //         ),
    //       ),
    // ),
  );

  void showBottomSheetforlogout() => showModalBottomSheet(
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
    backgroundColor: Color(0xFFFFFFFF),
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) =>
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the bottom sheet
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Shadow color
                    blurRadius: 10, // Blur intensity
                    spreadRadius: 5, // Spread radius
                    offset: const Offset(0, -4), // Moves shadow upwards
                  ),
                ],
              ),
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
                            // Container(
                            //   padding: EdgeInsets.only(
                            //     top: MediaQuery.of(context).size.height * 0.0,
                            //     bottom: MediaQuery.of(context).size.height * 0.03,
                            //     left: MediaQuery.of(context).size.height * 0.18,
                            //     right: MediaQuery.of(context).size.height * 0.18,
                            //   ),
                            //   child: Divider(
                            //     height: 0,
                            //     indent: 0,
                            //     thickness: MediaQuery.of(context).size.height * 0.008,
                            //     color:Color(0xFF95C8D6).withOpacity(0.3),
                            //   ),
                            // ),
                            Center(
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
                                  color: Color(0x2413678F),    // Divider color
                                  // color: Colors.grey[100]!.withOpacity( 0.1),
                                  // color : Colors.red,
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded edges
                                ),
                              ),
                            ),


                            Padding(
                              padding: EdgeInsets.only(
                                top : MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.height * 0.0,
                                right: MediaQuery.of(context).size.height * 0.0,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(0), // No need for individual padding here
                                    child: Text(
                                      "Do you want to Logout?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                    ),
                                  ),
                                ],
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
                                      0.03,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.02),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context,
                                          rootNavigator: true)
                                          .pop();
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.04,
                                      width: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.17,
                                      padding: new EdgeInsets.only(
                                          left:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.015,
                                          right:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.015,
                                          top:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01,
                                          bottom:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01),
                                      decoration: BoxDecoration(
                                        // color: Colors.grey[300],
                                        borderRadius:
                                        BorderRadius.circular(
                                            5),
                                        border: Border.all(
                                          color: Color(0xFFA8B1CE),
                                          // Border color
                                          width: 1, // Border width
                                        ),
                                      ),

                                      margin: EdgeInsets.only(
                                        left: MediaQuery.of(context)
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
                                            0.00,
                                        right:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.01,
                                      ),
                                      // color: Colors.grey[300],
                                      alignment: Alignment.center,
                                      // height:
                                      // MediaQuery.of(context).size.height * 0.070,
                                      child: Text("Close",
                                          textAlign:
                                          TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .height *
                                                  0.014)),
                                    ),
                                  ),
                                  GestureDetector(
                                    // onTap: () async {
                                    //   await UserSecureStorage.setIfLoggedOut("YES");
                                    //   Navigator.of(context).pushAndRemoveUntil(
                                    //     MaterialPageRoute(
                                    //       builder: (BuildContext context) => LoginPage(),
                                    //     ),
                                    //         (Route route) => false,
                                    //   );
                                    // },
                                    child: Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.04,
                                      width: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.17,
                                      padding: new EdgeInsets.only(
                                          left:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.015,
                                          right:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.015,
                                          top:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01,
                                          bottom:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.01),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD42620).withOpacity(0.5),
                                        borderRadius:
                                        BorderRadius.circular(
                                            5),
                                      ),

                                      margin: EdgeInsets.only(
                                        left: MediaQuery.of(context)
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
                                            0.00,
                                        right:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.005,
                                      ),
                                      // color: Colors.grey[300],
                                      alignment: Alignment.center,
                                      // height:
                                      // MediaQuery.of(context).size.height * 0.070,
                                      child: Text("Okay",
                                          textAlign:
                                          TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .height *
                                                  0.016)),
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







                ],
              ),
            ),
          ),
    ),
  );

}
