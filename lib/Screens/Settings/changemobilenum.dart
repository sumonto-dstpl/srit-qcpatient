

import 'dart:async';
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

import '../Utils/customNotification.dart';
import '../VerifyOtp/verifyOtp.dart';

class ChangeMobileNumber extends StatefulWidget {
  // const ChangeMobileNumber({
  //   super.key,
  // });
  final String? mobileNumber; // Optional numbe

  const ChangeMobileNumber({Key? key, this.mobileNumber}) : super(key: key);
  @override
  State<ChangeMobileNumber> createState() => ChangeMobileNumberstate();
}

class ChangeMobileNumberstate extends State<ChangeMobileNumber> {
  final int _numPages = 2;
  int _currentPage = 0;
  Successfulychangenum successnumchangedalert = new Successfulychangenum();

  late PageController _pageController = PageController(initialPage: 1);
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

  // TextEditingController Otp1stdigitTextController = TextEditingController();
  // TextEditingController Otp2nddigitTextController = TextEditingController();
  // TextEditingController Otp3rddigitTextController = TextEditingController();
  // TextEditingController Otp4thdigitTextController = TextEditingController();
  // TextEditingController Otp5thdigitTextController = TextEditingController();
  // TextEditingController Otp6thdigitTextController = TextEditingController();
  //
  // FocusNode? pin2FocusNode;
  // FocusNode? pin3FocusNode;
  // FocusNode? pin4FocusNode;
  // FocusNode? pin5FocusNode;
  // FocusNode? pin6FocusNode;


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

