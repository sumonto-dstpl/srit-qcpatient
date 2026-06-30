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


class TermsandconditionsMain extends StatefulWidget {
  int selectedIndex = 0;

  TermsandconditionsMain({
    super.key,
  });

  @override
  State<TermsandconditionsMain> createState() => TermsAndConditionsMainstate();
}

class TermsAndConditionsMainstate extends State<TermsandconditionsMain> {
  bool isGuestUser =false;
  String usernameValue = "Terms & Conditions";
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

                              Container(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.01,
                                  right: MediaQuery.of(context).size.height * 0.01,
                                  top: MediaQuery.of(context).size.height * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                ),
                                child: Text(
                                  "These terms may be changed from time to time without further notice, at the discretion of QC. Your continued use of the Site after any such changes constitutes your acceptance of the new terms. If you do not agree to abide by these or any future terms, please do not use the Site or download content from it.\n\n"
                                      "The Website and App provide you the ability to pay online through a third party payment gateway for some of the Services available on the Website or App. If you choose to pay online, you may be directed to a third party payment gateway to enable processing of the payment. This transaction will be governed by the terms and conditions and privacy policy of the third party payment gateway. QC shall not be liable for any loss or damage arising directly or indirectly arising out of the usage, decline or acceptance of authorization for any transaction, for any reason whatsoever.\n\n"
                                      "The cancellation and refund policy is only applicable to all online payments made through mobile app and website for booking appointments.\n\n"
                                      "In case cancellation is initiated by the user, at the time of cancellation, amount will be refunded via same source of payment and will be subject to the payment terms of the source only. Amount will be refunded within 15 working days.\n\n"
                                      "Some of the content, text, data, graphics, images, information, suggestions, guidance, and other material (collectively, \"Information\") that may be available on the Website (including information provided in direct response to your questions or postings) may be provided by individuals in the medical profession. The provision of such Information does not create a licensed medical professional/patient relationship, between QC and you and does not constitute an opinion, medical advice, or diagnosis or treatment of any particular condition, but is only provided to assist you with locating appropriate medical care from a qualified practitioner. In case of a medical emergency (either on your or another person's behalf), please contact an ambulance service, hospital, doctor or appropriate medical professional directly.\n\n"
                                      "By using this Website and App, you agree that any information shared by you with QC or with any other person, medical service provider or anyone else using the Website, App or Services will be subject to our Privacy Policy.\n\n"
                                      "You are solely responsible for the content that you choose to submit for publication on the Website, including any feedback, ratings, or reviews. QC disclaims all responsibility with respect to the content that you post on the Website and QC shall be entitled to re-publishing any content across any of its or its Partners platforms.",
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
