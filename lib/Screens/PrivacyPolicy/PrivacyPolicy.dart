import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';


class PrivacyPolicyMain extends StatefulWidget {

  PrivacyPolicyMain({
    super.key,
  });

  @override
  State<PrivacyPolicyMain> createState() => PrivacyPolicyMainstate();
}

class PrivacyPolicyMainstate extends State<PrivacyPolicyMain> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;


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
                Header(userName: 'Privacy Policy',showProfile: false,),

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
