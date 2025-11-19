import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/OnBoarding/onboarding_screen.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/VerifyOtp/verifyOtp.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

import '../Settings/changemobilenum.dart';
import '../Settings/mpinmain.dart';

class LoginUHIDPage extends StatefulWidget {
  const LoginUHIDPage({
    super.key,
  });
  @override
  State<LoginUHIDPage> createState() => LoginuhidPagestate();
}

class LoginuhidPagestate extends State<LoginUHIDPage> {
  @override
  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  TextEditingController UserNumberEditTextController = TextEditingController();
  TextEditingController PasswordEditTextController = TextEditingController();
  bool hidePassword = true;
  late ProgressDialog progressDialog;
  RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$');

  Timer? _errorClearTimer;
  @override
  void initState() {
    super.initState();

    // setState(() {
    //   UserNumberEditTextController?.text = "babureddy921234567@gmail.com";
    //   PasswordEditTextController?.text = "Test@123456";
    // });

    UserNumberEditTextController.addListener(() {
      if (errorMessage != null) {
        // Cancel previous timer agar user type karta rahe
        _errorClearTimer?.cancel();

        // Naya timer start karo
        _errorClearTimer = Timer(const Duration(seconds: 2), () {
          setState(() {
            errorMessage = null;

          });
        });
      }
    });
  }

  String? errorMessage;
  bool isValid = false;
  bool hasStartedTyping = false; // Track if the user has started typing

  void checkUserIdEmpty(String text) {
    print("text : ${text}");
    if (text.isEmpty) {
      setState(() {
        hasStartedTyping = false;
        errorMessage = null;
        isValid = false;
      });
    }
  }

  void validateNumber(String value) {
    String number = value.trim();

    // Remove +91 if exists for validation
    // if (number.startsWith("+91 ")) {
    number = number.substring(4);
    // }

    // Check if exactly 10 digits
    if (number.length == 10 && RegExp(r'^[0-9]+$').hasMatch(number)) {
      setState(() {
        isValid = true;
        errorMessage = null;
      });
    }
    // else {
    //   setState(() {
    //     isValid = false;
    //     errorMessage ="Please enter a 10-digit mobile number";
    //   });
    // }
  }

