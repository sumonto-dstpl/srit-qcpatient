import 'dart:convert';
import 'dart:ui';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/finddoctorslist.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithdata.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/HomeCare/diagnosticmain.dart';
import 'package:newfolder/Screens/HomeCare/doctorhcmain.dart';
import 'package:newfolder/Screens/HomeCare/homecaremain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Medications/medicationselecttime.dart';
import 'package:newfolder/Screens/Medications/medicationsmybook.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/PaymentHistory/paymenthistory.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Widgets/tab_item.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';


class PrivacyPolicyMain extends StatefulWidget {
  int selectedIndex = 0;

  PrivacyPolicyMain({
    super.key,
  });

  @override
  State<PrivacyPolicyMain> createState() => PrivacyPolicyMainstate();
}

class PrivacyPolicyMainstate extends State<PrivacyPolicyMain> {
  bool isGuestUser =false;
  String usernameValue = "Privacy Policy";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;

  int selectedIndex = -1;


  TextEditingController? reviewtextcontroller = TextEditingController();
  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  bool _isLoading = false;

  void _loadData() async {
    // await Future.delayed(const Duration(seconds: 2));// Simulating API call
    var guestUser = await UserSecureStorage.getIfGuestLogged();
    print("guestUser: $guestUser");
    isGuestUser=guestUser == "YES";
    setState(() {});
    if(!isGuestUser){
      String? username =  await UserSecureStorage.getUsernameid();
      print("username: $username");
      Map<String, dynamic>? user = await UserSecureStorage.getUser(username!);
      print("user : $user");
      final fname = user?['data']['fname'] ?? '';
      final lname = user?['data']['lname'] ?? '';
      final trimmedFname = fname.length > 5 ? fname.substring(0, 5) : fname;
      final trimmedLname = lname.length > 5 ? lname.substring(0, 5) : lname;
      usernameValue += fname+" "+lname;
    }else{
      usernameValue +="Guest";
    }
    print("usernameValue: $usernameValue");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Header(userName: usernameValue,showProfile: false,),

                // Main Content Section
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
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [


                        // About Us
                        Container(
                          padding: EdgeInsets.only(
                            left : screenHeight * 0.015,
                            right : screenHeight * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[

// Effective Date
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.015,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "Effective Date: 12/12/2010",
                                  style: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.height * 0.014),
                                ),
                              ),

// Last Updated
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.015,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "Last Updated: 12/12/2029",
                                  style: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.height * 0.014),
                                ),
                              ),

// 1. Introduction
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.015,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "1. Introduction",
                                  style: TextStyle(
                                      color: Color(0xFF126086),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height * 0.015),
                                ),
                              ),

// Intro Paragraph
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.005,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "Welcome to QC Hospital us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application (“App”). We are committed to protecting your personal health information in compliance with applicable laws and healthcare data standards. \n"
                                      "By using the QC Hospital App, you agree to the terms outlined in this Privacy Policy. If you do not agree, please discontinue use of the App.",
                                  style: TextStyle(
                                    color: Color(0xFF000000).withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                    height: screenHeight * 0.002,
                                  ),
                                ),
                              ),

// 2. Information We Collect
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.015,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "2. Information We Collect",
                                  style: TextStyle(
                                      color: Color(0xFF126086),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height * 0.015),
                                ),
                              ),

// Info Paragraphs
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.005,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "We may collect the following types of information:\n"
                                      "a. Personal Information\n"
                                      "• Full name, contact details (phone number, email address), gender, and date of birth.\n"
                                      "• Patient ID, hospital registration number, and medical record details.\n"
                                      "b. Health Information\n"
                                      "• Doctor consultations, prescriptions, lab reports, diagnoses, and medical history.\n"
                                      "• Appointment and billing information.\n"
                                      "c. Device and Usage Information\n"
                                      "• Device type, operating system, IP address, and app usage data.\n"
                                      "• Crash reports, analytics, and performance data (for improving app experience).",
                                  style: TextStyle(
                                    color: Color(0xFF000000).withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                    height: screenHeight * 0.002,
                                  ),
                                ),
                              ),

// 3. How We Use Your Information
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.015,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "3. How We Use Your Information",
                                  style: TextStyle(
                                      color: Color(0xFF126086),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height * 0.015),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.005,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "We use your information to:\n"
                                      "• Provide healthcare and hospital-related services.\n"
                                      "• Manage appointments, lab results, and billing.\n"
                                      "• Improve our app performance and user experience.\n"
                                      "• Communicate important updates, notifications, and reminders.\n"
                                      "• Ensure patient safety and maintain healthcare records securely.",
                                  style: TextStyle(
                                    color: Color(0xFF000000).withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                    height: screenHeight * 0.002,
                                  ),
                                ),
                              ),

// 4. Data Sharing and Disclosure
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.015,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "4. Data Sharing and Disclosure",
                                  style: TextStyle(
                                      color: Color(0xFF126086),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      fontSize: MediaQuery.of(context).size.height * 0.015),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right: MediaQuery.of(context).size.height * 0.01,
                                    top: MediaQuery.of(context).size.height * 0.005,
                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                child: Text(
                                  "We do not sell or share your personal data with third parties for marketing purposes.\n"
                                      "We may share limited information only in the following cases:\n"
                                      "• With your treating doctors, nurses, or authorized healthcare staff for providing medical care.\n"
                                      "• With laboratories, pharmacies, or insurance providers as required for your treatment.\n"
                                      "• To comply with legal or regulatory obligations (e.g., government health authorities).\n"
                                      "All partners and service providers are required to follow strict confidentiality and data protection standards.",
                                  style: TextStyle(
                                    color: Color(0xFF000000).withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                    height: screenHeight * 0.002,
                                  ),
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.05),





                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // First  - Center Docked
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  CustomFloatingActionButton(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }




}
