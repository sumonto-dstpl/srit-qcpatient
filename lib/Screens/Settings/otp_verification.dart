

import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/passsuccesssendback.dart';
import 'package:newfolder/Screens/Settings/mpinmain.dart';
import 'package:newfolder/Screens/Settings/otp_verified.dart';
import 'package:newfolder/Screens/Settings/sucesschangenum.dart';
import 'package:newfolder/Screens/Success_Message/sucess_message.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/customNotification.dart';
import '../VerifyOtp/verifyOtp.dart';

class OtpVerification extends StatefulWidget {
  // const ChangeMobileNumber({
  //   super.key,
  // });
  final String? mobileNumber; // Optional numbe

  const OtpVerification({Key? key, this.mobileNumber}) : super(key: key);
  @override
  State<OtpVerification> createState() => ChangeMobileNumberstate();
}

class ChangeMobileNumberstate extends State<OtpVerification> {

  Successfulychangenum successnumchangedalert = new Successfulychangenum();


  late final bool hasMobileNumber;
  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;
  List<String> otpValues = List.filled(6, "");
  List<bool> isError = List.filled(6, false); // true = show red border
  List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$');

  TextEditingController UserNumberEditTextController = TextEditingController();




  String? errorMessage;
  bool isValid = false;
  bool hasStartedTyping = false; // Track if the user has started typing

  // Asgar
  bool _isButtonEnabled = false;

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


  @override
  void initState() {
    /* setState(() {
      UserNumberEditTextController?.text = "subramanib40@gmail.com";
      NewPasswordEditTextController?.text = "Pugazh@#123456";
      ReenterPassEditTextController?.text = "Pugazh@#123456";
    });*/
    super.initState();




    UserNumberEditTextController.addListener(_checkInput);
  }

  @override
  void dispose() {

    UserNumberEditTextController.removeListener(_checkInput);
    UserNumberEditTextController.dispose();
    // Dispose all controllers if you have them
    otpControllers.forEach((controller) => controller.dispose());

    // Dispose all focus nodes
    focusNodes.forEach((node) => node.dispose());
    super.dispose();

  }







  // Asgar
  void _checkInput() {
    // print('_checkInput');
    // setState(() {
    //   setState(() {
    //     if (UserNumberEditTextController.text.trim().isNotEmpty) {
    //       _isButtonEnabled = true;
    //     } else {
    //       _isButtonEnabled = false;
    //     }
    //   });
    // });
    // print('_isButtonEnabled : $_isButtonEnabled');
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
    else {
      setState(() {
        isValid = false;
        // errorMessage ="Please enter a 10-digit mobile number";
        errorMessage = null;
      });
    }
  }

