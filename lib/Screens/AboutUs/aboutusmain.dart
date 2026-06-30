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
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';

class AboutUsMain extends StatefulWidget {
  int selectedIndex = 0;

  AboutUsMain({
    super.key,
  });

  @override
  State<AboutUsMain> createState() => AboutUsMainstate();
}

class AboutUsMainstate extends State<AboutUsMain> {
  String usernameValue = "About us";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;

  int selectedIndex = -1;


  TextEditingController? reviewtextcontroller = TextEditingController();
  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

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


                        Container(
                          margin: EdgeInsets.only(
                            right: screenHeight * 0.0,
                            top: screenHeight * 0.0,
                            bottom: screenHeight * 0.01,
                            left: screenHeight * 0.0,
                          ), // Responsive margin
                          height: MediaQuery.of(context).size.height * 0.22,
                          decoration: BoxDecoration(
                            // color: Color(0xFFC80000), // Fallback color if image fails to load
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/contactusbanner.png'), // Path to your banner image
                              fit: BoxFit.fill, // Adjust to cover the entire container
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).hintColor.withOpacity(0.0),
                                offset: Offset(0, 4),
                                blurRadius: 9,
                              ),
                            ],
                          ),

                        ),


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
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.015,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "About Us",
                                  style: TextStyle(
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.018),
                                ),
                              ),



                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.005,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text( "Know more about us,",
                                  style: TextStyle(
                                      color: Color(0xFF000000).withOpacity(0.4),
                                      fontWeight: FontWeight.w500,
                                      // overflow: TextOverflow.ellipsis,
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.015
                                  ),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005),
                                child: Text( "Welcome to Quadracyte Hospital, where cutting-edge healthcare meets compassionate care. As a leading multispecialty hospital, we are dedicated to providing comprehensive, patient-centered medical services designed to meet the diverse needs of our community.",
                                  style: TextStyle(
                                    color: Color(0xFF000000).withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.012,
                                    height: screenHeight * 0.0025,
                                  ),
                                ),
                              ),



                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005),
                                child: Text( "At Quadracyte Hospital, our mission is to enhance the health and well-being of our patients through exceptional care, innovation, and education. We strive to deliver personalized, high-quality medical treatment with a focus on compassion, integrity, and excellence.",
                                  style: TextStyle(
                                    color: Color(0xFF000000).withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.012,
                                    height: screenHeight * 0.0025,
                                  ),
                                ),
                              ),



                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                    right: MediaQuery.of(context).size.height *
                                        0.01,
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text( "We envision a future where every patient receives top-tier healthcare in a supportive, state-of-the-art environment. By integrating the latest medical advancements with a holistic approach to treatment, we aim to set new standards in patient care and clinical outcomes.",
                                  style: TextStyle(
                                    color: Color(0xFF000000).withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.012,
                                    height: screenHeight * 0.0025,
                                  ),
                                ),
                              ),




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
