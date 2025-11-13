import 'dart:convert';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Timeline/timelinedetails.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Timeline/timelinedetails.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';

import 'package:timeline_tile/timeline_tile.dart';
import 'dart:ui' show TextDirection;
import 'dart:math' as Math;
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';

class TimelineMain extends StatefulWidget {
  int selectedIndex = 0;

  TimelineMain({
    super.key,
  });

  @override
  State<TimelineMain> createState() => TimelineMainstate();
}

class TimelineMainstate extends State<TimelineMain> {
  String usernameValue = "TimeLine";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;

  final List<TimelineEntry> allEntries = [
    TimelineEntry(
      date: DateTime(2023, 12, 20),
      displayDate: "20-12",
      title: "Difficulty in breathing (OP)",
      doctor: "Dr. Steve, Cardiology",
      description:
      "Duration: 6 Days • Intensity: Severe\nOnset/Time course: Acute • Radiation of Pain: Chest\nAssociated Symptoms: Wheezing",
      color:   Color(0xFFFFF1E6),
    ),
    TimelineEntry(
      date: DateTime(2023, 12, 25),
      displayDate: "25-12",
      title: "Chest Pain (IP)",
      doctor: "Dr. Steve, Cardiology",
      description:
      "Duration: 3 Days • Intensity: Severe\nOnset/Time course: Acute • Radiation of Pain: Chest\nAssociated Symptoms: Sweating",
      color: Color(0x1A2BFF00),
    ),
    TimelineEntry(
      date: DateTime(2023, 12, 27),
      displayDate: "02-01",
      title: "Difficulty in breathing (OP)",
      doctor: "Dr. Steve, Cardiology",
      description:
      "Duration: 6 Days • Intensity: Severe\nOnset/Time course: Acute • Radiation of Pain: Chest\nAssociated Symptoms: Wheezing",
      color:   Color(0xFFFFF1E6),
    ),
    TimelineEntry(
      date: DateTime(2023, 12, 29),
      displayDate: "25-12",
      title: "Chest Pain (IP)",
      doctor: "Dr. Steve, Cardiology",
      description:
      "Duration: 3 Days • Intensity: Severe\nOnset/Time course: Acute • Radiation of Pain: Chest\nAssociated Symptoms: Sweating",
      color: Color(0x1A2BFF00),
    ),
    TimelineEntry(
      date: DateTime(2024, 1, 11),
      displayDate: "11-01",
      title: "Chest Pain (IP)",
      doctor: "Dr. Steve, Cardiology",
      description:
      "Duration: 3 Days • Intensity: Severe\nOnset/Time course: Acute • Radiation of Pain: Chest\nAssociated Symptoms: Sweating",
      color: Color(0x1A2BFF00),
    ),
    TimelineEntry(
      date: DateTime(2024, 1, 2),
      displayDate: "02-01",
      title: "Difficulty in breathing (OP)",
      doctor: "Dr. Steve, Cardiology",
      description:
      "Duration: 6 Days • Intensity: Severe\nOnset/Time course: Acute • Radiation of Pain: Chest\nAssociated Symptoms: Wheezing",
      color:   Color(0xFFFFF1E6),
    ),
    TimelineEntry(
      date: DateTime(2024, 1, 11),
      displayDate: "11-01",
      title: "Chest Pain (IP)",
      doctor: "Dr. Steve, Cardiology",
      description:
      "Duration: 3 Days • Intensity: Severe\nOnset/Time course: Acute • Radiation of Pain: Chest\nAssociated Symptoms: Sweating",
      color: Color(0x1A2BFF00),
    ),

    TimelineEntry(
      date: DateTime(2024, 2, 11),
      displayDate: "11-01",
      title: "Chest Pain (IP)",
      doctor: "Dr. Steve, Cardiology",
      description:
      "Duration: 3 Days • Intensity: Severe\nOnset/Time course: Acute • Radiation of Pain: Chest\nAssociated Symptoms: Sweating",
      color: Color(0x1A2BFF00),
    ),
  ];
  late List<DateTime> allDates;
  late int _startIndex;
  late int _endIndex;

