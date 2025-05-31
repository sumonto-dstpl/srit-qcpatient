import 'package:flutter/material.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Login/loginpage.dart';
import 'package:newfolder/Screens/Login/loginuhidpage.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';

class LoginHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MediaQuery( // ⛔️ Override system font scaling
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo Image
                Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.08),
                  child: Image.asset(
                    'assets/splashqc.png',
                    height: screenHeight * 0.05,
                    width: screenHeight * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
                // Onboarding Image
                Center(
                  child: Image.asset(
                    'assets/onboarding0.png',
                    height: screenHeight * 0.45,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text Container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, -4),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.03),
                        child: Text(
                          "Let's get started!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenHeight * 0.022,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F1F1F),
                            fontFamily: "Inter",
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.09),
                        child: Text(
                          "Log in to enjoy the features we've provided and be well!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenHeight * 0.0145,
                            color: Color(0xFF6A6E83),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Buttons Section
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      children: [
                        // Login Button
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              left: screenHeight * 0.02,
                              right: screenHeight * 0.02,
                              top: screenHeight * 0.02,
                              bottom: screenHeight * 0.008,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(screenHeight * 0.012),
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.center,
                                  stops: [0.5, 0.9],
                                  colors: [
                                    Color(0xFF126086),
                                    Color(0xFF126086),
                                  ],
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                                },
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight * 0.017,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 130.0),
                                  minimumSize: Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Registered Patient Button
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginUHIDPage(),
                            ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              left: screenHeight * 0.02,
                              right: screenHeight * 0.02,
                              top: screenHeight * 0.008,
                              bottom: screenHeight * 0.01,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF126086), width: 1),
                              borderRadius: BorderRadius.circular(screenHeight * 0.012),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginUHIDPage(),
                                ));
                              },
                              child: Text(
                                "Registered Patient",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontSize: screenHeight * 0.016,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Inter",
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ),
                        ),
                        // Continue as Guest
                        GestureDetector(
                          onTap: () async {
                            print("coming from guest");
                            await UserSecureStorage.setIfGuestLogged("YES");
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => HomePageMain()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.02),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 1.0),
                                  child: Text(
                                    "Continue as Guest",
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.012,
                                      color: Color(0xFF126086),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 0.7,
                                    width: screenHeight * 0.15,
                                    color: Color(0xFF126086),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


