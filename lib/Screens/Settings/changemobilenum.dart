

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/passsuccesssendback.dart';
import 'package:newfolder/Screens/Settings/sucesschangenum.dart';
import 'package:newfolder/Screens/Success_Message/sucess_message.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangeMobileNumber extends StatefulWidget {
  const ChangeMobileNumber({
    super.key,
  });
  @override
  State<ChangeMobileNumber> createState() => ChangeMobileNumberstate();
}

class ChangeMobileNumberstate extends State<ChangeMobileNumber> {
  final int _numPages = 2;
  int _currentPage = 0;
  Successfulychangenum successnumchangedalert = new Successfulychangenum();

  final PageController _pageController = PageController(initialPage: 0);

  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;

  RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$');

  TextEditingController UserNumberEditTextController = TextEditingController();

  TextEditingController Otp1stdigitTextController = TextEditingController();
  TextEditingController Otp2nddigitTextController = TextEditingController();
  TextEditingController Otp3rddigitTextController = TextEditingController();
  TextEditingController Otp4thdigitTextController = TextEditingController();
  TextEditingController Otp5thdigitTextController = TextEditingController();
  TextEditingController Otp6thdigitTextController = TextEditingController();

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;


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
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();

    UserNumberEditTextController.addListener(_checkInput);
  }

  @override
  void dispose() {

    UserNumberEditTextController.removeListener(_checkInput);
    UserNumberEditTextController.dispose();
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  List<Widget> _buildPageIndicator() {
    return List<Widget>.generate(
      _numPages,
          (index) => _indicator(index == _currentPage),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: MediaQuery.of(context).size.height * 0.005,
      width: isActive
          ? MediaQuery.of(context).size.height * 0.035
          : MediaQuery.of(context).size.height * 0.035,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF126086) : Colors.black12,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  // Asgar
  void _checkInput() {
    print('_checkInput');
    setState(() {
      setState(() {
        if (UserNumberEditTextController.text.trim().isNotEmpty) {
          _isButtonEnabled = true;
        } else {
          _isButtonEnabled = false;
        }
      });
    });
    print('_isButtonEnabled : $_isButtonEnabled');
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
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
                      height: MediaQuery.of(context).size.height * 0.022 ,
                      width: MediaQuery.of(context).size.height * 0.022,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF126086).withOpacity(0.2),

                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 0.0, color: Color(0xFF126086)),
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
                        _currentPage == 0
                            ? "Change Mobile Number"
                            : _currentPage == 1
                            ? "Verification"
                            : "Verification",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w700,
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
                        margin: EdgeInsets.only(
                          top: screenHeight * 0.06,
                          bottom:  screenHeight * 0.02,
                        ),
                        child: Image.asset(
                          'assets/splashqc.png',
                          height: screenHeight * 0.06,
                          fit: BoxFit.contain,
                        ),
                      ),
                      // PageView with fixed height
                      SizedBox(
                        height: screenHeight * 0.62,
                        child: PageView(
                          physics:
                          NeverScrollableScrollPhysics(), // Disable swiping
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: <Widget>[
                            _buildForgotPasswordPage(context),
                            _buildVerificationPage(context),

                          ],
                        ),
                      ),

                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),

                      // Buttons for page navigation
                      if (_currentPage == 0)
                        GestureDetector(
                          onTap: () async {

                            // Fluttertoast.showToast(msg: "Clicked", toastLength: Toast.LENGTH_SHORT);
                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(
                                  top:
                                  MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.00,
                                  left:
                                  MediaQuery.of(context).size.height * 0.00,
                                  right: MediaQuery.of(context).size.height *
                                      0.00),
                              margin: EdgeInsets.only(
                                  right:
                                  MediaQuery.of(context).size.height * 0.04,
                                  top:
                                  MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.01,
                                  left: MediaQuery.of(context).size.height *
                                      0.04),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.012),

                                        // color: Color(0xFF126086),
                                            color : _isButtonEnabled ? Color(0xFF126086) : Color(0xFFBDBDBD),
                                        ),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(left: 0.0),
                                        child: TextButton(
                                          onPressed: () async {
                                            _pageController.animateToPage(
                                              1, // Go to the next page
                                              duration:
                                              Duration(milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          child: Text("Send OTP",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.02)),
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),  // Remove default button padding
                                            minimumSize: Size(0, 0), // Allow smallest possible size
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap area
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                        )
                      else if (_currentPage == 1)
                        GestureDetector(
                          onTap: () async {

                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(
                                  top:
                                  MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.00,
                                  left:
                                  MediaQuery.of(context).size.height * 0.00,
                                  right: MediaQuery.of(context).size.height *
                                      0.00),
                              margin: EdgeInsets.only(
                                  right:
                                  MediaQuery.of(context).size.height * 0.04,
                                  top:
                                  MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.01,
                                  left: MediaQuery.of(context).size.height *
                                      0.04),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.012),
                                          color : Color(0xFFBDBDBD),
                                            ),

                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(left: 0.0),
                                        child: TextButton(
                                          onPressed: () async {
                                            // successnumchangedalert.showticket(
                                            //   context,
                                            // );
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) =>SuccessMessage())
                                            );

                                          },
                                          child: Text("Reset Password",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.02)),
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),  // Remove default button padding
                                            minimumSize: Size(0, 0), // Allow smallest possible size
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap area
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                        )

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

  Widget _buildForgotPasswordPage(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: new EdgeInsets.only(
          left: MediaQuery.of(context).size.height * 0.0,
          top: MediaQuery.of(context).size.height * 0.01,
          right: MediaQuery.of(context).size.height * 0.0,
          bottom: MediaQuery.of(context).size.height * 0.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(

            child: Column(children: [
              Text(
                "Change Mobile Number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.022,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: new EdgeInsets.only(
                  top : MediaQuery.of(context).size.height * 0.005,
                  left : MediaQuery.of(context).size.height * 0.11,
                  right : MediaQuery.of(context).size.height * 0.11,),
                child: Text(
                  "Enter which contact details should we use to Change your Mobile Number.",
                  style: TextStyle(
                    height: 1.8,
                    fontSize: MediaQuery.of(context).size.height * 0.012,
                    color: Color(0xFF6A6E83),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
          Padding(
            padding: new EdgeInsets.only(
                top : MediaQuery.of(context).size.height * 0.03,
                left: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.height * 0.0,
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
              left: MediaQuery.of(context).size.height * 0.04,
              right: MediaQuery.of(context).size.height * 0.04,
              bottom: MediaQuery.of(context).size.height * 0.005,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: UserNumberEditTextController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {

                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.height * 0.02,
                      MediaQuery.of(context).size.height * 0.012,
                      MediaQuery.of(context).size.height * 0.012,
                      MediaQuery.of(context).size.height * 0.012,
                    ),
                    filled: true,
                    fillColor: Color(0xFFFFFFFF),
                    hintText: "Enter your Mobile Number",
                    hintStyle: TextStyle(
                        color: Color(0x4D111111),
                        fontSize: MediaQuery.of(context).size.height * 0.012,
                        fontWeight: FontWeight.w500
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: hasStartedTyping
                            ? (isValid ? Colors.green : Colors.red)
                            : Color(0xFFF1F1F1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                        color: hasStartedTyping
                            ? (isValid ? Colors.green : Colors.red)
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Text(
                    errorMessage ?? '',
                    style: TextStyle(
                      color: isValid ? Colors.green : Colors.red,
                      fontSize: MediaQuery.of(context).size.height * 0.012,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
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


        ],
      ),
    );
  }

  Widget _buildVerificationPage(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: new EdgeInsets.only(
          left: MediaQuery.of(context).size.height * 0.0,
          top: MediaQuery.of(context).size.height * 0.01,
          right: MediaQuery.of(context).size.height * 0.0,
          bottom: MediaQuery.of(context).size.height * 0.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(

            child: Column(children: [
              Text(
                "Enter Verification Code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F1F1F),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top : MediaQuery.of(context).size.height * 0.005,
                  left : MediaQuery.of(context).size.height * 0.12,
                  right : MediaQuery.of(context).size.height * 0.12,
                ),
                child: Text(
                  "We have sent the code verification to your mobile number",
                  style: TextStyle(
                    height: 1.8,
                    fontSize: MediaQuery.of(context).size.height * 0.012,
                    color: Color(0xFF6A6E83),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     alignment: Alignment.centerRight,
          //     padding: EdgeInsets.only(
          //         top: MediaQuery.of(context).size.height * 0.0,
          //         bottom: MediaQuery.of(context).size.height * 0.00,
          //         left: MediaQuery.of(context).size.height * 0.00,
          //         right: MediaQuery.of(context).size.height * 0.00),
          //     margin: EdgeInsets.only(
          //         right: MediaQuery.of(context).size.height * 0.02,
          //         top: MediaQuery.of(context).size.height * 0.0,
          //         bottom: MediaQuery.of(context).size.height * 0.0,
          //         left: MediaQuery.of(context).size.height * 0.02),
          //     child: Column(children: [
          //       /* Padding(
          //         padding: new EdgeInsets.only(
          //             left: MediaQuery.of(context).size.height * 0.005,
          //             right: MediaQuery.of(context).size.height * 0.0,
          //             bottom: MediaQuery.of(context).size.height * 0.00),
          //         child: Align(
          //           alignment: Alignment.centerLeft,
          //           child: Text(
          //             "Enter OTP Value",
          //             style: TextStyle(
          //                 fontSize: MediaQuery.of(context).size.height * 0.018,
          //                 color: Colors.black54,
          //                 fontWeight: FontWeight.bold),
          //             textAlign: TextAlign.start,
          //           ),
          //         ),
          //       ),*/
          //
          //       Container(
          //         padding: EdgeInsets.only(
          //           top: MediaQuery.of(context).size.height * 0.00,
          //           left: MediaQuery.of(context).size.height * 0.00,
          //           right: MediaQuery.of(context).size.height * 0.00,
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //
          //
          //             SizedBox(
          //               width: SizeConfig.blockSizeHorizontal! * 11,
          //               child: TextFormField(
          //                 // autofocus: true,
          //                 // obscureText: true,
          //                 style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.034),
          //                 controller: Otp1stdigitTextController,
          //                 inputFormatters: [
          //                   LengthLimitingTextInputFormatter(1),
          //                   FilteringTextInputFormatter.allow(RegExp('[0-9]'))
          //                 ],
          //                 keyboardType: TextInputType.number,
          //                 textAlign: TextAlign.center,
          //                 decoration: InputDecoration(
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
          //                   filled: false, // Remove background color
          //                   hintText: '0', // Example hint text
          //                   hintStyle: TextStyle(color: Colors.white70),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey), // Set border color
          //                   ),
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.015)),
          //                     borderSide: BorderSide(color: Colors.grey[300]!), // Set border color
          //                   ),
          //                 ),
          //                 onChanged: (value) {
          //                   nextField(value, pin2FocusNode!);
          //                 },
          //               ),
          //             ),
          //
          //
          //             SizedBox(
          //               width: SizeConfig.blockSizeHorizontal! * 11,
          //               child: TextFormField(
          //                 focusNode: pin2FocusNode,
          //                 style: TextStyle(
          //                   fontSize: MediaQuery.of(context).size.height * 0.034,
          //                 ),
          //                 controller: Otp2nddigitTextController,
          //                 inputFormatters: [
          //                   LengthLimitingTextInputFormatter(1),
          //                   FilteringTextInputFormatter.allow(RegExp('[0-9]'))
          //                 ],
          //                 keyboardType: TextInputType.number,
          //                 textAlign: TextAlign.center,
          //                 decoration: InputDecoration(
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
          //                   filled: false, // Remove background color
          //                   hintStyle: TextStyle(color: Colors.white70),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey), // Set border color to grey
          //                   ),
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
          //                   ),
          //                 ),
          //                 onChanged: (value) => nextField(value, pin3FocusNode!),
          //               ),
          //             ),
          //
          //
          //
          //             SizedBox(
          //               width: SizeConfig.blockSizeHorizontal! * 11,
          //               child: TextFormField(
          //                 focusNode: pin3FocusNode,
          //                 style: TextStyle(
          //                   fontSize: MediaQuery.of(context).size.height * 0.034,
          //                 ),
          //                 controller: Otp3rddigitTextController,
          //                 inputFormatters: [
          //                   LengthLimitingTextInputFormatter(1),
          //                   FilteringTextInputFormatter.allow(RegExp('[0-9]'))
          //                 ],
          //                 keyboardType: TextInputType.number,
          //                 textAlign: TextAlign.center,
          //                 decoration: InputDecoration(
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
          //                   filled: false, // Remove background color
          //                   hintStyle: TextStyle(color: Colors.white70),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey), // Set border color to grey
          //                   ),
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color:Colors.grey[300]!), // Set border color to grey
          //                   ),
          //                 ),
          //                 onChanged: (value) => nextField(value, pin4FocusNode!),
          //               ),
          //             ),
          //
          //
          //             // 4
          //             SizedBox(
          //               width: SizeConfig.blockSizeHorizontal! * 11,
          //               child: TextFormField(
          //                 focusNode: pin4FocusNode,
          //                 style: TextStyle(
          //                   fontSize: MediaQuery.of(context).size.height * 0.034,
          //                 ),
          //                 controller: Otp4thdigitTextController,
          //                 inputFormatters: [
          //                   LengthLimitingTextInputFormatter(1),
          //                   FilteringTextInputFormatter.allow(RegExp('[0-9]'))
          //                 ],
          //                 keyboardType: TextInputType.number,
          //                 textAlign: TextAlign.center,
          //                 decoration: InputDecoration(
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
          //                   filled: false, // Remove background color
          //                   hintStyle: TextStyle(color: Colors.white70),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey), // Set border color to grey
          //                   ),
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
          //                   ),
          //                 ),
          //                 onChanged: (value) => nextField(value, pin5FocusNode!),
          //               ),
          //             ),
          //
          //
          //             // 5
          //             SizedBox(
          //               width: SizeConfig.blockSizeHorizontal! * 11,
          //               child: TextFormField(
          //                 focusNode: pin5FocusNode,
          //                 style: TextStyle(
          //                   fontSize: MediaQuery.of(context).size.height * 0.034,
          //                 ),
          //                 controller: Otp5thdigitTextController,
          //                 inputFormatters: [
          //                   LengthLimitingTextInputFormatter(1),
          //                   FilteringTextInputFormatter.allow(RegExp('[0-9]'))
          //                 ],
          //                 keyboardType: TextInputType.number,
          //                 textAlign: TextAlign.center,
          //                 decoration: InputDecoration(
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
          //                   filled: false, // Remove background color
          //                   hintStyle: TextStyle(color: Colors.white70),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey), // Set border color to grey
          //                   ),
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
          //                   ),
          //                 ),
          //                 onChanged: (value) => nextField(value, pin6FocusNode!),
          //               ),
          //             ),
          //
          //
          //             // for 6
          //             SizedBox(
          //               width: SizeConfig.blockSizeHorizontal! * 11,
          //               child: TextFormField(
          //                 focusNode: pin6FocusNode,
          //                 style: TextStyle(
          //                   fontSize: MediaQuery.of(context).size.height * 0.034,
          //                 ),
          //                 controller: Otp6thdigitTextController,
          //                 inputFormatters: [
          //                   LengthLimitingTextInputFormatter(1),
          //                   FilteringTextInputFormatter.allow(RegExp('[0-9]'))
          //                 ],
          //                 keyboardType: TextInputType.number,
          //                 textAlign: TextAlign.center,
          //                 decoration: InputDecoration(
          //                   isDense: true,
          //                   contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
          //                   filled: false, // Remove background color
          //                   hintStyle: TextStyle(color: Colors.white70),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey), // Set border color to grey
          //                   ),
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
          //                     borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
          //                   ),
          //                 ),
          //                 onChanged: (value) {
          //                   if (value.length == 1) {
          //                     pin6FocusNode!.unfocus();
          //                     // Then you need to check if the OTP code is correct
          //                   }
          //                 },
          //               ),
          //             ),
          //
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.only(
          //             left: MediaQuery.of(context).size.height * 0.00,
          //             right: 0,
          //             top: MediaQuery.of(context).size.height * 0.005,
          //             bottom: MediaQuery.of(context).size.height * 0.010),
          //         child: Row(
          //             mainAxisSize: MainAxisSize.max,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               Text(
          //                 "Didn't get OTP?",
          //                 style: TextStyle(
          //                   fontSize:
          //                   MediaQuery.of(context).size.height * 0.018,
          //                   color: Colors.black87,
          //                   // fontWeight: FontWeight.bold
          //                 ),
          //                 textAlign: TextAlign.start,
          //               ),
          //               GestureDetector(
          //                 onTap: () {
          //                 },
          //                 child: Padding(
          //                   padding: new EdgeInsets.only(
          //                       top: MediaQuery.of(context).size.height * 0.0,
          //                       left:
          //                       MediaQuery.of(context).size.height * 0.010,
          //                       right: MediaQuery.of(context).size.height * 0.0,
          //                       bottom:
          //                       MediaQuery.of(context).size.height * 0.0),
          //                   child: Text(
          //                     "Resend OTP",
          //                     style: TextStyle(
          //                       // decoration: TextDecoration.underline,
          //                         decorationColor: Colors.blue[300],
          //                         fontSize: MediaQuery.of(context).size.height *
          //                             0.018,
          //                         color: Color(0xFF126086),
          //                         fontWeight: FontWeight.bold),
          //                     textAlign: TextAlign.center,
          //                   ),
          //                 ),
          //               ),
          //             ]),
          //       ),
          //     ]),
          //   ),
          // ),

          Column(children: [


            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
                left: MediaQuery.of(context).size.height * 0.05,
                right: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 09,
                    height: SizeConfig.blockSizeHorizontal! * 12,
                    child: TextFormField(
                      // autofocus: true,
                      // obscureText: true,
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * 0.034),
                      controller: Otp1stdigitTextController,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                        ),
                        filled: false,
                        // fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                          borderSide: BorderSide(
                            color:
                            Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                          borderSide: BorderSide(
                            color:  Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                      ),
                      onChanged: (value) {
                        nextField(value, pin2FocusNode!);
                      },
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 09,
                    height: SizeConfig.blockSizeHorizontal! * 12,
                    child: TextFormField(
                      focusNode: pin2FocusNode,
                      // obscureText: true,
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * 0.034),
                      controller: Otp2nddigitTextController,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                        ),
                        filled: false,
                        // fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                          borderSide: BorderSide(
                            color:
                            Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                          borderSide: BorderSide(
                            color:  Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                      ),
                      onChanged: (value) =>
                          nextField(value, pin3FocusNode!),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 09,
                    height: SizeConfig.blockSizeHorizontal! * 12,
                    child: TextFormField(
                      focusNode: pin3FocusNode,
                      // obscureText: true,
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * 0.034),
                      controller: Otp3rddigitTextController,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                        ),
                        filled: false,
                        // fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                          borderSide: BorderSide(
                            color:
                            Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                          borderSide: BorderSide(
                            color:  Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                      ),
                      onChanged: (value) =>
                          nextField(value, pin4FocusNode!),
                    ),
                  ),

                  // 4
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 09,
                    height: SizeConfig.blockSizeHorizontal! * 12,
                    child: TextFormField(
                      focusNode: pin4FocusNode,
                      // obscureText: true,
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * 0.034),
                      controller: Otp4thdigitTextController,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                        ),
                        filled: false,
                        // fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                          borderSide: BorderSide(
                            color:
                            Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                          borderSide: BorderSide(
                            color:  Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                      ),
                      onChanged: (value) =>
                          nextField(value, pin5FocusNode!),
                    ),
                  ),

                  // 5
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 09,
                    height: SizeConfig.blockSizeHorizontal! * 12,
                    child: TextFormField(
                      focusNode: pin5FocusNode,
                      // obscureText: true,
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * 0.034),
                      controller: Otp5thdigitTextController,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                        ),
                        filled: false,
                        // fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                          borderSide: BorderSide(
                            color:
                            Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                          borderSide: BorderSide(
                            color:  Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                      ),
                      onChanged: (value) =>
                          nextField(value, pin6FocusNode!),
                    ),
                  ),

                  // for 6
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 09,
                    height: SizeConfig.blockSizeHorizontal! * 12,
                    child: TextFormField(
                      focusNode: pin6FocusNode,
                      // obscureText: true,
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * 0.034),
                      controller: Otp6thdigitTextController,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.0,
                        ),
                        filled: false,
                        // fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                          borderSide: BorderSide(
                            color:
                            Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                          borderSide: BorderSide(
                            color:  Color(0xFFF1F1F1), // Initially grey, turns red or green
                          ), // Set border color
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1) {
                          pin6FocusNode!.unfocus();
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
                  top: MediaQuery.of(context).size.height * 0.015,
                  bottom: MediaQuery.of(context).size.height * 0.010),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Didn't get OTP?",
                      style: TextStyle(
                          fontSize:
                          MediaQuery.of(context).size.height * 0.012,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.start,
                    ),
                    GestureDetector(
                      onTap: () {
                        // validateSendOTP();
                      },
                      child: Padding(
                        padding: new EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.0,
                            left:
                            MediaQuery.of(context).size.height * 0.004,
                            right: MediaQuery.of(context).size.height * 0.0,
                            bottom:
                            MediaQuery.of(context).size.height * 0.0),
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                            // decoration: TextDecoration.underline,
                            decorationColor: Colors.blue[300],
                            fontSize: MediaQuery.of(context).size.height *
                                0.013,
                            color: Color(0xFF126086),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ]),
            ),
          ]),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/onboard2verification.png',
                  height: MediaQuery.of(context).size.height * 0.35,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),

          /* Image.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.contain,
          ),*/
        ],
      ),
    );
  }


}
