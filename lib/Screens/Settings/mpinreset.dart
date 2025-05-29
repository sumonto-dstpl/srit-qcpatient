//
//
// import 'dart:convert';
//
// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/passsuccesssendback.dart';
import 'package:newfolder/Screens/Settings/mpinmain.dart';
import 'package:newfolder/Screens/Settings/sucesschangenum.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Utils/auth_service.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
// import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:fluttertoast/fluttertoast.dart';
//
// class MpinResetSettings extends StatefulWidget {
//   const MpinResetSettings({
//     super.key,
//   });
//   @override
//   State<MpinResetSettings> createState() => MpinResetSettingsstate();
// }
//
// class MpinResetSettingsstate extends State<MpinResetSettings> {
//
//
//   ConnectivityService connectivityservice = ConnectivityService();
//   APIService apiService = new APIService();
//   late ProgressDialog progressDialog;
//
//   TextEditingController Otp1stdigitTextController = TextEditingController();
//   TextEditingController Otp2nddigitTextController = TextEditingController();
//   TextEditingController Otp3rddigitTextController = TextEditingController();
//   TextEditingController Otp4thdigitTextController = TextEditingController();
//
//
//   TextEditingController Otp1stdigitTextController2 = TextEditingController();
//   TextEditingController Otp2nddigitTextController2 = TextEditingController();
//   TextEditingController Otp3rddigitTextController2 = TextEditingController();
//   TextEditingController Otp4thdigitTextController2 = TextEditingController();
//
//
//   FocusNode? pin2FocusNode;
//   FocusNode? pin3FocusNode;
//   FocusNode? pin4FocusNode;
//
//   FocusNode? pin2FocusNode2;
//   FocusNode? pin3FocusNode2;
//   FocusNode? pin4FocusNode2;
//
//   //Asgar
//   bool _isButtonEnabled = false;
//
//
//
//   @override
//   void initState() {
//
//     super.initState();
//     pin2FocusNode = FocusNode();
//     pin3FocusNode = FocusNode();
//     pin4FocusNode = FocusNode();
//
//     pin2FocusNode2 = FocusNode();
//     pin3FocusNode2 = FocusNode();
//     pin4FocusNode2 = FocusNode();
//
//     Otp1stdigitTextController.addListener(_checkInput);
//     Otp2nddigitTextController.addListener(_checkInput);
//     Otp3rddigitTextController.addListener(_checkInput);
//     Otp4thdigitTextController.addListener(_checkInput);
//
//     Otp1stdigitTextController2.addListener(_checkInput);
//     Otp2nddigitTextController2.addListener(_checkInput);
//     Otp3rddigitTextController2.addListener(_checkInput);
//     Otp4thdigitTextController2.addListener(_checkInput);
//
//   }
//
//   @override
//   void dispose() {
//
//
//
//     Otp1stdigitTextController.removeListener(_checkInput);
//     Otp1stdigitTextController.dispose();
//     Otp2nddigitTextController.removeListener(_checkInput);
//     Otp2nddigitTextController.dispose();
//     Otp3rddigitTextController.removeListener(_checkInput);
//     Otp3rddigitTextController.dispose();
//     Otp4thdigitTextController.removeListener(_checkInput);
//     Otp4thdigitTextController.dispose();
//
//     Otp1stdigitTextController2.removeListener(_checkInput);
//     Otp1stdigitTextController2.dispose();
//     Otp2nddigitTextController2.removeListener(_checkInput);
//     Otp2nddigitTextController2.dispose();
//     Otp3rddigitTextController2.removeListener(_checkInput);
//     Otp3rddigitTextController2.dispose();
//     Otp4thdigitTextController2.removeListener(_checkInput);
//     Otp4thdigitTextController2.dispose();
//
//
//
//
//     super.dispose();
//     pin2FocusNode!.dispose();
//     pin3FocusNode!.dispose();
//     pin4FocusNode!.dispose();
//
//     pin2FocusNode2!.dispose();
//     pin3FocusNode2!.dispose();
//     pin4FocusNode2!.dispose();
//
//   }
//
//
//   void nextField(String value, FocusNode focusNode) {
//     if (value.length == 1) {
//       focusNode.requestFocus();
//     }
//   }
//
//
//   void _checkInput() {
//     print('_checkInput');
//     setState(() {
//       setState(() {
//         if (Otp1stdigitTextController.text.trim().isNotEmpty || Otp2nddigitTextController.text.trim().isNotEmpty || Otp3rddigitTextController.text.trim().isNotEmpty || Otp4thdigitTextController.text.trim().isNotEmpty
//            || Otp1stdigitTextController2.text.trim().isNotEmpty || Otp2nddigitTextController2.text.trim().isNotEmpty || Otp3rddigitTextController2.text.trim().isNotEmpty || Otp4thdigitTextController2.text.trim().isNotEmpty
//         ) {
//           _isButtonEnabled = true;
//         } else {
//           _isButtonEnabled = false;
//         }
//       });
//     });
//     print('_isButtonEnabled : $_isButtonEnabled');
//   }
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
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   children: [
//
//                     // Logo Image
//                     Container(
//                       margin: EdgeInsets.only(top: screenHeight * 0.03),
//                       child: Image.asset(
//                         'assets/splashqc.png',
//                         height: screenHeight * 0.06,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//
//                     Text(
//                       "MPIN",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: screenHeight * 0.028,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: screenHeight * 0.1,
//                       ),
//                       child: Text(
//                         "By setting LP a strong you can help protect your mobile device and personal Information from unauthorized access.",
//                         style: TextStyle(
//                           fontSize: screenHeight * 0.014,
//                           color: Color(0xFF6A6E83),
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//
//
//
//
//                     Container(
//                       alignment: Alignment.centerRight,
//                       padding: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.height * 0.0,
//                           bottom: MediaQuery.of(context).size.height * 0.00,
//                           left: MediaQuery.of(context).size.height * 0.00,
//                           right: MediaQuery.of(context).size.height * 0.00),
//                       margin: EdgeInsets.only(
//                           right: MediaQuery.of(context).size.height * 0.02,
//                           top: MediaQuery.of(context).size.height * 0.02,
//                           bottom: MediaQuery.of(context).size.height * 0.24,
//                           left: MediaQuery.of(context).size.height * 0.02),
//                       child: Column(children: [
//
//
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: MediaQuery.of(context).size.height * 0.00,
//                               right: 0,
//                               top: MediaQuery.of(context).size.height * 0.0,
//                               bottom: MediaQuery.of(context).size.height * 0.010),
//                           child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Text(
//                                   "Input Your Preferred 4 Digit MPIN",
//                                   style: TextStyle(
//                                     fontSize:
//                                     MediaQuery.of(context).size.height * 0.018,
//                                     color: Color(0xFF126086),
//                                     // fontWeight: FontWeight.bold
//                                   ),
//                                   textAlign: TextAlign.start,
//                                 ),
//
//                               ]),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height * 0.00,
//                             left: MediaQuery.of(context).size.height * 0.05,
//                             right: MediaQuery.of(context).size.height * 0.05,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal! * 11,
//                                 child: TextFormField(
//                                   // autofocus: true,
//                                   // obscureText: true,
//                                   style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.034),
//                                   controller: Otp1stdigitTextController,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                                     filled: false, // Remove background color
//                                     hintText: '0', // Example hint text
//                                     hintStyle: TextStyle(color: Colors.white70),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey), // Set border color
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.015)),
//                                       borderSide: BorderSide(color: Colors.grey[300]!), // Set border color
//                                     ),
//                                   ),
//                                   onChanged: (value) {
//                                     nextField(value, pin2FocusNode!);
//                                   },
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal! * 11,
//                                 child: TextFormField(
//                                   focusNode: pin2FocusNode,
//                                   style: TextStyle(
//                                     fontSize: MediaQuery.of(context).size.height * 0.034,
//                                   ),
//                                   controller: Otp2nddigitTextController,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                                     filled: false, // Remove background color
//                                     hintStyle: TextStyle(color: Colors.white70),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey), // Set border color to grey
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
//                                     ),
//                                   ),
//                                   onChanged: (value) => nextField(value, pin3FocusNode!),
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal! * 11,
//                                 child: TextFormField(
//                                   focusNode: pin3FocusNode,
//                                   style: TextStyle(
//                                     fontSize: MediaQuery.of(context).size.height * 0.034,
//                                   ),
//                                   controller: Otp3rddigitTextController,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                                     filled: false, // Remove background color
//                                     hintStyle: TextStyle(color: Colors.white70),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey), // Set border color to grey
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color:Colors.grey[300]!), // Set border color to grey
//                                     ),
//                                   ),
//                                   onChanged: (value) => nextField(value, pin4FocusNode!),
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal! * 11,
//                                 child: TextFormField(
//                                   focusNode: pin4FocusNode,
//                                   style: TextStyle(
//                                     fontSize: MediaQuery.of(context).size.height * 0.034,
//                                   ),
//                                   controller: Otp4thdigitTextController,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                                     filled: false, // Remove background color
//                                     hintStyle: TextStyle(color: Colors.white70),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey), // Set border color to grey
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
//                                     ),
//                                   ),
//                                   onChanged: (value) {
//                                     if (value.length == 1) {
//                                       pin4FocusNode!.unfocus();
//                                       // Then you need to check is the code is correct or not
//                                     }
//                                   },
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                         ),
//
//
//
//                         // Re-Enter Your Preferred 4 Digit MPIN
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: MediaQuery.of(context).size.height * 0.00,
//                               right: 0,
//                               top: MediaQuery.of(context).size.height * 0.03,
//                               bottom: MediaQuery.of(context).size.height * 0.010),
//                           child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 Text(
//                                   "Re-Enter Your Preferred 4 Digit MPIN",
//                                   style: TextStyle(
//                                     fontSize:
//                                     MediaQuery.of(context).size.height * 0.018,
//                                     color: Color(0xFF126086),
//                                     // fontWeight: FontWeight.bold
//                                   ),
//                                   textAlign: TextAlign.start,
//                                 ),
//
//                               ]),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(
//                             top: MediaQuery.of(context).size.height * 0.00,
//                             left: MediaQuery.of(context).size.height * 0.05,
//                             right: MediaQuery.of(context).size.height * 0.05,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal! * 11,
//                                 child: TextFormField(
//                                   // autofocus: true,
//                                   // obscureText: true,
//                                   style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.034),
//                                   controller: Otp1stdigitTextController2,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                                     filled: false, // Remove background color
//                                     hintText: '0', // Example hint text
//                                     hintStyle: TextStyle(color: Colors.white70),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey), // Set border color
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.015)),
//                                       borderSide: BorderSide(color: Colors.grey[300]!), // Set border color
//                                     ),
//                                   ),
//                                   onChanged: (value) {
//                                     nextField(value, pin2FocusNode2!);
//                                   },
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal! * 11,
//                                 child: TextFormField(
//                                   focusNode: pin2FocusNode2,
//                                   style: TextStyle(
//                                     fontSize: MediaQuery.of(context).size.height * 0.034,
//                                   ),
//                                   controller: Otp2nddigitTextController2,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                                     filled: false, // Remove background color
//                                     hintStyle: TextStyle(color: Colors.white70),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey), // Set border color to grey
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
//                                     ),
//                                   ),
//                                   onChanged: (value) => nextField(value, pin3FocusNode2!),
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal! * 11,
//                                 child: TextFormField(
//                                   focusNode: pin3FocusNode2,
//                                   style: TextStyle(
//                                     fontSize: MediaQuery.of(context).size.height * 0.034,
//                                   ),
//                                   controller: Otp3rddigitTextController2,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                                     filled: false, // Remove background color
//                                     hintStyle: TextStyle(color: Colors.white70),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey), // Set border color to grey
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color:Colors.grey[300]!), // Set border color to grey
//                                     ),
//                                   ),
//                                   onChanged: (value) => nextField(value, pin4FocusNode2!),
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 width: SizeConfig.blockSizeHorizontal! * 11,
//                                 child: TextFormField(
//                                   focusNode: pin4FocusNode2,
//                                   style: TextStyle(
//                                     fontSize: MediaQuery.of(context).size.height * 0.034,
//                                   ),
//                                   controller: Otp4thdigitTextController2,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                                   ],
//                                   keyboardType: TextInputType.number,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     isDense: true,
//                                     contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                                     filled: false, // Remove background color
//                                     hintStyle: TextStyle(color: Colors.white70),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey), // Set border color to grey
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.015),
//                                       borderSide: BorderSide(color: Colors.grey[300]!), // Set border color to grey
//                                     ),
//                                   ),
//     onChanged: (value) {
//       if (value.length == 1) {
//         pin4FocusNode2!.unfocus();
//         // Then you need to check is the code is correct or not
//       }
//     }
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                         ),
//
//
//
//
//
//                       ]),
//                     ),
//
//
//
//
//                     Container(
//                         color: Colors.white, // Set the background color to white
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: screenHeight * 0.05,
//                                 ),
//                                 child: Text(
//                                   "Update Your MPIN Easily Via 'Accounts > Settings: Or Experience The Convenience Of Fingerprint Login For Enhanced Security.",
//                                   style: TextStyle(
//                                     fontSize: screenHeight * 0.014,
//                                     color: Color(0xFF6A6E83),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//
//                               SizedBox(height: screenHeight * 0.02), // Spacing before the button
//
//                               GestureDetector(
//                                 onTap: () async {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                       builder: (BuildContext context) {
//                                         return MpinMainSettings();
//                                       },
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   margin: EdgeInsets.only(bottom: screenHeight * 0.0), // Margin to avoid clipping
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(screenHeight * 0.012),
//                                             gradient: LinearGradient(
//                                               begin: Alignment.centerRight,
//                                               end: Alignment.center,
//                                               stops: [0.5, 0.9],
//                                               colors: _isButtonEnabled ?  [
//                                                 Color(0xFF126086),
//                                                 Color(0xFF126086),
//                                               ] : [Colors.grey,Colors.grey],
//                                             ),
//                                           ),
//                                           alignment: Alignment.center,
//                                           child: TextButton(
//                                             onPressed: () async {
//                                               Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                   builder: (BuildContext context) {
//                                                     return MpinMainSettings();
//                                                   },
//                                                 ),
//                                               );
//                                             },
//                                             child: Text(
//                                               "Submit",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: screenHeight * 0.02,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//
//
//
//
//                   ],
//                 ),
//               ),
//             ),
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

