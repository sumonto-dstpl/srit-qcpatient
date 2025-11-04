

import 'dart:convert';

// import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Settings/mpinmain.dart';
import 'package:newfolder/Data/biometric_service.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';



class AccessScreen extends StatefulWidget {
  const AccessScreen({
    super.key,
  });
  @override
  State<AccessScreen> createState() => AccessScreenState();
}

class AccessScreenState extends State<AccessScreen> {


  ConnectivityService connectivityservice = ConnectivityService();


  bool isFingerprintEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricStatus();
  }

  Future<void> _loadBiometricStatus() async {
    bool enabled = await BiometricService.isBiometricEnabled();
    setState(() {
      isFingerprintEnabled = enabled;
    });
  }


  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // image: AssetImage("assets/patternbackground.png"),
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
           SizedBox(height: screenHeight * 0.1,),

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
                    Expanded(
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

                            // MPIN Text
                            Container(
                              padding: EdgeInsets.only(
                                top : screenHeight * 0.04,
                              ),
                              child: Text(
                                "Access your account Securely",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: screenHeight * 0.025,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1F1F1F),
                                    fontFamily: "Inter"
                                ),
                              ),
                            ),

                            // Description
                            Container(
                              padding: EdgeInsets.only(
                                top : screenHeight * 0.015,
                                left : screenHeight * 0.08,
                                right : screenHeight * 0.08,
                              ),
                              child: Text(
                                "To protect your data you can only access the app when it’s unlocked",
                                style: TextStyle(
                                  height: 1.8,
                                  fontSize: screenHeight * 0.012,
                                  color: Color(0xFF6A6E83),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.05,),
                    // Image Section with Flex
                    Expanded(
                        flex: 1,

                        // Adjust flex value as needed
                      child: Center(
                        child: Image.asset(
                          'assets/mpinbiometry.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),



                    // Buttons Section
                    Expanded(
                        flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(

                          bottom: screenHeight * 0.03,
                        ),
                        color: Colors.white, // Set the background color to white
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Unlock with Biometrics
                              Opacity(
                                opacity: isFingerprintEnabled ? 1.0 : 0.5, // dim when disabled
                                child: IgnorePointer(
                                  ignoring: !isFingerprintEnabled, // block touch when disabled
                                  child: GestureDetector(
                                    onTap: () async {
                                      // Optional: additional onTap logic if needed
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
                                        right: MediaQuery.of(context).size.height * 0.0,
                                        top: MediaQuery.of(context).size.height * 0.01,
                                        bottom: MediaQuery.of(context).size.height * 0.01,
                                        left: MediaQuery.of(context).size.height * 0.0,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 0.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                  MediaQuery.of(context).size.height * 0.012,
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
                                              child: TextButton(
                                                onPressed: () async {
                                                  bool success = await BiometricService.authenticateUser(context);

                                                  if (success) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text("Biometric unlock successful")),
                                                    );

                                                    // ✅ Set user session or mark login status
                                                    await UserSecureStorage.setIfLogged("YES");
                                                    // await UserSecureStorage.setUsernameid(mobileNumber);

                                                    // ✅ Navigate to HomePageMain and clear all previous routes
                                                    Navigator.of(context).pushAndRemoveUntil(
                                                      MaterialPageRoute(builder: (context) => HomePageMain()),
                                                          (Route<dynamic> route) => false,
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text("Authentication failed")),
                                                    );
                                                  }
                                                },

                                                style: ButtonStyle(
                                                  padding: MaterialStateProperty.all(
                                                      EdgeInsets.symmetric(vertical: 11.0)),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  minimumSize: MaterialStateProperty.all(Size.zero),
                                                  alignment: Alignment.center,
                                                  backgroundColor:
                                                  MaterialStateProperty.all(Colors.transparent),
                                                  overlayColor:
                                                  MaterialStateProperty.all(Colors.transparent),
                                                ),
                                                child: Text(
                                                  "Unlock with Biometrics",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                    MediaQuery.of(context).size.height * 0.018,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // GestureDetector(
                              //   onTap: () async {
                              //
                              //   },
                              //   child: Container(
                              //     alignment: Alignment.centerRight,
                              //     padding: EdgeInsets.only(
                              //       top: MediaQuery.of(context).size.height * 0.01,
                              //       bottom: MediaQuery.of(context).size.height * 0.00,
                              //       left: MediaQuery.of(context).size.height * 0.00,
                              //       right: MediaQuery.of(context).size.height * 0.00,
                              //     ),
                              //     margin: EdgeInsets.only(
                              //       right: MediaQuery.of(context).size.height * 0.0,
                              //       top: MediaQuery.of(context).size.height * 0.01,
                              //       bottom: MediaQuery.of(context).size.height * 0.01,
                              //       left: MediaQuery.of(context).size.height * 0.0,
                              //     ),
                              //     child: Row(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: <Widget>[
                              //         Expanded(
                              //
                              //           child: Container(
                              //             padding:  EdgeInsets.symmetric( vertical: 0.0),
                              //             decoration: BoxDecoration(
                              //
                              //               borderRadius: BorderRadius.circular(
                              //                 MediaQuery.of(context).size.height *
                              //                     0.012,
                              //               ),
                              //               gradient: LinearGradient(
                              //                 begin: Alignment.centerRight,
                              //                 end: Alignment.center,
                              //                 stops: [0.5, 0.9],
                              //                 colors: [
                              //                   Color(0xFF126086),
                              //                   Color(0xFF126086),
                              //                 ],
                              //               ),
                              //             ),
                              //             alignment: Alignment.center,
                              //
                              //             child: TextButton(
                              //               onPressed: () async {
                              //
                              //               },
                              //               style: ButtonStyle(
                              //                 padding: MaterialStateProperty.all(EdgeInsets.symmetric( vertical: 11.0)), // 🔽 Minimal padding
                              //                 tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 🔽 Removes extra space from Material
                              //                 minimumSize: MaterialStateProperty.all(Size.zero), // 🔽 No min size
                              //                 alignment: Alignment.center, // 🔽 Center text properly
                              //                 backgroundColor: MaterialStateProperty.all(Colors.transparent), // Optional
                              //                 overlayColor: MaterialStateProperty.all(Colors.transparent), // Optional
                              //               ),
                              //               child: Text(
                              //                 "Unlock with Biometrics",
                              //                 textAlign: TextAlign.center,
                              //                 style: TextStyle(
                              //                   color: Colors.white,
                              //                   fontSize:
                              //                   MediaQuery.of(context).size.height *
                              //                       0.018,
                              //                   fontWeight: FontWeight.w700
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              // Unlock with mPIN
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return MpinAccessScreen();
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
                                    right: MediaQuery.of(context).size.height * 0.0,
                                    top: MediaQuery.of(context).size.height * 0.00,
                                    bottom: MediaQuery.of(context).size.height * 0.01,
                                    left: MediaQuery.of(context).size.height * 0.0,
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
                                          padding:  EdgeInsets.symmetric( vertical: 0.0),
                                          child: TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) {
                                                    return MpinAccessScreen();
                                                  },
                                                ),
                                              );
                                            },
                                            // style: TextButton.styleFrom(
                                            //   padding: EdgeInsets.zero, // Important to remove default button padding
                                            // ),
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all(EdgeInsets.symmetric( vertical: 9.0)), // 🔽 Minimal padding
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 🔽 Removes extra space from Material
                                              minimumSize: MaterialStateProperty.all(Size.zero), // 🔽 No min size
                                              alignment: Alignment.center, // 🔽 Center text properly
                                              backgroundColor: MaterialStateProperty.all(Colors.transparent), // Optional
                                              overlayColor: MaterialStateProperty.all(Colors.transparent), // Optional
                                            ),
                                             child: Text(
                                              "Unlock with mPIN",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF126086),
                                                fontSize:
                                                MediaQuery.of(context).size.height *
                                                    0.018,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
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
