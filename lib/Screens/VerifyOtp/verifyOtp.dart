import 'package:newfolder/Screens/Alerts/registrationsuccess.dart';
import 'package:newfolder/Screens/Settings/mpinmain.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Utils/auth_service.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/VerifyOtp/forgetMpin.dart';

import '../Utils/user_secure_storage.dart';

class MpinResetSettings extends StatefulWidget {
  // const MpinResetSettings({
  //   super.key,
  // });
  final String? mobileNumber; // Optional number
  const MpinResetSettings({Key? key, this.mobileNumber}) : super(key: key);
  @override
  State<MpinResetSettings> createState() => Mpinstate();
}

class Mpinstate extends State<MpinResetSettings> {

  late final bool hasMobileNumber;
  late final String mobileNumber;

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
  bool _isLoading = false; // <-- add this to your state

  bool _digitMpin = false;
  bool _reEnterdigitMpin = false;



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
                            fontWeight: FontWeight.w800,
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
                        "By setting up a strong MPIN, you can help protect your mobile device and personal Information from unauthorized access.",
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
                                    obscureText: true,
                                    obscuringCharacter: '•',

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
                                    obscureText: true,
                                    obscuringCharacter: '•',

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
                                    obscureText: true,
                                    obscuringCharacter: '•',

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
                                    obscureText: true,
                                    obscuringCharacter: '•',

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
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.04),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: screenHeight * 0.03,
                                right: screenHeight * 0.03,
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
                            SizedBox(height: screenHeight * 0.015),

                            // 🔹 Main Button Section
                            Builder(
                              builder: (context) {
                                final textScale = MediaQuery.of(context).textScaleFactor;
                                final double bottomMargin = screenHeight * 0.02 * textScale;

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
                                                  ? [Color(0xFF126086), Color(0xFF126086)]
                                                  : [Colors.grey, Colors.grey],
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: TextButton(
                                            onPressed: _isButtonEnabled
                                                ? () {
                                              if (_isLoading) return;
                                              setState(() => _isLoading = true);

                                              saveMpin();

                                              // Future.delayed(Duration(milliseconds: 500), () {
                                              //   connectivityservice.checkconnectivity().then((intenet) async {
                                              //     setState(() => _isLoading = false);
                                              //
                                              //     // ✅ Only show modal when MPIN is successfully set
                                              //     RegistrationSuccessModel().showModel(context);
                                              //   });
                                              // });
                                            }
                                                : null, // Disabled when _isButtonEnabled == false
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(vertical: 9.5, horizontal: 12.0),
                                              minimumSize: Size(double.infinity, screenHeight * 0.06),
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: screenHeight * 0.022,
                                                  height: screenHeight * 0.022,
                                                  margin: EdgeInsets.only(right: screenHeight * 0.008),
                                                  child: _isLoading
                                                      ? CircularProgressIndicator(
                                                    strokeWidth: 2.0,
                                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                  )
                                                      : SizedBox.shrink(),
                                                ),
                                                Text(
                                                  "Set your MPIN",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: screenHeight * 0.018,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )



                    //         Container(
            //           color: Colors.white, // Set the background color to white
            //           child: Padding(
            //             padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.04),
            //             child: Column(
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.only(
            //                     // top : screenHeight * 0.01,
            //                     left : screenHeight * 0.03,
            //                     right : screenHeight * 0.03,
            //                   ),
            //                   child: Text(
            //                     "Update Your MPIN Easily Via 'Accounts > Settings: Or Experience The Convenience Of Fingerprint Login For Enhanced Security.",
            //                     style: TextStyle(
            //                       height: 1.8,
            //                       fontSize: screenHeight * 0.012,
            //                       color: Color(0xFF6A6E83),
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                     textAlign: TextAlign.center,
            //                   ),
            //                 ),
            //
            //                 SizedBox(height: screenHeight * 0.015), // Spacing before the button
            //
            //
            //             GestureDetector(
            //             onTap: () async {
            // if (_isLoading) return; // prevent multiple taps
            // setState(() => _isLoading = true);
            //
            // saveMpin(); // run your async function
            // Future.delayed(Duration(milliseconds: 500), () {
            //   connectivityservice.checkconnectivity().then((intenet) async {
            //     setState(() => _isLoading = false); // Hide loader after actions
            //   });
            // });
            // },
            //   child: Builder(
            //     builder: (context) {
            //       final textScale = MediaQuery.of(context).textScaleFactor;
            //       final double bottomMargin =
            //           screenHeight * 0.02 * textScale; // Adjust margin with font scale
            //
            //       return Container(
            //         margin: EdgeInsets.only(bottom: bottomMargin),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Expanded(
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(screenHeight * 0.012),
            //                   gradient: LinearGradient(
            //                     begin: Alignment.centerRight,
            //                     end: Alignment.center,
            //                     stops: [0.5, 0.9],
            //                     colors: _isButtonEnabled
            //                         ? [Color(0xFF126086), Color(0xFF126086)]
            //                         : [Colors.grey, Colors.grey],
            //                   ),
            //                 ),
            //                 alignment: Alignment.center,
            //                 child: TextButton(
            //                   onPressed: () {
            //                     if (_isLoading) return;
            //                     setState(() => _isLoading = true);
            //
            //                     saveMpin();
            //
            //                     Future.delayed(Duration(milliseconds: 500), () {
            //                       connectivityservice.checkconnectivity().then((intenet) async {
            //                         setState(() => _isLoading = false);
            //                       });
            //                     });
            //                   },
            //                   child: Row(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: [
            //                       // Loader (only shows when loading)
            //                       if (_isLoading) ...[
            //                         SizedBox(
            //                           height: screenHeight * 0.022,
            //                           width: screenHeight * 0.022,
            //                           child: CircularProgressIndicator(
            //                             color: Colors.white,
            //                             strokeWidth: 2.2,
            //                           ),
            //                         ),
            //                         SizedBox(width: screenHeight * 0.008),
            //                       ],
            //                       Text(
            //                         "Set your MPIN",
            //                         textAlign: TextAlign.center,
            //                         style: TextStyle(
            //                           color: Colors.white,
            //                           fontSize: screenHeight * 0.018,
            //                           fontWeight: FontWeight.w700,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // )
            //
            // // GestureDetector(
            //                 //   onTap: () {
            //                 //     print('Tapped!');
            //                 //     saveMpin();
            //                 //   },
            //                 //   child: Builder(
            //                 //     builder: (context) {
            //                 //       final textScale = MediaQuery.of(context).textScaleFactor;
            //                 //       final double bottomMargin = screenHeight * 0.02 * textScale; // Adjust margin with font scale
            //                 //
            //                 //       return Container(
            //                 //         margin: EdgeInsets.only(bottom: bottomMargin),
            //                 //         child: Row(
            //                 //           mainAxisAlignment: MainAxisAlignment.center,
            //                 //           children: <Widget>[
            //                 //             Expanded(
            //                 //               child: Container(
            //                 //                 decoration: BoxDecoration(
            //                 //                   borderRadius: BorderRadius.circular(screenHeight * 0.012),
            //                 //                   gradient: LinearGradient(
            //                 //                     begin: Alignment.centerRight,
            //                 //                     end: Alignment.center,
            //                 //                     stops: [0.5, 0.9],
            //                 //                     colors: _isButtonEnabled
            //                 //                         ? [
            //                 //                       Color(0xFF126086),
            //                 //                       Color(0xFF126086),
            //                 //                     ]
            //                 //                         : [Colors.grey, Colors.grey],
            //                 //                   ),
            //                 //                 ),
            //                 //                 alignment: Alignment.center,
            //                 //                 child: TextButton(
            //                 //                   onPressed: () async {
            //                 //                     saveMpin();
            //                 //                   },
            //                 //                   child: Text(
            //                 //                     "Set your MPIN",
            //                 //                     textAlign: TextAlign.center,
            //                 //                     style: TextStyle(
            //                 //                       color: Colors.white,
            //                 //                       fontSize: screenHeight * 0.018,
            //                 //                       fontWeight: FontWeight.w700,
            //                 //                     ),
            //                 //                   ),
            //                 //                 ),
            //                 //               ),
            //                 //             ),
            //                 //           ],
            //                 //         ),
            //                 //       );
            //                 //     },
            //                 //   ),
            //                 // ),
            //               ],
            //             ),
            //           ),
            //         ),





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
          print("verifyOtp: ${mobileNumber.trim()}");
          await UserSecureStorage.setUsernameid(mobileNumber.trim());
          await UserSecureStorage.updateUserMpin(mobileNumber.trim(), Otp1stdigit2.trim() + Otp2nddigit2.trim() + Otp3rddigit2.trim() + Otp4thdigit2.trim());
          bool forgetMpin = await  isForgetMpinSet();
          Future.delayed(Duration(milliseconds: 1000), () {
            connectivityservice.checkconnectivity().then((intenet) async {
              setState(() => _isLoading = false);

              // ✅ Only show modal when MPIN is successfully set
              RegistrationSuccessModel().showModel(context);
            });
          });

          // RegistrationSuccessModel().showModel(context);
          if(forgetMpin){
            Timer(Duration(seconds: 1), () {
              deleteForgetMpin();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForgetMpinScreen())
              );
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => MpinAccessScreen(mobileNumber:mobileNumber))
              // );
            });
          }
          else{
            // Timer(Duration(seconds: 1), () {
            //   Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => MpinAccessScreen(mobileNumber:mobileNumber))
            //   );
            // });
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
