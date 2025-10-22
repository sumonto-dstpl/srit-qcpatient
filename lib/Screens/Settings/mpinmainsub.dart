

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/passsuccesssendback.dart';
import 'package:newfolder/Screens/Settings/sucesschangenum.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MpinSubSettings extends StatefulWidget {
  const MpinSubSettings({
    super.key,
  });
  @override
  State<MpinSubSettings> createState() => MpinSubSettingsstate();
}

class MpinSubSettingsstate extends State<MpinSubSettings> {


  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;

  TextEditingController Otp1stdigitTextController = TextEditingController();
  TextEditingController Otp2nddigitTextController = TextEditingController();
  TextEditingController Otp3rddigitTextController = TextEditingController();
  TextEditingController Otp4thdigitTextController = TextEditingController();


  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;



  @override
  void initState() {

    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();

  }


  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        /* decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/patternbackground.png"), // Replace with your image path
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),*/

        decoration: const BoxDecoration(
          image: DecorationImage(
            // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),
        child: Column(
          children: <Widget>[
            // Top Section with Back Arrow and Login Text
            Container(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.05,
              ),
              margin: EdgeInsets.only(
                  right: screenHeight * 0.01,
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.0,
                  left: screenHeight * 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back Arrow
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      width: MediaQuery.of(context).size.height * 0.035,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.01,
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

                  Expanded(
                    child: Center(
                      child: Text(
                        "MPIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.026,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Placeholder for alignment (Empty container for symmetry)
                  SizedBox(width: screenHeight * 0.05),
                ],
              ),
            ),

            // Main Content Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.03),
                    topRight: Radius.circular(screenHeight * 0.03),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Logo Image
                      Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.03),
                        child: Image.asset(
                          'assets/splashqc.png',
                          height: screenHeight * 0.06,
                          fit: BoxFit.contain,
                        ),
                      ),



                      Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.0),
                        child: Image.asset(
                          'assets/mpinsubscreen.png',
                          height: screenHeight * 0.16,
                          fit: BoxFit.contain,
                        ),
                      ),



                    /*  Expanded(
                        flex: 1, // Adjust flex value as needed
                        child: Center(
                          child: Image.asset(
                            'assets/mpinbiometry.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),*/

                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: 0,
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.00),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Enter MPIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.026,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                            ]),
                      ),






                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00),
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.02,
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.24,
                            left: MediaQuery.of(context).size.height * 0.02),
                        child: Column(children: [

                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right: 0,
                                top: MediaQuery.of(context).size.height * 0.0,
                                bottom: MediaQuery.of(context).size.height * 0.010),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Enter your four digit MPIN",
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.016,
                                      color: Color(0xFF6A6E83),
                                      // fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.start,
                                  ),

                                ]),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              left: MediaQuery.of(context).size.height * 0.07,
                              right: MediaQuery.of(context).size.height * 0.07,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! * 11,
                                  child: TextFormField(
                                    // autofocus: true,
                                    // obscureText: true,
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.034),
                                    controller: Otp1stdigitTextController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                    ],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
                                      filled: false, // Remove background color
                                      hintText: '0', // Example hint text
                                      hintStyle: TextStyle(color: Colors.white70),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
                                        borderSide: BorderSide(color: Colors.grey), // Set border color
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.015)),
                                        borderSide: BorderSide(color: Colors.grey[300]!), // Set border color
                                      ),
                                    ),
                                    onChanged: (value) {
                                      nextField(value, pin2FocusNode!);
                                    },
                                  ),
                                ),

                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! * 11,
                                  child: TextFormField(
                                    focusNode: pin2FocusNode,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height * 0.034,
                                    ),
                                    controller: Otp2nddigitTextController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                    ],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
                                      filled: false, // Remove background color
                                      hintStyle: TextStyle(color: Colors.white70),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
                                        borderSide: BorderSide(color: Colors.grey), // Set border color to grey
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
                                        borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
                                      ),
                                    ),
                                    onChanged: (value) => nextField(value, pin3FocusNode!),
                                  ),
                                ),

                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! * 11,
                                  child: TextFormField(
                                    focusNode: pin3FocusNode,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height * 0.034,
                                    ),
                                    controller: Otp3rddigitTextController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                    ],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
                                      filled: false, // Remove background color
                                      hintStyle: TextStyle(color: Colors.white70),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
                                        borderSide: BorderSide(color: Colors.grey), // Set border color to grey
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
                                        borderSide: BorderSide(color:Colors.grey[300]!), // Set border color to grey
                                      ),
                                    ),
                                    onChanged: (value) => nextField(value, pin4FocusNode!),
                                  ),
                                ),

                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! * 11,
                                  child: TextFormField(
                                    focusNode: pin4FocusNode,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height * 0.034,
                                    ),
                                    controller: Otp4thdigitTextController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                    ],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
                                      filled: false, // Remove background color
                                      hintStyle: TextStyle(color: Colors.white70),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
                                        borderSide: BorderSide(color: Colors.grey), // Set border color to grey
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
                                        borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        pin4FocusNode!.unfocus();
                                        // Then you need to check is the code is correct or not
                                      }
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right: 0,
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom: MediaQuery.of(context).size.height * 0.010),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Forget MPIN?",
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.016,
                                      color: Color(0xFF6A6E83),
                                      // fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.start,
                                  ),

                                ]),
                          ),

                        ]),
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}