// import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class MpinResetSettings extends StatefulWidget {
  const MpinResetSettings({
    super.key,
  });
  @override
  State<MpinResetSettings> createState() => Mpinstate();
}

class Mpinstate extends State<MpinResetSettings> {


  ConnectivityService connectivityservice = ConnectivityService();



  TextEditingController Otp1stdigitTextController = TextEditingController();
  TextEditingController Otp2nddigitTextController = TextEditingController();
  TextEditingController Otp3rddigitTextController = TextEditingController();
  TextEditingController Otp4thdigitTextController = TextEditingController();


  TextEditingController Otp1stdigitTextController2 = TextEditingController();
  TextEditingController Otp2nddigitTextController2 = TextEditingController();
  TextEditingController Otp3rddigitTextController2 = TextEditingController();
  TextEditingController Otp4thdigitTextController2 = TextEditingController();

  String? digitMpinMessage ;


  bool Otp1stdigitisValid = false;
  bool Otp1stdigithasStartedTyping = false;

  bool Otp2nddigitisValid = false;
  bool Otp2nddigithasStartedTyping = false;

  bool Otp3rddigitisValid = false;
  bool Otp3rddigithasStartedTyping = false;

  bool Otp4thdigitisValid = false;
  bool Otp4thdigithasStartedTyping = false;

