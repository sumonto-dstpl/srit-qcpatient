
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Maps/google_map_screen.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/Screens/Widgets/UploadBox.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:newfolder/Screens/Widgets/homecare_otherservices_address_screen.dart';
import 'package:newfolder/constants/time_slot_constants.dart';
import 'package:newfolder/utils/custom_calendar.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';


import '../../utils/TimeSlotSelector.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class HomecareOtherserviceDetail extends StatefulWidget {
  String usernameValue;
  int selectedIndex = 0;
  HomecareOtherserviceDetail({
    super.key,
    required this.usernameValue,
  });
  @override
  State<HomecareOtherserviceDetail> createState() => HomecareOtherserviceDetailState();
}

class HomecareOtherserviceDetailState extends State<HomecareOtherserviceDetail> {

  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  bool _isExpandedtime = true;
  bool _isExpandedlocation = true;
  String selectedSlot = "";
  DateTime? _selectedDay;

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  List location = [
    ["Home Address", "65 Mohamed Bin Al Qassim St, Doha, Qatar"],
    ["Home Address", "65 Mohamed Bin Al Qassim St, Doha, Qatar"],
  ];

  bool timeSelectFlag = false;

  String slectedDateSlot = DateFormat('dd-MM-yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    String todayDate = DateFormat('MMMM d yyyy').format(now);

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
              Header(userName: widget.usernameValue),

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
                      topLeft: Radius.circular(height * 0.03),
                      topRight: Radius.circular(height * 0.03),
                    ),
                  ),
                  child: ListView(
                    children: [
                      // File Upload
                      // Container(
                      //   width: double.infinity,
                      //   padding: EdgeInsets.only(
                      //     top: 0,
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
                      //                     0.02,
                      //                 bottom:
                      //                 MediaQuery.of(context).size.height *
                      //                     0.01),
                      //             width: height * 0.04,
                      //             height: height * 0.04,
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
                      //                     fontWeight: FontWeight.w600,
                      //                     color: Color(0xFF1F1F1F),
                      //                     fontSize: MediaQuery.of(context)
                      //                         .size
                      //                         .height *
                      //                         0.014,
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
                      //                         0.02),
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
                      //                           fontSize: height * 0.012,
                      //                         ),
                      //                       ),
                      //                       TextSpan(
                      //                         text: ' 10MB',
                      //                         style: TextStyle(
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: height * 0.012,
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

                      // Select Time

                      UploadBox(),

                      Container(
                        child: CustomCalendar(
                          onDateSelected: (date) {
                            setState(() {
                              _selectedDay = date;
                              slectedDateSlot =
                                  DateFormat('dd-MM-yyyy').format(date);
                            });

                            print(
                                "Selected Date: ${DateFormat('dd-MM-yyyy').format(date)}");
                            // Call your getBookingDetails() function here if needed
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.015,
                          left: MediaQuery.of(context).size.height * 0.015,
                        ),
                        child: Card(
                          color: Colors.white,
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
                                      color: Color(
                                          0x24000000), // Top border color
                                      width: 2.0, // Top border thickness
                                    ),
                                    right: BorderSide(
                                      color: Color(
                                          0x24000000), // Right border color
                                      width: 2.0, // Right border thickness
                                    ),
                                    bottom: BorderSide(
                                      color: Color(
                                          0x24000000), // Bottom border color
                                      width: _isExpandedtime
                                          ? 1.0
                                          : 2.0, // Reduced bottom border thickness on expansion
                                    ),
                                    left: BorderSide(
                                      color: Color(
                                          0x24000000), // Left border color
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
                              if(_isExpandedtime)
                                SizedBox(height: height * 0.015,),
                              if(_isExpandedtime)
                                TimeSlotSelector(
                                  timeSlots: timeSlots,
                                  selectedDate: _selectedDay ?? DateTime.now(),
                                  onSelected: (selectedTime) {
                                    setState(() {

                                      selectedSlot = selectedTime;
                                      timeSelectFlag = true;

                                    });
                                    // print("Selected Slot: $selectedSlot");
                                    // print("Selected Slot: $selectedSlot");
                                  },
                                  pagename: "${widget.usernameValue}",
                                ),
                              if (_isExpandedtime)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.02,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.011,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.0),
                                  // child: Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Text(
                                  //     "Select Your Time",
                                  //     style: TextStyle(
                                  //       fontSize:
                                  //           MediaQuery.of(context).size.height *
                                  //               0.014,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Select Location
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
                                        color: Color(
                                            0x24000000), // Top border color
                                        width: 2.0, // Top border thickness
                                      ),
                                      right: BorderSide(
                                        color: Color(0x24000000),
                                        width: 2.0, // Right border thickness
                                      ),
                                      bottom: BorderSide(
                                        color: Color(0x24000000),
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
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.005, // Dynamic top padding

                                  ),
                                  child: ListView.builder(
                                    shrinkWrap:
                                    true, // Prevents infinite height
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: location.length,
                                    itemBuilder: (context, index) {
                                      final item = location[index];
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

                                            padding: EdgeInsets.zero,
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
                                              margin: EdgeInsets.zero,
                                              padding: EdgeInsets.all(
                                                   height *
                                                      0.005,
                                                  ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left:height *
                                                          0.01,
                                                      right: height *
                                                          0.005,
                                                      top: height *
                                                          0.01,
                                                      bottom: height *
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
                                                              left:  height *
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
                                                            width:  height *
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
                                                                EdgeInsets.zero,

                                                                child: Text(
                                                                  item[0],
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
                                                                    fontSize:  height *
                                                                        0.014,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                EdgeInsets
                                                                    .zero,
                                                                child: Text(
                                                                  item[1],
                                                                  style:
                                                                  TextStyle(
                                                                    color: Color(
                                                                        0x99000000),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    fontSize:  height *
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
                                                          size:  height *
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
                      GestureDetector(
                        onTap: () async{
                          print( "location");

                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomecareOtherservicesAddressScreen(),
                            ),
                          );

                          print("Selected Address: $result");
                          if(result != null) {
                            setState(() {
                              location.add([
                                result['street'],
                                "${result['landmark'].toString().isNotEmpty ? result['landmark'].toString().isNotEmpty :  result['thoroughfare']} ${result['address'].toString().isNotEmpty ? result['address'].toString().isNotEmpty : result['subLocality']} ${result['city']}",
                              ]);
                            });
                          }

                        },
                        child: Container(
                          color : Colors.transparent,
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
                                    fontSize:
                                    MediaQuery.of(context).size.height * 0.01,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Add service button
                      GestureDetector(
                        onTap: () async {
                          if(timeSelectFlag && slectedDateSlot.isNotEmpty ){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HomePageMain();
                                },
                              ),
                            );
                          }
                          else {
                            showTopNotification(
                              context,
                              title: "Book Service",
                              message: "Please select Time Slot",
                              type: NotificationType.error,
                            );
                          }
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
                                              colors: (timeSelectFlag && slectedDateSlot.isNotEmpty ) ?[ Color(0xFF13668E) ,Color(0xFF13668E)] : [ Color(0xFFBDBDBD),Color(0xFFBDBDBD), ]



                                          )),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 0.0),
                                      child: TextButton(
                                        onPressed: () async {
                                          final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";

                                          if (isLoggedIn == "YES") {
                                            // Show login bottom sheet for guest users
                                            Timer(const Duration(milliseconds: 0), () {
                                              LoginBottomSheet.show(context, false);
                                            });
                                          } else {
                                            if (timeSelectFlag) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (
                                                      BuildContext context) {
                                                    return HomePageMain();
                                                  },
                                                ),
                                              );
                                            }

                                            else {
                                              showTopNotification(
                                                context,
                                                title: "Book Service",
                                                message: "Please select Time Slot",
                                                type: NotificationType.error,
                                              );
                                            }
                                          }
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
                                            )),
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 9.0,
                                              horizontal:
                                              12.0), // ← Adjust this
                                          minimumSize: Size(0,
                                              0), // Removes minimum button constraints
                                          tapTargetSize: MaterialTapTargetSize
                                              .shrinkWrap, // Removes extra tap padding
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
      floatingActionButton:  CustomFloatingActionButton(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }




}