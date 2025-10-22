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
  }

  Future<void> checkMobileAndProceed() async {
    String input = mobileController.text.trim();
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
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                        child: TextField(
                          controller: mobileController,
                          focusNode: focusMobile,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 10,
                          onChanged: validateInput,
                          decoration: InputDecoration(
                            hintText: "Enter your Mobile Number",
                            counterText: "",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),

                      if (errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.01),
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.015),
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