  String? reEnterDigitMpinMessage;
  bool Otp1stdigitisValid2 = false;
  bool Otp1stdigithasStartedTyping2 = false;

  bool Otp2nddigitisValid2 = false;
  bool Otp2nddigithasStartedTyping2 = false;

  bool Otp3rddigitisValid2 = false;
  bool Otp3rddigithasStartedTyping2 = false;

  bool Otp4thdigitisValid2 = false;
  bool Otp4thdigithasStartedTyping2 = false;



  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;


  FocusNode? pin1FocusNode2;
  FocusNode? pin2FocusNode2;
  FocusNode? pin3FocusNode2;
  FocusNode? pin4FocusNode2;


  bool _isButtonEnabled = false;

  bool _digitMpin = false;
  bool _reEnterdigitMpin = false;



  @override
  void initState() {

    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

    pin1FocusNode2 = FocusNode();
    pin2FocusNode2 = FocusNode();
    pin3FocusNode2 = FocusNode();
    pin4FocusNode2 = FocusNode();

    Otp1stdigitTextController.addListener(_checkInput);
    Otp2nddigitTextController.addListener(_checkInput);
    Otp3rddigitTextController.addListener(_checkInput);
    Otp4thdigitTextController.addListener(_checkInput);

    Otp1stdigitTextController2.addListener(_checkInput);
    Otp2nddigitTextController2.addListener(_checkInput);
    Otp3rddigitTextController2.addListener(_checkInput);
    Otp4thdigitTextController2.addListener(_checkInput);

  }

