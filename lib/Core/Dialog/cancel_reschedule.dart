import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 🌟 IMPORTANT: Apne exact imports yahan zaroor add karein
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Medications/medicationselecttime.dart';

class CancelRescheduleBottomSheet {

  // 🌟 NAYA: BuildContext add kiya gaya hai
  static void showAppointmentActionSheet(
      BuildContext context,
      Map detail,
      String origin,
      {String? username, String? profession}
      ) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // 🌟 NAYA: Object yahan initialize karein taaki globally accessible ho
    AppointmentCancel appointmentcancelalert = AppointmentCancel();

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
        ),
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
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) =>
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: height * 0.025,

                                      bottom: height * 0.015),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: height * 0.01,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          // Top Handle Bar
                                          GestureDetector(


                                            child: Center(
                                              child: Container(

                                                padding: EdgeInsets.only(
                                                  top: height * 0.01,
                                                  bottom:  height * 0.03,
                                                  left:  height * 0.18,
                                                  right:  height * 0.18,
                                                ),


                                                width: width * 0.23,
                                                // Same thickness as Divider
                                                height:  height * 0.006,
                                                // Same thickness as Divider
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD9D9D9), // Divider color
                                                  borderRadius: BorderRadius.circular(
                                                      10), // Rounded edges
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),

                                          // Cancel Appointment
                                          GestureDetector(
                                            onTap: () {
                                              appointmentcancelalert.showticket(context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: height * 0.005,
                                                  right: height * 0.025,
                                                  bottom: height * 0.005,
                                                  top: height * 0.015),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFA8B1CE).withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0x0A056390), Color(0x0A056390)])),
                                                padding: EdgeInsets.symmetric(horizontal: height * 0.005),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.all(height * 0.01),
                                                      height: height * 0.025,
                                                      width: height * 0.025,
                                                      child: Image.asset('assets/CancelAppointment.png', fit: BoxFit.fill),
                                                    ),
                                                    SizedBox(width: height * 0.010),
                                                    Expanded(
                                                      child: Text(
                                                        "Cancel Appointment",
                                                        style: TextStyle(
                                                          color: Color(0xFF126086),
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: height * 0.014,
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(Icons.arrow_forward_ios, size: height * 0.014, color: Color(0xFF126086)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Reschedule Appointment
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop(); // Close bottom sheet

                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) {
                                                    return MedicatiSelectTimeSlot(
                                                      detail['doctorId'],
                                                      username: detail['name'] ?? username,
                                                      profession: detail['speciality'] ?? profession,
                                                      detail: detail,
                                                      isReschedule: true,
                                                      previousDate: DateFormat('dd-MM-yyyy').parse(detail['date']),
                                                      previousTime: detail['time'],
                                                      origin: origin,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: height * 0.005,
                                                  right: height * 0.025,
                                                  bottom: height * 0.005,
                                                  top: height * 0.015),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFA8B1CE).withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    gradient: LinearGradient(
                                                        colors: [Color(0x0A056390), Color(0x0A056390)])),
                                                padding: EdgeInsets.symmetric(horizontal: height * 0.005),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.all(height * 0.01),
                                                      height: height * 0.025,
                                                      width: height * 0.025,
                                                      child: Image.asset('assets/RescheduleAppointment.png', fit: BoxFit.fill),
                                                    ),
                                                    SizedBox(width: height * 0.010),
                                                    Expanded(
                                                      child: Text(
                                                        "Reschedule Appointment",
                                                        style: TextStyle(
                                                          color: Color(0xFF126086),
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: height * 0.014,
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(Icons.arrow_forward_ios, size: height * 0.014, color: Color(0xFF126086)),
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
            ],
          );
        });
  }
}