  void validateInput() {
    String input = UserNumberEditTextController.text.trim();

    if (input.isEmpty) {
      setState(() {
        errorMessage = "Please enter your email or mobile number";
        isValid = false;
      });
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input) &&
        !RegExp(r'^[0-9]{10}$').hasMatch(input)) {
      setState(() {
        errorMessage = "Please enter a valid email or mobile number";
        isValid = false;
      });
    } else {
      setState(() {
        errorMessage = "Entered email or phone number is valid";
        isValid = true;
      });
    }
  }

  void validateUHID(String value) {
    String number = value.trim();

    // Check if exactly 10 digits
    if (number.length >=3) {
      setState(() {
        isValid = true;

      });
    } else {
      setState(() {
        isValid = false;

      });
    }
  }

  String? passerrorMessage;
  bool passisValid = false;
  bool passhasStartedTyping = false; // Track if the user has started typing

  void checkPasswordEmpty(String text) {
    print("text : ${text}");
    if (text.isEmpty) {
      setState(() {
        passhasStartedTyping = false;
        passerrorMessage = null;
        passisValid = false;
      });
    }
  }

  void passvalidateInput() {
    String input = PasswordEditTextController.text.trim();

    if (input.isEmpty) {
      setState(() {
        passerrorMessage = "Please enter Password";
        passisValid = false;
      });
    } else if (!RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$')
        .hasMatch(input)) {
      setState(() {
        passerrorMessage =
        "Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.";
        passisValid = false;
      });
    } else {
      setState(() {
        passerrorMessage = "Entered Password is valid";
        passisValid = true;
      });
    }
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    progressDialog.style(
        message: 'Authenticating..' '\nPlease Wait',
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        /*decoration: const BoxDecoration(
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
                  right: MediaQuery.of(context).size.height * 0.01,
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.0,
                  left: MediaQuery.of(context).size.height * 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back Arrow

                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Timer(Duration(seconds: 1), () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OnboardingScreen()),
                        );
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.025,
                      width: MediaQuery.of(context).size.height * 0.025,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF126086).withOpacity(0.2),
                        // color : Colors.red,
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

                  // Login Text
                  Expanded(
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter",
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
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.03,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: screenHeight * 0.015),
                            child: Image.asset(
                              'assets/splashqc.png',
                              height: screenHeight * 0.06,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // Welcome Back Text
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: new EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.0,
                                      top: MediaQuery.of(context).size.height *
                                          0.005,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.00),
                                  child: Text(
                                    "Welcome Back!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.027,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1F1F1F),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Padding(
                                  padding: new EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                      MediaQuery.of(context).size.height *
                                          0.0,
                                      bottom:
                                      MediaQuery.of(context).size.height *
                                          0.00),
                                  child: Text(
                                    "Use Credentials to access your account",
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.012,
                                      color: Color(0xFF6A6E83),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          // Employee ID text
                          Padding(
                            padding: new EdgeInsets.only(
                                left:
                                MediaQuery.of(context).size.height * 0.025,
                                right:
                                MediaQuery.of(context).size.height * 0.025,
                                bottom:
                                MediaQuery.of(context).size.height * 0.008),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "UHID",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  // color: Colors.black54,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),

                          // Employee ID Field
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.025,
                              right: MediaQuery.of(context).size.height * 0.025,
                              bottom:
                              MediaQuery.of(context).size.height * 0.005,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Focus(
                                  onFocusChange: (hasFocus) {
                                    if (hasFocus) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    }
                                  },
                                  child: TextFormField(
                                    controller: UserNumberEditTextController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(15),
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z0-9]'))
                                    ],
                                    textCapitalization:
                                    TextCapitalization.characters,

                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.016,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value){
                                      validateUHID(value);
                                    },

                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                        vertical:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      hintText: "Enter your Unique Health ID provided by the hospital",
                                      hintStyle: TextStyle(
                                          color: Color(0x4D111111),
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.012,
                                          fontWeight: FontWeight.w400),
                                      suffixIcon: UserNumberEditTextController
                                          .text.isNotEmpty &&
                                          isValid
                                          ? Icon(Icons.check_circle,
                                          color: Colors.green)
                                          : null,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: hasStartedTyping
                                              ? (isValid
                                              ? Colors.green
                                              : Colors.red)
                                              : Color(
                                              0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: hasStartedTyping
                                              ? (isValid
                                              ? Colors.green
                                              : Colors.red)
                                              : Color(
                                              0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide:
                                        BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide:
                                        BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                                if (errorMessage != null)
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0, left: 4.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.error, color: Colors.red, size: MediaQuery.of(context).size.height * 0.015),
                                        SizedBox(width: 4), // spacing between icon and text
                                        Text(
                                          // "Please enter a 10-digit mobile number",
                                          errorMessage!,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: MediaQuery.of(context).size.height * 0.013,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Login button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Login Button

                                GestureDetector(
                                  onTap: () async {
                                    validateUHIDLogin(context);
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height *
                                              0.01,
                                          bottom: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          left: MediaQuery.of(context).size.height *
                                              0.02,
                                          right: MediaQuery.of(context).size.height *
                                              0.02),
                                      margin: EdgeInsets.only(
                                          right:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                          top: MediaQuery.of(context).size.height *
                                              0.01,
                                          bottom:
                                          MediaQuery.of(context).size.height *
                                              0.001,
                                          left: MediaQuery.of(context).size.height *
                                              0.01),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.012),
                                                gradient: LinearGradient(
                                                    begin:
                                                    Alignment.centerRight,
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
                                                validateUHIDLogin(
                                                    context);
                                              },
                                              child: Text("Login",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.019,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ])),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: new EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                                left:
                                MediaQuery.of(context).size.height * 0.035,
                                right:
                                MediaQuery.of(context).size.height * 0.035,
                                bottom:
                                MediaQuery.of(context).size.height * 0.0),
                            child: CustomDividerWithText(),
                          ),

                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.04,
                                    right: MediaQuery.of(context).size.height * 0.04,
                                    bottom: MediaQuery.of(context).size.height * 0.02,
                                    top: MediaQuery.of(context).size.height * 0.03,
                                  ),

                                  child: Material(
                                    color: Colors.transparent, // Needed for Ink ripple to show
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0x1A000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.012,
                                        ),
                                      ),

                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.012,
                                        ),
                                        splashColor: Colors.black12,
                                        highlightColor: Colors.black12,
                                        onTap: () async {},

                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context).size.height * 0.0,
                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                            left: MediaQuery.of(context).size.height * 0.00,
                                            right: MediaQuery.of(context).size.height * 0.00,
                                          ),
                                          margin: EdgeInsets.only(
                                            right: MediaQuery.of(context).size.height * 0.04,
                                            top: MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height * 0.0,
                                            left: MediaQuery.of(context).size.height * 0.04,
                                          ),

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: MediaQuery.of(context).size.width * 0.0,
                                                ),
                                                child: Image.asset(
                                                  'assets/appleicon.png',
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                ),
                                              ),

                                              SizedBox(width: screenWidth * 0.1),

                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 11.0,
                                                    horizontal: 12.0,
                                                  ),
                                                  child: Text(
                                                    "Sign In With Apple",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFF1F1F1F),
                                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Inter",
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


// ------------------ GOOGLE BUTTON --------------------

                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.04,
                                    right: MediaQuery.of(context).size.height * 0.04,
                                    top: MediaQuery.of(context).size.height * 0.01,
                                    bottom: MediaQuery.of(context).size.height * 0.0,
                                  ),

                                  child: Material(
                                    color: Colors.transparent,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0x1A000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.012,
                                        ),
                                      ),

                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.012,
                                        ),
                                        splashColor: Colors.black12,
                                        highlightColor: Colors.black12,
                                        onTap: () async {},

                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context).size.height * 0.0,
                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                            left: MediaQuery.of(context).size.height * 0.0,
                                            right: MediaQuery.of(context).size.height * 0.0,
                                          ),
                                          margin: EdgeInsets.only(
                                            right: MediaQuery.of(context).size.height * 0.04,
                                            top: MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height * 0.0,
                                            left: MediaQuery.of(context).size.height * 0.04,
                                          ),

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: MediaQuery.of(context).size.width * 0.0,
                                                ),
                                                child: Image.asset(
                                                  'assets/googleicon.png',
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                ),
                                              ),

                                              SizedBox(width: screenWidth * 0.1),

                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 11.0,
                                                    horizontal: 12.0,
                                                  ),
                                                  child: Text(
                                                    "Sign In With Google",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFF1F1F1F),
                                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Inter",
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



                                // Container(
                                //   padding: new EdgeInsets.only(
                                //     left: MediaQuery.of(context).size.height *
                                //         0.0,
                                //     right: MediaQuery.of(context).size.height *
                                //         0.0,
                                //     bottom: MediaQuery.of(context).size.height *
                                //         0.02,
                                //     top: MediaQuery.of(context).size.height *
                                //         0.03,
                                //   ),
                                //   child: Container(
                                //     alignment: Alignment.centerRight,
                                //     padding: EdgeInsets.only(
                                //       top: MediaQuery.of(context).size.height *
                                //           0.0,
                                //       bottom:
                                //           MediaQuery.of(context).size.height *
                                //               0.00,
                                //       left: MediaQuery.of(context).size.height *
                                //           0.00,
                                //       right:
                                //           MediaQuery.of(context).size.height *
                                //               0.00,
                                //     ),
                                //     margin: EdgeInsets.only(
                                //       right:
                                //           MediaQuery.of(context).size.height *
                                //               0.04,
                                //       top: MediaQuery.of(context).size.height *
                                //           0.00,
                                //       bottom:
                                //           MediaQuery.of(context).size.height *
                                //               0.0,
                                //       left: MediaQuery.of(context).size.height *
                                //           0.04,
                                //     ),
                                //     decoration: BoxDecoration(
                                //       border: Border.all(
                                //         color:
                                //             Color(0x1A000000), // Border color
                                //         width: 1, // Border width
                                //       ),
                                //       borderRadius: BorderRadius.circular(
                                //         MediaQuery.of(context).size.height *
                                //             0.012,
                                //       ),
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: <Widget>[
                                //         // Google Logo
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //             right: MediaQuery.of(context)
                                //                     .size
                                //                     .width *
                                //                 0.0,
                                //           ),
                                //           child: Image.asset(
                                //             'assets/appleicon.png', // Replace with your asset path
                                //             height: MediaQuery.of(context)
                                //                     .size
                                //                     .height *
                                //                 0.03, // Adjust size as needed
                                //           ),
                                //         ),
                                //         // "Sign up with Google" Text
                                //         SizedBox(width: screenWidth * 0.1),
                                //         Flexible(
                                //           child: TextButton(
                                //             style: TextButton.styleFrom(
                                //               padding: EdgeInsets.symmetric(
                                //                   vertical: 11.0,
                                //                   horizontal:
                                //                       12.0), // Remove default button padding
                                //               minimumSize: Size(0,
                                //                   0), // Allow smallest possible size
                                //               tapTargetSize: MaterialTapTargetSize
                                //                   .shrinkWrap, // Shrink tap area
                                //             ),
                                //             onPressed: () async {
                                //               // Navigator.of(context).pushAndRemoveUntil(
                                //               //   MaterialPageRoute(
                                //               //     builder: (BuildContext context) =>
                                //               //         LoginHome(),
                                //               //   ),
                                //               //   (Route route) => false,
                                //               // );
                                //             },
                                //             child: Text(
                                //               "Sign In With Apple",
                                //               textAlign: TextAlign.center,
                                //               style: TextStyle(
                                //                   color: Color(0xFF1F1F1F),
                                //                   fontSize:
                                //                       MediaQuery.of(context)
                                //                               .size
                                //                               .height *
                                //                           0.016,
                                //                   overflow:
                                //                       TextOverflow.ellipsis,
                                //                   fontWeight: FontWeight.w500,
                                //                   fontFamily: "Inter"
                                //                   // Enable ellipsis
                                //                   ),
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // Container(
                                //   padding: new EdgeInsets.only(
                                //       left: MediaQuery.of(context).size.height *
                                //           0.0,
                                //       right:
                                //           MediaQuery.of(context).size.height *
                                //               0.0,
                                //       top: MediaQuery.of(context).size.height *
                                //           0.01,
                                //       bottom:
                                //           MediaQuery.of(context).size.height *
                                //               0.0),
                                //   child: Container(
                                //     alignment: Alignment.centerRight,
                                //     padding: EdgeInsets.only(
                                //       top: MediaQuery.of(context).size.height *
                                //           0.0,
                                //       bottom:
                                //           MediaQuery.of(context).size.height *
                                //               0.00,
                                //       left: MediaQuery.of(context).size.height *
                                //           0.00,
                                //       right:
                                //           MediaQuery.of(context).size.height *
                                //               0.00,
                                //     ),
                                //     margin: EdgeInsets.only(
                                //       right:
                                //           MediaQuery.of(context).size.height *
                                //               0.04,
                                //       top: MediaQuery.of(context).size.height *
                                //           0.00,
                                //       bottom:
                                //           MediaQuery.of(context).size.height *
                                //               0.0,
                                //       left: MediaQuery.of(context).size.height *
                                //           0.04,
                                //     ),
                                //     decoration: BoxDecoration(
                                //       border: Border.all(
                                //         color:
                                //             Color(0x1A000000), // Border color
                                //         width: 1, // Border width
                                //       ),
                                //       borderRadius: BorderRadius.circular(
                                //         MediaQuery.of(context).size.height *
                                //             0.012,
                                //       ),
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: <Widget>[
                                //         // Google Logo
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //             right: MediaQuery.of(context)
                                //                     .size
                                //                     .width *
                                //                 0.0,
                                //           ),
                                //           child: Image.asset(
                                //             'assets/googleicon.png', // Replace with your asset path
                                //             height: MediaQuery.of(context)
                                //                     .size
                                //                     .height *
                                //                 0.03, // Adjust size as needed
                                //           ),
                                //         ),
                                //         // "Sign up with Google" Text
                                //         SizedBox(width: screenWidth * 0.1),
                                //         Flexible(
                                //           child: TextButton(
                                //             style: TextButton.styleFrom(
                                //               padding: EdgeInsets.symmetric(
                                //                   vertical: 11.0,
                                //                   horizontal:
                                //                       12.0), // Remove default button padding
                                //               minimumSize: Size(0,
                                //                   0), // Allow smallest possible size
                                //               tapTargetSize: MaterialTapTargetSize
                                //                   .shrinkWrap, // Shrink tap area
                                //             ),
                                //             onPressed: () async {},
                                //             child: Text(
                                //               "Sign In With Google",
                                //               textAlign: TextAlign.center,
                                //               style: TextStyle(
                                //                   color: Color(0xFF1F1F1F),
                                //                   fontSize:
                                //                       MediaQuery.of(context)
                                //                               .size
                                //                               .height *
                                //                           0.016,
                                //                   overflow:
                                //                       TextOverflow.ellipsis,
                                //                   fontWeight: FontWeight.w500,
                                //                   fontFamily: "Inter"
                                //                   // Enable ellipsis
                                //                   ),
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.02,
                                    ),
                                    // color: Colors.blue,
                                    child: Align(
                                      alignment: Alignment
                                          .bottomCenter, // 👈 Pin to bottom
                                      child: TextButton(
                                        onPressed: () {
                                          // Your logic
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .merge(
                                              TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                'Don\'t have an account ?',
                                                style: TextStyle(
                                                  color: Color(0xFF1F1F1F),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.011,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' Sign Up',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.014,
                                                  color: Color(0xFF126086),
                                                  fontFamily: "Inter",
                                                ),
                                                recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Navigator.of(context)
                                                        .push(
                                                      MaterialPageRoute(
                                                        builder:
                                                            (BuildContext
                                                        context) {
                                                          return Registration();
                                                        },
                                                      ),
                                                    );
                                                  },
                                              ),
                                            ],
                                          ),
                                        ),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void validateUHIDLogin(BuildContext context) async {
  //   String uhid = UserNumberEditTextController.text.trim();
  //
  //   if (uhid.isEmpty || uhid.length < 3) {
  //     setState(() {
  //       errorMessage = "UHID should be more than 3 characters";
  //       isValid = false;
  //     });
  //     return;
  //   }
  //
  //   // 1. Check if UHID exists in local storage
  //   Map<String, dynamic>? userData = await UserSecureStorage.getUser(uhid);
  //
  //   if (userData != null && userData['mpin'] != null && userData['mpin'].isNotEmpty) {
  //     // UHID exists and has MPIN -> navigate to MPIN verification
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => MpinAccessScreen(mobileNumber: uhid), // or pass UHID
  //       ),
  //     );
  //   } else {
  //     // UHID not present or MPIN not set -> navigate to set MPIN
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => MpinResetSettings(mobileNumber: uhid), // or pass UHID
  //       ),
  //     );
  //   }
  // }

  void validateUHIDLogin(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        String input = UserNumberEditTextController.text.trim();

        if (input.isEmpty || input.length < 3) {
          setState(() {
            hasStartedTyping = true;
            errorMessage = "UHID should be more than 3 characters";
            isValid = false;
          });
          Timer(Duration(seconds: 1), () {
            setState(() {
              errorMessage = null;
              hasStartedTyping = false;

            });
          });
          return;
        }
        // else if (input.length < 3){
        //   setState(() {
        //     hasStartedTyping = true;
        //     errorMessage = "UHID should be more than 3 characters";
        //     isValid = false;
        //   });
        //   Timer(Duration(seconds: 1), () {
        //     setState(() {
        //       errorMessage = null;
        //       hasStartedTyping = false;
        //
        //     });
        //   });
        //   return;
        // }
        else {
          setState(() {
            hasStartedTyping = false;
            errorMessage = null;
            isValid = false;
          });
        }

        // if (isValid) {
        print("input: $input");
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => MpinAccessScreen(mobileNumber: input.substring(3)))
        // );

        // }
        /*  progressDialog.showMaterial(
              title: "Authenticating", message: "Please wait");*/
        // progressDialog.show();

//   UserNumberEditTextController?.text = "babureddy921234567@gmail.com";
        //   PasswordEditTextController?.text = "Test@123456";
        // dynamic user = await apiService.submitlogin(
        //
        //     "babureddy921234567@gmail.com",
        //     base64Encode(utf8.encode("Test@123456")));
        //
        // print("user: ${user.toString()}");
        // if (user.accessToken != null) {
        //   // progressDialog.hide();
        //   await UserSecureStorage.setTokenvalue(user.accessToken);
        //   await UserSecureStorage.setRefreshTokenvalue(user.refreshToken);
        //   // await UserSecureStorage.setIfLogged("YES");
        //   // await UserSecureStorage.setIfLoggedOut("NO");
        //   await UserSecureStorage.setIfGuestLogged("NO");
        //   // await UserSecureStorage.setIfLoggedOut("NO");
        //   // if(await UserSecureStorage.getUsernameid())
          Map<String, dynamic>? userData = await UserSecureStorage.getUser(input.trim());
          print(input.trim());
          print("userDataUHID: $userData");
          if(userData == null){
            await UserSecureStorage.saveUser(
              userId: input.trim(),
              mpin: "",
              userData: {
                "fname": "Priya",
                "lname": "Krishamurty",
                "mobile": "1234567890",
                "email": "uhid@gmail.com",
                "gender":"M"
              },
            );

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChangeMobileNumber(mobileNumber: input.trim()))
            );
          }
          else
            {
              String? mpin = userData['mpin'];
              if(mpin!.isEmpty)
              {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MpinResetSettings(mobileNumber: input.trim()))
                );
              }
              else{
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MpinAccessScreen(mobileNumber: input.trim()))
                );
              }
            }


          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => HomePageMain()),
          //     (Route<dynamic> route) => false);
        // }
        // else if (user.message != null) {
        //   // progressDialog.hide();
        //
        //   // final snackBar = SnackBar(
        //   //   content: Text(user.message),
        //   //   backgroundColor: Colors.red[600],
        //   // );
        //   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   showTopNotification(
        //     context,
        //     title: "Login Credential",
        //     message: "Invalid User Credentails",
        //     type: NotificationType.error,
        //   );
        //
        //   /* Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(builder: (context) => HomePageMain()),
        //             (Route<dynamic> route) => false);*/
        //
        //   // customalert.showError(context, user.error);
        // }
      } else {
        // No-Internet Case
        final snackBar = SnackBar(
            content: Text("No Internet, Check Connectivity!"),
            backgroundColor: Colors.red[600]);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
