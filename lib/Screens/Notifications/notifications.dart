import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';


class NotificationMain extends StatefulWidget {
  final int initialTabIndex;

    NotificationMain(
        {
          Key? key,
          this.initialTabIndex = 0
        }

    ) : super(key: key);



  @override
  State<NotificationMain> createState() => NotificationMainstate();
}

class NotificationMainstate extends State<NotificationMain> {
  String usernameValue = "My Health";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;



  final uploadfilestime0 = [
  ["assets/notificaiocn1.png", "Test & Services", "9:00 am"],
  ];
  final  uploadfilestime = [
    ["assets/profileProfile1.png", "Test & Services", "9:00 am"],
    ["assets/NutanBhatt.png", "Appointment", "01:00 pm"],


  ];

  final uploadfilestime1 = [
    ["assets/notificaiocn1.png", "Test & Services", "9:00 am"],
    ["assets/notificaiocn1.png", "Appointment", "01:00 pm"],
    ["assets/notificaiocn1.png", "Test & Services", "9:00 am"],
    ["assets/notificaiocn1.png", "Appointment", "01:00 pm"],
    ["assets/notificaiocn1.png", "Test & Services", "9:00 am"],


  ];

  final List<String> cartnametoplist = [
    "QCT Superior Health Plan",
    "QCT Diabetic Health Plan",
    "QCT Master Health Check Package",
  ];

  final List<String> endtextbottomlist = [
    "QR 1999",
    "QR 1999",
    "QR 1999",
  ];


  final List<String> cartnameottomlist = [
    "QCT Master Health Check Package",
    "QCT Diabetic Health Plan",
    "QCT Master Health Check Package",
  ];


  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  //Asgar
  bool isTodayCount = true;
  bool isYesterdayCount = true;
  bool isDay19Count = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

