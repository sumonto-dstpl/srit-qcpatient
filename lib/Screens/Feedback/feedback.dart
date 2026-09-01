import 'dart:ui';
import 'package:newfolder/Core/Image%20Action/profile_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/constants/custom_emoji_feedback.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'dart:async';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';
class FeedbackMain extends StatefulWidget {
  int selectedIndex = 0;

  FeedbackMain({
    super.key,
  });

  @override
  State<FeedbackMain> createState() => FeedbackMainstate();
}

class FeedbackMainstate extends State<FeedbackMain> {
  String usernameValue = "Feedback";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final List<String> myopinions = [
    "PROVISIONAL DIAGNOSIS CODE",
    "S43.4 — Sprain and strain Of shoulder joint(Primary)",
    "S43.4 - Sprain and strain of shoulder joint",
  ];
  double? _selectedRating = 5.0;
  final myimageslist = [
    ["assets/profileM1.png"],
    ["assets/profileM2.png"],
    ["assets/profileM3.png"],
    ["assets/profileM4.png"],
  ];
  int selectedIndex = -1;



  TextEditingController? reviewtextcontroller = TextEditingController();
  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  //Asgar
  bool _isButtonEnabled = false;
  bool emojiCheck = false;

  bool isGuestUser =false;
  String UHID = "UHID";
  String mobileNumber = "Mobile Number";

  @override
  void initState() {
    _loadData();
    reviewtextcontroller!.addListener(_checkInput);
  }

