import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/Login/loginpage.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

import '../Settings/changemobilenum.dart';
import '../Settings/mpinreset.dart';
import '../Utils/customNotification.dart';
import '../Utils/user_secure_storage.dart';

class Registration extends StatefulWidget {
  const Registration({
    super.key,
  });
  @override
  State<Registration> createState() => Registrationstate();
}

class Registrationstate extends State<Registration> {
  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();

  TextEditingController FirstNameEditTextController = TextEditingController();
  TextEditingController LastNameEditTextController = TextEditingController();
  TextEditingController MobileNummberEditTextController =
      TextEditingController();
  TextEditingController EmailEditTextController = TextEditingController();
  TextEditingController GenderEditTextController = TextEditingController();
  TextEditingController NewPasswordTextController = TextEditingController();
  TextEditingController ConfirmPasswordTextController = TextEditingController();

  bool hidePassword = true;
  bool checkedValue = true;
  late ProgressDialog progressDialog;
  RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$');

  String? genderselectedval;

  // Mapping for gender display and internal values
  final Map<String, String> genderMap = {
    "M": "Male",
    "F": "Female",
    "O": "Others",
  };

  // Reverse mapping
  final List<Map<String, String>> genderOptions = [
    {"key": "M", "label": "Male"},
    {"key": "F", "label": "Female"},
    {"key": "O", "label": "Other"},
  ];

  final GlobalKey _dropdownKey = GlobalKey();
  bool _isGenderSelected = true;

  @override
  void initState() {
    super.initState();

    /*setState(() {
      FirstNameEditTextController?.text = "sdfsd";
      LastNameEditTextController?.text = "sd";
      MobileNummberEditTextController?.text = "9698292183";
      EmailEditTextController?.text = "subramanib1111@gmail.com";
      GenderEditTextController?.text = "male";
      NewPasswordTextController?.text = "Pugazh@#123456";
      ConfirmPasswordTextController?.text = "Pugazh@#123456";
    });*/
  }

  // State variable to track validation
  bool _isGenderValid = true;

  void _validateGenderSelection() {
    print('_validateGenderSelection');
    setState(() {
      _isGenderValid = genderselectedval != null; // Update validation status
    });
  }

  bool isValidEmail(String email) {
    // Regular expression for validating general email addresses
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  String? firstnameerrorMessage;
  bool firstnameisValid = false;
  bool firstnamehasStartedTyping =
      false; // Track if the user has started typing

  void validateInput() {
    String input = FirstNameEditTextController.text.trim();

    if (input.isEmpty) {
      setState(() {
        firstnameerrorMessage = "Please enter your First Name";
        firstnameisValid = false;
      });
    } else {
      setState(() {
        firstnameerrorMessage = "Entered First Name";
        firstnameisValid = true;
      });
    }
  }

  String? lastnameerrorMessage;
  bool lastnameisValid = false;
  bool lastnamehasStartedTyping = false; // Track if the user has started typing

  void lastnamevalidateInput() {
    String input = LastNameEditTextController.text.trim();

    if (input.isEmpty) {
      setState(() {
        lastnameerrorMessage = "Please enter your Last Name";
        lastnameisValid = false;
      });
    } else {
      setState(() {
        lastnameerrorMessage = "Entered Last Name";
        lastnameisValid = true;
      });
    }
  }

  String? mobilenumerrorMessage;
  bool mobilenumisValid = false;
  bool mobilenumhasStartedTyping =
      false; // Track if the user has started typing

  void mobilenumvalidateInput() {
    String input = MobileNummberEditTextController.text.trim();

    if (input.isEmpty) {
      setState(() {
        mobilenumerrorMessage = null;
        mobilenumisValid = false;
      });
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(input)) {
      setState(() {
        mobilenumerrorMessage = null;
        mobilenumisValid = false;
      });
    } else {
      setState(() {
        mobilenumerrorMessage = null;
        mobilenumisValid = true;
      });
    }
  }

  String? emailerrorMessage;
  bool emailisValid = false;
  bool emailhasStartedTyping = false; // Track if the user has started typing

  void emailvalidateInput() {
    String input = EmailEditTextController.text.trim();

    if (input.isEmpty) {
      setState(() {
        emailerrorMessage = null;
        emailisValid = false;
      });
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input)) {
      setState(() {
        emailerrorMessage = null;
        emailisValid = false;
      });
    } else {
      setState(() {
        emailerrorMessage = null;
        emailisValid = true;
      });
    }
  }

