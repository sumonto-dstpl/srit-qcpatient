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
                            .width * 0.08),
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
                                  .width * 0.07,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFD9D9D9),
                                  blurRadius: 100,

                                ),
                              ],
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
                                        .height * 0.06,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.06,
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
                                            0.03,
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.03,
                                      ),
                                    ),

                                  ),

                                  SizedBox(
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.0),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.01,
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
                                  SizedBox(
                                      height:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.005),
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
                                      GestureDetector(
                                        onTap : () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(
                                              color: const Color(0xFFA8B1CE),
                                              width: 1,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context).size.width * 0.07,
                                            vertical: MediaQuery.of(context).size.height * 0.01,
                                          ),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero), // 🔹 No padding at all
                                              minimumSize: WidgetStateProperty.all(Size.zero), // 🔹 Remove default min constraints
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 🔹 Remove extra touch area
                                              alignment: Alignment.center, // 🔹 Center text properly
                                              foregroundColor: WidgetStateProperty.all(Colors.black),
                                              textStyle: WidgetStateProperty.all(
                                                TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF1F1F1F),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Close"),
                                          ),
                                        ),
                                      ),




                                      GestureDetector(
                                        onTap : () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0x80D42620),
                                            borderRadius: BorderRadius.circular(7),

                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context).size.width * 0.07,
                                            vertical: MediaQuery.of(context).size.height * 0.01,
                                          ),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero), // 🔹 No padding at all
                                              minimumSize: WidgetStateProperty.all(Size.zero), // 🔹 Remove default min constraints
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 🔹 Remove extra touch area
                                              alignment: Alignment.center, // 🔹 Center text properly
                                              foregroundColor: WidgetStateProperty.all(Colors.white,),
                                              textStyle: WidgetStateProperty.all(
                                                TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Okay"),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,)
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