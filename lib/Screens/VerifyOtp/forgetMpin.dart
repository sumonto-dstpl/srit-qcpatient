import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:newfolder/Screens/Settings/mpinresetsettings.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/VerifyOtp/verifyOtp.dart';

class ForgetMpinScreen extends StatefulWidget {
  const ForgetMpinScreen({Key? key}) : super(key: key);

  @override
  State<ForgetMpinScreen> createState() => _ForgetMpinScreenState();
}

class _ForgetMpinScreenState extends State<ForgetMpinScreen> {
  final TextEditingController mobileController = TextEditingController();
  bool _isNextButtonEnabled = false;
  String? errorMessage;
  bool _isLoading = false;

  FocusNode focusMobile = FocusNode();

  void validateInput(String value) {
    if (value.isEmpty) {
      setState(() {
        errorMessage = "Please enter your mobile number";
        _isNextButtonEnabled = false;
      });
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      setState(() {
        errorMessage = "Enter a valid 10-digit number";
        _isNextButtonEnabled = false;
      });
    } else {
      setState(() {
        errorMessage = null;
        _isNextButtonEnabled = true;
      });
    }

    if(value.length == 14) {
      setState(() {
        errorMessage = null;
        _isNextButtonEnabled = true;
      });
    }
  }

  Future<void> checkMobileAndProceed() async {
    String input1 = mobileController.text.trim();
    String digitsOnly = input1.replaceAll(RegExp(r'\D'), '');
    String input = digitsOnly.substring(2);

    if (!_isNextButtonEnabled) return;

    setState(() => _isLoading = true);

    // Get all users map
    Map<String, dynamic> allUsers = await UserSecureStorage.getAllUsers();

    if (!allUsers.containsKey(input)) {
      setState(() {
        _isLoading = false;
        errorMessage = "Mobile number not found";
      });
      return;
    }

    setState(() => _isLoading = false);

    // Navigate to MPIN Reset Page for that user only
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MpinResetSettings(mobileNumber: input),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Header
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
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await Future.delayed(const Duration(milliseconds: 150));
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: screenHeight * 0.022,
                      width: screenHeight * 0.022,
                      margin: EdgeInsets.only(right: screenHeight * 0.01),
                      decoration: BoxDecoration(
                        color: const Color(0xFF126086).withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(width: 0.0, color: const Color(0xFF126086)),
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
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenHeight * 0.03),
                ],
              ),
            ),

            // White card
            Expanded(
              child: Container(
                width: double.infinity,
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
                      // Logo
                      Container(
                        margin: EdgeInsets.only(
                          top: screenHeight * 0.06,
                          bottom: screenHeight * 0.02,
                        ),
                        child: Image.asset(
                          'assets/splashqc.png',
                          height: screenHeight * 0.06,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Illustration
                      Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.01),
                        child: Image.asset(
                          'assets/onboard2forgotpassword.png',
                          height: screenHeight * 0.18,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Title
                      Container(
                        padding: EdgeInsets.only(top: screenHeight * 0.03),
                        child: Text(
                          "Forgot MPIN?",
                          style: TextStyle(
                            fontSize: screenHeight * 0.022,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F1F1F),
                            fontFamily: "Inter",
                          ),
                        ),
                      ),

                      // Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                        child: Text(
                          "Enter your registered mobile number to reset your MPIN.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenHeight * 0.017,
                            color: const Color(0xFF6A6E83),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Mobile number field

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.035,


                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (hasFocus) {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                }
                              },
                              child: TextField(
                                controller: mobileController, // Tumhara existing controller
                                keyboardType: TextInputType.phone,

                                // ✅ Top wale ki tarah sirf digits allow kiye aur max length 10 kar di
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(14),
                                ] ,


                                onChanged: (value) {

                                  if (value.isNotEmpty &&
                                      !value.startsWith("+91 ")) {
                                    mobileController.text =
                                        "+91 " + value;
                                    mobileController.selection =
                                        TextSelection.fromPosition(
                                          TextPosition(
                                              offset:
                                              mobileController
                                                  .text.length),
                                        );
                                  }
                                  if (value == "+91 ") {
                                    mobileController.clear();
                                  }
                                  validateInput(value) ;// Tumhara validation function call
                                },
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: MediaQuery.of(context).size.height * 0.016,
                                  fontWeight: FontWeight.w500,
                                ),
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
                                  suffixIcon: mobileController
                                      .text.isNotEmpty && mobileController.text.length == 14
                                      ? Icon(Icons.check_circle,
                                      color: Colors.green)
                                      : null,

                                  // ✅ Top wale ka clean Grey Border aur 8 Border Radius

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Color(0xFFF1F1F1), )

                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(color: Color(0xFFF1F1F1), )

                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(color: Color(0xFFF1F1F1), )

                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(color: Color(0xFFF1F1F1), )

                                  ),
                                ),
                              ),
                            ),

                            // ✅ Tumhara niche wala Error Message structure with Icon
                            if (errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.error, color: Colors.red, size: MediaQuery.of(context).size.height * 0.015),
                                    const SizedBox(width: 4),
                                    Text(
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

                      SizedBox(height: screenHeight * 0.05),

                      // Next button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                        child: GestureDetector(
                          onTap: _isNextButtonEnabled ? checkMobileAndProceed : null,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: _isNextButtonEnabled
                                  ? const Color(0xFF126086)
                                  : const Color(0xFFBDBDBD),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.06),
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
