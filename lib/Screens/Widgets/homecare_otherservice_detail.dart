
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newfolder/Core/Button/save.dart';
import 'package:newfolder/Core/Data/dummy_data.dart';
import 'package:newfolder/Core/Date%20Time%20Picker/date_time_picker.dart';
import 'package:newfolder/Core/Text/label.dart';
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
    final width = MediaQuery.of(context).size.width;

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


                      UploadBox(),


                      Padding(
                        padding:   EdgeInsets.symmetric(horizontal: height * 0.02,),
                        child: LabelWithAsterisk(label: 'Select Date & Time',),
                      ),




                      CustomDateTimePicker(
                        globallyBookedSlots: DummyData.globallyBookedSlots,
                        onDateTimeSelected: (date, time) {
                          print("User selected Date: $date and Time: $time");
                          // Yahan state update karein aur Book Service button enable karein
                          setState(() {
                            // 1. Date update karein (taaki button logic pass ho)
                            slectedDateSlot = DateFormat('dd-MM-yyyy').format(date);

                            // 2. Time update karein
                            selectedSlot = time;

                            // 3. Flag ko true karein (YEH SABSE ZAROORI HAI ERROR ROKNE KE LIYE)
                            timeSelectFlag = true;
                          });
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: height * 0.01,
                          bottom: height * 0.0,
                          right: height * 0.015,
                          left: height * 0.015,
                        ),
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                              height *
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
                                          height *
                                              0.01), // Dynamic top left radius
                                      topRight: Radius.circular(
                                          height *
                                              0.01), // Dynamic top right radius
                                      bottomLeft: Radius.circular(
                                          height *
                                              0.01), // Bottom-left curve radius
                                      bottomRight: Radius.circular(MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.01), // Bottom-right curve radius
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    top: height *
                                        0.005, // Dynamic top padding
                                    bottom: height *
                                        0.005, // Dynamic bottom padding
                                    left: height *
                                        0.015, // Dynamic left padding
                                    right: height *
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
                                        height *
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
                                    top: height *
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
                            left: height * 0.02,
                            right: height * 0.015,
                            bottom: height * 0.016,
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
                                size: height *
                                    0.02, // Set icon size
                              ),
                              SizedBox(
                                  width: height *
                                      0.005), // Space between the icon and text
                              Container(
                                padding: EdgeInsets.only(
                                  left: height * 0.00,
                                  right:
                                  height * 0.00,
                                  top: height * 0.005,
                                  bottom:
                                  height * 0.00,
                                ),
                                child: Text(
                                  "Add new Address",
                                  style: TextStyle(
                                    color: Color(0xFF126086),
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    height * 0.01,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Add service button

                      GlobalActionButton(
                        isEnabled: timeSelectFlag && slectedDateSlot.isNotEmpty,
                        title: "Book Service",
                        onTap: () async {
                          // 1. Agar disabled hai, toh error dikhayein
                          if (!(timeSelectFlag && slectedDateSlot.isNotEmpty)) {
                            showTopNotification(
                              context,
                              title: "Book Service",
                              message: "Please select Date & Time Slot",
                              type: NotificationType.error,
                            );
                            return; // Code yahan ruk jayega
                          }

                          // 2. Agar enabled hai, toh user login status check karein
                          final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";

                          if (isLoggedIn == "YES") {
                            // Guest user ko login bottom sheet dikhayein
                            Timer(const Duration(milliseconds: 0), () {
                              LoginBottomSheet.show(context, false);
                            });
                          } else {
                            setState(() {
                              // AppDummyData me naya booking add kar rahe hain
                              DummyData.addNewBooking(slectedDateSlot, selectedSlot);

                              // Data save hone ke baad UI ke variables reset kar do taaki aage ke liye clean rahe
                              timeSelectFlag = false;
                            });
                            // Normal user ko home page par le jayein
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => HomePageMain(),
                              ),
                            );
                          }
                        },
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