import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Data/Models/appointmentselectime.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/doctordetailpage.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Medications/medicationsmybook.dart';
import 'package:newfolder/Screens/Widgets/ShareToOtherApp.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/time_slot_constants.dart';
import '../../utils/TimeSlotSelector.dart';
import '../../utils/custom_calendar.dart';

class MedicatiSelectTimeSlot extends StatefulWidget {
  final String? doctoridval;

  MedicatiSelectTimeSlot(this.doctoridval, {Key? key}) : super(key: key);

  @override
  State<MedicatiSelectTimeSlot> createState() => MedicatiSelectTimeSlotstate();
}

class MedicatiSelectTimeSlotstate extends State<MedicatiSelectTimeSlot> {
  String usernameValue = "Hello, Priya Krishnamurty";
  String useraddressValue = "Reg: TSMC/FMR/09823";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  final today = DateTime.now();
  String slectedDateSlot = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String selectedSlot = "";
  DateTime? _selectedDay;
  int? selectedIndex;
  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;
  AppointmentSelectTimeResponse? responsedetails;
  List<String>? respontimeslotlist = [];
  String? formattedDate;

  String doctornameval = "";
  String completedSpecialityString = "";
  String qualificationval = "";
  bool _isSharing = false;

  @override
  void initState() {
    // getSharedPrefs();
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = null;
  }

  Future getSharedPrefs() async {
    formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    print(formattedDate);
    // CheckSession();
    getBookingDetails(formattedDate);
  }