  Map<String, bool> _expandedMonths = {};
  String lastMonth = "";
  String formattedDate = "";
  void initState() {
    super.initState();
    allDates = allEntries.map((e) => e.date).toList();
    _startIndex = 0;
    _endIndex = allDates.length - 1;

    final lastEntry = allEntries.last;

// Format its date
    final formatter = DateFormat('MMMM yyyy');
      formattedDate = formatter.format(lastEntry.date);

      // Output: January 2024
  }

  int count = 0;
  int everyValueLength = 0;

  var grouped= {};

  @override
  Widget build(BuildContext context) {
    grouped =  _groupEntriesByMonth(allEntries);
    lastMonth = grouped.keys.last;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // double progressWidth = MediaQuery.of(context).size.width * 0.92;

    final dateFormatter = DateFormat('dd-MM-yyyy');
    final filteredEntries = allEntries.where((entry) {
      return entry.date.isAfter(allDates[_startIndex].subtract(Duration(days: 1))) &&
          entry.date.isBefore(allDates[_endIndex].add(Duration(days: 1)));
    }).toList();



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
              // Container(
              //   padding: EdgeInsets.only(
              //     top: screenHeight * 0.07,
              //     left: screenWidth * 0.045,
              //     right: screenWidth * 0.045,
              //     bottom: screenWidth * 0.06,
              //   ),
              //   margin: EdgeInsets.only(
              //     right: screenHeight * 0.0,
              //     top: screenHeight * 0.0,
              //     bottom: screenHeight * 0.01,
              //     left: screenHeight * 0.0,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //
              //       InkWell(
              //         onTap: () => Navigator.pop(context),
              //         child: Container(
              //           height: MediaQuery.of(context).size.height * 0.035,
              //           width: MediaQuery.of(context).size.height * 0.035,
              //           margin: EdgeInsets.only(
              //             left: MediaQuery.of(context).size.height * 0.00,
              //             top: MediaQuery.of(context).size.height * 0.00,
              //             right: MediaQuery.of(context).size.height * 0.02,
              //             bottom: MediaQuery.of(context).size.height * 0.00,
              //           ),
              //           decoration: BoxDecoration(
              //
              //             color: Color(0xFF126086).withOpacity(0.2),
              //
              //             shape: BoxShape.circle,
              //             border: Border.all(
              //                 width: 0.0, color: Color(0xFF126086)),
              //           ),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(130.0),
              //             child: Image.asset(
              //               'assets/medicationBack.png',
              //               fit: BoxFit.fill,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //             padding: EdgeInsets.only(
              //               top: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height * 0.00,
              //               bottom: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height * 0.005,
              //               left: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height * 0.00,
              //               right: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height * 0.00,
              //             ),
              //             child: Text(
              //               usernameValue,
              //               style: TextStyle(
              //                 fontSize:
              //                 MediaQuery
              //                     .of(context)
              //                     .size
              //                     .height * 0.018,
              //                 color: Color(0xFFFFFFFF),
              //                 fontWeight: FontWeight.w600,
              //               ),
              //               overflow: TextOverflow.ellipsis,
              //               textAlign: TextAlign.left,
              //             ),
              //           ),
              //
              //
              //           GestureDetector(
              //             onTap: () {
              //                Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                       builder:
              //                           (BuildContext context) {
              //                         return AddressScreen();
              //                       },
              //                     ),
              //                   );
              //             },
              //             child:
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               // Align items to the start
              //               children: [
              //                 Container(
              //                   padding: EdgeInsets.symmetric(
              //                     vertical: MediaQuery
              //                         .of(context)
              //                         .size
              //                         .height * 0.00,
              //                     horizontal: MediaQuery
              //                         .of(context)
              //                         .size
              //                         .height * 0.00,
              //                   ),
              //                   child: Text(
              //                     useraddressValue,
              //                     style: TextStyle(
              //                       overflow: TextOverflow.ellipsis,
              //                       fontSize: MediaQuery
              //                           .of(context)
              //                           .size
              //                           .height * 0.012,
              //                       color: Colors.white,
              //                     ),
              //                     textAlign: TextAlign.left,
              //                   ),
              //                 ),
              //                 Icon(
              //                   Icons.keyboard_arrow_down,
              //                   // Downward pointing arrow
              //                   color: Colors.white,
              //                   size: MediaQuery
              //                       .of(context)
              //                       .size
              //                       .height * 0.02, // Responsive size
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //
              //
              //       // Action Bar 2nd half
              //       Expanded(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //
              //             // Cart
              //             GestureDetector(
              //               onTap: () {
              //                 Navigator.of(context).push(
              //                   MaterialPageRoute(
              //                     builder:
              //                         (BuildContext context) {
              //                       return AddToCartMain();
              //                     },
              //                   ),
              //                 );
              //               },
              //               child:
              //               AppointmentIconBadge(
              //                 appointmentcount: "",
              //               ),
              //             ),
              //
              //
              //             // Notification
              //             GestureDetector(
              //               onTap: () {
              //                 Navigator.of(context).push(
              //                   MaterialPageRoute(
              //                     builder:
              //                         (BuildContext context) {
              //                       return NotificationMain();
              //                     },
              //                   ),
              //                 );
              //               },
              //               child:
              //               IconBadge(
              //                 notificationcount: "",
              //               ),
              //             ),
              //
              //
              //             // Profile Image
              //             userprofilepValue != "NA"
              //                 ?
              //
              //             GestureDetector(
              //                 onTap: () async {
              //                   Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                       builder: (BuildContext context) {
              //                         return ProfileMain();
              //                       },
              //                     ),
              //                   );
              //                 }, child:
              //             Container(
              //               height: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height *
              //                   0.050,
              //               width: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height *
              //                   0.050,
              //               decoration: BoxDecoration(
              //                 border: Border.all(
              //                   width: 1.0,
              //                   color: Colors.white,
              //                 ),
              //                 shape: BoxShape.circle,
              //                 image: new DecorationImage(
              //                   fit: BoxFit.fill,
              //                   image: Image
              //                       .memory(
              //                       base64Decode(userprofilepValue))
              //                       .image,
              //                 ),
              //               ),
              //             )
              //             )
              //                 : GestureDetector(
              //               onTap: () async {
              //                 Navigator.of(context).push(
              //                   MaterialPageRoute(
              //                     builder: (BuildContext context) {
              //                       return ProfileMain();
              //                     },
              //                   ),
              //                 );
              //               }, child: Container(
              //               height: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height *
              //                   0.04,
              //               width: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height *
              //                   0.04,
              //               padding: EdgeInsets.only(
              //                 left: MediaQuery
              //                     .of(context)
              //                     .size
              //                     .height *
              //                     0.00,
              //               ),
              //               decoration: BoxDecoration(
              //                 color: Colors.green,
              //                 shape: BoxShape.circle,
              //                 border: Border.all(
              //                   width: 1.0,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(130.0),
              //                 child: Image.asset(
              //                   'assets/drsujeet.png',
              //                   fit: BoxFit.fill,
              //                 ),
              //               ),
              //             ),
              //             )
              //
              //
              //
              //
              //
              //
              //
              //
              //
              //
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),


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
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: MediaQuery.of(context).size.height * 0.03,
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.00,
                          top: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.01,
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
                    Expanded(

                      child: Column(
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
                              softWrap: true,
                              maxLines: 2,

                            ),
                          ),


                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (BuildContext context) {
                                    return AddressScreen();
                                  },
                                ),
                              );
                            },
                            child:
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              // Align items to the start
                              children: [
                                Expanded(
                                  flex : 6,
                                  child: Container(
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

                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    // Downward pointing arrow
                                    color: Colors.white,
                                    size: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.02, // Responsive size
                                  ),
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
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.0,
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

                    child : Column(
                      children: [

                        SizedBox(height: screenHeight * 0.02,),

                        // Start and End Range Sliders
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.white, // Customize to your desired color
                              thumbShape: RingThumbShape(),
                              overlayColor: Colors.transparent, // 🔹 removes purple effect
                              overlayShape: SliderComponentShape.noOverlay, // 🔹 removes overlay shape
                              showValueIndicator: ShowValueIndicator.never, // 🔹 disables tooltip text
                              activeTrackColor: Color(0xFF0F5C83),
                              inactiveTrackColor: Colors.grey.shade200,
                            ),
                            // child: RangeSlider(
                            //   values: RangeValues(_startIndex.toDouble(), _endIndex.toDouble()),
                            //   min: 0,
                            //   max: (allDates.length - 1).toDouble(),
                            //   divisions: allDates.length - 1,
                            //   labels: RangeLabels(
                            //     dateFormatter.format(allDates[_startIndex]),
                            //     dateFormatter.format(allDates[_endIndex]),
                            //   ),
                            //   onChanged: (values) {
                            //     setState(() {
                            //       _startIndex = values.start.round();
                            //       _endIndex = values.end.round();
                            //     });
                            //   },
                            //
                            //
                            // ),
                            child: Slider(
                              value: _endIndex.toDouble(),
                              min: 0,
                              max: (allDates.length - 1).toDouble(),
                              divisions: allDates.length - 1,
                              label: dateFormatter.format(allDates[_endIndex]),
                              onChanged: (value) {
                                setState(() {
                                  _endIndex = value.round();
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(dateFormatter.format(allDates[_startIndex]),
                                  style: TextStyle(
                                      color : Color(0xFF13668E),
                                      fontSize: screenHeight * 0.01,
                                      fontWeight: FontWeight.w600
                                  )),
                              Text(dateFormatter.format(allDates[_endIndex]),
                                  style: TextStyle(color : Color(0xFF858585),
                                      fontSize: screenHeight * 0.01,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),


                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: _groupEntriesByMonth(filteredEntries).entries.map((entry) {
                              final month = entry.key;


                              final values = entry.value;

                              everyValueLength =  values.length ;


                              final tiles = entry.value.map(_buildTimelineTile).toList();
                              count = 0;
                              everyValueLength = 0;
                              return _buildMonthSection(month, tiles);
                            }).toList(),
                          ),
                        ),


                      ],
                    )

                ),
              ),


            ],
          ),
        ]),
      ),

      // First  - Center Docked
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


    );
  }

  Map<String, List<TimelineEntry>> _groupEntriesByMonth(List<TimelineEntry> entries) {
    final Map<String, List<TimelineEntry>> grouped = {};

    final formatter = DateFormat('MMMM yyyy'); // e.g., "January 2024"

    for (final entry in entries) {
      final key = formatter.format(entry.date);
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(entry);
    }

    return grouped;
  }
  Widget _buildMonthSection(String month, List<Widget> tiles) {
    final isExpanded = _expandedMonths[month] ?? true;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        InkWell(
          onTap: () {
            setState(() {
              _expandedMonths[month] = !(isExpanded);
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            // color: Colors.red,
            color : Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9).withOpacity(0.2),

              ),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height *
                    0.005, // Dynamic top padding
                bottom: MediaQuery.of(context).size.height *
                    0.005, // Dynamic bottom padding
                left: MediaQuery.of(context).size.height *
                    0.025, // Dynamic left padding
                right: MediaQuery.of(context).size.height *
                    0.025 , // Dynamic right padding
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    month,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context)
                          .size
                          .height *
                          0.013, // Dynamic font size
                      fontWeight: FontWeight.w600,
                      color : Color(0xB2000000),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size:
                    MediaQuery.of(context).size.height *
                        0.02, // Dynamic icon size
                  ),
                ],
              ),
            ),
          ),
        ),



        if (isExpanded) ...tiles,

        if(lastMonth == month)
          SizedBox(height: 40,),


      ],
    );
  }

  Widget _buildTimelineTile(TimelineEntry entry) {
    count = count + 1 ;

    final isFirst = count == 1;
    final isLast = count == everyValueLength;
    final height = MediaQuery.of(context).size.height;
    const lineColor = Color(0xFF126086);

    return  Container(

      margin: EdgeInsets.zero,
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height *
            0.02,
        right:
        MediaQuery.of(context).size.height *
            0.02,
      ),

      child: Container(

        padding: EdgeInsets.zero,
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [


              Container(
                margin: EdgeInsets.only(
                  top: isFirst ?   MediaQuery.of(context)
                      .size
                      .height *
                      0.06 : MediaQuery.of(context)
                      .size
                      .height *
                      0.03   ,
                ),
                child: Text(
                  entry.displayDate,
                  style: TextStyle(
                      color: Color(0xFF126086),
                      overflow:
                      TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                      fontSize:
                      MediaQuery.of(context)
                          .size
                          .height *
                          0.012
                  ),
                ),
              ),

              Stack(
                children:[
                  Container(

                  width: 25,
                  child: Column(
                    children: [
                      // Circle icon
                      if (isFirst)
                            Transform.rotate(
                              angle: 45 * (3.14159 / 180),
                              child: Container(
                                width: height * 0.01,
                                height: height * 0.01,
                                color: lineColor,
                              ),
                            ),
                      // Flexible vertical line


                        Expanded(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children:[
                              Container(
                              width: 2,
                              color:  lineColor,
                            ),

                              Positioned(
                                top:  isFirst ? MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.055    : MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.035   ,
                                 left: -3,
                                  child:
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.01,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.01,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF126086),
                                        border: Border.all(
                                            color: Color(0xFF126086),
                                            width: 2),
                                      ),
                                    ),
                              ),
                            ]
                          ),
                        ),
                      if (isLast)
                        Transform.rotate(
                          angle: 45 * (3.14159 / 180),
                          child: Container(
                            width: height * 0.01,
                            height: height * 0.01,
                            color: lineColor,
                          ),
                        ),
                    ],
                  ),
                ),

                ]
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: isFirst ? MediaQuery.of(context)
                        .size
                        .height *
                        0.06 : MediaQuery.of(context)
                        .size
                        .height *
                        0.035   ,
                  ),
                 child: CustomPaint(
                   size: Size(8, 15),
                   painter: LeftTrainglePainter(color: entry.color),
                 ),
                ),
              Expanded(
                child: Container(
          
                  margin: EdgeInsets.only(
          
                      right: MediaQuery.of(context)
                          .size
                          .height *
                          0.015,
                      top: isFirst ?  MediaQuery.of(context)
                          .size
                          .height *
                          0.04  : MediaQuery.of(context)
                          .size
                          .height *
                          0.015   ,
                      bottom: isLast? MediaQuery.of(context)
                          .size
                          .height *
                          0.025 : MediaQuery.of(context)
                          .size
                          .height *
                          0.0
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      // 1st column
          
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext
                              context) {
                                return TimelineDetails();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: entry.color,
          
                            borderRadius:
                            BorderRadius.circular(
                                8.0),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(
                                        context)
                                        .size
                                        .height *
                                        0.0,
                                    right: MediaQuery
                                        .of(
                                        context)
                                        .size
                                        .height *
                                        0.015,
                                    top: MediaQuery.of(
                                        context)
                                        .size
                                        .height *
                                        0.00,
                                    bottom: MediaQuery.of(
                                        context)
                                        .size
                                        .height *
                                        0.00),
                                child: Text(
                                  "Difficulty in breathing (OP)",
                                  style: TextStyle(
                                      color: Color(
                                          0xFF126086),
                                      overflow:
                                      TextOverflow
                                          .ellipsis,
                                      fontWeight:
                                      FontWeight
                                          .w600,
                                      fontSize: MediaQuery.of(
                                          context)
                                          .size
                                          .height *
                                          0.014
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(
                                        context)
                                        .size
                                        .height *
                                        0.0,
                                    right: MediaQuery
                                        .of(
                                        context)
                                        .size
                                        .height *
                                        0.015,
                                    top: MediaQuery.of(
                                        context)
                                        .size
                                        .height *
                                        0.00,
                                    bottom: MediaQuery.of(
                                        context)
                                        .size
                                        .height *
                                        0.00),
                                child: Text(
                                  "Dr. Steve, Cardiology",
                                  style: TextStyle(
                                      color:
                                      Color(0xB2000000),
                                      overflow:
                                      TextOverflow
                                          .ellipsis,
                                      fontWeight:
                                      FontWeight
                                          .w400,
                                      fontSize: MediaQuery.of(
                                          context)
                                          .size
                                          .height *
                                          0.012),
                                ),
                              ),
                              Container(
                                padding:
                                EdgeInsets.only(
                                  left: MediaQuery.of(
                                      context)
                                      .size
                                      .height *
                                      0.0,
                                  right: MediaQuery.of(
                                      context)
                                      .size
                                      .height *
                                      0.015,
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
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "HIP: ",
                                        style:
                                        TextStyle(
                                          // backgroundColor: Colors.black, // Background color for "HIP:"
                                          color:Color(0xE5292929),
                                          // Text color for "HIP:"
                                          fontWeight:
                                          FontWeight
                                              .w700,
                                          // Make "HIP:" bold
                                          fontSize: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.012,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                        "Duration: 6 Days : Intensity: Severe Onset/Time course: Acute : Radiation of Pain: Chest Associated Symptoms:vomiting",
                                        style:
                                        TextStyle(
                                          color: Color(0x4D000000),
                                          // Color for the rest of the text
                                          fontWeight:
                                          FontWeight
                                              .w400,
                                          // Bold for the rest of the text (optional)
                                          fontSize: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.012,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
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
      ),
    );
  }



  void _onItemTapped(int index) {
    setState(() {
      int selected = index;

      if (selected == 0) {
        /* Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePageMain()),
            (Route<dynamic> route) => false);*/
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

      /* widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;*/

      // Fluttertoast.showToast(msg: "test", toastLength: Toast.LENGTH_LONG);

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

class TimelineEntry {
  final DateTime date;
  final String displayDate;
  final String title;
  final String doctor;
  final String description;
  final Color color;

  TimelineEntry({
    required this.date,
    required this.displayDate,
    required this.title,
    required this.doctor,
    required this.description,
    required this.color,
  });
}

class RingThumbShape extends SliderComponentShape {
  final double outerRadius;
  final double innerRadius;
  final Color outerColor;
  final Color innerColor;

  RingThumbShape({
    this.outerRadius = 8,
    this.innerRadius = 4,
    this.outerColor = const Color(0xFF0F5C83), // Blue ring
    this.innerColor = Colors.white,           // White center
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(outerRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;

    // Outer circle (ring)
    final Paint outerPaint = Paint()
      ..color = outerColor
      ..style = PaintingStyle.fill;

    // Inner circle
    final Paint innerPaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;

    // Draw outer ring
    canvas.drawCircle(center, outerRadius, outerPaint);

    // Draw inner white circle
    canvas.drawCircle(center, innerRadius, innerPaint);
  }
}


class LeftTrainglePainter extends CustomPainter {
   final Color color ;

   LeftTrainglePainter({

     required this.color,
    }) ;
   @override
  void paint(Canvas canvas, Size size) {
     final paint = Paint()..color = color;

     var path = Path();
     path.moveTo(0, size.height / 2);
     path.lineTo(size.width, 0);
     path.lineTo(size.width, size.height);
     path.close();

     canvas.drawPath(path,paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}



