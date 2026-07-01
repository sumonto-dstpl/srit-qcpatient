import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigationBar({Key? key, required this.selectedIndex})
      : super(key: key);

  // Navigation Logic
  void _onItemTapped(int index, BuildContext context) {
    // FIX 3: Added 'index != 0' so it always allows navigating to Home
    // even if the current screen (like Profile) shares index 0.
    if (index == selectedIndex && index != 0 && index != 3 && index != 4 ) return;

    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePageMain()),
              (Route<dynamic> route) => false);
    } else if (index == 1) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MyReportsMain()));
    } else if (index == 2) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => UploadPrescriptionMain()));
    } else if (index == 3) {
      _showBottomSheet(context);
    } else if (index == 4) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MyHealthMain()));
    }
  }

  // Aapka Bottom Sheet Function
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
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

  @override
  Widget build(BuildContext context) {
    // Colors ko variables me store kar liya for cleaner code
    final activeColor = const Color(0xFF126086);
    final inactiveColor = const Color(0xFF484C52);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.09,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (index) => _onItemTapped(index, context),
              backgroundColor: Colors.white,
              selectedItemColor: activeColor,
              unselectedItemColor: inactiveColor,
              selectedFontSize: MediaQuery.of(context).size.height * 0.014,
              unselectedFontSize: MediaQuery.of(context).size.height * 0.012,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    child: Image.asset(
                      'assets/Homeactive.png', // Aap chahein toh inactive icon alag lagayen, ya color overlay use karein
                      width: MediaQuery.of(context).size.height * 0.027,
                      height: MediaQuery.of(context).size.height * 0.027,
                      // FIX 1: Applied active/inactive color overlay to the image
                      color: selectedIndex == 0 ? activeColor : inactiveColor,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    child: Image.asset(
                      'assets/MyReports.png',
                      width: MediaQuery.of(context).size.height * 0.027,
                      height: MediaQuery.of(context).size.height * 0.027,
                      // FIX 1: Applied color overlay
                      color: selectedIndex == 1 ? activeColor : inactiveColor,
                    ),
                  ),
                  label: 'My Reports',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.025),
                    child: Image.asset('assets/Appoinments.png', width: 0, height: 0), // 0 height bcz yahan FAB aayega
                  ),
                  label: 'Upload',
                ),

                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    child: Image.asset(
                      'assets/Appoinments.png',
                      width: MediaQuery.of(context).size.height * 0.027,
                      height: MediaQuery.of(context).size.height * 0.027,
                      // FIX 1: Applied color overlay
                      color: selectedIndex == 3 ? activeColor : inactiveColor,
                    ),
                  ),
                  label: 'Appointments',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    child: Image.asset(
                      'assets/MyHealth.png',
                      width: MediaQuery.of(context).size.height * 0.027,
                      height: MediaQuery.of(context).size.height * 0.027,
                      // FIX 1: Applied color overlay
                      color: selectedIndex == 4 ? activeColor : inactiveColor,
                    ),
                  ),
                  label: 'My Health',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}