  String? passerrorMessage;
  bool passisValid = false;
  bool passhasStartedTyping = false;

  void passvalidateInput() {
    String input = NewPasswordTextController.text.trim();

    if (input.isEmpty) {
      setState(() {
        passerrorMessage = "Please enter Password";
        passisValid = false;
      });
    } else if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$')
        .hasMatch(input)) {
      setState(() {
        passerrorMessage =
            "Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.";
        passisValid = false;
      });
    } else {
      setState(() {
        passerrorMessage = "Entered Password is valid";
        passisValid = true;
      });
    }
  }

  String? conpasserrorMessage;
  bool conpassisValid = false;
  bool conpasshasStartedTyping = false;


  void conpassvalidateInput() {
    String input = ConfirmPasswordTextController.text.trim();

    if (input.isEmpty) {
      setState(() {
        conpasserrorMessage = "Please enter confirm Password";
        conpassisValid = false;
      });
    } else if (NewPasswordTextController.text.trim() != input) {
      setState(() {
        conpasserrorMessage = "Please enter same Password";
        conpassisValid = false;
      });
    } else {
      setState(() {
        conpasserrorMessage = "Entered confirm Password is valid";
        conpassisValid = true;
      });
    }
  }

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  // final GlobalKey _textFieldKey = GlobalKey();
  //Asgar
  final _formKey = GlobalKey<FormState>();
  final GlobalKey _textFieldKey = GlobalKey();

  // void _showGenderDropdown() {
  //
  //   // Remove existing overlay before creating a new one
  //   _removeOverlay();
  //
  //   final overlay = Overlay.of(context);
  //   final renderBox = _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
  //   final size = renderBox?.size;
  //   final offset = renderBox?.localToGlobal(Offset.zero);
  //
  //   if (size == null || offset == null) return;
  //
  //   //Asgar
  //   // Calculate available space below and above
  //   final double screenHeight = MediaQuery.of(context).size.height;
  //   final double availableSpaceBelow = screenHeight - (offset.dy + size.height);
  //   final double availableSpaceAbove = offset.dy;
  //
  //   // Define dropdown height
  //   double dropdownHeight = 150; // Fixed dropdown height
  //
  //   // Check if the dropdown will be hidden under the Terms & Conditions checkbox
  //   bool shouldShowAbove = availableSpaceBelow < dropdownHeight && availableSpaceAbove > dropdownHeight;
  //
  //   // Position dropdown accordingly
  //   double dropdownTop = shouldShowAbove ? (offset.dy - dropdownHeight) : (offset.dy + size.height);
  //
  //
  //   _overlayEntry = OverlayEntry(
  //     builder: (context) => Stack(
  //       children: [
  //         // Full-screen tap detector to dismiss overlay
  //         Positioned.fill(
  //           child: GestureDetector(
  //             behavior: HitTestBehavior.opaque, // Ensure taps outside are detected
  //             onTap: () {
  //               _removeOverlay(); // Remove overlay when tapped outside
  //             },
  //           ),
  //         ),
  //
  //         // Dropdown positioned below the TextFormField
  //         Positioned(
  //           width: size.width, // Match TextFormField width
  //           left: offset.dx, // Position it directly below the TextFormField
  //           // top: offset.dy + size.height, // Drop down below the TextFormField
  //           top: dropdownTop,
  //           child: Material(
  //             elevation: 4.0,
  //             borderRadius: BorderRadius.circular(5),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: genderMap.entries.map((entry) {
  //                 return ListTile(
  //                   // title: Text(entry.value),
  //                   title : Text(
  //                     // "Asgar",
  //                       entry.value,
  //                     style: TextStyle(
  //                       fontSize: MediaQuery.of(context).size.height * 0.013,
  //                       color: Color(0xFF333333),
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     setState(() {
  //                       genderselectedval = entry.key; // Update selected gender
  //                     });
  //                     _removeOverlay(); // Remove dropdown when option is selected
  //                   },
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  //
  //   overlay?.insert(_overlayEntry!);
  // }

// Function to remove the overlay

  void _showGenderDropdown() {
    _removeOverlay();

    final overlay = Overlay.of(context);
    final renderBox =
        _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
    final size = renderBox?.size;
    final offset = renderBox?.localToGlobal(Offset.zero);

    if (size == null || offset == null) return;

    // Calculate available space below and above
    final double screenHeight = MediaQuery.of(context).size.height;
    final double availableSpaceBelow = screenHeight - (offset.dy + size.height);
    final double availableSpaceAbove = offset.dy;

    double dropdownHeight = 110;

    // Check if the dropdown will be hidden under the Terms & Conditions checkbox
    bool shouldShowAbove = availableSpaceBelow < dropdownHeight &&
        availableSpaceAbove > dropdownHeight;

    // Position dropdown accordingly
    double dropdownTop = shouldShowAbove
        ? (offset.dy - dropdownHeight)
        : (offset.dy + size.height);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Full-screen tap detector to dismiss overlay
          Positioned.fill(
            child: GestureDetector(
              behavior:
                  HitTestBehavior.opaque, // Ensure taps outside are detected
              onTap: () {
                _removeOverlay(); // Remove overlay when tapped outside
              },
            ),
          ),

          // Dropdown positioned below the TextFormField
          Positioned(
            width: size.width, // Match TextFormField width
            left: offset.dx, // Position it directly below the TextFormField
            top: dropdownTop,
            child: Material(
              color: Colors.white, // Set background color to white
              child: Container(
                height: MediaQuery.of(context).size.height *
                    0.13, // Set fixed height for dropdown
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xFFF1F1F1),
                      width: 1), // Add 1px black border
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: genderMap.entries.map((entry) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          genderselectedval =
                              entry.key; // Update selected gender
                        });
                        _removeOverlay(); // Remove dropdown when option is selected
                      },
                      child: Container(
                          alignment: Alignment.centerLeft,
                          // height: dropdownHeight / (genderMap.entries.length  ), // Divide the dropdown height by the number of entries
                          height: MediaQuery.of(context).size.height * 0.04,
                          padding: EdgeInsets
                              .zero, // Remove any extra padding in the container
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.015,
                          ), // Ensure no margin around the item
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.012,
                              // color: Colors.black54,
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                            ),
                          )),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  bool isExpanded = false;

  bool isButtonEnabled = false;
  void checkFieldEmpty(){

    print("genderselectedval : $genderselectedval");

     setState(() {
       if(FirstNameEditTextController.text.isNotEmpty && LastNameEditTextController.text.isNotEmpty
          && MobileNummberEditTextController.text.isNotEmpty  && EmailEditTextController.text.isNotEmpty
          && (genderselectedval != null)
       ){
         isButtonEnabled = true ;
       }
       else {
         isButtonEnabled = false;
       }
     });
  }
  @override
    Widget build(BuildContext context) {
      progressDialog = ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
      progressDialog.style(
          message: 'Registering..' '\nPlease Wait',
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(
            color: Colors.blueAccent,
            strokeWidth: MediaQuery.of(context).size.height * 0.002,
          ),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
            color: Colors.blueAccent,
            fontSize: 13.0,
          ),
          messageTextStyle: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w600));
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
  
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          /* decoration: const BoxDecoration(
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
                      onTap: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                        Navigator.pop(context);
                      },
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
                          "Register",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: screenHeight * 0.02,
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
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.03,
                      left: screenHeight * 0.025,
                      right: screenHeight * 0.025,
                      bottom: screenHeight * 0.01,
                    ),
                    child: SingleChildScrollView(
                      // physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          // Logo Image
                          Container(
                            margin: EdgeInsets.only(top: screenHeight * 0.015),
                            child: Image.asset(
                              'assets/splashqc.png',
                              height: screenHeight * 0.06,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
  
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
                                    "Create an Account",
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
                                    ""
                                    "Please fill in these detail to create an account",
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
  
                          // Scroll view
                          Container(
                            height: MediaQuery.of(context).size.height *
                                0.45, // Set the fixed height you want
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height * 0.005),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // First Name Label
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height *
                                            0.01,
                                        left: MediaQuery.of(context).size.height *
                                            0.005,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: 'First Name', // Your label
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height * 0.012,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' *', // Red asterisk
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
  
                                    // First Name Input Field
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height *
                                            0.005,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.008,
                                      ),
                                      child: Column(
                                        // mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            controller:
                                                FirstNameEditTextController,
                                            inputFormatters: [
                                              AlphabetOnlyFormatter(),
                                              LengthLimitingTextInputFormatter(
                                                  50),
                                            ],
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.016,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) {
                                              /* if (!hasStartedTyping) {
                                                setState(() {
                                                  hasStartedTyping = true; // Track that the user has started typing
                                                });
                                              }
                                              validateInput();*/

                                              checkFieldEmpty();
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.012,
                                                //  left :  MediaQuery.of(context).size.height * 0.02,
                                                //  top :  MediaQuery.of(context).size.height * 0.012,
                                                // bottom :  MediaQuery.of(context).size.height * 0.012,
                                                // top: MediaQuery.of(context).size.height * 0.014, // Slightly higher top padding
                                                // bottom: MediaQuery.of(context).size.height * 0.08 ,
                                                // left: MediaQuery.of(context).size.height * 0.02,
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFFFFFFF),
                                              hintText: "Enter your First Name",
                                              hintStyle: TextStyle(
                                                color: Color(0x4D111111),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.012,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                  color: firstnamehasStartedTyping
                                                      ? (firstnameisValid
                                                          ? Colors.green
                                                          : Colors.red)
                                                      : Color(
                                                          0xFFF1F1F1), // Initially grey, turns red or green
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                  color: firstnamehasStartedTyping
                                                      ? (firstnameisValid
                                                          ? Colors.green
                                                          : Colors.red)
                                                      : Color(
                                                          0xFFF1F1F1), // Initially grey, turns red or green
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                    BorderSide(color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                    BorderSide(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          if (firstnameerrorMessage != null)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              child: Text(
                                                firstnameerrorMessage ?? '',
                                                style: TextStyle(
                                                  color: firstnameisValid
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
  
                                    // Last Name Label
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height *
                                            0.005,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: 'Last Name', // Your label
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height * 0.012,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' *', // Red asterisk
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Last Name Input Field
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height *
                                            0.005,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.008,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            controller:
                                                LastNameEditTextController,
                                            inputFormatters: [
                                              AlphabetOnlyFormatter(),
                                              LengthLimitingTextInputFormatter(
                                                  50),
                                            ],
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.016,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) {
                                              /* if (!lastnamehasStartedTyping) {
                                                setState(() {
                                                  lastnamehasStartedTyping = true; // Track that the user has started typing
                                                });
                                              }
                                              lastnamevalidateInput();*/
                                              checkFieldEmpty();
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.012,
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFFFFFFF),
                                              hintText: "Enter your Last Name",
                                              hintStyle: TextStyle(
                                                  color: Color(0x4D111111),
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.012,
                                                  fontWeight: FontWeight.w400),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                  color: lastnamehasStartedTyping
                                                      ? (lastnameisValid
                                                          ? Colors.green
                                                          : Colors.red)
                                                      : Color(
                                                          0xFFF1F1F1), // Initially grey, turns red or green
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                  color: lastnamehasStartedTyping
                                                      ? (lastnameisValid
                                                          ? Colors.green
                                                          : Colors.red)
                                                      : Color(
                                                          0xFFF1F1F1), // Initially grey, turns red or green
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                    BorderSide(color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                    BorderSide(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          if (lastnameerrorMessage != null)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              child: Text(
                                                lastnameerrorMessage ?? '',
                                                style: TextStyle(
                                                  color: lastnameisValid
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
  
                                    //Mobile Number
                                    Padding(
                                      padding: new EdgeInsets.only(
                                          left:
                                              MediaQuery.of(context).size.height *
                                                  0.005,
                                          right:
                                              MediaQuery.of(context).size.height *
                                                  0.0,
                                          bottom:
                                              MediaQuery.of(context).size.height *
                                                  0.01),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: 'Mobile Number', // Your label
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height * 0.012,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' *', // Red asterisk
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
  
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height *
                                            0.005,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.008,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            controller:
                                                MobileNummberEditTextController,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[0-9]'))
                                            ],
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.016,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              mobilenumvalidateInput();
                                              /* if (!mobilenumhasStartedTyping) {
                                                setState(() {
                                                  mobilenumhasStartedTyping = true; // Track that the user has started typing
                                                });
                                              }
                                              mobilenumvalidateInput();*/
                                              checkFieldEmpty();
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.012,
                                              ),
                                              suffixIcon: MobileNummberEditTextController
                                                  .text.isNotEmpty &&
                                                  mobilenumisValid
                                                  ? Icon(Icons.check_circle,
                                                  color: Colors.green)
                                                  : null,
                                              filled: true,
                                              fillColor: Color(0xFFFFFFFF),
                                              hintText:
                                                  "Enter your Mobile Number",
                                              hintStyle: TextStyle(
                                                  color: Color(0x4D111111),
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.012,
                                                  fontWeight: FontWeight.w400),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                  color: mobilenumhasStartedTyping
                                                      ? (mobilenumisValid
                                                          ? Colors.green
                                                          : Colors.red)
                                                      : Color(
                                                          0xFFF1F1F1), // Initially grey, turns red or green
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                  color: mobilenumhasStartedTyping
                                                      ? (mobilenumisValid
                                                          ? Colors.green
                                                          : Colors.red)
                                                      : Color(
                                                          0xFFF1F1F1), // Initially grey, turns red or green
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                    BorderSide(color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                    BorderSide(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          if (mobilenumerrorMessage != null)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              child: Text(
                                                mobilenumerrorMessage ?? '',
                                                style: TextStyle(
                                                  color: mobilenumisValid
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
  
                                    //Email Text
                                    Padding(
                                      padding: new EdgeInsets.only(
                                          left:
                                              MediaQuery.of(context).size.height *
                                                  0.005,
                                          right:
                                              MediaQuery.of(context).size.height *
                                                  0.0,
                                          bottom:
                                              MediaQuery.of(context).size.height *
                                                  0.01),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: 'Email', // Your label
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height * 0.012,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' *', // Red asterisk
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Email Field
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height *
                                            0.005,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.008,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            controller: EmailEditTextController,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  100),
                                            ],
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.016,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onChanged: (value) {
                                              emailvalidateInput();
                                              /* if (!emailhasStartedTyping) {
                                                setState(() {
                                                  emailhasStartedTyping = true; // Track that the user has started typing
                                                });
                                              }
                                              emailvalidateInput();*/
                                              checkFieldEmpty();
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.012,
                                              ),
                                              suffixIcon: EmailEditTextController
                                                  .text.isNotEmpty &&
                                                  emailisValid
                                                  ? Icon(Icons.check_circle,
                                                  color: Colors.green)
                                                  : null,
                                              filled: true,
                                              fillColor: Color(0xFFFFFFFF),
                                              hintText: "Enter your email",
                                              hintStyle: TextStyle(
                                                  color: Color(0x4D111111),
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.012,
                                                  fontWeight: FontWeight.w400),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                  color: emailhasStartedTyping
                                                      ? (emailisValid
                                                          ? Colors.green
                                                          : Colors.red)
                                                      : Color(
                                                          0xFFF1F1F1), // Initially grey, turns red or green
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                  color: emailhasStartedTyping
                                                      ? (emailisValid
                                                          ? Colors.green
                                                          : Colors.red)
                                                      : Color(
                                                          0xFFF1F1F1), // Initially grey, turns red or green
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                    BorderSide(color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                    BorderSide(color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          if (emailerrorMessage != null)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              child: Text(
                                                emailerrorMessage ?? '',
                                                style: TextStyle(
                                                  color: emailisValid
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
  
                                    // Gender
                                    Padding(
                                      padding: new EdgeInsets.only(
                                          left:
                                              MediaQuery.of(context).size.height *
                                                  0.005,
                                          right:
                                              MediaQuery.of(context).size.height *
                                                  0.0,
                                          bottom:
                                              MediaQuery.of(context).size.height *
                                                  0.008),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                            text: 'Gender', // Your label
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height * 0.012,
                                              color: Color(0xFF333333),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' *', // Red asterisk
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
  
                                    // Updated TextFormField inside Column
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.height * 0.000,
                                        bottom: MediaQuery.of(context).size.height * 0.01,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
  
                                          // 🔹 Radio Buttons Row
                                          // _buildLabelWithAsterisk(context, 'Gender', required: true),

                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.start, // left align the whole row
                                          //   children: genderOptions.map((gender) {
                                          //     return InkWell(
                                          //       onTap: () {
                                          //         setState(() {
                                          //           genderselectedval = gender["key"]!;
                                          //           _isGenderValid = true;
                                          //         });
                                          //
                                          //         checkFieldEmpty();
                                          //       },
                                          //       child: Row(
                                          //         mainAxisSize: MainAxisSize.min, // take only as much space as needed
                                          //         crossAxisAlignment: CrossAxisAlignment.center,
                                          //         children: [
                                          //           Radio<String>(
                                          //             value: gender["key"]!,
                                          //             groupValue: genderselectedval,
                                          //             activeColor: const Color(0xFF00C7BE),
                                          //             visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                          //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          //             onChanged: (value) {
                                          //               setState(() {
                                          //                 genderselectedval = value!;
                                          //                 _isGenderValid = true;
                                          //               });
                                          //               checkFieldEmpty();
                                          //             },
                                          //           ),
                                          //           SizedBox(width: 2), // small gap between radio and text
                                          //           Text(
                                          //             gender["label"]!,
                                          //             style: TextStyle(
                                          //               fontSize: screenHeight * 0.014,
                                          //             ),
                                          //           ),
                                          //           SizedBox(width: 10), // optional: gap between different options
                                          //         ],
                                          //       ),
                                          //     );
                                          //   }).toList(),
                                          // ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: genderOptions.map((gender) {
                                              final bool isSelected = genderselectedval == gender["key"];

                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    genderselectedval = gender["key"]!;
                                                    _isGenderValid = true;
                                                  });
                                                  checkFieldEmpty();
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    // Custom radio circle with stroke color
                                                    Container(
                                                      width: screenHeight * 0.022,
                                                      height: screenHeight * 0.022,
                                                      margin: const EdgeInsets.only(right: 4),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: isSelected ? const Color(0xFF00C7BE) : const Color(0xFFD0D5DD),
                                                          width: isSelected ? 2.0 : 0.7,
                                                        ),
                                                      ),
                                                      child: isSelected
                                                          ? Center(
                                                        child: Container(
                                                          width: screenHeight * 0.010,
                                                          height: screenHeight * 0.010,
                                                          decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Color(0xFF00C7BE),
                                                          ),
                                                        ),
                                                      )
                                                          : null,
                                                    ),
                                                    Text(
                                                      gender["label"]!,
                                                      style: TextStyle(
                                                        fontSize: screenHeight * 0.014,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),

                                          if (!_isGenderValid)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: MediaQuery.of(context).size.height * 0.005,
                                              ),
                                              child: Text(
                                                "Please select a gender",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    )
  
  
  
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // T & C
                          Container(
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom: MediaQuery.of(context).size.height * 0.0,
                                left: MediaQuery.of(context).size.height * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                   
                                Row(
                                  children: [
                   
                                    // SizedBox(
                                    //   width: MediaQuery.of(context).size.width *
                                    //       0.04,
                                    // ),
                                    Container(
                                      // width: MediaQuery.of(context).size.width * 0.7,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'By Registering you agree to the ', // Normal black text
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height * 0.012,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Inter",
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Terms & Condition', // Hyperlink text
                                              style: TextStyle(
                                                color: Colors.blue, // Hyperlink color
                                                decoration: TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Navigate to Terms & Condition page or open URL
                                                  print("Terms & Condition clicked");
                                                },
                                            ),
                                            TextSpan(
                                              text: ' and ', // Normal black text
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Privacy Policy', // Hyperlink text
                                              style: TextStyle(
                                                color: Colors.blue, // Hyperlink color
                                                decoration: TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Navigate to Privacy Policy page or open URL
                                                  print("Privacy Policy clicked");
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Register Button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Register Button
  
                                GestureDetector(
                                  onTap: () async {

                                    if(isButtonEnabled)
                                      validSignupSubmit();
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height *
                                              0.0,
                                          bottom:
                                              MediaQuery.of(context).size.height *
                                                  0.00,
                                          left: MediaQuery.of(context).size.height *
                                              0.00,
                                          right:
                                              MediaQuery.of(context).size.height *
                                                  0.00),
                                      margin: EdgeInsets.only(
                                          right:
                                              MediaQuery.of(context).size.height *
                                                  0.01,
                                          top: MediaQuery.of(context).size.height *
                                              0.03,
                                          bottom:
                                              MediaQuery.of(context).size.height *
                                                  0.0,
                                          left:
                                              MediaQuery.of(context).size.height *
                                                  0.01),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.012),
                                                gradient: LinearGradient(
                                                    begin: Alignment.centerRight,
                                                    end: Alignment.center,
                                                    stops: [
                                                      0.5,
                                                      0.9
                                                    ],
                                                    colors: isButtonEnabled ?  [ Color(0xFF126086),Color(0xFF126086),]  :  [ Color(0xFFBCBCBC),Color(0xFFBCBCBC),]


                                                     )),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: TextButton(
                                              onPressed: () async {
                                                if(isButtonEnabled)
                                                validSignupSubmit();
                                              },
                                              child: Text("Register",
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
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal:
                                                        12.0), // Remove default button padding
                                                minimumSize: Size(0,
                                                    0), // Allow smallest possible size
                                                tapTargetSize: MaterialTapTargetSize
                                                    .shrinkWrap, // Shrink tap area
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                                ),
                              ],
                            ),
                          ),
  
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.0,
                              right: MediaQuery.of(context).size.height * 0.0,
                              top: MediaQuery.of(context).size.height * 0.03,
                              // bottom: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size.zero), // Ensures no extra space
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Shrinks the tap area
                              ),
                              onPressed: () {
                                // General button logic can go here if needed
                              },
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .merge(
                                        TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                  children: [
                                    TextSpan(
                                      text: 'Already have an account?',
                                      style: TextStyle(
                                          color: Color(0xFF1F1F1F),
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              MediaQuery.of(context).size.height *
                                                  0.011,
                                          fontFamily: "Inter"),
                                    ),
                                    TextSpan(
                                      text: ' Login',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.014,
                                        color: Color(0xFF126086),
                                        fontFamily: "Inter",
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigation logic for Login page
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return LoginPage(); // Replace with your Login page widget
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
                ),
              ),
            ],
          ),
        ),
      );
    }

  void validSignupSubmit() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        String input = FirstNameEditTextController.text.trim();

        if (input.isEmpty) {
          setState(() {
            firstnamehasStartedTyping = true;
            firstnameerrorMessage = "Please enter your First Name";
            firstnameisValid = false;
          });
        } else {
          setState(() {
            firstnamehasStartedTyping = false;
            firstnameerrorMessage = null;
            firstnameisValid = true;
          });
        }

        String input2 = LastNameEditTextController.text.trim();

        if (input2.isEmpty) {
          setState(() {
            lastnamehasStartedTyping = true;
            lastnameerrorMessage = "Please enter your Last Name";
            lastnameisValid = false;
          });
        } else {
          setState(() {
            lastnamehasStartedTyping = false;
            lastnameerrorMessage = null;
            lastnameisValid = true;
          });
        }

        String input3 = MobileNummberEditTextController.text.trim();

        if (input3.isEmpty) {
          setState(() {
            mobilenumhasStartedTyping = true;
            mobilenumerrorMessage = "Please enter your Mobile Number";
            mobilenumisValid = false;
          });
        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(input3)) {
          setState(() {
            mobilenumhasStartedTyping = true;
            mobilenumerrorMessage = "Please enter a valid mobile number";
            mobilenumisValid = false;
          });
        } else {
          setState(() {
            mobilenumhasStartedTyping = false;
            mobilenumerrorMessage = null;
            mobilenumisValid = true;
          });
        }

        String input4 = EmailEditTextController.text.trim();

        if (input4.isEmpty) {
          setState(() {
            emailhasStartedTyping = true;
            emailerrorMessage = "Please enter your email";
            emailisValid = false;
          });
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(input4)) {
          setState(() {
            emailhasStartedTyping = true;
            emailerrorMessage = "Please enter a valid email";
            emailisValid = false;
          });
        } else {
          setState(() {
            emailhasStartedTyping = false;
            emailerrorMessage = null;
            emailisValid = true;
          });
        }

        print('genderselectedval : ${genderselectedval}');
        if (genderselectedval == null) {
          // _validateGenderSelection();
          setState(() {
            _isGenderValid = false;
          });
        } else {
          setState(() {
            _isGenderValid = true;
          });
        }

        if (firstnameisValid &&
            lastnameisValid &&
            mobilenumisValid &&
            emailisValid &&
            _isGenderValid) {
          /* final snackBar = SnackBar(content: Text("Please do api calling"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);*/

          if (checkedValue == false) {

            final snackBar = SnackBar(
              content: Text("Please Select Terms and Conditions"),
              backgroundColor: Colors.red[600],
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          }

          showTopNotification(
            context,
            title: "Congratulations",
            message: "Your Account has been Created Successfully.",
            type: NotificationType.success,
          );

          progressDialog.show();
          await UserSecureStorage.saveUser(
            userId: input3.trim(),
            mpin: "",
            userData: {
              "fname": input.trim(),
              "lname": input2.trim(),
              "mobile": input3.trim(),
              "email": input4.trim(),
              "gender":genderselectedval!.trim()
            },
          );

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ChangeMobileNumber(mobileNumber:input3),
            ),
          );

          // dynamic user = await apiService.submitregistration(
          //     FirstNameEditTextController.text,
          //     LastNameEditTextController.text,
          //     MobileNummberEditTextController.text,
          //     EmailEditTextController.text,
          //     genderselectedval,
          //     "Y",
          //     base64Encode(utf8.encode(NewPasswordTextController.text)));
          //
          // print('user : $user');
          //
          // if (user.message != null) {
          //   print('if (user.message != null)');
          //   progressDialog.hide();
          //   final snackBar = SnackBar(
          //     content: Text(user.message),
          //     backgroundColor: Colors.red[600],
          //   );
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // } else if (user.response != null) {
          //   progressDialog.hide();
          //   final snackBar = SnackBar(
          //     content: Text(user.response), backgroundColor: Colors.green[600],
          //     duration: Duration(seconds: 2), // Set duration to 2 seconds
          //   );
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //   Future.delayed(Duration(seconds: 3), () {
          //     Navigator.of(context).pushAndRemoveUntil(
          //       MaterialPageRoute(
          //         builder: (BuildContext context) => LoginPage(),
          //       ),
          //       (Route route) => false,
          //     );
          //   });
          // } else {
          //   print('else');
          //   progressDialog.hide();
          //   final snackBar = SnackBar(
          //       content: Text("API Services not working"),
          //       backgroundColor: Colors.red[600]);
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //   // customalert.showError(context, user.error);
          // }
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

class AlphabetOnlyFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'[a-zA-Z ]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filteredText = newValue.text.characters.where((char) {
      return _regExp.hasMatch(char);
    }).join();

    // Calculate offset so the cursor doesn't jump
    int offset = filteredText.length;
    if (filteredText.length < newValue.text.length) {
      offset = oldValue.selection.start;
    } else {
      offset = newValue.selection.baseOffset;
    }

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
