import 'dart:convert';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
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
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class TimelineMain extends StatefulWidget {
  final int selectedIndex ;

  TimelineMain({
    super.key,
    this.selectedIndex = 0 ,
  });

  @override
  State<TimelineMain> createState() => TimelineMainstate();
}

class TimelineMainstate extends State<TimelineMain> {
  String usernameValue = "TimeLine";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";


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



              Header(userName: usernameValue),
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
      floatingActionButton:  CustomFloatingActionButton(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: widget.selectedIndex),


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



