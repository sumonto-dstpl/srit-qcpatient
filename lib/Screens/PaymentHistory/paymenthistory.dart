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
import 'package:newfolder/Screens/Insurance/addinsurance.dart';
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
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class PaymentHistoryMain extends StatefulWidget {
  final int selectedIndex ;

  PaymentHistoryMain({
    super.key,
    this.selectedIndex = 0 ,
  });

  @override
  State<PaymentHistoryMain> createState() => PaymentHistoryMainstate();
}

class PaymentHistoryMainstate extends State<PaymentHistoryMain> {
  String usernameValue = "Payments History";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                  Header(userName: usernameValue,showProfile: false,),

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
                                            .height * 0.1,
                                        right:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.1,
                                        bottom:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.01,
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
                                      // color: Color(0xFFA8B1CE).withOpacity(0.4),
                                      color : Color(0x66D9D9D9),
                                      border: Border.all(
                                        // Add a red border
                                        color: Color(0x66D9D9D9), // Red color for the border
                                        width: 2, // Border width
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
                                              0.014),
                                      unselectedLabelColor: Colors.black,
                                      unselectedLabelStyle:
                                      TextStyle(fontWeight: FontWeight.w500),
                                      tabs: [
                                        Tab(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Paid Bills",
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
                                                "Receipts",
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),



                                


                              ]
                          ),


                          // TabBarView Section
                          Expanded(
                            child: TabBarView(
                              children: [

                                // Paid Bills
                                Container(

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
                                          0.005,
                                       ),
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
                                    8,
                                    // You can adjust the item count
                                    itemBuilder:
                                        (BuildContext context,
                                        int index) {
                                      return  Column(
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
                                                    color: Color(0x99E0E8F2), // Border color
                                                    width: 1, // Border width
                                                  ),
                                                  borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
                                                ),

                                                margin: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.01,
                                                    right: MediaQuery.of(context).size.height * 0.01,
                                                    bottom: MediaQuery.of(context).size.height * 0.0,
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
                                                          0.01,
                                                      right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.01),
                                                  child: Row(

                                                    children: <Widget>[

                                                      Expanded(
                                                        flex: 2,
                                                        child:
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                            left: MediaQuery.of(context).size.height * 0.005,
                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                            right: MediaQuery.of(context).size.height * 0.006,
                                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                                          ),

                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(0.0),
                                                            child: Image.asset(
                                                              'assets/PaidBills.png',
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),



                                                      ),

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
                                                                    0.01,
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
                                                                "QCT Superior Health Plan",
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
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.01,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.005,
                                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                                              ),
                                                              child: Text(
                                                                "Booking ID : 6732797327",
                                                                style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w600,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.011,
                                                                ),
                                                              ),
                                                            ),




                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start, // Ensures columns align properly
                                                              children: [
                                                                Container(

                                                                  child:
                                                                  Column(
                                                                    mainAxisSize: MainAxisSize.min, // Allows the column to take only the required space
                                                                    crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                          left: MediaQuery.of(context).size.height * 0.01,
                                                                          right: MediaQuery.of(context).size.height * 0.00,
                                                                          top: MediaQuery.of(context).size.height * 0.005,
                                                                          bottom: MediaQuery.of(context).size.height * 0.00,
                                                                        ),
                                                                        child: Text(
                                                                          "Order Date",
                                                                          style: TextStyle(
                                                                            color: Colors.black54,
                                                                            fontWeight: FontWeight.w500,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                          left: MediaQuery.of(context).size.height * 0.01,
                                                                          right: MediaQuery.of(context).size.height * 0.00,
                                                                          top: MediaQuery.of(context).size.height * 0.00,
                                                                          bottom: MediaQuery.of(context).size.height * 0.00,
                                                                        ),
                                                                        child: Text(
                                                                          "Jun 07, 2023",
                                                                          style: TextStyle(
                                                                            color: Color(0xFF26273A),
                                                                            fontWeight: FontWeight.w400,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),


                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                    left : MediaQuery.of(context).size.height * 0.025,
                                                                  ),
                                                                  child:
                                                                  Column(
                                                                    mainAxisSize: MainAxisSize.min, // Allows the column to take only the required space
                                                                    crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                          left: MediaQuery.of(context).size.height * 0.0,
                                                                          right: MediaQuery.of(context).size.height * 0.00,
                                                                          top: MediaQuery.of(context).size.height * 0.005,
                                                                          bottom: MediaQuery.of(context).size.height * 0.00,
                                                                        ),
                                                                        child: Text(
                                                                          "Sample Colle Date",
                                                                          style: TextStyle(
                                                                            color: Colors.black54,
                                                                            fontWeight: FontWeight.w500,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                          left: MediaQuery.of(context).size.height * 0.00,
                                                                          right: MediaQuery.of(context).size.height * 0.00,
                                                                          top: MediaQuery.of(context).size.height * 0.00,
                                                                          bottom: MediaQuery.of(context).size.height * 0.00,
                                                                        ),
                                                                        child: Text(
                                                                          "Jun 09, 2023",
                                                                          style: TextStyle(
                                                                            color: Color(0xFF26273A),
                                                                            fontWeight: FontWeight.w400,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )

                                                          ],
                                                        ),
                                                      ),
                                                      // Adding the side arrow at the end

                                                      Container(


                                                        child: Column(

                                                           crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [

                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: Color(0xFF34C759).withOpacity(0.2),
                                                                borderRadius: BorderRadius.circular(4),
                                                              ),
                                                              padding: EdgeInsets.only(
                                                                left : MediaQuery.of(context).size.height * 0.005,
                                                                right : MediaQuery.of(context).size.height * 0.005,
                                                                top : MediaQuery.of(context).size.height * 0.001,
                                                                bottom : MediaQuery.of(context).size.height * 0.001,
                                                              ),
                                                              child:Container(

                                                                child: Text(
                                                                  'Pathology',
                                                                  style: TextStyle(
                                                                    color: Color(0xFF34C759),
                                                                    fontWeight: FontWeight.w400,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),


                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                top : MediaQuery.of(context).size.height * 0.04,

                                                              ),
                                                              child: Text(
                                                                'QR 99.00',
                                                                style: TextStyle(
                                                                  color: Color(0xFF26273A),
                                                                  fontWeight: FontWeight.w700,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
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
                                          if(index == 7)
                                          const SizedBox(height: 50,),
                                        ],
                                      );
                                    },
                                  ),
                                ),

                                // Receipts
                                // Receipts Tab Implementation
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.height * 0.02,
                                      vertical: MediaQuery.of(context).size.height * 0.02,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // 1. Header Name
                                        Text(
                                          "Receipts",
                                          style: TextStyle(
                                            color: Color(0xFF126086),
                                            fontSize: MediaQuery.of(context).size.height * 0.018,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                        Text(
                                          "Priya Krishnamurthy",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: MediaQuery.of(context).size.height * 0.014,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                                        // 2. Booking Details Card
                                        Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF8F9FA), // Light grey background
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              _buildReceiptRow(context, "Booking ID", "43445789456", isValueBold: true),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                              _buildReceiptRow(context, "Order Date", "Jan 16, 2024"),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                              _buildReceiptRow(context, "Sample Collected Date", "Jan 18, 2024", isValueBold: true),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                        // 3. Test Items Card
                                        Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF8F9FA),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              _buildReceiptRow(context, "CBC", "QR 50.00", isValueBold: true),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                              _buildReceiptRow(context, "Lipid Profile", "QR 120.00", isValueBold: true),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                              _buildReceiptRow(context, "Liver Function Test", "QR 70.00", isValueBold: true),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                        // 4. Payment Totals Card
                                        Container(
                                          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF8F9FA),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              _buildReceiptRow(context, "Subtotal", "QR 240.00", isValueBold: true),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                              _buildReceiptRow(context, "Discount", "-", valueColor: Colors.green),

                                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                              // Custom Dashed Line Divider
                                              Row(
                                                children: List.generate(40, (index) => Expanded(
                                                  child: Container(
                                                    color: index % 2 == 0 ? Colors.grey[400] : Colors.transparent,
                                                    height: 1,
                                                  ),
                                                )),
                                              ),

                                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                              _buildReceiptRow(context, "Total Paid", "QR 240.00", isValueBold: true, fontSize: 0.018),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                                        // 5. Footer (Credit Card)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Pay via Credit Card",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              "780383728",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Extra spacing for bottom nav bar
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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





            ],
          ),
        ),




        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  CustomFloatingActionButton(),
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: widget.selectedIndex),
      ),
    );
  }





}

// Helper method to build rows in the receipt
Widget _buildReceiptRow(BuildContext context, String label, String value,
    {bool isValueBold = false, Color valueColor = Colors.black, double fontSize = 0.012}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: MediaQuery.of(context).size.height * 0.012,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: valueColor,
          fontWeight: isValueBold ? FontWeight.bold : FontWeight.w500,
          fontSize: MediaQuery.of(context).size.height * fontSize,
        ),
      ),
    ],
  );
}
