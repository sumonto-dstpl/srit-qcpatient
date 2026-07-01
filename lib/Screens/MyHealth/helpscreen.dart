import 'dart:convert';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Core/size.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/finddoctorslist.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithdata.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/HomeCare/diagnosticmain.dart';
import 'package:newfolder/Screens/HomeCare/doctorhcmain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class HelpscreenMain extends StatefulWidget {
  int selectedIndex = 4;

  HelpscreenMain({
    super.key,
  });

  @override
  State<HelpscreenMain> createState() => HelpscreenMainstate();
}

class HelpscreenMainstate extends State<HelpscreenMain> {
  String usernameValue = "My Health";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 4;

  final mytopspecialities = [
    ["assets/Diagnostic.png", "My Prescription"],
    ["assets/Doctor.png", "Test Reports"],
    ["assets/Nurse.png", "My Medications"],
    ["assets/Physio.png", "Health Records"],
    ["assets/MedicalEquipment.png", "Radiology"],
    ["assets/Physio.png", "Timeline"],
    ["assets/MedicalEquipment.png", "Hospital Invoice"],
  ];

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
        child: Stack(children: [
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  bottom: screenWidth * 0.02,
                ),
                margin: EdgeInsets.only(
                  right: screenHeight * 0.0,
                  top: screenHeight * 0.0,
                  bottom: screenHeight * 0.01,
                  left: screenHeight * 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ),

              // Main Content Section
              Expanded(
                child: Container(

                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.03),
                      topRight: Radius.circular(screenHeight * 0.03),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: AppSize.headerHeight,),

                      Container(

                        margin: EdgeInsets.only(
                          right: screenHeight * 0.025,

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.02,
                                ),
                                height: screenHeight * 0.035,
                                width: screenHeight * 0.035,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7F5F6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: Color(0xFF999999),
                                  size: screenHeight * 0.018,
                                ),
                              ),
                            ),

                            // Help Text (Centered)
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Help",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.018,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            // Placeholder to Balance Row (Keeps Help Text Centered)
                            SizedBox(width: screenHeight * 0.035),

                          ],
                        )
                        ,
                      ),
                      SizedBox(height: AppSize.headerHeight,),
                      // Select your Issue
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.025,


                             ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select your Issue",
                            style: TextStyle(
                              fontSize:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.014,
                              color: Color(0xFF1F1F1F),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      _buildCard(context, "Account related queries"),
                      SizedBox(height: 8,),
                      _buildCard(context, "Record related queries"),
                      SizedBox(height: 8,),
                      _buildCard(context, "I want to delete my account"),
                      SizedBox(height: 8,),
                      _buildCard(context, "I have logged in but I am not able to see my profile"),
                      SizedBox(height: 8,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  CustomFloatingActionButton(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }

  Widget _buildCard(BuildContext context,String text) {
     return  GestureDetector(
       onTap: () {

       },
       child:Container(
         margin: EdgeInsets.only(
             left: MediaQuery.of(context)
                 .size
                 .height *
                 0.025,
             right: MediaQuery.of(context)
                 .size
                 .height *
                 0.025,
              ),
         decoration: BoxDecoration(
           color: Color(0xFFA8B1CE).withOpacity(0.1), // Background color of the container

           borderRadius: BorderRadius.circular(
               8), // Optional: Rounded corners
         ),

         // color: Colors.white,
         child: Container(
           // color: Colors.white,

           decoration: BoxDecoration(
               borderRadius:
               BorderRadius.circular(10),
               gradient: LinearGradient(
                   begin:Alignment.centerLeft,
                   end:Alignment.centerRight,
                   stops: [0.5,0.9],
                   colors: [Color(0xFFA8B1CE).withOpacity(0.1),Color(0xFFA8B1CE).withOpacity(0.1),]
               )),

           padding: EdgeInsets.all(MediaQuery.of(context).size.height *0.005,),

           child: Column(
             crossAxisAlignment:
             CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 padding: EdgeInsets.only(
                   left:
                   MediaQuery.of(context)
                       .size
                       .height *
                       0.005,
                   right:
                   MediaQuery.of(context)
                       .size
                       .height *
                       0.025,
                   top:
                   MediaQuery.of(context)
                       .size
                       .height *
                       0.01,
                   bottom:
                   MediaQuery.of(context)
                       .size
                       .height *
                       0.01,
                 ),
                 child: Row(
                   crossAxisAlignment:
                   CrossAxisAlignment
                       .center,
                   mainAxisAlignment:
                   MainAxisAlignment
                       .start,
                   children: <Widget>[

                     SizedBox(
                         width: MediaQuery.of(
                             context)
                             .size
                             .height *
                             0.010),
                     Expanded(
                       flex: 8,
                       child: Column(
                         crossAxisAlignment:
                         CrossAxisAlignment
                             .start,
                         mainAxisAlignment:
                         MainAxisAlignment
                             .center,
                         children: <Widget>[
                           Container(
                             padding:
                             EdgeInsets
                                 .only(
                               left: MediaQuery.of(
                                   context)
                                   .size
                                   .height *
                                   0.00,
                               right: MediaQuery.of(
                                   context)
                                   .size
                                   .height *
                                   0.00,
                               top: MediaQuery.of(
                                   context)
                                   .size
                                   .height *
                                   0.0,
                               bottom: MediaQuery.of(
                                   context)
                                   .size
                                   .height *
                                   0.00,
                             ),
                             child: Text(
                               text,
                               style:
                               TextStyle(
                                 color: Color(0xFF126086),
                                 overflow:
                                 TextOverflow
                                     .ellipsis,
                                 fontWeight:
                                 FontWeight
                                     .w500,
                                 fontSize: MediaQuery.of(context)
                                     .size
                                     .height *
                                     0.0135,
                               ),
                             ),
                           ),

                         ],
                       ),
                     ),
                     // Adding the side arrow at the end
                     Icon(
                       Icons
                           .arrow_forward_ios,
                       size: MediaQuery.of(
                           context)
                           .size
                           .height *
                           0.014, // Dynamic icon size
                       color:
                       Color(0xFF126086),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
       ),
     ) ;
  }

}