  void _loadData() async {

    isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";


    // Dynamic naming: Guest01 for guest, otherwise use stored user name
    setState(() {});
    if (isGuestUser) {
      usernameValue = "Guest";
    } else {
      String? username = await UserSecureStorage.getUsernameid();
      Map<String, dynamic>? user = await UserSecureStorage.getUser(username!);

      if (user != null && user['data'] != null) {
        String? fname = user['data']['fname'];
        String? lname = user['data']['lname'];
        usernameValue = ((fname ?? "") + " " + (lname ?? "")).trim();
        mobileNumber = user['data']['mobile'] ?? "Mobile Number";
      } else {
        usernameValue = "ashdsaj";
      }
    }





    if (isGuestUser) {
      Timer(Duration(seconds: 0), () {
        LoginBottomSheet.show(context, true);
      });
    }
  }
  @override
  void dispose() {
    reviewtextcontroller!.removeListener(_checkInput);
    reviewtextcontroller!.dispose();
  }
  //Asgar
  void _checkInput() {

    setState(() {
      setState(() {

        if (  reviewtextcontroller!.text.trim().isNotEmpty   ) {
          _isButtonEnabled = true;
        } else {
          _isButtonEnabled = false;
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

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


          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  // Top Section
                  Header(userName: 'Feedback',showProfile: false,),


                  Expanded(
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.height * 0.03),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.height * 0.03),
                        ),
                      ),
                      child: Column(

                        children: [
                          Container(
                            padding: EdgeInsets.only(

                              top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.03,
                            ),
                            margin : EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height *
                                    0.02
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(screenHeight * 0.03),
                                topRight: Radius.circular(screenHeight * 0.03),
                              ),
                            ),
                            child:
                            Column(
                                children: [
                                  ProfileImagePicker(
                                    isGuestUser: isGuestUser, // Jo bhi aapka variable ho true/false ke liye pass karein
                                  ),
                                  const SizedBox(height : 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            left:
                                            MediaQuery.of(context).size.height * 0.01,
                                            right:
                                            MediaQuery.of(context).size.height * 0.01,
                                            top:
                                            MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height *
                                                0.00),
                                        child: Text(
                                          usernameValue,
                                          style: TextStyle(
                                              color: Colors.black,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  0.016),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left:
                                              MediaQuery.of(context).size.height * 0.01,
                                              right:
                                              MediaQuery.of(context).size.height * 0.01,
                                              top:
                                              MediaQuery.of(context).size.height * 0.00,
                                              bottom: MediaQuery.of(context).size.height *
                                                  0.00),
                                          child: RichText(
                                            text: TextSpan(
                                              text: "SID0007 | ${mobileNumber}",
                                              style: TextStyle(
                                                color: Color(0xFF126086),
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ]
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    Container(

                                      child: Text(
                                        "Your opinion is important to us!",
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018
                                        ),
                                      ),
                                    ),


                                  ],
                                ),

                                // Emoji Card
                                Container(
                                  // color: Colors.white,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // gradient: LinearGradient(
                                    //     begin: Alignment.centerLeft,
                                    //     end: Alignment.centerRight,
                                    //     stops: [0.5, 0.9],
                                    //     colors: [
                                    //       Color(0xFFE8F0F3),
                                    //       Color(0xFFE8F0F3)
                                    //     ])
                                    color : Color(0x1AD9D9D9),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.02,
                                      right: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.02,
                                      bottom: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.005,
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.007),
                                  padding: EdgeInsets.only(
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.005,
                                      right: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.005,
                                      bottom: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.005,
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.00),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Container(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height *
                                                0.07,
                                            right: MediaQuery.of(context).size.height *
                                                0.07,
                                            top: MediaQuery.of(context).size.height *
                                                0.02,
                                            bottom: MediaQuery.of(context).size.height *
                                                0.02),
                                        child: Text(
                                          "How was your overall experience in using the mobile app?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF1F1F1F),
                                              // overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500,

                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  0.014),
                                        ),
                                      ),

                                      Container(
                                        // color: Colors.yellow,

                                        padding: EdgeInsets.only(
                                            top:
                                            MediaQuery.of(context).size.height * 0.0,
                                            bottom:
                                            MediaQuery.of(context).size.height * 0.00,
                                            left:
                                            MediaQuery.of(context).size.height * 0.02,
                                            right: MediaQuery.of(context).size.height *
                                                0.02),
                                        margin: EdgeInsets.only(
                                            right:
                                            MediaQuery.of(context).size.height * 0.02,
                                            top:
                                            MediaQuery.of(context).size.height * 0.01,
                                            bottom:
                                            MediaQuery.of(context).size.height * 0.02,
                                            left: MediaQuery.of(context).size.height *
                                                0.02),

                                        child:
                                        CustomEmojiFeedback(
                                          showLabel : false,
                                          elementSize: MediaQuery.of(context).size.height * 0.035,
                                          animDuration: Duration(milliseconds: 300),
                                          // Optional animation
                                          onChanged: (rating) {
                                            setState(() {
                                              _selectedRating = rating.toDouble();
                                              emojiCheck = true;
                                            });
                                            print("Selected Rating: $rating");
                                          },
                                        ),
                                      ),

                                      Container(

                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.015,
                                            right: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.015,
                                            top: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00,
                                            bottom: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.02),
                                        child: TextFormField(

                                          /* inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9/]')),
                            ],*/
                                          keyboardType: TextInputType.text,
                                          maxLines: 6,
                                          onChanged: (value) {
                                            setState(() {
                                              /*  _trackErrorval = (value == null || value.isEmpty)
                                                              ? 'Please enter Application Number'
                                                              : "";*/

                                              /*_trackErrorval = (value == null || value.isEmpty)
                                    ? 'Please enter your email'
                                    : (RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{3,3}$')
                                            .hasMatch(value))
                                        ? ''
                                        : 'Invalid email format';*/
                                            });
                                          },

                                          controller: reviewtextcontroller,
                                          // maxLength: 500,
                                          // textCapitalization: TextCapitalization.characters,
                                          style:
                                          TextStyle(color: Colors.black),
                                          // onSaved: (input) => loginRequestModel.email = input,

                                          /*  validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                  .hasMatch(value)) {
                                return 'Invalid email format';
                              }
                              return null;
                            },*/

                                          decoration: InputDecoration(
                                            // errorText: _trackErrorval,
                                            errorStyle: TextStyle(
                                              // height: 0.1,
                                                color: Colors.red,
                                                fontSize:
                                                MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.020),
                                            errorMaxLines: 2,
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                // width: 2.0,
                                              ),
                                            ),

                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300]!),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300]!),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300]!),
                                            ),

                                            isDense: true,
                                            contentPadding:
                                            EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.025,
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.00,
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.025,
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.015,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText:
                                            "Write review.....",
                                            hintStyle: TextStyle(
                                                fontSize:
                                                MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.012,
                                                color: Colors.black26),
                                            // prefixIcon: Icon(Icons.person, color: Colors.black45,),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),


                                // Submit button
                                GestureDetector(
                                  onTap: () async {

                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(
                                          top:
                                          MediaQuery.of(context).size.height * 0.01,
                                          bottom:
                                          MediaQuery.of(context).size.height * 0.00,
                                          left:
                                          MediaQuery.of(context).size.height * 0.00,
                                          right: MediaQuery.of(context).size.height *
                                              0.00),
                                      margin: EdgeInsets.only(
                                          right:
                                          MediaQuery.of(context).size.height * 0.02,
                                          top:
                                          MediaQuery.of(context).size.height * 0.01,
                                          bottom:
                                          MediaQuery.of(context).size.height * 0.01,
                                          left: MediaQuery.of(context).size.height *
                                              0.02),
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.012),
                                                  // gradient: LinearGradient(
                                                  //     begin: Alignment.centerRight,
                                                  //     end: Alignment.center,
                                                  //     stops: [
                                                  //       0.5,
                                                  //       0.9
                                                  //     ],
                                                  //     colors:  (_isButtonEnabled && emojiCheck) ?  [
                                                  //       Color(0xFF126086),
                                                  //       Color(0xFF126086),
                                                  //     ] : [
                                                  //       Color(0xFFA8B1CE),
                                                  //       Color(0xFFA8B1CE),
                                                  //     ])

                                                  color : (_isButtonEnabled && emojiCheck) ? Color(0xFF126086) :  Color(0x99909090),
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(left: 0.0),
                                                child: TextButton(
                                                    onPressed: () async {

                                                    },
                                                    child: Text("Submit",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.018)
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),  // Remove default button padding
                                                      minimumSize: Size(0, 0), // Allow smallest possible size
                                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap area
                                                    )
                                                ),
                                              ),
                                            ),
                                          ])),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.045,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardVisible? null: CustomFloatingActionButton(),
      bottomNavigationBar: isKeyboardVisible? null: CustomBottomNavigationBar(selectedIndex: _selectedIndex),


      );
  }




}
