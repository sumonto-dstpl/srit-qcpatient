

// import 'dart:convert';
//
// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:newfolder/Screens/Alerts/passsuccesssendback.dart';
// import 'package:newfolder/Screens/Settings/mpinmainsub.dart';
// import 'package:newfolder/Screens/Settings/sucesschangenum.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Utils/auth_service.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
// import 'package:progress_dialog2/progress_dialog2.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class MpinMainSettings extends StatefulWidget {
//   const MpinMainSettings({
//     super.key,
//   });
//   @override
//   State<MpinMainSettings> createState() => MpinMainSettingsstate();
// }
//
// class MpinMainSettingsstate extends State<MpinMainSettings> {
//
//
//   ConnectivityService connectivityservice = ConnectivityService();
//   APIService apiService = new APIService();
//   late ProgressDialog progressDialog;
//
//
//   @override
//   Widget build(BuildContext context) {
//     progressDialog = ProgressDialog(context,
//         type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
//     progressDialog.style(
//         message: 'Loading..' '\nPlease Wait',
//         borderRadius: 10.0,
//         backgroundColor: Colors.white,
//         progressWidget: CircularProgressIndicator(
//           color: Colors.blueAccent,
//           strokeWidth: MediaQuery.of(context).size.height * 0.002,
//         ),
//         elevation: 10.0,
//         insetAnimCurve: Curves.easeInOut,
//         progress: 0.0,
//         maxProgress: 100.0,
//         progressTextStyle: TextStyle(
//           color: Colors.blueAccent,
//           fontSize: 13.0,
//         ),
//         messageTextStyle: TextStyle(
//             color: Colors.black,
//             fontSize: MediaQuery.of(context).size.height * 0.018,
//             fontWeight: FontWeight.w600));
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/patternbackground.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: <Widget>[
//             // Top Section with Back Arrow and Login Text
//             Container(
//               padding: EdgeInsets.only(
//                 top: screenHeight * 0.05,
//                 left: screenWidth * 0.05,
//                 right: screenWidth * 0.05,
//                 bottom: screenWidth * 0.05,
//               ),
//               margin: EdgeInsets.only(
//                 right: screenHeight * 0.01,
//                 top: screenHeight * 0.02,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // Back Arrow
//                   InkWell(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       height: screenHeight * 0.035,
//                       width: screenHeight * 0.035,
//                       decoration: BoxDecoration(
//                         color: Color(0xFF126086).withOpacity(0.2),
//                         shape: BoxShape.circle,
//                         border: Border.all(width: 0.0, color: Color(0xFF126086)),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(130.0),
//                         child: Image.asset(
//                           'assets/medicationBack.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Expanded(
//                     child: Center(
//                       child: Text(
//                         "MPIN",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: screenHeight * 0.026,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(width: screenHeight * 0.05),
//                 ],
//               ),
//             ),
//
//             // Main Content Section
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(screenHeight * 0.03),
//                     topRight: Radius.circular(screenHeight * 0.03),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             // Logo Image
//                             Container(
//                               margin: EdgeInsets.only(top: screenHeight * 0.03),
//                               child: Image.asset(
//                                 'assets/splashqc.png',
//                                 height: screenHeight * 0.06,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//
//                             Text(
//                               "Access your account Securely",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: screenHeight * 0.028,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: screenHeight * 0.1,
//                               ),
//                               child: Text(
//                                 "To protect your data you can only access the app when it’s unlocked",
//                                 style: TextStyle(
//                                   fontSize: screenHeight * 0.014,
//                                   color: Color(0xFF6A6E83),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     // Image Section with Flex
//                     Expanded(
//                       flex: 1, // Adjust flex value as needed
//                       child: Center(
//                         child: Image.asset(
//                           'assets/mpinbiometry.png',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//
//
//
//                     // Buttons Section
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         color: Colors.white, // Set the background color to white
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               // Unlock with Biometrics
//                               GestureDetector(
//                                 onTap: () async {
//
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.centerRight,
//                                   padding: EdgeInsets.only(
//                                     top: MediaQuery.of(context).size.height * 0.01,
//                                     bottom: MediaQuery.of(context).size.height * 0.00,
//                                     left: MediaQuery.of(context).size.height * 0.00,
//                                     right: MediaQuery.of(context).size.height * 0.00,
//                                   ),
//                                   margin: EdgeInsets.only(
//                                     right: MediaQuery.of(context).size.height * 0.0,
//                                     top: MediaQuery.of(context).size.height * 0.01,
//                                     bottom: MediaQuery.of(context).size.height * 0.01,
//                                     left: MediaQuery.of(context).size.height * 0.0,
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               MediaQuery.of(context).size.height *
//                                                   0.012,
//                                             ),
//                                             gradient: LinearGradient(
//                                               begin: Alignment.centerRight,
//                                               end: Alignment.center,
//                                               stops: [0.5, 0.9],
//                                               colors: [
//                                                 Color(0xFF126086),
//                                                 Color(0xFF126086),
//                                               ],
//                                             ),
//                                           ),
//                                           alignment: Alignment.center,
//                                           padding: EdgeInsets.only(left: 0.0),
//                                           child: TextButton(
//                                             onPressed: () async {
//
//                                             },
//                                             child: Text(
//                                               "Unlock with Biometrics",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize:
//                                                 MediaQuery.of(context).size.height *
//                                                     0.02,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//                               // Unlock with mPIN
//                               GestureDetector(
//                                 onTap: () async {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (BuildContext context) {
//                                         return MpinSubSettings();
//                                       },
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   alignment: Alignment.centerRight,
//                                   padding: EdgeInsets.only(
//                                     top: MediaQuery.of(context).size.height * 0.0,
//                                     bottom: MediaQuery.of(context).size.height * 0.00,
//                                     left: MediaQuery.of(context).size.height * 0.00,
//                                     right: MediaQuery.of(context).size.height * 0.00,
//                                   ),
//                                   margin: EdgeInsets.only(
//                                     right: MediaQuery.of(context).size.height * 0.0,
//                                     top: MediaQuery.of(context).size.height * 0.00,
//                                     bottom: MediaQuery.of(context).size.height * 0.01,
//                                     left: MediaQuery.of(context).size.height * 0.0,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: Color(0xFF126086), // Border color
//                                       width: 1, // Border width
//                                     ),
//                                     borderRadius: BorderRadius.circular(
//                                       MediaQuery.of(context).size.height * 0.012,
//                                     ),
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           padding: EdgeInsets.only(left: 0.0),
//                                           child: TextButton(
//                                             onPressed: () async {
//                                               Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                   builder: (BuildContext context) {
//                                                     return MpinSubSettings();
//                                                   },
//                                                 ),
//                                               );
//                                             },
//                                             child: Text(
//                                               "Unlock with mPIN",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: Color(0xFF126086),
//                                                 fontSize:
//                                                 MediaQuery.of(context).size.height *
//                                                     0.02,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//
//
//
//
//                   ],
//                 ),
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//
//
//   }
//
//
//
// }



import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';



class MpinAccessScreen extends StatefulWidget {
  // const MpinAccessScreen({
  //   super.key,
  // });
  final String? mobileNumber; // Optional number
  const MpinAccessScreen({Key? key, this.mobileNumber}) : super(key: key);
  @override
  State<MpinAccessScreen> createState() => MpinAccessScreenState();
}

class MpinAccessScreenState extends State<MpinAccessScreen> {
  late final bool hasMobileNumber;
  late final String mobileNumber;

  ConnectivityService connectivityservice = ConnectivityService();


  TextEditingController Otp1stdigitTextController = TextEditingController();
  TextEditingController Otp2nddigitTextController = TextEditingController();
  TextEditingController Otp3rddigitTextController = TextEditingController();
  TextEditingController Otp4thdigitTextController = TextEditingController();


  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;


  bool Otp1stdigithasStartedTyping = false;
  bool Otp2nddigithasStartedTyping = false;
  bool Otp3rddigithasStartedTyping = false;
  bool Otp4thdigithasStartedTyping = false;

  String? digitMpinMessage ;

  @override
  void initState() {

    super.initState();
    hasMobileNumber = widget.mobileNumber != null && widget.mobileNumber!.isNotEmpty;
    if (hasMobileNumber) {
      mobileNumber = widget.mobileNumber!;
    }
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();

  }


  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  final rawFocus1 = FocusNode();
  final rawFocus2 = FocusNode();
  final rawFocus3 = FocusNode();
  final rawFocus4 = FocusNode();

  final rawFocusv1 = FocusNode();
  final rawFocusv2 = FocusNode();
  final rawFocusv3 = FocusNode();
  final rawFocusv4 = FocusNode();

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
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await Future.delayed(Duration(milliseconds: 150));
                      Navigator.pop(context);
                    },
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
                        "MPIN",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  // Placeholder for alignment (Empty container for symmetry)
                  SizedBox(width: screenHeight * 0.03),
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
                  physics: NeverScrollableScrollPhysics(),
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


                      // Image
                      Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.01),
                        child: Image.asset(
                          'assets/mpinsubscreen.png',
                          height: screenHeight * 0.18,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Text
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: 0,
                            top: MediaQuery.of(context).size.height * 0.02,
                            bottom: MediaQuery.of(context).size.height * 0.00),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Enter MPIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.022,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1F1F1F),
                                    fontFamily: "Inter"
                                ),
                              ),

                            ]),
                      ),






                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00),
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.02,
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.24,
                            left: MediaQuery.of(context).size.height * 0.02),
                        child: Column(children: [

                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right: 0,
                                top: MediaQuery.of(context).size.height * 0.0,
                                bottom: MediaQuery.of(context).size.height * 0.010),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Enter your four digit MPIN",
                                    style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height * 0.012,
                                        color: Color(0xFF6A6E83),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Inter"
                                    ),
                                    textAlign: TextAlign.start,
                                  ),

                                ]),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              left: MediaQuery.of(context).size.height * 0.1,
                              right: MediaQuery.of(context).size.height * 0.1,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RawKeyboardListener(
                                  focusNode: rawFocus1, // Use a dedicated focus node for RawKeyboardListener
                                  onKey: (RawKeyEvent event) {
                                    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                      if (Otp1stdigitTextController.text.isEmpty) {
                                        // Move to previous field and clear it
                                        pin1FocusNode!.requestFocus();
                                        Otp1stdigitTextController.clear();
                                      } else {
                                        // Just clear this field
                                        Otp1stdigitTextController.clear();
                                      }
                                      setState(() {
                                        Otp1stdigithasStartedTyping = false;
                                      });
                                    }
                                  },
                                  child: SizedBox(
                                    width: SizeConfig.blockSizeHorizontal! * 09,
                                    height: SizeConfig.blockSizeHorizontal! * 12,
                                    child: TextFormField(
                                      focusNode: pin1FocusNode,
                                      obscureText: true,
                                      obscuringCharacter: '•',
                                      controller: Otp1stdigitTextController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                      ],

                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height * 0.034,
                                        height: 1.0,

                                      ),
                                      cursorHeight: MediaQuery.of(context).size.height * 0.034, // smaller height
                                      cursorWidth: 2.0,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context).size.height * 0.012, // balanced top-bottom padding
                                          horizontal: MediaQuery.of(context).size.height * 0.01,
                                        ),
                                        filled: false, // Remove background color
                                        hintStyle: TextStyle(color: Colors.white70),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                                          borderSide: BorderSide(
                                            color: Otp1stdigithasStartedTyping
                                                ?  Colors.red
                                                : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                                          borderSide: BorderSide(
                                            color: Otp1stdigithasStartedTyping
                                                ?  Colors.red
                                                : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).requestFocus(pin2FocusNode); // move to 2nd field
                                          setState(() {
                                            Otp1stdigithasStartedTyping = false;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),

                                RawKeyboardListener(
                                  focusNode: rawFocus2, // Use a dedicated focus node for RawKeyboardListener
                                  onKey: (RawKeyEvent event) {
                                    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                      if (Otp2nddigitTextController.text.isEmpty) {
                                        // Move to previous field and clear it
                                        pin1FocusNode!.requestFocus();
                                        Otp1stdigitTextController.clear();
                                      } else {
                                        // Just clear this field
                                        Otp2nddigitTextController.clear();
                                      }
                                      setState(() {
                                        Otp2nddigithasStartedTyping = false;
                                      });
                                    }
                                  },
                                  child: SizedBox(
                                    width: SizeConfig.blockSizeHorizontal! * 09,
                                    height: SizeConfig.blockSizeHorizontal! * 12,
                                    child: TextFormField(
                                      focusNode: pin2FocusNode,
                                      obscureText: true,
                                      obscuringCharacter: '•',
                                      controller: Otp2nddigitTextController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                      ],

                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height * 0.034,
                                        height: 1.0,

                                      ),
                                      cursorHeight: MediaQuery.of(context).size.height * 0.034, // smaller height
                                      cursorWidth: 2.0,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context).size.height * 0.012, // balanced top-bottom padding
                                          horizontal: MediaQuery.of(context).size.height * 0.01,
                                        ),
                                        filled: false, // Remove background color
                                        hintStyle: TextStyle(color: Colors.white70),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                                          borderSide: BorderSide(
                                            color: Otp2nddigithasStartedTyping
                                                ?  Colors.red
                                                : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                                          borderSide: BorderSide(
                                            color: Otp2nddigithasStartedTyping
                                                ?  Colors.red
                                                : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).requestFocus(pin3FocusNode); // move to 3rd field
                                          setState(() {
                                            Otp2nddigithasStartedTyping = false;
                                          });
                                          // Then you need to check is the code is correct or not
                                        }
                                      },
                                    ),
                                  ),
                                ),

                                RawKeyboardListener(
                                  focusNode: rawFocus3, // Use a dedicated focus node for RawKeyboardListener
                                  onKey: (RawKeyEvent event) {
                                    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                      if (Otp3rddigitTextController.text.isEmpty) {
                                        // Move to previous field and clear it
                                        pin2FocusNode!.requestFocus();
                                        Otp2nddigitTextController.clear();
                                      } else {
                                        // Just clear this field
                                        Otp3rddigitTextController.clear();
                                      }
                                      setState(() {
                                        Otp3rddigithasStartedTyping = false;
                                      });
                                    }
                                  },
                                  child: SizedBox(
                                    width: SizeConfig.blockSizeHorizontal! * 09,
                                    height: SizeConfig.blockSizeHorizontal! * 12,
                                    child: TextFormField(
                                      focusNode: pin3FocusNode,
                                      obscureText: true,
                                      obscuringCharacter: '•',
                                      controller: Otp3rddigitTextController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                      ],

                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height * 0.034,
                                        height: 1.0,

                                      ),
                                      cursorHeight: MediaQuery.of(context).size.height * 0.034, // smaller height
                                      cursorWidth: 2.0,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context).size.height * 0.012, // balanced top-bottom padding
                                          horizontal: MediaQuery.of(context).size.height * 0.01,
                                        ),
                                        filled: false, // Remove background color
                                        hintStyle: TextStyle(color: Colors.white70),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                                          borderSide: BorderSide(
                                            color: Otp3rddigithasStartedTyping
                                                ?  Colors.red
                                                : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                                          borderSide: BorderSide(
                                            color: Otp3rddigithasStartedTyping
                                                ?  Colors.red
                                                : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).requestFocus(pin4FocusNode); // move to 4th field
                                          setState(() {
                                            Otp3rddigithasStartedTyping = false;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),

                                RawKeyboardListener(
                                  focusNode: rawFocus4, // Use a dedicated focus node for RawKeyboardListener
                                  onKey: (RawKeyEvent event) {
                                    if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                      if (Otp4thdigitTextController.text.isEmpty) {
                                        // Move to previous field and clear it
                                        pin3FocusNode!.requestFocus();
                                        Otp3rddigitTextController.clear();
                                      } else {
                                        // Just clear this field
                                        Otp4thdigitTextController.clear();
                                      }
                                      setState(() {
                                        Otp4thdigithasStartedTyping = false;
                                      });
                                    }
                                  },
                                  child: SizedBox(
                                    width: SizeConfig.blockSizeHorizontal! * 09,
                                    height: SizeConfig.blockSizeHorizontal! * 12,
                                    child: TextFormField(
                                      focusNode: pin4FocusNode,
                                      obscureText: true,
                                      obscuringCharacter: '•',
                                      controller: Otp4thdigitTextController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                      ],

                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height * 0.034,
                                        height: 1.0,

                                      ),
                                      cursorHeight: MediaQuery.of(context).size.height * 0.034, // smaller height
                                      cursorWidth: 2.0,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context).size.height * 0.012, // balanced top-bottom padding
                                          horizontal: MediaQuery.of(context).size.height * 0.01,
                                        ),
                                        filled: false, // Remove background color
                                        hintStyle: TextStyle(color: Colors.white70),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.005),
                                          borderSide: BorderSide(
                                            color: Otp4thdigithasStartedTyping
                                                ?  Colors.red
                                                : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                                          borderSide: BorderSide(
                                            color: Otp4thdigithasStartedTyping
                                                ?  Colors.red
                                                : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          pin4FocusNode!.unfocus(); // Last field, can unfocus
                                          setState(() {
                                            Otp4thdigithasStartedTyping = false;
                                          });
                                          mpinCheck();
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.00,
                                right: 0,
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom: MediaQuery.of(context).size.height * 0.010),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    onPressed : () {
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(builder: (context) => MobileNumberVerificationForMPIN())
                                      // );

                                    },
                                    child: Text(
                                      "Forget MPIN?",
                                      style: TextStyle(
                                        fontSize:
                                        MediaQuery.of(context).size.height * 0.012,
                                        color: Color(0xFF6A6E83),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Inter",
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),

                                ]),
                          ),

                        ]),
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

  void mpinCheck() {
    print( "mpinCheck");
    connectivityservice.checkconnectivity().then((intenet) async {

      if (intenet != null && intenet) {


        String Otp1stdigit =  Otp1stdigitTextController.text;

        if(Otp1stdigit.isEmpty){
          setState(() {
            Otp1stdigithasStartedTyping = true;
            digitMpinMessage = "Please enter 1st Digit Mpin";

          });
          return;
        }
        else {
          setState(() {
            Otp1stdigithasStartedTyping = false;
            digitMpinMessage = null;

          });
        }

        String Otp2nddigit =  Otp2nddigitTextController.text;

        if(Otp2nddigit.isEmpty){
          setState(() {
            Otp2nddigithasStartedTyping = true;
            digitMpinMessage = "Please enter 2nd Digit Mpin";

          });
          return;
        }
        else {
          setState(() {
            Otp2nddigithasStartedTyping = false;
            digitMpinMessage = null;

          });
        }

        String Otp3rddigit =  Otp3rddigitTextController.text;

        if(Otp3rddigit.isEmpty){
          setState(() {
            Otp3rddigithasStartedTyping = true;
            digitMpinMessage = "Please enter 3rd Digit Mpin";

          });
          return;
        }
        else {
          setState(() {
            Otp3rddigithasStartedTyping = false;
            digitMpinMessage = null;

          });
        }

        String Otp4thdigit =  Otp4thdigitTextController.text;

        if(Otp4thdigit.isEmpty){
          setState(() {
            Otp4thdigithasStartedTyping = true;
            digitMpinMessage = "Please enter 4th Digit Mpin";

          });
          return;
        }
        else {
          setState(() {
            Otp4thdigithasStartedTyping = false;
            digitMpinMessage = null;

          });
        }







        String upperDigit = Otp1stdigit + Otp2nddigit + Otp3rddigit + Otp4thdigit ;
        // bool checkMpin = await isMpinMatched(upperDigit);


        bool checkMpin = await UserSecureStorage.verifyUserMpin(mobileNumber, upperDigit);
        print( "checkMpin : ${checkMpin}");
        if(!checkMpin){

          final snackBar = SnackBar(
              content: Text("Invalid MPIN"),
              backgroundColor: Colors.red[600]);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return ;
        }
        else {
          await UserSecureStorage.setIfLogged("YES");
          await UserSecureStorage.setUsernameid(mobileNumber);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePageMain()),
                  (Route<dynamic> route) => false);
        }














      } else {
        // No-Internet Case
        final snackBar = SnackBar(
            content: Text("No Internet, Check Connectivity!"),
            backgroundColor: Colors.red[600]);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    });
  }



}

