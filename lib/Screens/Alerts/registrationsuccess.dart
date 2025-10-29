import 'package:flutter/material.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'dart:ui';

import 'package:newfolder/Screens/Login/loginpage.dart';
import 'package:newfolder/Screens/Login/loginuhidpage.dart';

import '../Utils/user_secure_storage.dart';

class RegistrationSuccessModel {
  showModel(BuildContext context) async {
    await Future.delayed(Duration(microseconds: 1));

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    showGeneralDialog(
      barrierLabel: "RegistrationSuccessDialog",
      barrierDismissible: false,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: GestureDetector(
            onTap: () {},
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent tap-through
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.all(screenHeight * 0.015),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: screenHeight * 0.5,
                        maxWidth: screenWidth * 0.95,
                      ),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5.0,
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: screenHeight * 0.02),

                            // ✅ Success Image
                            Image.asset(
                              'assets/Success_Message_Pop_Up.png', // Replace with your image
                              height: screenHeight * 0.12,
                              fit: BoxFit.contain,
                            ),

                            SizedBox(height: screenHeight * 0.02),

                            // ✅ Congratulations Text
                            Text(
                              "Congratulations 🎉",
                              style: TextStyle(
                                color: Color(0xFF126086),
                                fontSize: 20, // px
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: screenHeight * 0.01),

                            // ✅ Description Text
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                              child: Text(
                                "Your Account has been Created Successfully",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.40),
                                  fontSize: 14, // px
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.035),

                            // ✅ Back to Home Button
                            GestureDetector(
                              onTap: () async{

                                // String? username = await UserSecureStorage.getUsernameid();
                                // Map<String, dynamic>? user = await UserSecureStorage.getUser(username!);
                                // // usernameValue +=  isGuestUser ? "Guest01": user?['data']['fname']+" "+user?['data']['lname'];
                                // print("usernameUHID :$username");
                                // print("user: ${user?['data']}");
                                // Future.delayed(Duration(milliseconds: 1000), () {
                                //
                                // });
                                // if (RegExp(r'^[0-9]{10}$').hasMatch(username!)) {
                                //   Navigator.of(context).pop();
                                //   // Navigator.of(context).pop();// Close the modal
                                //   Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //       builder: (BuildContext context) {
                                //         return LoginPage(); // Replace with your Login page widget
                                //       },
                                //     ),
                                //   ); // Adjust your home route
                                // }
                                // else
                                //   {
                                //     Navigator.of(context).pop();
                                //     Navigator.of(context).pop();// Close the modal
                                //     // Navigator.of(context).push(
                                //     //   MaterialPageRoute(
                                //     //     builder: (BuildContext context) {
                                //     //       return LoginUHIDPage(); // Replace with your Login page widget
                                //     //     },
                                //     //   ),
                                //     // );
                                //   }

                                Navigator.of(context, rootNavigator: true).pop();

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => HomePageMain()),
                                        (Route<dynamic> route) => false);
                              },
                              child: Container(
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFF126086),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Back to Home",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );


    await Future.delayed(Duration(seconds: 1));


    Navigator.of(context, rootNavigator: true).pop();


      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePageMain()),
          (Route<dynamic> route) => false);
  }
}
