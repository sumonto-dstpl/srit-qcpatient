import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/LabTests/bottomsheet.dart';
import 'package:newfolder/Screens/LabTests/labsmartreportslist.dart';
import 'package:newfolder/Screens/LabTests/labviewreportslist.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';

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
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class PreviousOrderViewAll extends StatefulWidget {
  int selectedIndex = 0;
  PreviousOrderViewAll({
    super.key,
  });
  @override
  State<PreviousOrderViewAll> createState() => PreviousOrderViewAllstate();
}

class PreviousOrderViewAllstate extends State<PreviousOrderViewAll> {
  String usernameValue = "Full Body Checkup";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final mybrowsebyhealthcond = [
    ["assets/Diagnostic.png", "Harmone"],
    ["assets/Doctor.png", "Diabetes"],
    ["assets/Nurse.png", "Joint Pain"],
    ["assets/Physio.png", "Thyroid"],
    ["assets/MedicalEquipment.png", "Heart"],
    ["assets/Diagnostic.png", "Bone"],
    ["assets/Doctor.png", "Blood Sugar"],
    ["assets/Nurse.png", "Vitamin"],
    ["assets/Physio.png", "Hair Fall"],
    ["assets/MedicalEquipment.png", "Liver"],
    ["assets/Physio.png", "Kidney"],
    ["assets/MedicalEquipment.png", "Fever"],
  ];

  final myhealthpackages = [
    ["assets/Diagnostic.png", "Full Body Checkup"],
    ["assets/Doctor.png", "Men’s Wellness"],
    ["assets/Nurse.png", "Women’s Health"],
    ["assets/Physio.png", "Thyroid Package"],
    ["assets/MedicalEquipment.png", "Heart Package"],
    ["assets/Diagnostic.png", "Diabetes package"],
    ["assets/Doctor.png", "Blood Studies Package"],
    ["assets/Nurse.png", "Vitamin package"],
    ["assets/Physio.png", "Hairfall package"],
    ["assets/MedicalEquipment.png", "Liver Package"],
    ["assets/Physio.png", "Kidney Package"],
    ["assets/MedicalEquipment.png", "Fever Package"],
  ];

  // List of filter categories
  final List<String> categories = [
    'Must have tests',
    'Category',
  ];

  // Tracks the selected category
  int selectedCategoryIndex = 0;


  final List<String> musthavetests = [
    "Complete Blood Count (CBC)",
    "Glucose, Post Prandial (PP), 2 Hours",
    "Complete Urine Examination",
    "Thyroid Profile (Total T3, Total T4)",
    "Lipid Profile",
    "Liver Function Test (I-FT)",
    "C - Reactive Protein (Quantitative)",
  ];

