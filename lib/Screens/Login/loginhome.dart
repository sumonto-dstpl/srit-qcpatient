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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Spacer(flex: 1),
            // Logo Image
            Container(
              padding: EdgeInsets.only(
                top : screenHeight * 0.08,
              ) ,
              child: Container(
                // alignment: Alignment.centerRight,

                child: Image.asset(
                  'assets/splashqc.png', // Replace with your image asset
                  height: screenHeight * 0.05,
                  width: screenHeight * 0.3,

                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.035,),
            // Onboarding Image
            Container(

              child: Center(
                child: Image.asset(
                  'assets/onboarding0.png', // Replace with your image asset
                  height: screenHeight * 0.45,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Text
            Container(

              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
                decoration: BoxDecoration(
                  color:
                      Colors.white,


                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0), // Top-left curve
                    topRight: Radius.circular(20.0), // Top-right curve
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.3), // Shadow color with opacity
                      offset: Offset(0, -4), // Offset to place the shadow above
                      blurRadius: 10.0, // Blur radius for soft shadow
                      spreadRadius:
                          2.0, // Spread radius to make shadow appear more prominent
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top : screenHeight * 0.03,
                      ),
                      child: Text(
                        "Let's get started!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.022,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F1F1F),
                          fontFamily: "Inter"
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.09,
                        right: MediaQuery.of(context).size.height * 0.09,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                      ),
                      color: Colors.white,
                      child: Text(
                        "Log in to enjoy the features we've provided and be well!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.0145,
                          color: Color(0xFF6A6E83),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
            // SizedBox(height: screenHeight * 0.035,),
            // Buttons Section
            Container(

              child: Container(
                color: Colors.white,  // Set the background color to white
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Login Button
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return LoginPage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                          ),
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.02,
                            top: MediaQuery.of(context).size.height * 0.03,
                            bottom: MediaQuery.of(context).size.height * 0.005,
                            left: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.012,
                                    ),
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
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                    top : screenHeight * 0.0,
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return LoginPage();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenHeight * 0.017,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:  "Inter",

                                      ),
                                    ),

                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0), // ← Adjust this
                                      minimumSize: Size(0, 0), // Removes minimum button constraints
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap padding
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Registered Patient Button
                      GestureDetector(
                        onTap: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return LoginUHIDPage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                          ),
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.02,
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.height * 0.02,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF126086), // Border color
                              width: 1, // Border width
                            ),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.012,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: 0.0),
                                  child: TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return LoginUHIDPage();
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Registered Patient",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF126086),
                                        fontSize: screenHeight * 0.016,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:  "Inter",

                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0), // ← Adjust this
                                      minimumSize: Size(0, 0), // Removes minimum button constraints
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap padding
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Continue as Guest Text
                      GestureDetector(
                        onTap:  () async {
                          print("coming from guest");

                          await UserSecureStorage.setIfGuestLogged("YES");

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => HomePageMain()),
                                  (Route<dynamic> route) => false);
                        },
                        child: Padding(
                          padding:  EdgeInsets.only(
                            top : screenHeight  * 0.02,
                          ),
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
                                  fontFamily: "Inter"
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 0.7,
                                    width: screenHeight * 0.15, // Adjust width as needed
                                    color: Color(0xFF126086),
                                  ),
                                ),
                            ]
                          ),
                        ),
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