    return
      DefaultTabController(
        length: 3,
        initialIndex: widget.initialTabIndex,
        child:

        Scaffold(
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
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  bottom: screenWidth * 0.02,
                ),
                margin: EdgeInsets.only(
                  right: screenHeight * 0.0,
                  top: screenHeight * 0.0,
                  bottom: screenHeight * 0.01,
                  left: screenHeight * 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
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
                  child: Column(
                    children: [


                      Container(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.0,
                          left: screenWidth * 0.0,
                          right: screenWidth * 0.0,
                          bottom: screenWidth * 0.01,
                        ),
                        margin: EdgeInsets.only(
                          right: screenHeight * 0.0,
                          top: screenHeight * 0.03,
                          bottom: screenHeight * 0.0,
                          left: screenHeight * 0.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.01,
                                ),
                                height: screenHeight * 0.035,
                                width: screenHeight * 0.035,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7F5F6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: Color(0xFF999999),
                                  size: screenHeight * 0.018,
                                ),
                              ),
                            ),

                            // Help Text (Centered)
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Notification",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.018,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            // Placeholder to Balance Row (Keeps Help Text Centered)
                            SizedBox(width: screenHeight * 0.035),

                          ],
                        )
                        ,
                      ),



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
                                .height * 0.00,
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
                          color: Color(0x66D9D9D9),
                          border: Border.all(
                             // Add a red border
                            color: Color(0x66D9D9D9),// Red color for the border
                            width: 0.5, // Border width
                          ),
                        ),
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),),
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
                                    0.014
                            ),
                            unselectedLabelColor: Color(0xB2000000),
                            unselectedLabelStyle:
                            TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.014
                            ),
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "All",
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
                                      "Offers",
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Notifications",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // TabBarView Section
                      Expanded(
                        child: TabBarView(
                          children: [
                            // All
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
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),),
                                child: ListView(
                                    padding: EdgeInsets.zero,
                                  shrinkWrap:
                                  true,
                                  /*  mainAxisAlignment: MainAxisAlignment
                                      .start, // Center vertically
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Center horizontally*/
                                  children: [

                                    // top card
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: screenHeight * 0.02,
                                        top: screenHeight * 0.01,
                                        bottom: screenHeight * 0.01,
                                        left: screenHeight * 0.02,
                                      ), // Re
                                      
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(

                                            topLeft: Radius.circular(15),
                                            topRight : Radius.circular(15),
                                            bottomLeft: Radius.circular(15), // Set the curve radius
                                            bottomRight: Radius.circular(15),
                                          ),

                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: screenHeight * 0.0,
                                                top: screenHeight * 0.0,
                                                bottom: screenHeight * 0.0,
                                                left: screenHeight * 0.0,
                                              ), // Responsive margin
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.14,
                                              decoration: BoxDecoration(
                                                /*color: Color(
                                                    0xFFC80000), */// Fallback color if image fails to load
                                                borderRadius: BorderRadius.circular(6),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/B1_ls.png'), // Path to your banner image
                                                  fit: BoxFit.fill, // Adjust to cover the entire container
                                                ),
                                                
                                            
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                            
                                                  Flexible(
                                                    flex: 6, // 6 out of 10 for the text section
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.height * 0.005,
                                                          right: MediaQuery.of(context).size.height * 0.00,
                                                          bottom: MediaQuery.of(context).size.height * 0.0,
                                                          top: MediaQuery.of(context).size.height * 0.01),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                            
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                              top: screenHeight * 0.0,
                                                              bottom: screenHeight * 0.00,
                                                              left: screenHeight * 0.02,
                                                              right: screenHeight * 0.00,
                                                            ),
                                                            child: Text(
                                                              "Do not ignore your symptoms!",
                                                              style: TextStyle(
                                                                fontSize: screenHeight * 0.015,
                                                                color: Color(0xFFFFFFFF),
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                              top: screenHeight * 0.0,
                                                              bottom: screenHeight * 0.0,
                                                              left: screenHeight * 0.02,
                                                              right: screenHeight * 0.00,
                                                            ),
                                                            child: Text(
                                                              "Find out what could be causing them ",
                                                              style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                fontSize: screenHeight * 0.011,
                                                                color: Colors.white,
                                                                fontWeight : FontWeight.w400,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                          ),
                                            
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                              margin: EdgeInsets.only(
                                                                  left: MediaQuery.of(context).size.height * 0.02,
                                                                  right: MediaQuery.of(context).size.height * 0.15,
                                                                  bottom:
                                                                  MediaQuery.of(context).size.height * 0.00,
                                                                  top: MediaQuery.of(context).size.height * 0.0
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: Colors.white.withOpacity(0.2),
                                            
                                            
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
                                                                    MediaQuery.of(context).size.height * 0.00,
                                                                    right:
                                                                    MediaQuery.of(context).size.height * 0.00,
                                                                    bottom:
                                                                    MediaQuery.of(context).size.height * 0.00,
                                                                    top:
                                                                    MediaQuery.of(context).size.height * 0.00),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.height *
                                                                            0.005,
                                                                        right: MediaQuery.of(context).size.height *
                                                                            0.00,
                                                                        top: MediaQuery.of(context).size.height *
                                                                            0.005,
                                                                        bottom: MediaQuery.of(context).size.height *
                                                                            0.005,
                                                                      ),
                                                                      child: Row(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: <Widget>[
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
                                                                                    "START ASSESSMENT",
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      overflow:
                                                                                      TextOverflow.ellipsis,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize:
                                                                                      MediaQuery.of(context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.009,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          // Adding the side arrow at the end
                                            
                                                                          Container(
                                                                            padding: EdgeInsets.only(
                                                                              left: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.00,
                                                                              right: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.01,
                                                                              top: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.0,
                                                                              bottom: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.0,
                                                                            ),
                                                                            child: Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              size: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.01, // Dynamic icon size
                                                                              color: Colors.white,
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
                                                  Flexible(
                                                    flex: 2, // 6 out of 10 for the text section
                                                    child: Container(),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(
                                                      15), // Apply curved corners here
                                                  bottomLeft: Radius.circular(15),
                                                ),
                                                border: Border(
                                                  left: BorderSide(color: Color(0x1A000000), width: 0.5),
                                                  right: BorderSide(color: Color(0x1A000000), width: 0.5),
                                                  bottom: BorderSide(color: Color(0x1A000000), width: 0.5),
                                                ),

                                              ),
                                              child:GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(

                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[

                                                            Container(
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
                                                                  right: MediaQuery.of(context).size.height * 0.008,
                                                                  top: MediaQuery.of(context).size.height * 0.0,
                                                                  bottom: MediaQuery.of(context).size.height * 0.0,
                                                                ),
                                                                height: MediaQuery.of(context).size.height * 0.017,
                                                                width: MediaQuery.of(context).size.height * 0.02,
                                                                child:
                                                                Image.asset(
                                                                  'assets/notificaiocn.png',
                                                                  fit:
                                                                  BoxFit.fill,
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
                                                                      "Reported Symptoms",
                                                                      style: TextStyle(
                                                                        color: Color(0xFF6A6E83),
                                                                        overflow:
                                                                        TextOverflow.ellipsis,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize:
                                                                        MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                            0.011,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Adding the side arrow at the end

                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.00,
                                                                right: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01,
                                                                top: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.0,
                                                                bottom: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.0,
                                                              ),
                                                              child: Icon(
                                                                Icons.arrow_forward_ios,
                                                                size: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01, // Dynamic icon size
                                                                color: Color(0xFF6A6E83),
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


                                    // violet
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: screenHeight * 0.02,
                                        top: screenHeight * 0.0,
                                        bottom: screenHeight * 0.01,
                                        left: screenHeight * 0.02,
                                      ), // Responsive margin
                                      height:  MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.14,
                                      decoration: BoxDecoration(
                                        color: Color(
                                            0xFFC80000), // Fallback color if image fails to load
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/B3_ls.png'), // Path to your banner image
                                          fit: BoxFit.fill,
                                          // Adjust to cover the entire container
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).hintColor.withOpacity(0.0),
                                            offset: Offset(0, 4),
                                            blurRadius: 9,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          // Flexible(
                                          //   flex: 6, // 6 out of 10 for the text section
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(MediaQuery
                                          //         .of(context)
                                          //         .size
                                          //         .height * 0.005),
                                          //     child: Column(
                                          //       mainAxisAlignment: MainAxisAlignment.start,
                                          //       crossAxisAlignment: CrossAxisAlignment.start,
                                          //       children: <Widget>[
                                          //
                                          //         Container(
                                          //           padding: EdgeInsets.only(
                                          //             top: screenHeight * 0.01,
                                          //             bottom: screenHeight * 0.00,
                                          //             left: screenHeight * 0.01,
                                          //             right: screenHeight * 0.02,
                                          //           ),
                                          //           child: ShaderMask(
                                          //             shaderCallback: (Rect bounds) {
                                          //               return LinearGradient(
                                          //                 begin: Alignment.centerLeft,
                                          //                 end: Alignment.centerRight,
                                          //                 colors: [Color(0xFFFFB300), Color(0xFFF9F3E5)],
                                          //                 tileMode: TileMode.clamp,
                                          //               ).createShader(bounds);
                                          //             },
                                          //             child: Text(
                                          //               "Caring for you, every step of the way",
                                          //               style: TextStyle(
                                          //                 fontSize: screenHeight * 0.018,
                                          //                 color: Colors.white, // This color will be overridden by the gradient
                                          //                 fontWeight: FontWeight.bold,
                                          //               ),
                                          //               textAlign: TextAlign.left,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Flexible(
                                            flex: 6, // 6 out of 10 for the text section
                                            child: Padding(
                                              padding: EdgeInsets.all( screenHeight * 0.02),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[

                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: screenHeight * 0.01,
                                                      bottom: screenHeight * 0.00,
                                                      left: screenHeight * 0.00,
                                                      right: screenHeight * 0.00,
                                                    ),
                                                    child:
                                                    ShaderMask(
                                                      shaderCallback: (Rect bounds) {
                                                        return LinearGradient(
                                                          begin: Alignment.centerLeft,
                                                          end: Alignment.centerRight,
                                                          colors: [Color(0xFFFFB300), Color(0xFFF9F3E5)],
                                                          tileMode: TileMode.clamp,
                                                        ).createShader(bounds);
                                                      },
                                                      child: Text(
                                                        "Caring for you, every step of the way",
                                                        style: TextStyle(
                                                            fontSize: screenHeight * 0.019,
                                                            color: Colors.white,
                                                            fontWeight : FontWeight.w700// This color will be overridden by the gradient                fontWeight: FontWeight.bold,
                                                        ),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                    ),

                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4, // 6 out of 10 for the text section
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Red Card
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: screenHeight * 0.02,
                                        top: screenHeight * 0.0,
                                        bottom: screenHeight * 0.0,
                                        left: screenHeight * 0.02,
                                      ),// Responsive margin
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.14,
                                      decoration: BoxDecoration(
                                        color: Color(
                                            0xFFC80000), // Fallback color if image fails to load
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/B2_ls.png'), // Path to your banner image
                                          fit: BoxFit.fill,

                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).hintColor.withOpacity(0.0),
                                            offset: Offset(0, 4),
                                            blurRadius: 9,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            flex: 4, // 6 out of 10 for the text section
                                            child: Container(),
                                          ),
                                          Flexible(
                                            flex: 6, // 6 out of 10 for the text section
                                            child: Padding(
                                              padding: EdgeInsets.all(screenHeight * 0.02),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: screenHeight * 0.01,
                                                      bottom: screenHeight * 0.00,
                                                      left: screenHeight * 0.00,
                                                      right: screenHeight * 0.00,
                                                    ),
                                                    child: Text(
                                                      "Patient Mobile App",
                                                      style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: screenHeight * 0.014,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: screenHeight * 0.00,
                                                      bottom: screenHeight * 0.00,
                                                      left: screenHeight * 0.00,
                                                      right: screenHeight * 0.00,
                                                    ),
                                                    child: Text(
                                                      "Caring for you, every step of the way",
                                                      style: TextStyle(
                                                        fontSize: screenHeight * 0.018,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),



                                    Container(
                                      margin: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height *
                                            0.005, // Dynamic top padding
                                        bottom: MediaQuery.of(context).size.height *
                                            0.05, // Dynamic bottom padding
                                        left: MediaQuery.of(context).size.height *
                                            0.005, // Dynamic left padding
                                        right: MediaQuery.of(context).size.height *
                                            0.005, // Dynamic right padding
                                      ),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap:
                                        true, // Prevents infinite height
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: uploadfilestime.length,
                                        itemBuilder: (context, index) {


                                          final file = uploadfilestime[index][0];

                                          return

                                          /*  Dismissible(
                                                key: Key(file), // Unique key for each item
                                                direction: DismissDirection.endToStart, // Allow swipe from right to left
                                                background: Container(
                                                  color: Colors.red,
                                                  alignment: Alignment.centerRight,
                                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onDismissed: (direction) {
                                                  // Remove the item immediately from the list
                                                  setState(() {
                                                    uploadfilestime.removeAt(index);
                                                  });

                                                  // Show a snackbar for feedback
                                                  *//* ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text("$file deleted"),
                                                                    duration: Duration(seconds: 2),
                                                                  ),
                                                                );*//*
                                                },
                                                child:*/

                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Card(
                                                    elevation: 0.0,
                                                    color: Colors.white,
                                                    child: Container(
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
                                                              Color(
                                                                  0xFFE8F0F3)
                                                                  .withOpacity(
                                                                  0.5),
                                                              Color(
                                                                  0xFFE8F0F3)
                                                                  .withOpacity(
                                                                  0.5),
                                                            ],)),
                                                      margin: EdgeInsets.only(
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
                                                              0.0,
                                                          top: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.00),
                                                      // color: Colors.white,
                                                      child: Container(
                                                        // color: Colors.white,


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
                                                                    0.015,
                                                                top:
                                                                MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.00,
                                                                bottom:
                                                                MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.005,
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
                                                                    width :  MediaQuery.of(context).size.height * 0.05,


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
                                                                        uploadfilestime[index][0],
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
                                                                          0.015),
                                                                  Expanded(
                                                                    flex: 6,
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      children: <Widget>[
                                                                        Container(
                                                                          margin : EdgeInsets.only(
                                                                            top : MediaQuery.of(
                                                                                context)
                                                                                .size
                                                                                .height *
                                                                                0.01,
                                                                          ),
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
                                                                              uploadfilestime[index][1],
                                                                            style:
                                                                            TextStyle(
                                                                              color: Color(0xFF126086),
                                                                              overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                              fontSize: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.012,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin : EdgeInsets.only(
                                                                            top : MediaQuery.of(
                                                                                context)
                                                                                .size
                                                                                .height *
                                                                                0.005,
                                                                          ),
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
                                                                            "Duration: 6 Days : Intensity: Severe, Onset/Time course: Acute : ",
                                                                            style:
                                                                            TextStyle(
                                                                              color: Color(0xFF126086).withOpacity(0.7),
                                                                              overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,

                                                                              fontSize: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.009,
                                                                              fontWeight : FontWeight.w400,
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
                                                                            "Radiation of Pain: Chest Associated Symptoms:",
                                                                            style:
                                                                            TextStyle(
                                                                              color: Color(0xFF126086).withOpacity(0.7),
                                                                              overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,

                                                                              fontSize: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.009,
                                                                              fontWeight : FontWeight.w400,
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
                                                                          child: Align(
                                                                          alignment: AlignmentDirectional.centerEnd, // Align text to the end
                                                                          child: Text(
                                                                                uploadfilestime[index][2],
                                                                                style : TextStyle(
                                                            color: Color(0xFF126086),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,

                                                            fontSize: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.009,
                                                            fontWeight : FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    ],
                                                                    ),
                                                                  ),
                                                                  // Adding the side arrow at the end




                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );

                                            // );
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            // Offers
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
                              child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),),
                                child: ListView(
                                    padding: EdgeInsets.zero,
                                  shrinkWrap:
                                  true,

                                  children: [

                                    // top card
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: screenHeight * 0.02,
                                        top: screenHeight * 0.01,
                                        bottom: screenHeight * 0.01,
                                        left: screenHeight * 0.02,
                                      ), // Re

                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(

                                            topLeft: Radius.circular(15),
                                            topRight : Radius.circular(15),
                                            bottomLeft: Radius.circular(15), // Set the curve radius
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: screenHeight * 0.0,
                                                top: screenHeight * 0.0,
                                                bottom: screenHeight * 0.0,
                                                left: screenHeight * 0.0,
                                              ), // Responsive margin
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.14,
                                              decoration: BoxDecoration(
                                                /*color: Color(
                                                    0xFFC80000), */// Fallback color if image fails to load
                                                borderRadius: BorderRadius.circular(6),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/B1_ls.png'), // Path to your banner image
                                                  fit: BoxFit.fill, // Adjust to cover the entire container
                                                ),

                                              ),
                                              child: Row(
                                                children: <Widget>[

                                                  Flexible(
                                                    flex: 6, // 6 out of 10 for the text section
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.height * 0.005,
                                                          right: MediaQuery.of(context).size.height * 0.00,
                                                          bottom: MediaQuery.of(context).size.height * 0.0,
                                                          top: MediaQuery.of(context).size.height * 0.01),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[

                                                          Container(
                                                            padding: EdgeInsets.only(
                                                              top: screenHeight * 0.0,
                                                              bottom: screenHeight * 0.00,
                                                              left: screenHeight * 0.02,
                                                              right: screenHeight * 0.00,
                                                            ),
                                                            child: Text(
                                                              "Do not ignore your symptoms!",
                                                              style: TextStyle(
                                                                fontSize: screenHeight * 0.015,
                                                                color: Color(0xFFFFFFFF),
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                              top: screenHeight * 0.0,
                                                              bottom: screenHeight * 0.0,
                                                              left: screenHeight * 0.02,
                                                              right: screenHeight * 0.00,
                                                            ),
                                                            child: Text(
                                                              "Find out what could be causing them ",
                                                              style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                fontSize: screenHeight * 0.011,
                                                                color: Colors.white,
                                                                fontWeight : FontWeight.w400,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                          ),

                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                              margin: EdgeInsets.only(
                                                                  left: MediaQuery.of(context).size.height * 0.02,
                                                                  right: MediaQuery.of(context).size.height * 0.15,
                                                                  bottom:
                                                                  MediaQuery.of(context).size.height * 0.00,
                                                                  top: MediaQuery.of(context).size.height * 0.0
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: Colors.white.withOpacity(0.2),


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
                                                                    MediaQuery.of(context).size.height * 0.00,
                                                                    right:
                                                                    MediaQuery.of(context).size.height * 0.00,
                                                                    bottom:
                                                                    MediaQuery.of(context).size.height * 0.00,
                                                                    top:
                                                                    MediaQuery.of(context).size.height * 0.00),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                        left: MediaQuery.of(context).size.height *
                                                                            0.005,
                                                                        right: MediaQuery.of(context).size.height *
                                                                            0.00,
                                                                        top: MediaQuery.of(context).size.height *
                                                                            0.005,
                                                                        bottom: MediaQuery.of(context).size.height *
                                                                            0.005,
                                                                      ),
                                                                      child: Row(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: <Widget>[
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
                                                                                    "START ASSESSMENT",
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      overflow:
                                                                                      TextOverflow.ellipsis,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize:
                                                                                      MediaQuery.of(context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.009,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          // Adding the side arrow at the end

                                                                          Container(
                                                                            padding: EdgeInsets.only(
                                                                              left: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.00,
                                                                              right: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.01,
                                                                              top: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.0,
                                                                              bottom: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.0,
                                                                            ),
                                                                            child: Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              size: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.01, // Dynamic icon size
                                                                              color: Colors.white,
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
                                                  Flexible(
                                                    flex: 2, // 6 out of 10 for the text section
                                                    child: Container(),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(
                                                      15), // Apply curved corners here
                                                  bottomLeft: Radius.circular(15),
                                                ),
                                                  
                                              ),
                                              child:GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(

                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[

                                                            Container(
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
                                                                  right: MediaQuery.of(context).size.height * 0.008,
                                                                  top: MediaQuery.of(context).size.height * 0.0,
                                                                  bottom: MediaQuery.of(context).size.height * 0.0,
                                                                ),
                                                                height: MediaQuery.of(context).size.height * 0.017,
                                                                width: MediaQuery.of(context).size.height * 0.02,
                                                                child:
                                                                Image.asset(
                                                                  'assets/notificaiocn.png',
                                                                  fit:
                                                                  BoxFit.fill,
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
                                                                      "Reported Symptoms",
                                                                      style: TextStyle(
                                                                        color: Color(0xFF6A6E83),
                                                                        overflow:
                                                                        TextOverflow.ellipsis,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize:
                                                                        MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                            0.011,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Adding the side arrow at the end

                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.00,
                                                                right: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01,
                                                                top: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.0,
                                                                bottom: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.0,
                                                              ),
                                                              child: Icon(
                                                                Icons.arrow_forward_ios,
                                                                size: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01, // Dynamic icon size
                                                                color: Color(0xFF6A6E83),
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


                                    // violet
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: screenHeight * 0.02,
                                        top: screenHeight * 0.0,
                                        bottom: screenHeight * 0.01,
                                        left: screenHeight * 0.02,
                                      ), // Responsive margin
                                      height:  MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.14,
                                      decoration: BoxDecoration(
                                        color: Color(
                                            0xFFC80000), // Fallback color if image fails to load
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/B3_ls.png'), // Path to your banner image
                                          fit: BoxFit.fill,
                                          // Adjust to cover the entire container
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).hintColor.withOpacity(0.0),
                                            offset: Offset(0, 4),
                                            blurRadius: 9,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          // Flexible(
                                          //   flex: 6, // 6 out of 10 for the text section
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(MediaQuery
                                          //         .of(context)
                                          //         .size
                                          //         .height * 0.005),
                                          //     child: Column(
                                          //       mainAxisAlignment: MainAxisAlignment.start,
                                          //       crossAxisAlignment: CrossAxisAlignment.start,
                                          //       children: <Widget>[
                                          //
                                          //         Container(
                                          //           padding: EdgeInsets.only(
                                          //             top: screenHeight * 0.01,
                                          //             bottom: screenHeight * 0.00,
                                          //             left: screenHeight * 0.01,
                                          //             right: screenHeight * 0.02,
                                          //           ),
                                          //           child: ShaderMask(
                                          //             shaderCallback: (Rect bounds) {
                                          //               return LinearGradient(
                                          //                 begin: Alignment.centerLeft,
                                          //                 end: Alignment.centerRight,
                                          //                 colors: [Color(0xFFFFB300), Color(0xFFF9F3E5)],
                                          //                 tileMode: TileMode.clamp,
                                          //               ).createShader(bounds);
                                          //             },
                                          //             child: Text(
                                          //               "Caring for you, every step of the way",
                                          //               style: TextStyle(
                                          //                 fontSize: screenHeight * 0.018,
                                          //                 color: Colors.white, // This color will be overridden by the gradient
                                          //                 fontWeight: FontWeight.bold,
                                          //               ),
                                          //               textAlign: TextAlign.left,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Flexible(
                                            flex: 6, // 6 out of 10 for the text section
                                            child: Padding(
                                              padding: EdgeInsets.all( screenHeight * 0.02),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[

                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: screenHeight * 0.01,
                                                      bottom: screenHeight * 0.00,
                                                      left: screenHeight * 0.00,
                                                      right: screenHeight * 0.00,
                                                    ),
                                                    child:
                                                    ShaderMask(
                                                                shaderCallback: (Rect bounds) {
                                                                  return LinearGradient(
                                                                    begin: Alignment.centerLeft,
                                                                    end: Alignment.centerRight,
                                                                    colors: [Color(0xFFFFB300), Color(0xFFF9F3E5)],
                                                                    tileMode: TileMode.clamp,
                                                                  ).createShader(bounds);
                                                              },
                                                                child: Text(
                                                                  "Caring for you, every step of the way",
                                                                  style: TextStyle(
                                                                    fontSize: screenHeight * 0.019,
                                                                    color: Colors.white, 
                                                                      fontWeight : FontWeight.w700// This color will be overridden by the gradient                fontWeight: FontWeight.bold,
                                                                  ),
                                                                  textAlign: TextAlign.left,
                                                                ),
                                                              ),
                                                            
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4, // 6 out of 10 for the text section
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Red Card
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: screenHeight * 0.02,
                                        top: screenHeight * 0.0,
                                        bottom: screenHeight * 0.01,
                                        left: screenHeight * 0.02,
                                      ),// Responsive margin
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.14,
                                      decoration: BoxDecoration(
                                        color: Color(
                                            0xFFC80000), // Fallback color if image fails to load
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/B2_ls.png'), // Path to your banner image
                                          fit: BoxFit.fill,

                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).hintColor.withOpacity(0.0),
                                            offset: Offset(0, 4),
                                            blurRadius: 9,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            flex: 4, // 6 out of 10 for the text section
                                            child: Container(),
                                          ),
                                          Flexible(
                                            flex: 6, // 6 out of 10 for the text section
                                            child: Padding(
                                              padding: EdgeInsets.all(screenHeight * 0.02),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: screenHeight * 0.01,
                                                      bottom: screenHeight * 0.00,
                                                      left: screenHeight * 0.00,
                                                      right: screenHeight * 0.00,
                                                    ),
                                                    child: Text(
                                                      "Patient Mobile App",
                                                      style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: screenHeight * 0.014,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: screenHeight * 0.00,
                                                      bottom: screenHeight * 0.00,
                                                      left: screenHeight * 0.00,
                                                      right: screenHeight * 0.00,
                                                    ),
                                                    child: Text(
                                                      "Caring for you, every step of the way",
                                                      style: TextStyle(
                                                        fontSize: screenHeight * 0.018,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.left,
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

                            // Notifications
                            Container(
                              height: double
                                  .infinity,

                              width: double
                                  .infinity,

                              color: Colors
                                  .white,
                              child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap:
                                true,

                                children: [


                                  // Today, Jan 20
                                  isTodayCount == false ?  Container() :
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015,
                                        right: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.0,
                                        top :  MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015,
                                        bottom: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.00),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Today, Jan 20",
                                        style: TextStyle(
                                          fontSize:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.014,
                                          color: Color(0xFF1F1F1F),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),

                                  isTodayCount == false ?  Container() :
                                  Container(
                                    margin: EdgeInsets.only(
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
                                      itemCount: uploadfilestime0.length,
                                      itemBuilder: (context, index) {


                                        final file = uploadfilestime[index][0];

                                        return

                                            Dismissible(
                                              key:  Key(file), // Unique key for each item
                                              direction: DismissDirection.endToStart, // Allow swipe from right to left
                                              background: Container(
                                                color: Colors.white,
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              onDismissed: (direction) {

                                                print('index : $index');
                                                // uploadfilestime.removeAt(index);
                                                print('Count : ${uploadfilestime0.length}');
                                                print('isTodayCount : $isTodayCount');
                                                Future.delayed(Duration(milliseconds: 300), () {
                                                  if (index < uploadfilestime0.length) {
                                                    setState(() {
                                                      uploadfilestime0.removeAt(index);
                                                    });
                                                  }

                                                });


                                                if (uploadfilestime0.length == 1) {
                                                  isTodayCount = false;

                                                  print('isTodayCount : $isTodayCount');
                                                }
                                                 /*setState(() {

                                                });*/

                                                // Show a snackbar for feedback
                                               /*  ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text("$file deleted"),
                                                                  duration: Duration(seconds: 2),
                                                                ),
                                                              );*/
                                              },
                                              child:

                                  GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 0.0,
                                      color: Colors.white,
                                      child: Container(
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
                                                Color(
                                                    0xFFE8F0F3)
                                                    .withOpacity(
                                                    0.5),
                                                Color(
                                                    0xFFE8F0F3)
                                                    .withOpacity(
                                                    0.5),
                                              ],)),
                                        margin: EdgeInsets.only(
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
                                                0.0,
                                            top: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00),
                                        child: Container(



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
                                                      0.015,
                                                  top:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.00,
                                                  bottom:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
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
                                                    width :  MediaQuery.of(context).size.height * 0.05,


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
                                                          uploadfilestime0[0][0],
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
                                                            0.015),
                                                    Expanded(
                                                      flex: 6,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          Container(
                                                      margin : EdgeInsets.only(
                                                            top : MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.01,
                                                      ),
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
                                                              uploadfilestime0[0][1],
                                                              style:
                                                              TextStyle(
                                                                color: Color(0xFF126086),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontSize: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.012,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin : EdgeInsets.only(
                                                              top : MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.005,
                                                            ),
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
                                                              "Duration: 6 Days : Intensity: Severe, Onset/Time course: Acute : ",
                                                              style:
                                                              TextStyle(
                                                                color: Color(0xFF126086).withOpacity(0.7),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,

                                                                fontSize: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.009,
                                                                fontWeight : FontWeight.w400,
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
                                                              "Radiation of Pain: Chest Associated Symptoms:",
                                                              style:
                                                              TextStyle(
                                                                color: Color(0xFF126086).withOpacity(0.7),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,

                                                                fontSize: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.009,
                                                                fontWeight : FontWeight.w400,
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
                                                            child: Align(
                                                              alignment: AlignmentDirectional.centerEnd, // Align text to the end
                                                              child: Text(
                                                                uploadfilestime0[0][2],
                                                                style : TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,

                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.009,
                                                                  fontWeight : FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    // Adding the side arrow at the end




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



                                  // Yesterday, Jan 19
                                  isYesterdayCount == false ? Container() :
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015,
                                        right: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.0,
                                        top :  MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015,
                                        bottom: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.00),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Yesterday, Jan 19",
                                        style: TextStyle(
                                          fontSize:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.014,
                                          color: Color(0xFF1F1F1F),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  )  ,

                                  isYesterdayCount == false ?  Container() :
                                  Container(
                                    margin: EdgeInsets.only(
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
                                      itemCount: uploadfilestime.length,
                                      itemBuilder: (context, index) {


                                        final file = uploadfilestime[index][0];

                                        return

                                            Dismissible(
                                              key:  Key(file), // Unique key for each item
                                              direction: DismissDirection.endToStart, // Allow swipe from right to left
                                              background: Container(
                                                color: Colors.white,
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              onDismissed: (direction) {

                                                print('index : $index');
                                                // uploadfilestime.removeAt(index);
                                                print('Count : ${uploadfilestime.length}');
                                                print('isYesterdayCount : $isYesterdayCount');
                                                Future.delayed(Duration(milliseconds: 300), () {
                                                  if (index < uploadfilestime.length) {
                                                    setState(() {
                                                      uploadfilestime.removeAt(index);
                                                    });
                                                  }

                                                });


                                                if (uploadfilestime.length == 1) {
                                                  isYesterdayCount = false;

                                                  print('isYesterdayCount : $isYesterdayCount');
                                                }
                                                 /*setState(() {

                                                });*/

                                                // Show a snackbar for feedback
                                               /*  ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text("$file deleted"),
                                                                  duration: Duration(seconds: 2),
                                                                ),
                                                              );*/
                                              },
                                              child:

                                          GestureDetector(
                                            onTap: () {},
                                            child: Card(
                                              elevation: 0.0,
                                              color: Colors.white,
                                              child: Container(

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
                                                        Color(
                                                            0xFFE8F0F3)
                                                            .withOpacity(
                                                            0.5),
                                                        Color(
                                                            0xFFE8F0F3)
                                                            .withOpacity(
                                                            0.5),
                                                      ],)),
                                                margin: EdgeInsets.only(
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
                                                        0.0,
                                                    top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00),
                                                // color: Colors.white,
                                                child: Container(
                                                  // color: Colors.white,


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
                                                              0.015,
                                                          top:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                          bottom:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.005,
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
                                                              width :  MediaQuery.of(context).size.height * 0.05,


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
                                                                  uploadfilestime[index][0],
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
                                                                    0.015),
                                                            Expanded(
                                                              flex: 6,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: <Widget>[
                                                                  Container(
                                                                    margin : EdgeInsets.only(
                                                                      top : MediaQuery.of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                    ),
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
                                                                      uploadfilestime[index][1],
                                                                      style:
                                                                      TextStyle(
                                                                        color: Color(0xFF126086),
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                            0.012,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin : EdgeInsets.only(
                                                                      top : MediaQuery.of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.005,
                                                                    ),
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
                                                                      "Duration: 6 Days : Intensity: Severe, Onset/Time course: Acute : ",
                                                                      style:
                                                                      TextStyle(
                                                                        color: Color(0xFF126086).withOpacity(0.7),
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,

                                                                        fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                            0.009,
                                                                        fontWeight : FontWeight.w400,
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
                                                                      "Radiation of Pain: Chest Associated Symptoms:",
                                                                      style:
                                                                      TextStyle(
                                                                        color: Color(0xFF126086).withOpacity(0.7),
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,

                                                                        fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                            0.009,
                                                                        fontWeight : FontWeight.w400,
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
                                                                    child: Align(
                                                                      alignment: AlignmentDirectional.centerEnd, // Align text to the end
                                                                      child: Text(
                                                                        uploadfilestime[index][2],
                                                                        style : TextStyle(
                                                                          color: Color(0xFF126086),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,

                                                                          fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.009,
                                                                          fontWeight : FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            // Adding the side arrow at the end




                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )

                                         );
                                      },
                                    ),
                                  ),
                                                                                           
                                  // Dec 19 2023
                                  isDay19Count == false ? Container() :
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015,
                                        right: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.0,
                                        top :  MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015,
                                        bottom: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.00),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Dec 19 2023",
                                        style: TextStyle(
                                          fontSize:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.014,
                                          color: Color(0xFF1F1F1F),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),


                                  isDay19Count == false ? Container() :
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.005, // Dynamic top padding
                                      bottom: MediaQuery.of(context).size.height *
                                          0.05, // Dynamic bottom padding
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
                                      itemCount: uploadfilestime1.length,
                                      itemBuilder: (context, index) {


                                        final file2 = uploadfilestime1[index][0];

                                        return

                                          Dismissible(
                                              // key: ValueKey(file2),
                                              key : UniqueKey(),// Unique key for each item
                                              direction: DismissDirection.endToStart, // Allow swipe from right to left
                                              background: Container(
                                                color: Colors.white,
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              onDismissed: (direction) {

                                                // if (mounted) {
                                                //         if ( index < uploadfilestime1.length) {
                                                //
                                                //            print('if');
                                                //             uploadfilestime1.removeAt(index);
                                                //         }
                                                //  }

                                                final removedItem = uploadfilestime1[index];
                                                setState(() {
                                                    uploadfilestime1.removeAt(index);
                                                });
                                                // If the list is empty, show a message
                                                if (uploadfilestime1.isEmpty) {
                                                  print('uploadfilestime1.isEmpty');

                                                    isDay19Count = false;

                                                }



                                                /*setState(() {

                                                });*/

                                                // Show a snackbar for feedback
                                                /*  ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text("$file deleted"),
                                                                  duration: Duration(seconds: 2),
                                                                ),
                                                              );*/
                                              },
                                              child:

                                              GestureDetector(
                                                onTap: () {},
                                                child: Card(
                                                  elevation: 0.0,
                                                  color: Colors.white,
                                                  child: Container(
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
                                                            Color(
                                                                0xFFE8F0F3)
                                                                .withOpacity(
                                                                0.5),
                                                            Color(
                                                                0xFFE8F0F3)
                                                                .withOpacity(
                                                                0.5),
                                                          ],)),
                                                    margin: EdgeInsets.only(
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
                                                            0.0,
                                                        top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Container(
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
                                                                  0.015,
                                                              top:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
                                                              bottom:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.005,
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
                                                                  width :  MediaQuery.of(context).size.height * 0.05,


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
                                                                      uploadfilestime1[index][0],
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
                                                                        0.015),
                                                                Expanded(
                                                                  flex: 6,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: <Widget>[
                                                                      Container(
                                                                        margin : EdgeInsets.only(
                                                                          top : MediaQuery.of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.01,
                                                                        ),
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
                                                                          uploadfilestime1[index][1],
                                                                          style:
                                                                          TextStyle(
                                                                            color: Color(0xFF126086),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                            fontSize: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
                                                                                0.012,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin : EdgeInsets.only(
                                                                          top : MediaQuery.of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.005,
                                                                        ),
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
                                                                          "Duration: 6 Days : Intensity: Severe, Onset/Time course: Acute : ",
                                                                          style:
                                                                          TextStyle(
                                                                            color: Color(0xFF126086).withOpacity(0.7),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,

                                                                            fontSize: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
                                                                                0.009,
                                                                            fontWeight : FontWeight.w400,
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
                                                                          "Radiation of Pain: Chest Associated Symptoms:",
                                                                          style:
                                                                          TextStyle(
                                                                            color: Color(0xFF126086).withOpacity(0.7),
                                                                            overflow:
                                                                            TextOverflow
                                                                                .ellipsis,

                                                                            fontSize: MediaQuery.of(context)
                                                                                .size
                                                                                .height *
                                                                                0.009,
                                                                            fontWeight : FontWeight.w400,
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
                                                                        child: Align(
                                                                          alignment: AlignmentDirectional.centerEnd, // Align text to the end
                                                                          child: Text(
                                                                            uploadfilestime1[index][2],
                                                                            style : TextStyle(
                                                                              color: Color(0xFF126086),
                                                                              overflow:
                                                                              TextOverflow
                                                                                  .ellipsis,

                                                                              fontSize: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.009,
                                                                              fontWeight : FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                                // Adding the side arrow at the end




                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )

                                          );
                                      },
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