  final List<String> categorieslast = [
    "Pregnancy",
    "X - ray MRI CT Ultrasound",
    "Blood Studies",
    "Allergy",
    "Tax Saver",
    "Bone",
    "Men’s Health",
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();
  TextEditingController SearchfilterEditTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
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
              Header(userName: usernameValue),

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
              Container(
                padding: EdgeInsets.only(
                        left: MediaQuery
                            .of(context)
                            .size
                            .height * 0.0,
                        right: MediaQuery
                            .of(context)
                            .size
                            .height * 0.0,
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .height * 0.0),
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
  Container(

                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          left: screenWidth * 0.0,
                          right: screenWidth * 0.01,
                          bottom: screenWidth * 0.0,
                        ),
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.01,
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                            left: MediaQuery.of(context).size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(
                                width: screenHeight *
                                    0.005), // Add spacing between widgets
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(
                                        bottom: screenHeight * 0.01),

                                    child: TextFormField(
                                      controller: SearchEditTextController,

                                      style: TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) => input!.length < 3
                                          ? "Search should be more than 3 characters"
                                          : null,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(
                                          top :   screenHeight * 0.012,
                                          left :   screenHeight * 0.02,
                                          right :   screenHeight * 0.012,
                                          bottom :   screenHeight * 0.012,
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFF7F5F6),
                                        hintText: "Search by tests & packages",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: screenHeight * 0.014,
                                            fontWeight: FontWeight.w400
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          borderSide:
                                          BorderSide(color: Color(0xFFF7F5F6)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                        ),
                                        suffixIcon: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min, // Ensures the Row only takes as much space as needed
                                            children: [
                                              // Search Icon
                                              Icon(
                                                Icons.search,
                                                color: Colors.black45,
                                                size: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.025,
                                              ),
                                              // Divider
                                              Container(
                                                width: 1, // Width of the divider
                                                height: 20, // Height of the divider
                                                color: Colors.grey, // Color of the divider
                                                margin: EdgeInsets.symmetric(horizontal: 8), // Spacing around the divider
                                              ),
                                              // Icon from Assets
                                              InkWell(
                                                onTap: () {

                                                  showBottomSheet();


                                                },
                                                child: Image.asset(
                                                  'assets/scansearch.png', // Replace with your actual asset path
                                                  height: 15, // Height of the asset icon
                                                  width: 15,  // Width of the asset icon
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
                          ],
                        ),
                      ),
                      ]
                  ),
              ),
  Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.00),
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
                    children: [
                      // Search Input Field
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Provide a width constraint using SizedBox or Expanded
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.00),
                            // height: MediaQuery.of(context).size.height * 0.190,
                            child: ListView.builder(
                               padding: EdgeInsets.zero, // ✅ Remove extra top space
                              physics: ScrollPhysics(), // Ensures scrolling
                              shrinkWrap:
                              true, // Prevents ListView from taking up extra space
                              scrollDirection: Axis
                                  .vertical, // Makes the ListView horizontal
                              itemCount: 5, // You can adjust the item count
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Add your onTap logic here
                                  },
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child:  Container(
                                      width:MediaQuery.of(context).size.height * 0.410,
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
                                                          SizedBox(height : screenHeight * 0.005)  ,

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
                                                          SizedBox(height : screenHeight * 0.005)  ,

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
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    // ✅ LEFT SIDE — “More Details”
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => MyReportsMain(initialTabIndex: 1),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                              ),
                                                              child: Stack(
                                                                alignment: Alignment.bottomLeft,
                                                                children: [
                                                                  Text(
                                                                    "More Details",
                                                                    style: TextStyle(
                                                                      color: Color(0xFF12B76A),
                                                                      fontWeight: FontWeight.w500,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom: 0,
                                                                    left: 0,
                                                                    right: 0,
                                                                    child: Container(
                                                                      height: 1,
                                                                      color: Color(0xFF12B76A),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Container(
                                                    //   decoration: BoxDecoration(
                                                    //     borderRadius: BorderRadius.circular(15),
                                                    //   ),
                                                    //   child: Row(
                                                    //     children: <Widget>[
                                                    //       Container(
                                                    //         padding: EdgeInsets.only(
                                                    //           left: MediaQuery.of(context).size.height * 0.005,
                                                    //         ),
                                                    //         child: Stack(
                                                    //           alignment: Alignment.bottomLeft,
                                                    //           children: [
                                                    //             Text(
                                                    //               "More Details",
                                                    //               style: TextStyle(
                                                    //                 color: Color(0xFF12B76A),
                                                    //                 fontWeight: FontWeight.w500,
                                                    //                 overflow: TextOverflow.ellipsis,
                                                    //                 fontSize: MediaQuery.of(context).size.height * 0.01,
                                                    //               ),
                                                    //             ),
                                                    //             Positioned(
                                                    //               bottom: 0,
                                                    //               left: 0,
                                                    //               right: 0,
                                                    //               child: Container(
                                                    //                 height: 1,
                                                    //                 color: Color(0xFF12B76A),
                                                    //               ),
                                                    //             ),
                                                    //           ],
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),

                                                    // ✅ RIGHT SIDE — BOTH BUTTONS GROUPED TOGETHER
                                                    Row(
                                                      children: [
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
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: MediaQuery.of(context).size.height * 0.015,
                                                              vertical: MediaQuery.of(context).size.height * 0.007,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFF126086),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            margin: EdgeInsets.only(
                                                              right: MediaQuery.of(context).size.height * 0.01,
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              "Smart Report",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: MediaQuery.of(context).size.height * 0.01,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => MyReportsMain(initialTabIndex: 1),
                                                              ),
                                                            );
                                                          },
                                                          // onTap: () async {
                                                          //   Navigator.of(context).push(
                                                          //     MaterialPageRoute(
                                                          //       builder: (BuildContext context) {
                                                          //         return LabViewReports();
                                                          //       },
                                                          //     ),
                                                          //   );
                                                          // },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: MediaQuery.of(context).size.height * 0.015,
                                                              vertical: MediaQuery.of(context).size.height * 0.007,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFF126086),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              "View Reports",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: MediaQuery.of(context).size.height * 0.01,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              )

                                              // Container(
                                              //   padding: EdgeInsets.only(
                                              //       left: MediaQuery.of(context).size.height * 0.005,
                                              //       right: MediaQuery.of(context).size.height * 0.005,
                                              //       top: MediaQuery.of(context).size.height * 0.00,
                                              //       bottom: MediaQuery.of(context).size.height * 0.00),
                                              //   width: double.infinity,
                                              //   child: Column(
                                              //       crossAxisAlignment: CrossAxisAlignment.start,
                                              //       mainAxisAlignment: MainAxisAlignment.start,
                                              //       children: <Widget>[
                                              //         Container(
                                              //           decoration: BoxDecoration(
                                              //             borderRadius: BorderRadius.circular(06),
                                              //           ),
                                              //           padding: EdgeInsets.only(
                                              //             left: MediaQuery.of(context).size.height * 0.01,
                                              //             right: MediaQuery.of(context).size.height * 0.01,
                                              //             top: MediaQuery.of(context).size.height * 0.01,
                                              //             bottom: MediaQuery.of(context).size.height * 0.01,),
                                              //           child: Row(
                                              //             // mainAxisSize: MainAxisSize.max,
                                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //               crossAxisAlignment: CrossAxisAlignment.center,
                                              //               children: <Widget>[
                                              //
                                              //                 // More Details
                                              //                 Container(
                                              //                   decoration: BoxDecoration(
                                              //                     // color:Colors.white,
                                              //                     borderRadius: BorderRadius.circular(15),
                                              //                   ),
                                              //                   // color:Colors.green[100],
                                              //                   padding: EdgeInsets.only(
                                              //                       left: MediaQuery.of(context).size.height * 0.0,
                                              //                       right: MediaQuery.of(context).size.height * 0.0,
                                              //                       top: MediaQuery.of(context).size.height * 0.00,
                                              //                       bottom: MediaQuery.of(context).size.height * 0.00),
                                              //                   child:
                                              //
                                              //                   Row(
                                              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //                       crossAxisAlignment: CrossAxisAlignment.center,
                                              //                       children: <Widget>[
                                              //
                                              //
                                              //
                                              //                         Container(
                                              //                           padding: EdgeInsets.only(
                                              //                             left: MediaQuery.of(context).size.height * 0.005,
                                              //                             right: MediaQuery.of(context).size.height * 0.00,
                                              //                             top: MediaQuery.of(context).size.height * 0.00,
                                              //                             bottom: MediaQuery.of(context).size.height * 0.00,
                                              //                           ),
                                              //                           child: Stack(
                                              //                             alignment: Alignment.bottomLeft,
                                              //                             children: [
                                              //                               Text(
                                              //                                 "More Details",
                                              //                                 style: TextStyle(
                                              //                                   color: Color(0xFF12B76A), // Text color
                                              //                                   fontWeight: FontWeight.w500, // Bold text
                                              //                                   overflow: TextOverflow.ellipsis, // Handles overflow with ellipsis
                                              //                                   fontSize: MediaQuery.of(context).size.height * 0.012, // Dynamic font size
                                              //                                 ),
                                              //                               ),
                                              //                               Positioned(
                                              //                                 bottom: 0, // Position the underline at the bottom of the text
                                              //                                 left: 0,
                                              //                                 right: 0,
                                              //                                 child: Container(
                                              //                                   height: 1, // Thickness of the underline
                                              //                                   color: Color(0xFF12B76A),// Color of the underline
                                              //                                   margin: EdgeInsets.symmetric(horizontal: 0.0), // Adds padding to the underline
                                              //                                 ),
                                              //                               ),
                                              //                             ],
                                              //                           ),
                                              //                         ),
                                              //
                                              //
                                              //                       ]
                                              //                   ),
                                              //
                                              //                 ),
                                              //
                                              //                 GestureDetector(
                                              //                   onTap: () async {
                                              //                     Navigator.of(context).push(
                                              //                       MaterialPageRoute(
                                              //                         builder: (BuildContext context) {
                                              //                           return LabSmartReports();
                                              //                         },
                                              //                       ),
                                              //                     );
                                              //                   },
                                              //                   child: Container(
                                              //                     padding: new EdgeInsets.only(
                                              //                         left: MediaQuery.of(context).size.height * 0.015,
                                              //                         right: MediaQuery.of(context).size.height * 0.015,
                                              //                         top: MediaQuery.of(context).size.height * 0.007,
                                              //                         bottom: MediaQuery.of(context).size.height * 0.007),
                                              //                     decoration: BoxDecoration(
                                              //                       color: Color(0xFF126086),
                                              //                       borderRadius: BorderRadius.circular(5),
                                              //                     ),
                                              //
                                              //
                                              //                     margin: EdgeInsets.only(
                                              //                       left: MediaQuery.of(context).size.height * 0.00,
                                              //                       top: MediaQuery.of(context).size.height * 0.00,
                                              //                       bottom: MediaQuery.of(context).size.height * 0.00,
                                              //                       right: MediaQuery.of(context).size.height * 0.005,
                                              //                     ),
                                              //                     // color: Colors.grey[300],
                                              //                     alignment: Alignment.center,
                                              //                     // height:
                                              //                     // MediaQuery.of(context).size.height * 0.070,
                                              //                     child: Text("Smart Report",
                                              //                         textAlign: TextAlign.center,
                                              //                         style: TextStyle(
                                              //                             color: Colors.white,
                                              //                             fontWeight: FontWeight.w600,
                                              //                             fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                              //                   ),
                                              //                 ),
                                              //                 GestureDetector(
                                              //                   onTap: () async {
                                              //                     Navigator.of(context).push(
                                              //                       MaterialPageRoute(
                                              //                         builder: (BuildContext context) {
                                              //                           return LabViewReports();
                                              //                         },
                                              //                       ),
                                              //                     );
                                              //                   },
                                              //                   child: Container(
                                              //                     padding: new EdgeInsets.only(
                                              //                         left: MediaQuery.of(context).size.height * 0.015,
                                              //                         right: MediaQuery.of(context).size.height * 0.015,
                                              //                         top: MediaQuery.of(context).size.height * 0.007,
                                              //                         bottom: MediaQuery.of(context).size.height * 0.007),
                                              //                     decoration: BoxDecoration(
                                              //                       color: Color(0xFF126086),
                                              //                       borderRadius: BorderRadius.circular(5),
                                              //                     ),
                                              //
                                              //
                                              //                     margin: EdgeInsets.only(
                                              //                       left: MediaQuery.of(context).size.height * 0.00,
                                              //                       top: MediaQuery.of(context).size.height * 0.00,
                                              //                       bottom: MediaQuery.of(context).size.height * 0.00,
                                              //                       right: MediaQuery.of(context).size.height * 0.005,
                                              //                     ),
                                              //                     // color: Colors.grey[300],
                                              //                     alignment: Alignment.center,
                                              //                     // height:
                                              //                     // MediaQuery.of(context).size.height * 0.070,
                                              //                     child: Text("View Reports",
                                              //                         textAlign: TextAlign.center,
                                              //                         style: TextStyle(
                                              //                             color: Colors.white,
                                              //                             fontWeight: FontWeight.w600,
                                              //                             fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                              //                   ),
                                              //                 ),
                                              //
                                              //
                                              //
                                              //               ]),
                                              //         ),
                                              //       ]),
                                              // ),







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



                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                    ],
                  ),
                ),
              ),

               ],
                    ),
                  ),
              )

              // Main Content Section

            ],
          ),
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardVisible ? null : CustomFloatingActionButton(),

      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
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
