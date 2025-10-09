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
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });
  @override
  State<LoginPage> createState() => LoginPagestate();
}

class LoginPagestate extends State<LoginPage> {
  @override
  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  TextEditingController UserNumberEditTextController = TextEditingController();
  TextEditingController PasswordEditTextController = TextEditingController();
  bool hidePassword = true;
  late ProgressDialog progressDialog;
  RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$');

  @override
  void initState() {
    super.initState();

    setState(() {
      UserNumberEditTextController?.text = "babureddy921234567@gmail.com";
      PasswordEditTextController?.text = "Test@123456";
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
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
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
                                "Email / Mobile Number",
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
                                      LengthLimitingTextInputFormatter(100),
                                      LowerCaseTextFormatter(),
                                    ],
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: MediaQuery.of(context).size.height * 0.016,
                                            fontWeight: FontWeight.w500,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      checkUserIdEmpty(
                                          UserNumberEditTextController.text
                                              .toString());
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                       contentPadding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context).size.height * 0.02,
                                              vertical: MediaQuery.of(context).size.height * 0.012,
                                            ),
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      hintText:
                                          "Enter your email or mobile number",
                                      hintStyle: TextStyle(
                                          color: Color(0x4D111111),
                                          fontSize: MediaQuery.of(context).size.height * 0.012,
                                          fontWeight: FontWeight.w400
                                      ),
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
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    child: Text(
                                      errorMessage ?? '',
                                      style: TextStyle(
                                        color:
                                            isValid ? Colors.green : Colors.red,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Passwrod text
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
                                "Password",
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

                          // Password Field
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.025,
                              right: MediaQuery.of(context).size.height * 0.025,
                              bottom: MediaQuery.of(context).size.height * 0.005,
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
                                 // Wrap the TextFormField in a Stack to overlay the icon
child: Stack(
  alignment: Alignment.centerRight, // Align the icon to the right-center
  children: [
    TextFormField(
      controller: PasswordEditTextController,
      obscureText: hidePassword,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      style: TextStyle(
        color: Colors.black45,
        fontSize: MediaQuery.of(context).size.height * 0.016,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        checkPasswordEmpty(PasswordEditTextController.text.toString());
      },
      decoration: InputDecoration(
        isDense: true,
        // contentPadding: EdgeInsets.symmetric(
        //   horizontal: MediaQuery.of(context).size.height * 0.02,
        //   vertical: MediaQuery.of(context).size.height * 0.012,
        // ),
        contentPadding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height * 0.02,
          right: MediaQuery.of(context).size.height * 0.05, // Padding for the icon
          top: MediaQuery.of(context).size.height * 0.012,
          bottom: MediaQuery.of(context).size.height * 0.012,
        ),
        filled: true,
        fillColor: Colors.white60,
        hintText: "Enter the password",
        hintStyle: TextStyle(
          color: Color(0x4D111111),
          fontSize: MediaQuery.of(context).size.height * 0.012,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: passhasStartedTyping
                ? (passisValid ? Colors.green : Colors.red)
                : Color(0xFFF1F1F1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(
            color: passhasStartedTyping
                ? (passisValid ? Colors.green : Colors.red)
                : Color(0xFFF1F1F1),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        // Remove suffixIcon to avoid extra height
      ),
    ),
    // Absolutely positioned icon
    Padding(
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.02),      
      child: InkWell(
        onTap: () {
          setState(() {
            hidePassword = !hidePassword;
          });
        },        
        child: Icon(
          hidePassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.black45,
          size: MediaQuery.of(context).size.height * 0.02,
        ),
      ),
    ),
  ],
),


                                  // child: TextFormField(
                                  //   controller: PasswordEditTextController,
                                  //   inputFormatters: [
                                  //     LengthLimitingTextInputFormatter(100),
                                  //   ],
                                  //   style: TextStyle(
                                  //     color: Colors.black45,
                                  //     fontSize: MediaQuery.of(context).size.height * 0.016,
                                  //           fontWeight: FontWeight.w500,
                                  //   ),
                                  //   keyboardType: TextInputType.text,
                                  //   obscureText: hidePassword,
                                  //   onChanged: (value) {
                                  //     checkPasswordEmpty(
                                  //         PasswordEditTextController.text
                                  //             .toString());
                                  //   },
                                  //   decoration: InputDecoration(
                                  //     isDense: true,
                                  //     // contentPadding: EdgeInsets.fromLTRB(
                                  //     //   MediaQuery.of(context).size.height * 0.02,
                                  //     //   MediaQuery.of(context).size.height * 0.012,
                                  //     //   MediaQuery.of(context).size.height * 0.012,
                                  //     //   MediaQuery.of(context).size.height * 0.012,
                                  //     // ),
                                  //      contentPadding: EdgeInsets.symmetric(
                                  //             horizontal: MediaQuery.of(context).size.height * 0.02,
                                  //             vertical: MediaQuery.of(context).size.height * 0.012,
                                  //           ),
                                  //     filled: true,
                                  //     fillColor: Colors.white60,
                                  //     hintText: "Enter the password",
                                  //     hintStyle: TextStyle(
                                  //         color: Color(0x4D111111),
                                  //         fontSize: MediaQuery.of(context).size.height * 0.012,
                                  //         fontWeight: FontWeight.w400
                                  //     ),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderRadius:
                                  //           BorderRadius.circular(5.0),
                                  //       borderSide: BorderSide(
                                  //         color: passhasStartedTyping
                                  //             ? (passisValid
                                  //                 ? Colors.green
                                  //                 : Colors.red)
                                  //             : Color(
                                  //                 0xFFF1F1F1), // Initially grey, turns red or green
                                  //       ),
                                  //     ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(5.0)),
                                  //       borderSide: BorderSide(
                                  //         color: passhasStartedTyping
                                  //             ? (passisValid
                                  //                 ? Colors.green
                                  //                 : Colors.red)
                                  //             : Color(
                                  //                 0xFFF1F1F1), // Initially grey, turns red or green
                                  //       ),
                                  //     ),
                                  //     errorBorder: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(5.0)),
                                  //       borderSide:
                                  //           BorderSide(color: Colors.red),
                                  //     ),

                                  //     focusedErrorBorder: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(5.0)),
                                  //       borderSide:
                                  //           BorderSide(color: Colors.red),
                                  //     ),
                                  //     suffixIcon: Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //         vertical: MediaQuery.of(context).size.height * 0.00, // tweak as needed
                                  //       ),
                                  //       child: IconButton(
                                  //         padding: EdgeInsets.zero, // Remove extra padding
                                  //         constraints: BoxConstraints(), // Remove default constraints
                                  //         onPressed: () {
                                  //           setState(() {
                                  //             hidePassword = !hidePassword;
                                  //           });
                                  //         },
                                  //         icon: Icon(
                                  //           hidePassword ? Icons.visibility_off : Icons.visibility,
                                  //           color: Colors.black45,
                                  //           size: MediaQuery.of(context).size.height * 0.02,
                                  //         ),
                                  //       ),
                                  //     ),
                                    
                                  //     // suffixIcon: IconButton(
                                  //     //   onPressed: () {
                                  //     //     setState(() {
                                  //     //       hidePassword = !hidePassword;
                                  //     //     });
                                  //     //   },
                                  //     //   color: Colors.black45,
                                  //     //   icon: Icon(hidePassword
                                  //     //       ? Icons.visibility_off
                                  //     //       : Icons.visibility),
                                  //     // ),
                                  //   ),
                                  // ),
                                ),
                                if (passerrorMessage != null)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    child: Text(
                                      passerrorMessage ?? '',
                                      style: TextStyle(
                                        color: passisValid
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Forget Passwod
                          // Padding(
                          //   padding: new EdgeInsets.only(
                          //       left: MediaQuery.of(context).size.height * 0.005,
                          //       right: MediaQuery.of(context).size.height * 0.005,
                          //       bottom:
                          //           MediaQuery.of(context).size.height * 0.015),
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         Navigator.of(context).push(
                          //           MaterialPageRoute(
                          //             builder: (BuildContext context) {
                          //               return ForgotPassword();
                          //             },
                          //           ),
                          //         );
                          //         // Fluttertoast.showToast(msg: "Clicked on Forgot Password ", toastLength: Toast.LENGTH_SHORT);
                          //       },
                          //       child: Text(
                          //         "Forgot Password?",
                          //         style: TextStyle(
                          //           decoration: TextDecoration.underline,
                          //           fontWeight: FontWeight.w500,
                          //           decorationColor: Color(0xFFC80000),
                          //           fontSize: MediaQuery.of(context).size.height *
                          //               0.018,
                          //           color: Color(0xFFC80000),
                          //           // fontWeight: FontWeight.bold
                          //         ),
                          //         textAlign: TextAlign.end,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Forgot password
                          // Forget Passord
                          Padding(
                            padding: new EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left:
                                    MediaQuery.of(context).size.height * 0.025,
                                right:
                                    MediaQuery.of(context).size.height * 0.025,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return ForgotPassword();
                                      },
                                    ),
                                  );
                                  // Fluttertoast.showToast(msg: "Clicked on Forgot Password ", toastLength: Toast.LENGTH_SHORT);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    // decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                    decorationColor: Color(0xFFC80000),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.0105,
                                    color: Color(0xFFC80000),
                                    // fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ),

                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: screenWidth * 0.0),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       // Login Button
                          //
                          //       GestureDetector(
                          //         onTap: () async {
                          //           validateentriesatsubmit(context);
                          //         },
                          //         child: Container(
                          //             alignment: Alignment.centerRight,
                          //             padding: EdgeInsets.only(
                          //                 top: MediaQuery.of(context).size.height *
                          //                     0.01,
                          //                 bottom:
                          //                     MediaQuery.of(context).size.height *
                          //                         0.00,
                          //                 left: MediaQuery.of(context).size.height *
                          //                     0.00,
                          //                 right:
                          //                     MediaQuery.of(context).size.height *
                          //                         0.00),
                          //             margin: EdgeInsets.only(
                          //                 right:
                          //                     MediaQuery.of(context).size.height *
                          //                         0.01,
                          //                 top: MediaQuery.of(context).size.height *
                          //                     0.01,
                          //                 bottom:
                          //                     MediaQuery.of(context).size.height *
                          //                         0.01,
                          //                 left:
                          //                     MediaQuery.of(context).size.height *
                          //                         0.01),
                          //             child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          //               Expanded(
                          //                 child: Container(
                          //                   decoration: BoxDecoration(
                          //                       borderRadius:
                          //                           BorderRadius.circular(
                          //                               MediaQuery.of(context)
                          //                                       .size
                          //                                       .height *
                          //                                   0.012),
                          //                       gradient: LinearGradient(
                          //                           begin: Alignment.centerRight,
                          //                           end: Alignment.center,
                          //                           stops: [
                          //                             0.5,
                          //                             0.9
                          //                           ],
                          //                           colors: [
                          //                             Color(0xFF126086),
                          //                             Color(0xFF126086),
                          //                           ])),
                          //                   alignment: Alignment.center,
                          //                   padding: EdgeInsets.only(left: 0.0),
                          //                   child: TextButton(
                          //                     onPressed: () async {
                          //                       validateentriesatsubmit(context);
                          //                     },
                          //                     child: Text("Login",
                          //                         textAlign: TextAlign.center,
                          //                         style: TextStyle(
                          //                             color: Colors.white,
                          //                             fontSize:
                          //                                 MediaQuery.of(context)
                          //                                         .size
                          //                                         .height *
                          //                                     0.02)),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ])),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(height: screenHeight * 0.02),
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
                                    validateentriesatsubmit(context);
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
                                                validateentriesatsubmit(
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
                                  padding: new EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.0,
                                    right: MediaQuery.of(context).size.height *
                                        0.0,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.02,
                                    top: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.0,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                    ),
                                    margin: EdgeInsets.only(
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      left: MediaQuery.of(context).size.height *
                                          0.04,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color(0x1A000000), // Border color
                                        width: 1, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // Google Logo
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0,
                                          ),
                                          child: Image.asset(
                                            'assets/appleicon.png', // Replace with your asset path
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03, // Adjust size as needed
                                          ),
                                        ),
                                        // "Sign up with Google" Text
                                        SizedBox(width: screenWidth * 0.1),
                                        Flexible(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 11.0,
                                                  horizontal:
                                                      12.0), // Remove default button padding
                                              minimumSize: Size(0,
                                                  0), // Allow smallest possible size
                                              tapTargetSize: MaterialTapTargetSize
                                                  .shrinkWrap, // Shrink tap area
                                            ),
                                            onPressed: () async {
                                              // Navigator.of(context).pushAndRemoveUntil(
                                              //   MaterialPageRoute(
                                              //     builder: (BuildContext context) =>
                                              //         LoginHome(),
                                              //   ),
                                              //   (Route route) => false,
                                              // );
                                            },
                                            child: Text(
                                              "Sign up with Apple",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF1F1F1F),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.016,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Inter"
                                                  // Enable ellipsis
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: new EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.0,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      top: MediaQuery.of(context).size.height *
                                          0.01,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.0),
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.0,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                    ),
                                    margin: EdgeInsets.only(
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      top: MediaQuery.of(context).size.height *
                                          0.00,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      left: MediaQuery.of(context).size.height *
                                          0.04,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color(0x1A000000), // Border color
                                        width: 1, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        // Google Logo
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0,
                                          ),
                                          child: Image.asset(
                                            'assets/googleicon.png', // Replace with your asset path
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03, // Adjust size as needed
                                          ),
                                        ),
                                        // "Sign up with Google" Text
                                        SizedBox(width: screenWidth * 0.1),
                                        Flexible(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 11.0,
                                                  horizontal:
                                                      12.0), // Remove default button padding
                                              minimumSize: Size(0,
                                                  0), // Allow smallest possible size
                                              tapTargetSize: MaterialTapTargetSize
                                                  .shrinkWrap, // Shrink tap area
                                            ),
                                            onPressed: () async {},
                                            child: Text(
                                              "Sign up with Google",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF1F1F1F),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.016,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Inter"
                                                  // Enable ellipsis
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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

  void validateentriesatsubmit(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        String input = UserNumberEditTextController.text.trim();

        if (input.isEmpty) {
          setState(() {
            hasStartedTyping = true;
            errorMessage = "Please enter your email or mobile number";
            isValid = false;
          });
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                .hasMatch(input) &&
            !RegExp(r'^[0-9]{10}$').hasMatch(input)) {
          setState(() {
            hasStartedTyping = true;
            errorMessage = "Please enter a valid email or mobile number";
            isValid = false;
          });
        } else {
          setState(() {
            hasStartedTyping = false;
            errorMessage = null;
            isValid = true;
          });
        }

        String input1 = PasswordEditTextController.text.trim();

        if (input1.isEmpty) {
          setState(() {
            passhasStartedTyping = true;
            passerrorMessage = "Please enter Password";
            passisValid = false;
          });
        } else if (!RegExp(
                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$')
            .hasMatch(input1)) {
          setState(() {
            passhasStartedTyping = true;
            passerrorMessage =
                "Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.";
            passisValid = false;
          });
        } else {
          setState(() {
            passhasStartedTyping = false;
            passerrorMessage = null;
            passisValid = true;
          });
        }

        if (isValid && passisValid) {
          /*  progressDialog.showMaterial(
              title: "Authenticating", message: "Please wait");*/
          // progressDialog.show();

          dynamic user = await apiService.submitlogin(
              UserNumberEditTextController.text,
              base64Encode(utf8.encode(PasswordEditTextController.text)));

          if (user.accessToken != null) {
            // progressDialog.hide();
            await UserSecureStorage.setTokenvalue(user.accessToken);
            await UserSecureStorage.setRefreshTokenvalue(user.refreshToken);
            await UserSecureStorage.setIfLogged("YES");
            await UserSecureStorage.setIfLoggedOut("NO");
            await UserSecureStorage.setIfGuestLogged("NO");
            // await UserSecureStorage.setIfLoggedOut("NO");
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePageMain()),
                (Route<dynamic> route) => false);
          } else if (user.message != null) {
            // progressDialog.hide();

            final snackBar = SnackBar(
              content: Text(user.message),
              backgroundColor: Colors.red[600],
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            /* Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePageMain()),
                    (Route<dynamic> route) => false);*/

            // customalert.showError(context, user.error);
          }
        }
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
