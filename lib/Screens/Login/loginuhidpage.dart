import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class LoginUHIDPage extends StatefulWidget {
  const LoginUHIDPage({
    super.key,
  });
  @override
  State<LoginUHIDPage> createState() => LoginuhidPagestate();
}

class LoginuhidPagestate extends State<LoginUHIDPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController UserNumberEditTextController =
        TextEditingController();
    TextEditingController PasswordEditTextController = TextEditingController();
    bool hidePassword = true;
    return Scaffold(
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

                    onTap :() => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginHome()),),

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
                child: Column(
                  children: [
                    // Scrollable Main Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(screenHeight * 0.03),
                        child: Column(
                          children: [
                            // Logo Image
                            Container(
                              margin: EdgeInsets.only(top: screenHeight * 0.03),
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
                                        right: MediaQuery.of(context).size.height *
                                            0.0,
                                        top: MediaQuery.of(context).size.height *
                                            0.005,
                                        bottom: MediaQuery.of(context).size.height *
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
                                        right: MediaQuery.of(context).size.height *
                                            0.0,
                                        bottom: MediaQuery.of(context).size.height *
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
                            SizedBox(height: screenHeight * 0.02),

                            // UHID Text
                            Padding(
                              padding: new EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.005,
                                  right: MediaQuery.of(context).size.height * 0.0,
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
                            // UHID field
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.005,
                                right: MediaQuery.of(context).size.height * 0.005,
                                bottom: MediaQuery.of(context).size.height * 0.005,
                              ),
                              child: new TextFormField(
                                controller: UserNumberEditTextController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(15),
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-zA-Z0-9]'))
                                ],
                                textCapitalization:
                                    TextCapitalization.characters,
                                style: TextStyle(color: Colors.black45,fontSize: MediaQuery.of(context).size.height * 0.016,
                                            fontWeight: FontWeight.w500,),
                                keyboardType: TextInputType.emailAddress,
                                // onSaved: (input) => loginRequestModel.email = input,
                                validator: (input) => input!.length < 3
                                    ? "UHID should be more than 3 characters"
                                    : null,
                                /* validator: (input) => !input.contains('@')
                              ? "Email Id should be valid"
                              : null,*/
                            //     decoration: new InputDecoration(
                            //       isDense: true,
                            //       contentPadding: EdgeInsets.fromLTRB(
                            //         MediaQuery.of(context).size.height * 0.02,
                            //         MediaQuery.of(context).size.height * 0.012,
                            //         MediaQuery.of(context).size.height * 0.012,
                            //         MediaQuery.of(context).size.height * 0.012,
                            //       ),
                            //       filled: true,
                            //       fillColor: Colors.white60,
                            //       hintText: "Enter your UHID",
                            //       hintStyle: TextStyle(
                            //         color: Colors.black26,
                            //         fontSize:
                            //             MediaQuery.of(context).size.height *
                            //                 0.016, // Adjust this size
                            //       ),
                            //       /* // below code for rectangular box even without touching
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(5.0),
                            // ),
                            // // below code only for underline with custom color
                            // focusedBorder: UnderlineInputBorder(
                            //     borderSide: BorderSide(
                            //         color: Theme.of(context).accentColor)),
                            //                                                */
                            //       focusedBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(5.0),
                            //         borderSide:
                            //             BorderSide(color: Colors.lightBlue),
                            //       ),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(5.0)),
                            //         borderSide: BorderSide(color: Colors.grey),
                            //       ),
                            //       /*  prefixIcon: Icon(
                            //     Icons.account_circle_sharp,
                            //     color: Colors.black45,
                            //   ),*/
                            //     ),
                                decoration: InputDecoration(
                                  isDense: true,
                                   contentPadding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context).size.height * 0.02,
                                              vertical: MediaQuery.of(context).size.height * 0.012,
                                            ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Enter the UHID",
                                  hintStyle: TextStyle(
                                      color: Color(0x4D111111),
                                      fontSize: MediaQuery.of(context).size.height * 0.012,
                                      fontWeight: FontWeight.w400
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F1F1),  // Initially grey, turns red or green
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      color:Color(0xFFF1F1F1), // Initially grey, turns red or green
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
                            ),
                            // OTP text
                            Padding(
                              padding: new EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.005,
                                  right: MediaQuery.of(context).size.height * 0.0,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.008),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "OTP",
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

                            // OTP field
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.005,
                                right: MediaQuery.of(context).size.height * 0.005,
                                bottom: MediaQuery.of(context).size.height * 0.005,
                              ),
                              child: new TextFormField(
                                controller: PasswordEditTextController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(15),
                                ],
                                style: TextStyle(color: Colors.black45,fontSize: MediaQuery.of(context).size.height * 0.016,
                                            fontWeight: FontWeight.w500,),
                                keyboardType: TextInputType.text,
                                /* onSaved: (input) => loginRequestModel.password =
                          base64.encode(utf8.encode(input)),*/
                                validator: (input) => input!.length < 3
                                    ? "OTP should be more than 3 characters"
                                    : null,
                                obscureText: hidePassword,
                                decoration: InputDecoration(
                                  isDense: true,
                                   contentPadding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context).size.height * 0.02,
                                              vertical: MediaQuery.of(context).size.height * 0.012,
                                            ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Enter the OTP",
                                  hintStyle: TextStyle(
                                      color: Color(0x4D111111),
                                      fontSize: MediaQuery.of(context).size.height * 0.012,
                                      fontWeight: FontWeight.w400
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color:Color(0xFFF1F1F1),  // Initially grey, turns red or green
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F1F1), // Initially grey, turns red or green
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
                            ),

                            // Didn't get OTP text
                            Padding(
                              padding: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.005,
                                      top: MediaQuery.of(context).size.height *
                                          0.005,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Add your onTap logic here
                                      },
                                      child: TextButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(EdgeInsets.zero),
                                          minimumSize: MaterialStateProperty
                                              .all<Size>(Size
                                                  .zero), // Ensures no extra space
                                          tapTargetSize: MaterialTapTargetSize
                                              .shrinkWrap, // Shrinks the tap area
                                        ),
                                        onPressed: () {},
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
                                                text: 'Didn\'t get OTP?',
                                                style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: MediaQuery.of(context).size.height * 0.011,
                                                    fontFamily: "Inter"

                                                ),
                                              ),
                                              TextSpan(
                                                text: ' Resend OTP',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: MediaQuery.of(context).size.height * 0.013,
                                                  color: Color(0xFF126086),
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Login Button
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Login Button
                                  Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height *
                                            0.02,
                                        bottom:
                                        MediaQuery.of(context).size.height *
                                            0.00,
                                        left: MediaQuery.of(context).size.height *
                                            0.00,
                                        right:
                                        MediaQuery.of(context).size.height *
                                            0.00
                                    ),
                                    margin: EdgeInsets.only(
                                        right:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                        top: MediaQuery.of(context).size.height *
                                            0.01,
                                        bottom:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                        left:
                                        MediaQuery.of(context).size.height *
                                            0.01),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012),
                                              gradient: const LinearGradient(
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
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),  // Remove default button padding
                                                minimumSize: Size(0, 0), // Allow smallest possible size
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap area
                                              ),
                                              onPressed: () async {},
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // "Don't have an account?" section
                    // Padding(
                    //   padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                    //   child: TextButton(
                    //     onPressed: () {
                    //       // Handle sign-up navigation
                    //     },
                    //     child: RichText(
                    //       text: TextSpan(
                    //         style: TextStyle(
                    //           fontSize: screenHeight * 0.02,
                    //         ),
                    //         children: [
                    //           TextSpan(
                    //             text: 'Don\'t have an account? ',
                    //             style: TextStyle(
                    //               color: Colors.black54,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           TextSpan(
                    //             text: 'Sign Up',
                    //             style: TextStyle(
                    //               color: Color(0xFF126086),
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //             recognizer: TapGestureRecognizer()
                    //               ..onTap = () {
                    //                 // Add your navigation logic here
                    //                 Navigator.of(context).push(
                    //                   MaterialPageRoute(
                    //                     builder: (BuildContext context) {
                    //                       return Registration(); // Replace with your screen
                    //                     },
                    //                   ),
                    //                 );
                    //               },
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                        top : MediaQuery.of(context).size.height * 0.035,
                        left: MediaQuery.of(context).size.height * 0.0,
                        right: MediaQuery.of(context).size.height * 0.0,
                        bottom: MediaQuery.of(context).size.height * 0.0,
                      ),
                      child: TextButton(
                        onPressed: () {
                          // This can remain empty or add any general button logic here
                        },
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.titleLarge!.merge(
                              TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            children: [
                              TextSpan(
                                text: 'Don\'t have an account ?',
                                style: TextStyle(
                                    color: Color(0xFF1F1F1F),
                                    fontWeight: FontWeight.w400,
                                    fontSize: MediaQuery.of(context).size.height * 0.011,
                                    fontFamily: "Inter"

                                ),
                              ),
                              TextSpan(
                                text: ' Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.height * 0.014,
                                  color: Color(0xFF126086),
                                  fontFamily: "Inter",
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Add your navigation logic here
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return Registration(); // Replace with your screen
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