  bool isEnabled = false;



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
                      Navigator.pop(context);
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
                        "Change Mobile Number",
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
                                    "Change Mobile Number",
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
                                    "Enter New Mobile Number",
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
                                "Mobile Number",
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
                                      LengthLimitingTextInputFormatter(14),
                                      // FilteringTextInputFormatter.digitsOnly,
                                      // LowerCaseTextFormatter(),
                                    ],
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.016,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      hasStartedTyping = false;
                                      errorMessage = null;
                                      // Automatically add "+91" if user starts typing and it’s not there
                                      if (value.isNotEmpty &&
                                          !value.startsWith("+91 ")) {
                                        UserNumberEditTextController.text =
                                            "+91 " + value;
                                        UserNumberEditTextController.selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                  offset:
                                                  UserNumberEditTextController
                                                      .text.length),
                                            );
                                      }

                                      // Remove "+91" when user deletes all characters
                                      if (value == "+91 ") {
                                        UserNumberEditTextController.clear();
                                      }
                                      // Validate number for tick/error
                                      validateNumber(
                                          UserNumberEditTextController.text);
                                    },
                                    // onEditingComplete: () {
                                    //   // add error message and icon
                                    //   checkUserIdEmpty(
                                    //       UserNumberEditTextController.text
                                    //           .toString());
                                    // },
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
                                      hintText: "Enter your mobile number",
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
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top : MediaQuery.of(context).size.height * 0.0,
                                left: MediaQuery.of(context).size.height * 0.005,
                                right: MediaQuery.of(context).size.height * 0.005,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/onboard2forgotpassword.png',
                                    height: MediaQuery.of(context).size.height * 0.35,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Login button
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: screenHeight * 0.04
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Login Button

                                GestureDetector(
                                  onTap: () async {
                                    if(isValid){
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return OtpVerified(mobileNumber: UserNumberEditTextController.text,);
                                          },
                                        ),
                                      );
                                    }
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
                                                    colors: isValid ?  [ Color(0xFF126086), Color(0xFF126086), ] :  [ Color(0xFFBDBDBD), Color(0xFFBDBDBD), ]


                                                )),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: TextButton(
                                              onPressed: () async {
                                                if(isValid){
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) {
                                                        return OtpVerified(mobileNumber: UserNumberEditTextController.text,);
                                                      },
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Text("Get OTP",
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



  int otpAttempt =0;

  void verifyOtp() {
    setState(() {
      otpAttempt += 1;
    });
    String otp = otpValues.join();
    print("OTP entered: $otp");
// Simulate OTP verification
    bool isOtpValid = otp == "123456"; // Replace with your actual verification logic

    if (isOtpValid) {
      // Show success notification
      showTopNotification(
        context,
        title: "Congratulations",
        message: "OTP verified successfully",
        type: NotificationType.success,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MpinResetSettings(mobileNumber: widget.mobileNumber!)));
    } else {
      // Show error notification

      showTopNotification(
        context,
        title: "Error",
        message: "You have entered wrong OTP in your $otpAttempt attempt. You will have to wait for 10 minutes after 3 unsuccessful attempts",
        type: NotificationType.error,
      );
    }

  }



}


class OtpResendWidget extends StatefulWidget {
  // const OtpResendWidget({Key? key}) : super(key: key);

  final int? attempt; // Optional starting timer

  const OtpResendWidget({Key? key, this.attempt}) : super(key: key);

  @override
  _OtpResendWidgetState createState() => _OtpResendWidgetState();
}

class _OtpResendWidgetState extends State<OtpResendWidget> {
  bool isCounting = false;
  late int remainingSeconds;
  Timer? _timer;
  late int totalAttempt;

  @override
  void initState() {
    super.initState();
    totalAttempt =  widget.attempt ?? 0;
    remainingSeconds = totalAttempt < 3 ? 30 :10*60;
    // if (remainingSeconds > 0) startCountdown();
  }

  void startCountdown() {
    setState(() {
      isCounting = true;
      remainingSeconds = totalAttempt < 3 ? 30 :10*60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          isCounting = false;
        });
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  String formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    String minStr = min.toString().padLeft(2, '0');
    String secStr = sec.toString().padLeft(2, '0');
    return "$minStr:$secStr";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isCounting ? "Waiting for OTP " : "Didn't get OTP? ",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.012,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        isCounting
            ? Text(
          formatTime(remainingSeconds),
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.013,
            color:  Color(0xFFC83532),
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            fontStyle: FontStyle.normal,
            // fontWeight: FontWeight.w400,
            height: 1.0,
          ),
        )
            : GestureDetector(
          onTap: startCountdown, // Call  your resend OTP API ere
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.004,
            ),
            child: Text(
              "Resend OTP",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.013,
                color: Color(0xFF126086),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OtpInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(String, FocusNode?) nextField;

  const OtpInputFields({
    Key? key,
    required this.controllers,
    required this.focusNodes,
    required this.nextField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: SizeConfig.blockSizeHorizontal! * 9,
          height: SizeConfig.blockSizeHorizontal! * 12,
          child: TextFormField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.034,
            ),
            decoration: InputDecoration(
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
              ),
            ),
            onChanged: (value) {
              FocusNode? next = index < 5 ? focusNodes[index + 1] : null;
              nextField(value, next);
            },
          ),
        );
      }),
    );
  }
}



