import 'dart:ui';

import 'package:flutter/material.dart';

class AppointmentCancel {
  showticket(context) async {
    await Future.delayed(Duration(microseconds: 1));
    TextEditingController? tracktextcontroller = TextEditingController();

    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.transparent, // No dim overlay
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // ✅ Close on tap outside
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
              ),
            ),
            Center(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    insetPadding: EdgeInsets.symmetric(
                        horizontal: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery
                                .of(context)
                                .size
                                .height * 0.9,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02,
                              horizontal:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // -- Your Icon and Message Here --
                                  Container(
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.065,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.065,
                                    decoration: const BoxDecoration(
                                      // color: Color(0xFFFBEAE9),
                                      color: Color.fromRGBO(251, 234, 233,
                                          1.0), // Same color with full opacity

                                      shape: BoxShape.circle,
                                    ),

                                    child: Center(
                                      child: Image.asset(
                                        'assets/Error_ls.png',
                                        fit: BoxFit.contain,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.035,
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.035,
                                      ),
                                    ),

                                  ),

                                  SizedBox(
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.01),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.02,
                                      horizontal:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.01,
                                    ),
                                    child: Text(
                                      "Are you sure to cancel the Selected Appointment?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF6A6E83),
                                        fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.015,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                  // -- TextField for reason --
                                  TextFormField(
                                    controller: tracktextcontroller,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.black), // Set text color
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors
                                          .white10,
                                      // Slight transparent background
                                      hintText: "Enter your reason minimum 20 words",
                                      hintStyle: TextStyle(
                                        fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.012,
                                        color: Color(
                                            0x4D111111),
                                        // Semi-transparent hint color
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.02,
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.00,
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.025,
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.015,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xFFF1F1F1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xFFF1F1F1)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(
                                            10.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey),
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(height: 20),

                                  // -- Buttons Row --
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.05, // space between buttons
                                    runSpacing: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.01, // space between lines
                                    children: [
                                      // Close Button
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          elevation: 0,
                                          side: BorderSide(
                                              color: Color(0xFFA8B1CE),
                                              width: 1),
                                          padding: EdgeInsets.symmetric(
                                            vertical:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.004,
                                            horizontal:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.06,
                                          ),
                                          textStyle: TextStyle(
                                            fontSize:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.014,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                7),
                                          ),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Close"),
                                      ),

                                      // Okay Button
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0x80D42620),
                                          foregroundColor: Colors.white,
                                          shadowColor: Colors.transparent,
                                          padding: EdgeInsets.symmetric(
                                            vertical:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.004,
                                            horizontal:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.06,
                                          ),
                                          textStyle: TextStyle(
                                            fontSize:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.015,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                7),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // Optional: Navigator.pop(context); for double pop
                                        },
                                        child: Text("Okay"),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
  }