    hasMobileNumber = widget.mobileNumber != null && widget.mobileNumber!.isNotEmpty;
    _pageController = PageController(
      initialPage: hasMobileNumber ? 1 : 0,
    );
      String mobile = widget.mobileNumber!;
    if (hasMobileNumber) {
        if(!RegExp(r'^[0-9]{10}$').hasMatch(mobile)){
            mobile = "1234567890";
        }
      UserNumberEditTextController.text = mobile;
    }
    // UserNumberEditTextController.text ="9583817953";
    // pin2FocusNode = FocusNode();
    // pin3FocusNode = FocusNode();
    // pin4FocusNode = FocusNode();
    // pin5FocusNode = FocusNode();
    // pin6FocusNode = FocusNode();

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
                            // ? "Change Mobile Number"
                            ? "OTP Verification"
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: _buildPageIndicator(),
                      // ),
                      //
                      // // Buttons for page navigation
                      // if (_currentPage == 0)
                      //   GestureDetector(
                      //     onTap: () async {
                      //
                      //       // Fluttertoast.showToast(msg: "Clicked", toastLength: Toast.LENGTH_SHORT);
                      //     },
                      //     child: Container(
                      //         alignment: Alignment.centerRight,
                      //         padding: EdgeInsets.only(
                      //             top:
                      //             MediaQuery.of(context).size.height * 0.01,
                      //             bottom:
                      //             MediaQuery.of(context).size.height * 0.00,
                      //             left:
                      //             MediaQuery.of(context).size.height * 0.00,
                      //             right: MediaQuery.of(context).size.height *
                      //                 0.00),
                      //         margin: EdgeInsets.only(
                      //             right:
                      //             MediaQuery.of(context).size.height * 0.04,
                      //             top:
                      //             MediaQuery.of(context).size.height * 0.01,
                      //             bottom:
                      //             MediaQuery.of(context).size.height * 0.01,
                      //             left: MediaQuery.of(context).size.height *
                      //                 0.04),
                      //         child: Row(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: <Widget>[
                      //               Expanded(
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(
                      //                         MediaQuery.of(context)
                      //                             .size
                      //                             .height *
                      //                             0.012),
                      //
                      //                   // color: Color(0xFF126086),
                      //                       color : _isButtonEnabled ? Color(0xFF126086) : Color(0xFFBDBDBD),
                      //                   ),
                      //                   alignment: Alignment.center,
                      //                   padding: EdgeInsets.only(left: 0.0),
                      //                   child: TextButton(
                      //                     onPressed: () async {
                      //                       _pageController.animateToPage(
                      //                         1, // Go to the next page
                      //                         duration:
                      //                         Duration(milliseconds: 300),
                      //                         curve: Curves.easeInOut,
                      //                       );
                      //                     },
                      //                     child: Text("Send OTP",
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize:
                      //                             MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.02)),
                      //                     style: TextButton.styleFrom(
                      //                       padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),  // Remove default button padding
                      //                       minimumSize: Size(0, 0), // Allow smallest possible size
                      //                       tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap area
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ])),
                      //   )
                      // else if (_currentPage == 1)
                      //   GestureDetector(
                      //     onTap: () async {
                      //
                      //     },
                      //     child: Container(
                      //         alignment: Alignment.centerRight,
                      //         padding: EdgeInsets.only(
                      //             top:
                      //             MediaQuery.of(context).size.height * 0.01,
                      //             bottom:
                      //             MediaQuery.of(context).size.height * 0.00,
                      //             left:
                      //             MediaQuery.of(context).size.height * 0.00,
                      //             right: MediaQuery.of(context).size.height *
                      //                 0.00),
                      //         margin: EdgeInsets.only(
                      //             right:
                      //             MediaQuery.of(context).size.height * 0.04,
                      //             top:
                      //             MediaQuery.of(context).size.height * 0.01,
                      //             bottom:
                      //             MediaQuery.of(context).size.height * 0.01,
                      //             left: MediaQuery.of(context).size.height *
                      //                 0.04),
                      //         child: Row(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: <Widget>[
                      //               Expanded(
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                       borderRadius: BorderRadius.circular(
                      //                           MediaQuery.of(context)
                      //                               .size
                      //                               .height *
                      //                               0.012),
                      //                     color : Color(0xFFBDBDBD),
                      //                       ),
                      //
                      //                   alignment: Alignment.center,
                      //                   padding: EdgeInsets.only(left: 0.0),
                      //                   child: TextButton(
                      //                     onPressed: () async {
                      //                       // successnumchangedalert.showticket(
                      //                       //   context,
                      //                       // );
                      //                       Navigator.of(context).push(
                      //                           MaterialPageRoute(builder: (context) =>SuccessMessage())
                      //                       );
                      //
                      //                     },
                      //                     child: Text("Reset Password",
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize:
                      //                             MediaQuery.of(context)
                      //                                 .size
                      //                                 .height *
                      //                                 0.02)),
                      //                     style: TextButton.styleFrom(
                      //                       padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),  // Remove default button padding
                      //                       minimumSize: Size(0, 0), // Allow smallest possible size
                      //                       tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap area
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ])),
                      //   )

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

            child: Column(
              children: [
                Text(
                  "Verification Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F1F1F),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                  "Please enter verification code sent to",
                  style: TextStyle(
                    height: 1.8,
                    fontSize: MediaQuery.of(context).size.height * 0.012,
                    color: Color(0xFF6A6E83),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Masked number display
                UserNumberEditTextController.text.isNotEmpty
                    ? Text(
                  "+91 ******${UserNumberEditTextController.text.substring(UserNumberEditTextController.text.length - 4)}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                    color: Color(0xFF1F1F1F),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                )
                    : SizedBox.shrink(), // shows nothing if empty
              ],
            ),

          ),


          Column(children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
                left: MediaQuery.of(context).size.height * 0.05,
                right: MediaQuery.of(context).size.height * 0.05,
              ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 9,
                    height: SizeConfig.blockSizeHorizontal! * 12,
                    child: RawKeyboardListener(
                      focusNode: FocusNode(), // Required for RawKeyboardListener
                      onKey: (RawKeyEvent event) {
                        if (event is RawKeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.backspace) {
                          // Move to previous cell irrespective of current cell value
                          if (index > 0) {
                            focusNodes[index - 1].requestFocus();
                          }
                        }
                      },
                      child: TextFormField(
                        controller: otpControllers[index],
                        focusNode: focusNodes[index],
                        obscureText: true,
                        obscuringCharacter: '•',
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
                          contentPadding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.height * 0.01,
                            0,
                            MediaQuery.of(context).size.height * 0.01,
                            0,
                          ),
                          filled: false,
                          hintStyle: TextStyle(color: Colors.white70),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                            borderSide: BorderSide(color: isError[index] ? Colors.red : Color(0xFFF1F1F1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                            borderSide: BorderSide(color: isError[index] ? Colors.red : Color(0xFFF1F1F1)),
                          ),
                        ),
                        onChanged: (value) {
                          otpValues[index] = value;
                          setState(() {
                            isError[index] = value.isEmpty;
                          });

                          if (value.isNotEmpty) {
                            // Move forward if not last
                            if (index < 5) focusNodes[index + 1].requestFocus();
                            else verifyOtp(); // Last field
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),


              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: List.generate(6, (index) {
              //   return SizedBox(
              //   width: SizeConfig.blockSizeHorizontal! * 9,
              //   height: SizeConfig.blockSizeHorizontal! * 12,
              //   child: TextFormField(
              //   controller: otpControllers[index],
              //   focusNode: focusNodes[index],
              //   keyboardType: TextInputType.number,
              //   textAlign: TextAlign.center,
              //   inputFormatters: [
              //   LengthLimitingTextInputFormatter(1),
              //   FilteringTextInputFormatter.digitsOnly,
              //   ],
              //   style: TextStyle(
              //   fontSize: MediaQuery.of(context).size.height * 0.034,
              //   ),
              //   decoration: InputDecoration(
              //   isDense: true,
              //   contentPadding: EdgeInsets.fromLTRB(
              //   MediaQuery.of(context).size.height * 0.01,
              //   0,
              //   MediaQuery.of(context).size.height * 0.01,
              //   0,
              //   ),
              //   filled: false,
              //   hintStyle: TextStyle(color: Colors.white70),
              //   focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
              //   // borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
              //     borderSide: BorderSide(color: isError[index] ? Colors.red : Color(0xFFF1F1F1)),
              //   ),
              //   enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
              //   // borderSide: const BorderSide(color: Color(0xFF16B812)),
              //     borderSide: BorderSide(color: isError[index] ? Colors.red : Color(0xFFF1F1F1)),
              //   ),
              //   ),
              //   onChanged: (value) {
              //   // Automatically move to next field
              //     otpValues[index] = value;
              //    setState(() {
              //      isError[index] = value.isEmpty;
              //    });
              //
              //
              //   if (index < 5 && value.isNotEmpty) {
              //   focusNodes[index + 1].requestFocus();
              //   } else if (index == 5 && value.isNotEmpty) {
              //   // Last digit entered, OTP is complete
              //   verifyOtp(); // Call your OTP verification function here
              //   focusNodes[index].unfocus();
              //   }
              //   },
              //   ),
              //   );
              //   }),
              //   )
              ),

            OtpResendWidget(attempt: otpAttempt),
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