  // String selectedSlot = "";
  // final today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    progressDialog.style(
        message: 'Loading..' '\nPlease Wait',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          color: Colors.blueAccent,
          strokeWidth: MediaQuery.of(context).size.height * 0.002,
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 13.0,
        ),
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w600));
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();
    // String slectedDateSlot = DateFormat('dd-MM-yyyy').format(today);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(
                top: screenHeight * 0.07,
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                bottom: screenWidth * 0.0,
              ),
              margin: EdgeInsets.only(
                right: screenHeight * 0.0,
                top: screenHeight * 0.0,
                bottom: screenHeight * 0.0,
                left: screenHeight * 0.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.height * 0.03,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.0,
                        top: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.0,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF126086).withOpacity(0.2),
                        shape: BoxShape.circle,
                        border:
                        Border.all(width: 0.0, color: Color(0xFF126086)),
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
                  userprofilepValue != "NA"
                      ? Container(
                    height: MediaQuery.of(context).size.height * 0.250,
                    width: MediaQuery.of(context).size.height * 0.200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image:
                        Image.memory(base64Decode(userprofilepValue))
                            .image,
                      ),
                    ),
                  )
                      : Container(
                    // color: Colors.blue,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.0,
                        right: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom:
                        MediaQuery.of(context).size.height * 0.00),
                    height: MediaQuery.of(context).size.height * 0.250,
                    width: MediaQuery.of(context).size.height * 0.21,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.asset(
                        'assets/bookappointmentdoc.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.250,
                    // color: Colors.blue,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.0,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.0,
                      right: MediaQuery.of(context).size.height * 0.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[100]!.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.005,
                                    right: MediaQuery.of(context).size.height *
                                        0.012,
                                    top: MediaQuery.of(context).size.height *
                                        0.002,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.002),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: MediaQuery.of(context).size.height *
                                          0.015,
                                    ),
                                    Text(
                                      "4.2",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.012),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  // Navigator.pop(context);
                                  if (_isSharing) return;
                                  _isSharing = true;
                                  try {
                                    // Call your static method that wraps Share.share()
                                    ShareToOtherApp.share();

                                    // Add a delay because Share.share() returns immediately
                                    await Future.delayed(Duration(seconds: 2));
                                  } catch (e) {
                                    print('Sharing failed: $e');
                                  } finally {
                                    _isSharing = false;
                                  }
                                },
                                onDoubleTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.020,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.00),
                                  height: screenHeight * 0.03,
                                  width: screenHeight * 0.03,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue[100]!.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    // Ensures the image is centered
                                    child: Image.asset(
                                      'assets/share.png', // Replace with your actual asset path
                                      // color: Color(0xFF000000).withOpacity(0.2), // Optional: Apply color tint
                                      height: screenHeight * 0.035,
                                      width: screenHeight * 0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        Container(
                          // color: Colors.white,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.005,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                          ),
                          child: Text(
                            useraddressValue,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.012,
                              color: Colors.white,
                            ),
                            // textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(
            //     top: screenHeight * 0.07,
            //     left: screenWidth * 0.0,
            //     right: screenWidth * 0.0,
            //     bottom: screenWidth * 0.0,
            //   ),
            //   margin: EdgeInsets.only(
            //     right: screenHeight * 0.0,
            //     top: screenHeight * 0.0,
            //     bottom: screenHeight * 0.0,
            //     left: screenHeight * 0.0,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       InkWell(
            //         onTap: () => Navigator.pop(context),
            //         child: Container(
            //           height: MediaQuery.of(context).size.height * 0.03,
            //           width: MediaQuery.of(context).size.height * 0.03,
            //           margin: EdgeInsets.only(
            //             left: MediaQuery.of(context).size.height * 0.01,
            //             top: MediaQuery.of(context).size.height * 0.00,
            //             right: MediaQuery.of(context).size.height * 0.01,
            //             bottom: MediaQuery.of(context).size.height * 0.00,
            //           ),
            //           decoration: BoxDecoration(
            //             color: Color(0xFF126086).withOpacity(0.2),
            //             shape: BoxShape.circle,
            //             border:
            //                 Border.all(width: 0.0, color: Color(0xFF126086)),
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
            //       userprofilepValue != "NA"
            //           ? Container(
            //               height: MediaQuery.of(context).size.height * 0.250,
            //               width: MediaQuery.of(context).size.height * 0.200,
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   width: 1.0,
            //                   color: Colors.white,
            //                 ),
            //                 shape: BoxShape.circle,
            //                 image: new DecorationImage(
            //                   fit: BoxFit.fill,
            //                   image:
            //                       Image.memory(base64Decode(userprofilepValue))
            //                           .image,
            //                 ),
            //               ),
            //             )
            //           : Container(
            //               margin: EdgeInsets.only(
            //                   left: MediaQuery.of(context).size.height * 0.05,
            //                   right: MediaQuery.of(context).size.height * 0.00,
            //                   top: MediaQuery.of(context).size.height * 0.00,
            //                   bottom:
            //                       MediaQuery.of(context).size.height * 0.00),
            //               height: MediaQuery.of(context).size.height * 0.250,
            //               width: MediaQuery.of(context).size.height * 0.21,
            //               child: ClipRRect(
            //                 borderRadius: BorderRadius.circular(0.0),
            //                 child: Image.asset(
            //                   'assets/bookappointmentdoc.png',
            //                   fit: BoxFit.fill,
            //                 ),
            //               ),
            //             ),
            //       Container(
            //         height: MediaQuery.of(context).size.height * 0.250,
            //         padding: EdgeInsets.only(
            //           top: MediaQuery.of(context).size.height * 0.00,
            //           bottom: MediaQuery.of(context).size.height * 0.00,
            //           left: MediaQuery.of(context).size.height * 0.00,
            //           right: MediaQuery.of(context).size.height * 0.00,
            //         ),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Container(
            //                     decoration: BoxDecoration(
            //                       color: Colors.blue[100]!.withOpacity(0.9),
            //                       borderRadius: BorderRadius.circular(5),
            //                     ),
            //                     padding: EdgeInsets.only(
            //                         left: MediaQuery.of(context).size.height *
            //                             0.005,
            //                         right: MediaQuery.of(context).size.height *
            //                             0.012,
            //                         top: MediaQuery.of(context).size.height *
            //                             0.002,
            //                         bottom: MediaQuery.of(context).size.height *
            //                             0.002),
            //                     child: Row(
            //                       children: <Widget>[
            //                         Icon(
            //                           Icons.star,
            //                           color: Colors.amber,
            //                           size: MediaQuery.of(context).size.height *
            //                               0.015,
            //                         ),
            //                         Text(
            //                           "4.2",
            //                           style: TextStyle(
            //                               color: Colors.black87,
            //                               fontWeight: FontWeight.w600,
            //                               overflow: TextOverflow.ellipsis,
            //                               fontSize: MediaQuery.of(context)
            //                                       .size
            //                                       .height *
            //                                   0.012),
            //                         )
            //                       ],
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                     ),
            //                   ),
            //                   InkWell(
            //                     onTap: () async {
            //                       // Navigator.pop(context);
            //                       ShareToOtherApp.share();
            //                     },
            //                     onDoubleTap: () {},
            //                     child: Container(
            //                       margin: EdgeInsets.only(
            //                           left: MediaQuery.of(context).size.height *
            //                               0.020,
            //                           right:
            //                               MediaQuery.of(context).size.height *
            //                                   0.00,
            //                           top: MediaQuery.of(context).size.height *
            //                               0.00,
            //                           bottom:
            //                               MediaQuery.of(context).size.height *
            //                                   0.00),
            //                       height: screenHeight * 0.03,
            //                       width: screenHeight * 0.03,
            //                       decoration: BoxDecoration(
            //                         // color: Colors.blue[100]!.withOpacity(0.9),
            //                         shape: BoxShape.circle,
            //                       ),
            //                       child: Center(
            //                         // Ensures the image is centered
            //                         child: Image.asset(
            //                           'assets/share.png', // Replace with your actual asset path
            //                           // color: Color(0xFF000000).withOpacity(0.2), // Optional: Apply color tint
            //                           height: screenHeight * 0.035,
            //                           width: screenHeight * 0.035,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ]),
            //             Container(
            //               padding: EdgeInsets.only(
            //                 top: MediaQuery.of(context).size.height * 0.00,
            //                 bottom: MediaQuery.of(context).size.height * 0.005,
            //                 left: MediaQuery.of(context).size.height * 0.00,
            //                 right: MediaQuery.of(context).size.height * 0.00,
            //               ),
            //               child: Text(
            //                 useraddressValue,
            //                 style: TextStyle(
            //                   overflow: TextOverflow.ellipsis,
            //                   fontSize:
            //                       MediaQuery.of(context).size.height * 0.012,
            //                   color: Colors.white,
            //                 ),
            //                 // textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Main Content Section
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.00,
                    right: MediaQuery.of(context).size.height * 0.00,
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.00),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.03),
                    topRight: Radius.circular(screenHeight * 0.03),
                  ),
                ),
                // child: ListView(
                //   padding: EdgeInsets.zero,
                //   shrinkWrap: true,
                //   physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Doctor's Information
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Dr. Nutan Bhatt",
                    //       // doctornameval,
                    //       style: TextStyle(
                    //         color: Color(0xFF126086),
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: MediaQuery.of(context).size.height * 0.02,
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.only(
                    //           left: MediaQuery.of(context).size.height * 0.00,
                    //           right: MediaQuery.of(context).size.height * 0.00,
                    //           top: MediaQuery.of(context).size.height * 0.00,
                    //           bottom:
                    //               MediaQuery.of(context).size.height * 0.005),
                    //       child: Text(
                    //         "General physician / Internal Medicine",
                    //         // completedSpecialityString,
                    //         style: TextStyle(
                    //           color: Colors.black54,
                    //           fontWeight: FontWeight.w500,
                    //           fontSize:
                    //               MediaQuery.of(context).size.height * 0.014,
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(
                    //           left: MediaQuery.of(context).size.height * 0.02,
                    //           right: MediaQuery.of(context).size.height * 0.00,
                    //           top: MediaQuery.of(context).size.height * 0.005,
                    //           bottom:
                    //               MediaQuery.of(context).size.height * 0.00),
                    //       child: Text(
                    //         "41 YEARS Experience- MBBS, DIPLOMA IN FAMILY MEDICINE (123 Reviews)",
                    //         // qualificationval,
                    //         style: TextStyle(
                    //           color: Color(0xFF126086),
                    //           fontWeight: FontWeight.bold,
                    //           fontSize:
                    //               MediaQuery.of(context).size.height * 0.012,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Dr. Nutan Bhatt",
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return DoctorDetilPage(
                                            widget.doctoridval);
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.005,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.0,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.0,
                                      top: MediaQuery.of(context).size.height *
                                          0.005),
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(130.0),
                                    child: Image.asset(
                                      'assets/Infodocdetails.png',
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.014, // Adjust height
                                      width:
                                      MediaQuery.of(context).size.height *
                                          0.014, // Adjust width
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        SizedBox(height: 4),
                        Text(
                          "General physician / Internal Medicine",
                          // completedSpecialityString,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize:
                            MediaQuery.of(context).size.height * 0.014,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.0,
                              right: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.008,
                              bottom:
                              MediaQuery.of(context).size.height * 0.00),
                          child: Text(
                            "41 YEARS Experience- MBBS, DIPLOMA IN FAMILY MEDICINE (123 Reviews)",
                            // qualificationval,
                            style: TextStyle(
                              color: Color(0xFF126086),
                              fontWeight: FontWeight.bold,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.012,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Select Your Date
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       left: MediaQuery.of(context).size.height * 0.02,
                    //       right: MediaQuery.of(context).size.height * 0.00,
                    //       top: MediaQuery.of(context).size.height * 0.015,
                    //       bottom: MediaQuery.of(context).size.height * 0.00),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       "Select Your Date",
                    //       style: TextStyle(
                    //         fontSize: MediaQuery.of(context).size.height * 0.014,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: MediaQuery.of(context).size.height * 0.02,
                    //   ),
                    //   child: GestureDetector(
                    //     onPanUpdate: (details) {
                    //
                    //       Scrollable.ensureVisible(context);
                    //     },
                    //     child: TableCalendar(
                    //       firstDay: DateTime.utc(2010, 10, 20),
                    //       lastDay: DateTime.utc(2040, 10, 20),
                    //       focusedDay: _focusedDay,
                    //       calendarFormat: _calendarFormat,
                    //       rowHeight: MediaQuery.of(context).size.height * 0.04,
                    //       availableCalendarFormats: const {
                    //         CalendarFormat.month: 'Month',
                    //       },
                    //       headerStyle: const HeaderStyle(
                    //         formatButtonVisible: false, // Hide format button
                    //         titleCentered: false, // Align title to the left
                    //         headerPadding: EdgeInsets.symmetric(vertical: 8.0),
                    //         leftChevronVisible: false, // Hide default left chevron
                    //         rightChevronVisible: false, // Hide default right chevron
                    //       ),
                    //       calendarBuilders: CalendarBuilders(
                    //
                    //         defaultBuilder: (context, date, _) {
                    //           return Container(
                    //             margin: const EdgeInsets.all(3.0),
                    //             alignment: Alignment.center,
                    //             child: Text(
                    //               '${date.day}',
                    //               style: TextStyle(
                    //                   color: Color(0xFF126086),
                    //                   // color : Colors.red,
                    //                   fontSize:
                    //                   MediaQuery.of(context).size.height *
                    //                       0.014,
                    //                   fontWeight: FontWeight.w400
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //         selectedBuilder: (context, date, _) {
                    //           return Container(
                    //             margin: const EdgeInsets.all(3.0),
                    //             decoration: BoxDecoration(
                    //               color: Color(0xFF116A94),
                    //               shape: BoxShape.circle,
                    //             ),
                    //             alignment: Alignment.center,
                    //             child: Text(
                    //               '${date.day}',
                    //               style: TextStyle(
                    //                 color: Color(0xFFFFFFFF),
                    //                 fontSize:
                    //                 MediaQuery.of(context).size.height *
                    //                     0.014,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //         todayBuilder: (context, date, _) {
                    //           // if (!isSameDay(_selectedDay, date)) {
                    //           //   return Container(
                    //           //     margin: EdgeInsets.all(3.0),
                    //           //     decoration: BoxDecoration(
                    //           //       color: Colors.transparent,
                    //           //       shape: BoxShape.circle,
                    //           //     ),
                    //           //     alignment: Alignment.center,
                    //           //     child: Text(
                    //           //       '${date.day}',
                    //           //       style: TextStyle(
                    //           //         color: Color(0xFF126086),
                    //           //         fontSize:
                    //           //         MediaQuery.of(context).size.height *
                    //           //             0.014,
                    //           //       ),
                    //           //     ),
                    //           //   );
                    //           // }
                    //
                    //           return Container(
                    //             margin: EdgeInsets.all(3.0),
                    //             decoration: BoxDecoration(
                    //               color: Color(0x33116A94),
                    //               shape: BoxShape.circle,
                    //             ),
                    //             alignment: Alignment.center,
                    //             child: Text(
                    //               '${date.day}',
                    //               style: TextStyle(
                    //                 color: Color(0xFF116A94),
                    //                 fontSize:
                    //                 MediaQuery.of(context).size.height *
                    //                     0.014,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //
                    //         headerTitleBuilder: (context, date) {
                    //           return Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Padding(
                    //                 padding: EdgeInsets.only(
                    //                   left : MediaQuery
                    //                       .of(context)
                    //                       .size
                    //                       .height * 0.02,
                    //                 ),
                    //                 child:
                    //                 Text(
                    //                   DateFormat.MMMM().format(date),
                    //                   // DateFormat.yMMMM().format(date), // Display month name
                    //                   style: TextStyle(
                    //                     fontSize: MediaQuery.of(context).size.height * 0.014,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: Colors.black87,
                    //                   ),
                    //                 ),
                    //               ),
                    //
                    //               Row(
                    //                 children: [
                    //                   IconButton(
                    //                     icon: Icon(
                    //                       Icons.chevron_left,
                    //                       size: MediaQuery.of(context).size.height * 0.02,
                    //                     ),
                    //                     onPressed: () {
                    //                       setState(() {
                    //                         _focusedDay = DateTime(
                    //                           _focusedDay.year,
                    //                           _focusedDay.month - 1,
                    //                           _focusedDay.day,
                    //                         );
                    //                       });
                    //                     },
                    //                   ),
                    //                   IconButton(
                    //                     icon: Icon(
                    //                       Icons.chevron_right,
                    //                       size: MediaQuery.of(context).size.height * 0.02,
                    //                     ),
                    //                     onPressed: () {
                    //                       setState(() {
                    //                         _focusedDay = DateTime(
                    //                           _focusedDay.year,
                    //                           _focusedDay.month + 1,
                    //                           _focusedDay.day,
                    //                         );
                    //                       });
                    //                     },
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           );
                    //         },
                    //       ),
                    //       selectedDayPredicate: (day) {
                    //         return isSameDay(_selectedDay, day);
                    //       },
                    //       onDaySelected: (selectedDay, focusedDay) async {
                    //         setState(() {
                    //           // Update the selected day and focused day
                    //           _selectedDay = selectedDay;
                    //           _focusedDay = focusedDay;
                    //         });
                    //
                    //         // Format the selected date in the desired format
                    //         formattedDate =
                    //             DateFormat('dd-MM-yyyy').format(selectedDay);
                    //         print('Selected Date: $formattedDate');
                    //         // getBookingDetails(formattedDate);
                    //       },
                    //       onFormatChanged: (format) {
                    //         if (_calendarFormat != format) {
                    //           setState(() {
                    //             _calendarFormat = format;
                    //           });
                    //         }
                    //       },
                    //       onPageChanged: (focusedDay) {
                    //         _focusedDay = focusedDay;
                    //       },
                    //       enabledDayPredicate: (day) {
                    //         return day.isAfter(DateTime.now()
                    //             .subtract(const Duration(days: 1)));
                    //       },
                    //       daysOfWeekStyle: DaysOfWeekStyle(
                    //         dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date).substring(0, 1),
                    //         weekdayStyle: TextStyle(
                    //             fontSize: MediaQuery.of(context).size.height * 0.012,
                    //             color: Color(0xFF8F95B2),
                    //             fontWeight: FontWeight.w500
                    //         ),
                    //         weekendStyle: TextStyle(
                    //             fontSize: MediaQuery.of(context).size.height * 0.012,
                    //             color: Color(0xFF8F95B2),
                    //             fontWeight: FontWeight.w500
                    //         ),
                    //       ),
                    //
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomCalendar(
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

                            // Select Your Time
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.height * 0.02,
                                  right:
                                      MediaQuery.of(context).size.height * 0.00,
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.015),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Select Your Time",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.014,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            // Top timeslot Grid

                            /*Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(0),
                          height: MediaQuery.of(context).size.height * 0.090,
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: respontimeslotlist!
                                .length, // Example count; replace with `respontimeslotlist!.length`
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex =
                                        index; // Update the selected index
                                  });
                                  print("Selected index: $selectedIndex");
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                    horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.011,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        decoration: BoxDecoration(
                                          color: selectedIndex == index
                                              ? Color(
                                                  0xFF126086) // Highlight color for selected cell
                                              : Color(0xFF13668E)
                                                  .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color(0xFF126086),
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "07:30",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: selectedIndex == index
                                                    ? Colors
                                                        .white // Highlight color for selected cell
                                                    : Color(0xFF126086),
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.014,
                                              ),
                                            ),
                                            SizedBox(height: 0),
                                            Text(
                                              "PM",
                                              style: TextStyle(
                                                color: selectedIndex == index
                                                    ? Colors
                                                        .white // Highlight color for selected cell
                                                    : Color(0xFF126086),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.012,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),*/

                            // Static  Time slots
                            // Container(
                            //
                            //   padding: EdgeInsets.only(
                            //     top: MediaQuery.of(context).size.height * 0.00,
                            //     bottom: MediaQuery.of(context).size.height * 0.00,
                            //     left: MediaQuery.of(context).size.height * 0.00,
                            //     right: MediaQuery.of(context).size.height * 0.00,
                            //   ),
                            //   child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Container(
                            //           padding: EdgeInsets.only(
                            //             top: MediaQuery.of(context).size.height * 0.00,
                            //             bottom:
                            //             MediaQuery.of(context).size.height * 0.00,
                            //             left: MediaQuery.of(context).size.height * 0.00,
                            //             right:
                            //             MediaQuery.of(context).size.height * 0.00,
                            //           ),
                            //           child: Row(
                            //             mainAxisSize: MainAxisSize
                            //                 .max, // Ensure the Row takes up the full available width
                            //             children: <Widget>[
                            //               Container(
                            //                 height: MediaQuery.of(context).size.height *
                            //                     0.045,
                            //                 width: MediaQuery.of(context).size.width *
                            //                     0.17, // Increase width
                            //                 decoration: BoxDecoration(
                            //                   color: Color(0x1A999999),
                            //                   borderRadius: BorderRadius.circular(10),
                            //                 ),
                            //                 child: Column(
                            //                   mainAxisAlignment: MainAxisAlignment
                            //                       .center, // Center the content
                            //                   children: <Widget>[
                            //                     Text(
                            //                       "06:00",
                            //                       textAlign: TextAlign.center,
                            //                       style: TextStyle(
                            //                         color: Color(0x99333333),
                            //                         fontWeight: FontWeight.w400,
                            //                         fontSize: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                             0.012,
                            //                       ),
                            //                     ),
                            //                     SizedBox(height: 0),
                            //                     Text(
                            //                       "PM",
                            //                       style: TextStyle(
                            //                         color: Color(0x99333333),
                            //                         fontWeight: FontWeight.w400,
                            //                         fontSize: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                             0.012,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         Container(
                            //           padding: EdgeInsets.only(
                            //             top: MediaQuery.of(context).size.height * 0.00,
                            //             bottom:
                            //             MediaQuery.of(context).size.height * 0.00,
                            //             left: MediaQuery.of(context).size.height * 0.00,
                            //             right:
                            //             MediaQuery.of(context).size.height * 0.00,
                            //           ),
                            //           child: Row(
                            //             mainAxisSize: MainAxisSize
                            //                 .max, // Ensure the Row takes up the full available width
                            //             children: <Widget>[
                            //               Container(
                            //                 height: MediaQuery.of(context).size.height *
                            //                     0.045,
                            //                 width: MediaQuery.of(context).size.width *
                            //                     0.17, // Increase width
                            //                 decoration: BoxDecoration(
                            //                   color: Color(0x1A999999),
                            //                   borderRadius: BorderRadius.circular(10),
                            //                 ),
                            //                 child: Column(
                            //                   mainAxisAlignment: MainAxisAlignment
                            //                       .center, // Center the content
                            //                   children: <Widget>[
                            //                     Text(
                            //                       "06:30",
                            //                       textAlign: TextAlign.center,
                            //                       style: TextStyle(
                            //                         color: Color(0x99333333),
                            //                         fontWeight: FontWeight.w400,
                            //                         fontSize: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                             0.012,
                            //                       ),
                            //                     ),
                            //                     SizedBox(height: 0),
                            //                     Text(
                            //                       "PM",
                            //                       style: TextStyle(
                            //                         color: Color(0x99333333),
                            //                         fontWeight: FontWeight.w400,
                            //                         fontSize: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                             0.012,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         Container(
                            //           padding: EdgeInsets.only(
                            //             top: MediaQuery.of(context).size.height * 0.00,
                            //             bottom:
                            //             MediaQuery.of(context).size.height * 0.00,
                            //             left: MediaQuery.of(context).size.height * 0.00,
                            //             right:
                            //             MediaQuery.of(context).size.height * 0.00,
                            //           ),
                            //           child: Row(
                            //             mainAxisSize: MainAxisSize
                            //                 .max, // Ensure the Row takes up the full available width
                            //             children: <Widget>[
                            //               Container(
                            //                 height: MediaQuery.of(context).size.height *
                            //                     0.045,
                            //                 width: MediaQuery.of(context).size.width *
                            //                     0.17, // Increase width
                            //                 decoration: BoxDecoration(
                            //                   color: Color(0xFF126086),
                            //                   borderRadius: BorderRadius.circular(10),
                            //                 ),
                            //                 child: Column(
                            //                   mainAxisAlignment: MainAxisAlignment
                            //                       .center, // Center the content
                            //                   children: <Widget>[
                            //                     Text(
                            //                       "07:00",
                            //                       textAlign: TextAlign.center,
                            //                       style: TextStyle(
                            //                         color: Colors.white,
                            //                         fontWeight: FontWeight.w400,
                            //                         fontSize: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                             0.012,
                            //                       ),
                            //                     ),
                            //                     SizedBox(height: 0),
                            //                     Text(
                            //                       "PM",
                            //                       style: TextStyle(
                            //                         color: Colors.white,
                            //                         fontSize: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                             0.012,
                            //                         fontWeight: FontWeight.w400,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         Container(
                            //           padding: EdgeInsets.only(
                            //             top: MediaQuery.of(context).size.height * 0.00,
                            //             bottom:
                            //             MediaQuery.of(context).size.height * 0.00,
                            //             left: MediaQuery.of(context).size.height * 0.00,
                            //             right:
                            //             MediaQuery.of(context).size.height * 0.00,
                            //           ),
                            //           child: Row(
                            //             mainAxisSize: MainAxisSize
                            //                 .max, // Ensure the Row takes up the full available width
                            //             children: <Widget>[
                            //               Container(
                            //                 height: MediaQuery.of(context).size.height *
                            //                     0.045,
                            //                 width: MediaQuery.of(context).size.width *
                            //                     0.17, // Increase width
                            //                 decoration: BoxDecoration(
                            //                   color: Color(0xFF13668E).withOpacity(0.3),
                            //                   borderRadius: BorderRadius.circular(10),
                            //                   border: Border.all(
                            //                     color:
                            //                     Color(0xFF126086), // Black border
                            //                     width: 1.0, // Set the border width
                            //                   ),
                            //                 ),
                            //                 child: Column(
                            //                   mainAxisAlignment: MainAxisAlignment
                            //                       .center, // Center the content
                            //                   children: <Widget>[
                            //                     Text(
                            //                       "07:30",
                            //                       textAlign: TextAlign.center,
                            //                       style: TextStyle(
                            //                         color: Color(0xFF126086),
                            //                         fontWeight: FontWeight.w400,
                            //                         fontSize: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                             0.012,
                            //                       ),
                            //                     ),
                            //                     SizedBox(height: 0),
                            //                     Text(
                            //                       "PM",
                            //                       style: TextStyle(
                            //                         color: Color(0xFF126086),
                            //                         fontSize: MediaQuery.of(context)
                            //                             .size
                            //                             .height *
                            //                             0.012,
                            //                         fontWeight: FontWeight.w400,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ]),
                            // ),
                            // const TimeSlotSelector(timeSlots: ["06:00", "06:30", "07:00", "07:30"],)
                            TimeSlotSelector(
                              timeSlots: timeSlots,
                              selectedDate: _selectedDay ?? DateTime.now(),
                              onSelected: (selectedTime) {
                                setState(() {
                                  selectedSlot = selectedTime;
                                });
                                print("Selected Slot: $selectedSlot");
                                print("Selected Slot: $selectedSlot");
                              },
                            ),
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

      // Bottom Navigation with another  positioned on the right
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, -3), // Makes the shadow appear above
              blurRadius: 6,
            ),
          ],
        ),
        // height: MediaQuery.of(context).size.height * 0.150,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Consultation Fees
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.height * 0.05,
                right: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Consultation Fees",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.height * 0.015,
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            height: MediaQuery.of(context).size.height * 0.005,
                            width: MediaQuery.of(context).size.height * 0.005,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.005,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.00),
                                  child: Text(
                                    'QR 999',
                                    style: TextStyle(
                                        // color: Colors.blue[600],
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.014),
                                  )),
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.005,
                                    right: MediaQuery.of(context).size.height *
                                        0.00,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Free",
                                  style: TextStyle(
                                      // color: Colors.blue[600],
                                      color: Color(0xFF12B76A),
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ),
                ],
              ),
            ),

            // Book Appointment

            GestureDetector(
              onTap: () async {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => MedicationMyBookingsMain(),
                //   ),
                // );
              },
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.005,
                      right: MediaQuery.of(context).size.height * 0.005),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.04,
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.04),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.012),
                                gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.center,
                                    stops: [0.5, 0.9],
                                    colors: (selectedSlot.isNotEmpty &&
                                            slectedDateSlot.isNotEmpty)
                                        ? [
                                            Color(0xFF126086),
                                            Color(0xFF126086),
                                          ]
                                        : [
                                            Colors.grey.shade300,
                                            Colors.grey.shade300
                                          ]
                                )
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 0.0),
                            child: TextButton(
                              onPressed: () async {
                                if (selectedSlot.isNotEmpty &&
                                    slectedDateSlot.isNotEmpty) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MedicationMyBookingsMain(
                                            selectedDate: slectedDateSlot,
                                            selectedTime: selectedSlot,
                                          ),
                                    ),
                                  );
                                }
                              },
                              child: Text("Book Appointment",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02)),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 9.0,
                                    horizontal: 12.0), // ← Adjust this
                                minimumSize: Size(
                                    0, 0), // Removes minimum button constraints
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Removes extra tap padding
                              ),
                            ),
                          ),
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }

  void getBookingDetails(String? formattedDateval) {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        /* progressDialog.showMaterial(
            title: "Loading Data", message: "Please wait");*/
        progressDialog.show();
        dynamic user = await apiService.findDocAppTimedetails(
            widget.doctoridval, formattedDateval);

        if (user.message != null) {
          progressDialog.hide();
          final snackBar = SnackBar(content: Text(user.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        // Get the list data and show it

        else if (user.response != null) {
          progressDialog.hide();

          setState(() {
            responsedetails = user.response;
            doctornameval =
                responsedetails!.name != null ? responsedetails!.name! : "";
            qualificationval = responsedetails!.qualification != null
                ? responsedetails!.qualification!
                : "";

            respontimeslotlist = responsedetails!.timeSlot != null
                ? responsedetails!.timeSlot!
                : [];

            print(respontimeslotlist!.length!);

            if (responsedetails!.speciality != null &&
                responsedetails!.speciality!.isNotEmpty) {
              completedSpecialityString =
                  responsedetails!.speciality!.join('/');
              print('Speciality: $completedSpecialityString');
            } else {
              print('No specialities available.');
            }
          });

          final snackBar = SnackBar(
            content: Text("Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );
        } else {
          progressDialog.hide();
          final snackBar = SnackBar(
            content: Text("Specialities Not Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // customalert.showError(context, user.error);
        }
      } else {
        // No-Internet Case
        final snackBar = SnackBar(
          content: Text("No Internet, Check Connectivity!"),
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  // Success alert bottomsheet
  void showsucessalertBottomSheet() => showModalBottomSheet(
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
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context,
                  StateSetter setState /*You can rename this!*/) =>
              Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.020,
                      right: MediaQuery.of(context).size.height * 0.020,
                      top: MediaQuery.of(context).size.height * 0.030,
                      bottom: MediaQuery.of(context).size.height * 0.00),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/paymentsucess.png',
                              height: MediaQuery.of(context).size.height * 0.30,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Thank you!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.024),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                    MediaQuery.of(context).size.height * 0.00,
                              ),
                              child: Text(
                                "Payment Done Successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
                    ],
                  ),
                ),

                // Reschedule
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                    ),
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.03,
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.03,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF126086), // Border color
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.012),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 0.0),
                            child: TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Reschedule",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.026,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Back to Home
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePageMain(),
                      ),
                      (Route route) => false,
                    );
                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.00),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.03,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.03),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.012),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.center,
                                        stops: [
                                          0.5,
                                          0.9
                                        ],
                                        colors: [
                                          Color(0xFF126086),
                                          Color(0xFF126086),
                                        ])),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 0.0),
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePageMain(),
                                      ),
                                      (Route route) => false,
                                    );
                                  },
                                  child: Text("Back to Home",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.026)),
                                ),
                              ),
                            ),
                          ])),
                ),
              ],
            ),
          ),
        ),
      );
}
