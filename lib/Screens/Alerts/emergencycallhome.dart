import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';



class EmergencyHomeCall {
  showticket(context) async {
    await Future.delayed(Duration(microseconds: 1));

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    showGeneralDialog(
      barrierLabel: "EmergencyCallDialog",
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: GestureDetector(
                  onTap: () {

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
                  builder: (context, setState){
                    return WillPopScope(
                      onWillPop: () async => true,
                      child: Dialog(
                        backgroundColor: Colors.white,

                        insetPadding: EdgeInsets.symmetric(
                            horizontal: MediaQuery
                                .of(context)
                                .size
                                .width * 0.08),
                        child: LayoutBuilder(
                          builder: (context, constraints){
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
                                      .width * 0.02,
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
                                      // 🔻 Emergency Info Card
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.015,
                                          vertical: screenHeight * 0.003,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.0,
                                          vertical: screenHeight * 0.005,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: screenHeight * 0.02),
                                            Image.asset(
                                              'assets/ambulancealert.png',

                                              fit: BoxFit.fill,
                                              height: screenHeight * 0.07,

                                            ),
                                            SizedBox(height: screenHeight * 0.015),
                                            Text(
                                              "Emergency Call",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w700,
                                                fontSize: screenHeight * 0.016,
                                              ),
                                            ),
                                            Container(

                                              padding: EdgeInsets.symmetric(
                                                vertical: screenHeight * 0.01,

                                              ),
                                              child: Text(
                                                "You are about to call ambulance for an emergency. Are you sure you want to proceed?",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color : Colors.black45,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: screenHeight * 0.014,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),



                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.035, // space between buttons
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
                                                vertical: MediaQuery.of(context).size.height * 0.008,
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
                                              _makePhoneCall('1234567890');
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                // color: Color(0xFFD42620).withOpacity(0.8),
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(7),

                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: MediaQuery.of(context).size.width * 0.04,
                                                vertical: MediaQuery.of(context).size.height * 0.008,
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
                                                      fontSize: MediaQuery.of(context).size.height * 0.014,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _makePhoneCall('7903840515');
                                                },
                                                child: const Text("Call Now"),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: screenHeight * 0.02, bottom: screenHeight * 0.01),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "*",
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.01,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              " This service might be Chargeable",
                                              style: TextStyle(
                                                  fontSize: screenHeight * 0.008,
                                                  color: Color(0xFF6A6E83),
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]
        );
      },
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Show error message or fallback UI
      print("Cannot make phone call");
    }
  }
}