  @override
  void dispose() {



    Otp1stdigitTextController.removeListener(_checkInput);
    Otp1stdigitTextController.dispose();
    Otp2nddigitTextController.removeListener(_checkInput);
    Otp2nddigitTextController.dispose();
    Otp3rddigitTextController.removeListener(_checkInput);
    Otp3rddigitTextController.dispose();
    Otp4thdigitTextController.removeListener(_checkInput);
    Otp4thdigitTextController.dispose();

    Otp1stdigitTextController2.removeListener(_checkInput);
    Otp1stdigitTextController2.dispose();
    Otp2nddigitTextController2.removeListener(_checkInput);
    Otp2nddigitTextController2.dispose();
    Otp3rddigitTextController2.removeListener(_checkInput);
    Otp3rddigitTextController2.dispose();
    Otp4thdigitTextController2.removeListener(_checkInput);
    Otp4thdigitTextController2.dispose();




    super.dispose();
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();

    pin1FocusNode2!.dispose();
    pin2FocusNode2!.dispose();
    pin3FocusNode2!.dispose();
    pin4FocusNode2!.dispose();

  }


  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }


  void _checkInput() {
    print('_checkInput');
    setState(() {
      setState(() {
        if (Otp1stdigitTextController.text.trim().isNotEmpty || Otp2nddigitTextController.text.trim().isNotEmpty || Otp3rddigitTextController.text.trim().isNotEmpty || Otp4thdigitTextController.text.trim().isNotEmpty
            || Otp1stdigitTextController2.text.trim().isNotEmpty || Otp2nddigitTextController2.text.trim().isNotEmpty || Otp3rddigitTextController2.text.trim().isNotEmpty || Otp4thdigitTextController2.text.trim().isNotEmpty
        ) {
          _isButtonEnabled = true;
        } else {
          _isButtonEnabled = false;
        }
      });
    });
    print('_isButtonEnabled : $_isButtonEnabled');

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
            // image: AssetImage("assets/patternbackground.png"),
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover,
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
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.03),
                    topRight: Radius.circular(screenHeight * 0.03),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
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
                        top : screenHeight * 0.01,
                      ),
                      child: Text(
                        "Set MPIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: screenHeight * 0.022,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F1F1F),
                            fontFamily: "Inter"
                        ),
                      ),
                    ),

                    // Description
                    Container(
                      padding: EdgeInsets.only(
                        top : screenHeight * 0.01,
                        left : screenHeight * 0.08,
                        right : screenHeight * 0.08,
                      ),
                      child: Text(
                        "By setting LP a strong you can help protect your mobile device and personal Information from unauthorized access.",
                        style: TextStyle(
                          height: 1.8,
                          fontSize: screenHeight * 0.012,
                          color: Color(0xFF6A6E83),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height:  screenHeight * 0.018,),

                    // 4 Digit MPON & Re-Enter 4 Digit
                    Container(

                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.00),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.02,
                          top: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.22,
                          left: MediaQuery.of(context).size.height * 0.02
                      ),
                      child: Column(children: [

                        // 4 Digit Text
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
                                  "Input Your Preferred 4 Digit MPIN",
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                    color: Color(0xFF126086),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                  ),
                                  textAlign: TextAlign.start,
                                ),

                              ]),
                        ),

                        // 4 Digit TextField
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

                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(digitMpinMessage != null)
                          Container(
                            width : screenWidth * 0.5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                left : screenHeight * 0.005,
                              ),
                              child: Text(
                                digitMpinMessage ?? '',
                                style: TextStyle(
                                  color:  Colors.red,
                                  fontSize: MediaQuery.of(context).size.height * 0.015,
                                ),
                              ),
                            ),
                          ),



                        // 4 Digit Re-Enter Text
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: 0,
                              top: MediaQuery.of(context).size.height * 0.025,
                              bottom: MediaQuery.of(context).size.height * 0.010),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Re-Enter Your Preferred 4 Digit MPIN",
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                    color: Color(0xFF126086),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                  ),
                                  textAlign: TextAlign.start,
                                ),

                              ]),
                        ),

                        // 4 Digit Re-Enter TextField
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
                                focusNode: rawFocusv1, // Use a dedicated focus node for RawKeyboardListener
                                onKey: (RawKeyEvent event) {
                                  if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                    if (Otp1stdigitTextController2.text.isEmpty) {
                                      // Move to previous field and clear it
                                      pin1FocusNode2!.requestFocus();
                                      Otp1stdigitTextController2.clear();
                                    } else {
                                      // Just clear this field
                                      Otp1stdigitTextController2.clear();
                                    }
                                    setState(() {
                                      Otp1stdigithasStartedTyping2 = false;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! * 09,
                                  height: SizeConfig.blockSizeHorizontal! * 12,
                                  child: TextFormField(
                                    focusNode: pin1FocusNode2,

                                    controller: Otp1stdigitTextController2,
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
                                          color: Otp1stdigithasStartedTyping2
                                              ?  Colors.red
                                              : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                                        borderSide: BorderSide(
                                          color: Otp1stdigithasStartedTyping2
                                              ?  Colors.red
                                              : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(context).requestFocus(pin2FocusNode2); // move to 2nd field
                                        setState(() {
                                          Otp1stdigithasStartedTyping2 = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),

                              RawKeyboardListener(
                                focusNode: rawFocusv2, // Use a dedicated focus node for RawKeyboardListener
                                onKey: (RawKeyEvent event) {
                                  if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                    if (Otp2nddigitTextController2.text.isEmpty) {
                                      // Move to previous field and clear it
                                      pin1FocusNode2!.requestFocus();
                                      Otp1stdigitTextController2.clear();
                                    } else {
                                      // Just clear this field
                                      Otp2nddigitTextController2.clear();
                                    }
                                    setState(() {
                                      Otp2nddigithasStartedTyping2 = false;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! * 09,
                                  height: SizeConfig.blockSizeHorizontal! * 12,
                                  child: TextFormField(
                                    focusNode: pin2FocusNode2,

                                    controller: Otp2nddigitTextController2,
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
                                          color: Otp2nddigithasStartedTyping2
                                              ?  Colors.red
                                              : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                                        borderSide: BorderSide(
                                          color: Otp2nddigithasStartedTyping2
                                              ?  Colors.red
                                              : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(context).requestFocus(pin3FocusNode2); // move to 2nd field
                                        setState(() {
                                          Otp2nddigithasStartedTyping2 = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),

                              RawKeyboardListener(
                                focusNode: rawFocusv3, // Use a dedicated focus node for RawKeyboardListener
                                onKey: (RawKeyEvent event) {
                                  if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                    if (Otp3rddigitTextController2.text.isEmpty) {
                                      // Move to previous field and clear it
                                      pin2FocusNode2!.requestFocus();
                                      Otp2nddigitTextController2.clear();
                                    } else {
                                      // Just clear this field
                                      Otp3rddigitTextController2.clear();
                                    }
                                    setState(() {
                                      Otp3rddigithasStartedTyping2 = false;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! * 09,
                                  height: SizeConfig.blockSizeHorizontal! * 12,
                                  child: TextFormField(
                                    focusNode: pin3FocusNode2,

                                    controller: Otp3rddigitTextController2,
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
                                          color: Otp3rddigithasStartedTyping2
                                              ?  Colors.red
                                              : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                                        borderSide: BorderSide(
                                          color: Otp3rddigithasStartedTyping2
                                              ?  Colors.red
                                              : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(context).requestFocus(pin4FocusNode2); // move to 4th field
                                        setState(() {
                                          Otp3rddigithasStartedTyping2 = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),

                              RawKeyboardListener(
                                focusNode: rawFocusv4, // Use a dedicated focus node for RawKeyboardListener
                                onKey: (RawKeyEvent event) {
                                  if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                                    if (Otp4thdigitTextController2.text.isEmpty) {
                                      // Move to previous field and clear it
                                      pin3FocusNode2!.requestFocus();
                                      Otp3rddigitTextController2.clear();
                                    } else {
                                      // Just clear this field
                                      Otp4thdigitTextController2.clear();
                                    }
                                    setState(() {
                                      Otp4thdigithasStartedTyping2 = false;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: SizeConfig.blockSizeHorizontal! * 09,
                                  height: SizeConfig.blockSizeHorizontal! * 12,
                                  child: TextFormField(
                                    focusNode: pin4FocusNode2,

                                    controller: Otp4thdigitTextController2,
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
                                          color: Otp4thdigithasStartedTyping2
                                              ?  Colors.red
                                              : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height * 0.005)),
                                        borderSide: BorderSide(
                                          color: Otp4thdigithasStartedTyping2
                                              ?  Colors.red
                                              : Color(0xFFF1F1F1), // Initially grey, turns red or green
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        pin4FocusNode2!.unfocus(); // Last field, can unfocus
                                        setState(() {
                                          Otp4thdigithasStartedTyping2 = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        if(reEnterDigitMpinMessage != null)
                          Container(
                            width : screenWidth * 0.5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                left : screenHeight * 0.005,
                              ),
                              child: Text(
                                reEnterDigitMpinMessage ?? '',
                                style: TextStyle(
                                  color:  Colors.red,
                                  fontSize: MediaQuery.of(context).size.height * 0.015,
                                ),
                              ),
                            ),
                          ),





                      ]),
                    ),




                    Container(
                      color: Colors.white, // Set the background color to white
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.04),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                // top : screenHeight * 0.01,
                                left : screenHeight * 0.03,
                                right : screenHeight * 0.03,
                              ),
                              child: Text(
                                "Update Your MPIN Easily Via 'Accounts > Settings: Or Experience The Convenience Of Fingerprint Login For Enhanced Security.",
                                style: TextStyle(
                                  height: 1.8,
                                  fontSize: screenHeight * 0.012,
                                  color: Color(0xFF6A6E83),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.015), // Spacing before the button

                            GestureDetector(
                              onTap: () {
                                print('Tapped!');
                                saveMpin();
                              },
                              child: Builder(
                                builder: (context) {
                                  final textScale = MediaQuery.of(context).textScaleFactor;
                                  final double bottomMargin = screenHeight * 0.02 * textScale; // Adjust margin with font scale

                                  return Container(
                                    margin: EdgeInsets.only(bottom: bottomMargin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(screenHeight * 0.012),
                                              gradient: LinearGradient(
                                                begin: Alignment.centerRight,
                                                end: Alignment.center,
                                                stops: [0.5, 0.9],
                                                colors: _isButtonEnabled
                                                    ? [
                                                  Color(0xFF126086),
                                                  Color(0xFF126086),
                                                ]
                                                    : [Colors.grey, Colors.grey],
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: TextButton(
                                              onPressed: () async {
                                                saveMpin();
                                              },
                                              child: Text(
                                                "Submit",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: screenHeight * 0.018,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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

  void saveMpin() {

    connectivityservice.checkconnectivity().then((intenet) async {

      if (intenet != null && intenet) {


        String Otp1stdigit =  Otp1stdigitTextController.text;

        if(Otp1stdigit.isEmpty){
          setState(() {
            Otp1stdigithasStartedTyping = true;
            digitMpinMessage = "Please enter 4 Digit Mpin";

          });

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
            digitMpinMessage = "Please enter 4 Digit Mpin";

          });

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
            digitMpinMessage = "Please enter 4 Digit Mpin";

          });

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
            digitMpinMessage = "Please enter 4 Digit Mpin";

          });
          return;
        }
        else {
          setState(() {
            Otp4thdigithasStartedTyping = false;
            digitMpinMessage = null;

          });
        }



        String Otp1stdigit2 =  Otp1stdigitTextController2.text;

        if(Otp1stdigit2.isEmpty){
          setState(() {
            Otp1stdigithasStartedTyping2 = true;
            reEnterDigitMpinMessage = "Please enter 4 Digit Mpin";

          });

        }
        else {
          setState(() {
            Otp1stdigithasStartedTyping2 = false;
            reEnterDigitMpinMessage = null;

          });
        }

        String Otp2nddigit2 =  Otp2nddigitTextController2.text;

        if(Otp2nddigit2.isEmpty){
          setState(() {
            Otp2nddigithasStartedTyping2 = true;
            reEnterDigitMpinMessage = "Please enter 4 Digit Mpin";

          });

        }
        else {
          setState(() {
            Otp2nddigithasStartedTyping2 = false;
            reEnterDigitMpinMessage = null;

          });
        }

        String Otp3rddigit2 =  Otp3rddigitTextController2.text;

        if(Otp3rddigit2.isEmpty){
          setState(() {
            Otp3rddigithasStartedTyping2 = true;
            reEnterDigitMpinMessage = "Please enter 4 Digit Mpin";

          });

        }
        else {
          setState(() {
            Otp3rddigithasStartedTyping2 = false;
            reEnterDigitMpinMessage = null;

          });
        }

        String Otp4thdigit2 =  Otp4thdigitTextController2.text;

        if(Otp4thdigit2.isEmpty){
          setState(() {
            Otp4thdigithasStartedTyping2 = true;
            reEnterDigitMpinMessage = "Please enter 4 Digit Mpin";

          });
          return;
        }
        else {
          setState(() {
            Otp4thdigithasStartedTyping2 = false;
            reEnterDigitMpinMessage = null;

          });
        }

        String upperDigit = Otp1stdigit + Otp2nddigit + Otp3rddigit + Otp4thdigit ;
        String lowerDigit = Otp1stdigit2 + Otp2nddigit2 + Otp3rddigit2 + Otp4thdigit2 ;

        if(upperDigit != lowerDigit){

          final snackBar = SnackBar(
              content: Text("Re-Enter 4 Digit Pin is not matched"),
              backgroundColor: Colors.red[600]);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return ;
        }
        else {

          saveMpinAndEnabled(Otp1stdigit2 + Otp2nddigit2 + Otp3rddigit2 + Otp4thdigit2, "true");
          bool forgetMpin = await  isForgetMpinSet();
          if(forgetMpin){
            Timer(Duration(seconds: 1), () {
              deleteForgetMpin();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MpinAccessScreen())
              );
            });
          }
          else{
            Timer(Duration(seconds: 1), () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MpinAccessScreen()) 
              );
            });
          }




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

  void check1stDigitEmpty(String digit) {
    print( "check1stDigitEmpty");
    print("digit : ${digit.isNotEmpty}");
    if(digit.isNotEmpty){
      setState(() {
        Otp1stdigithasStartedTyping = false;
      });
    }
  }



}
