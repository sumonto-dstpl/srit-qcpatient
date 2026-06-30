import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
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
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/Widgets/homecare_otherservice_detail.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class HomeCareMain extends StatefulWidget {
  int selectedIndex = 0;
  HomeCareMain({
    super.key,
  });
  @override
  State<HomeCareMain> createState() => HomeCareMainstate();
}

class HomeCareMainstate extends State<HomeCareMain> {
  String usernameValue = "Home Care Services";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final mytopspecialities = [
    ["assets/Diagnostic.png", "Diagnostic"],
    ["assets/Doctor.png", "Doctor"],
    ["assets/Nurse.png", "Nurse"],
    ["assets/Physio.png", "Physio"],
    ["assets/MedicalEquipment.png", "Medical Equipment's"],
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
              Header(userName: usernameValue),

      Expanded(

        child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight * 0.03),
                  topRight: Radius.circular(screenHeight * 0.03),
                  bottomLeft: Radius.circular(screenHeight * 0.0),
                  bottomRight: Radius.circular(screenHeight * 0.00),
                  // bottomCenter: 0,
                ),
              ),
          child : Column(
            children: [

              Container(
                padding: EdgeInsets.only(
                left: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01,
                right: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01,
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.03),
                    topRight: Radius.circular(screenHeight * 0.03),
                    bottomLeft: Radius.circular(screenHeight * 0.0),
                    bottomRight: Radius.circular(screenHeight * 0.00),
                    // bottomCenter: 0,
                  ),
                ),
                child:
                Column(
                  children: [
                  // Search Input Field

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return QuickSearchWithoutData();
                            },
                          ),
                        );
                        print('Navigating to QuickSearchWithData!');
                      },
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.05,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0,
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                        ),
                        margin: EdgeInsets.only(
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0,
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                        ),
                        child: AbsorbPointer(
                          // Prevents the field from gaining focus or triggering gestures
                          child: TextFormField(
                            readOnly: true,
                            controller: SearchEditTextController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9]')),
                            ],
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(color: Colors.black45),
                            keyboardType: TextInputType.emailAddress,
                            validator: (input) => input!.length < 3
                                ? "Search should be more than 3 characters"
                                : null,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                              EdgeInsets.only(
                                top :  screenHeight * 0.012,
                                right :  screenHeight * 0.012,
                                bottom :  screenHeight * 0.012,
                                left :  screenHeight * 0.02,
                              ),
                              filled: true,
                              // fillColor: Colors.grey[200],
                              fillColor: const Color(0xFFF7F5F6),
                              hintText: "Search for Lab tests",
                              hintStyle: TextStyle(
                                  color: Color(0xFF999999),
                                  // overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.014
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.black45,
                                  size: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return QuickSearchWithData();
                                      },
                                    ),
                                  );
                                  print('Search icon clicked!');
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ]
                ),
              ),
              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.00),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.03),
                      topRight: Radius.circular(screenHeight * 0.03),
                    ),
                  ),
                  child: ListView(
                    children: [


                      // Home Care Services Grid
                      Container(
                        color: Colors.white,
                        child: GridView.count(
                          shrinkWrap:
                              true, // GridView takes only as much space as needed
                          physics:
                              NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.005,
                            bottom: MediaQuery.of(context).size.height * 0.00,
                          ),
                          crossAxisCount: 4,
                          crossAxisSpacing: screenHeight * 0.02,
                          mainAxisSpacing: screenHeight * 0.01,
                          children: List.generate(
                            mytopspecialities.length,
                            (index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  // onPressed: () {
                                  //   // Add specific actions for each index
                                  //   if (index == 0) {
                                  //     Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (BuildContext context) {
                                  //           return DiagnosticMain();
                                  //         },
                                  //       ),
                                  //     );
                                  //   } else if (index == 1) {
                                  //     Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (BuildContext context) {
                                  //           return DoctorHCMain();
                                  //         },
                                  //       ),
                                  //     );
                                  //   }else if (index == 2) {
                                  //     Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (BuildContext context) {
                                  //           return NurseHCMain();
                                  //         },
                                  //       ),
                                  //     );
                                  //   }else if (index == 3) {
                                  //     Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (BuildContext context) {
                                  //           return PhysioHCMain();
                                  //         },
                                  //       ),
                                  //     );
                                  //   } else if (index == 4) {
                                  //     Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (BuildContext context) {
                                  //           return MedicalEquipHCMain();
                                  //         },
                                  //       ),
                                  //     );
                                  //   }
                                  //   // Add more cases as needed
                                  // },

                                  onPressed: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          // return HomecareOtherserviceDetail(usernameValue : "Asgar");
                                          return HomecareOtherserviceDetail(usernameValue: mytopspecialities[index][1],);

                                        },
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFFE8F0F3),
                                    padding:
                                        EdgeInsets.all(screenHeight * 0.01),
                                    minimumSize: Size(screenHeight * 0.04,
                                        screenHeight * 0.04),
                                  ),
                                  child: Container(
                                    width: screenHeight * 0.03,
                                    height: screenHeight * 0.03,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            mytopspecialities[index][0]),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(screenHeight * 0.00),
                                    child: Text(
                                      mytopspecialities[index][1],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                (10 /
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height),
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
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




}
