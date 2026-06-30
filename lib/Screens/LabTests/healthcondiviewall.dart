import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/Models/findspecialitiesres.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';

import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/LabTests/recomendtestviewall.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';

import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class HealthCondiViewall extends StatefulWidget {
  const HealthCondiViewall({
    super.key,
  });
  @override
  State<HealthCondiViewall> createState() =>
      HealthCondiViewallstate();
}

class HealthCondiViewallstate
    extends State<HealthCondiViewall> {
  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;
  int _selectedIndex = 0;
  List<SpecialityResponse>? responselist = [];

  String usernameValue = "Find health condition";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  final mybrowsebyhealthcond = [
    ["assets/Harmone.png", "Harmone"],
    ["assets/Diabetes.png", "Diabetes"],
    ["assets/JointPain.png", "Joint Pain"],
    ["assets/Thyroid.png", "Thyroid"],
    ["assets/Heart.png", "Heart"],
    ["assets/Bone.png", "Bone"],
    ["assets/BloodSugar.png", "Blood Sugar"],
    ["assets/Vitamin.png", "Vitamin"],
    ["assets/HairFall.png", "Hair Fall"],
    ["assets/Liver.png", "Liver"],
    ["assets/Kidney.png", "Kidney"],
    ["assets/Fever.png", "Fever"],
  ];


  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();
  TextEditingController SearchEditTextController = TextEditingController();

  @override
  void initState() {
    // getSharedPrefs();
    super.initState();
  }

  Future getSharedPrefs() async {
    // CheckSession();
    getSpecialitiesList();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    progressDialog.style(
        message: 'Loading..' '\nPlease Wait',
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
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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

              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.0,
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
                      // Search Input Field
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.0,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return QuickSearchWithoutData();
                                      },
                                    ),
                                  );
                                },
                                child:
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.05,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF7F5F6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),

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
                                        .height * 0.0,
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
                                        .height * 0.0,
                                  ),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.02,
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.00,
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.00,
                                            bottom: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.0),
                                        child: Text(
                                          "Search by Health Condition",
                                          style: TextStyle(
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
                                        ),
                                      ),


                                      // Container(
                                      //   padding: EdgeInsets.only(
                                      //       left: MediaQuery
                                      //           .of(context)
                                      //           .size
                                      //           .height *
                                      //           0.008,
                                      //       right: MediaQuery
                                      //           .of(context)
                                      //           .size
                                      //           .height *
                                      //           0.00,
                                      //       top: MediaQuery
                                      //           .of(context)
                                      //           .size
                                      //           .height *
                                      //           0.00,
                                      //       bottom: MediaQuery
                                      //           .of(context)
                                      //           .size
                                      //           .height *
                                      //           0.0),
                                      //   child:
                                      //   DefaultTextStyle(
                                      //     style: TextStyle(
                                      //         color: Color(0xFF126086),
                                      //         overflow: TextOverflow.ellipsis,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize:
                                      //         MediaQuery
                                      //             .of(context)
                                      //             .size
                                      //             .height * 0.016),
                                      //     child: AnimatedTextKit(
                                      //       animatedTexts: [
                                      //         RotateAnimatedText(
                                      //           'Doctor',
                                      //           textStyle: TextStyle(
                                      //               color: Color(0xFF126086),
                                      //               overflow: TextOverflow.ellipsis,
                                      //               fontWeight: FontWeight.bold,
                                      //               fontSize:
                                      //               MediaQuery
                                      //                   .of(context)
                                      //                   .size
                                      //                   .height *
                                      //                   0.014), // Red text
                                      //         ),
                                      //         RotateAnimatedText(
                                      //           'Speciality',
                                      //           textStyle: TextStyle(
                                      //               color: Color(0xFF126086),
                                      //               overflow: TextOverflow.ellipsis,
                                      //               fontWeight: FontWeight.bold,
                                      //               fontSize:
                                      //               MediaQuery
                                      //                   .of(context)
                                      //                   .size
                                      //                   .height *
                                      //                   0.014),
                                      //         ),
                                      //
                                      //         RotateAnimatedText(
                                      //           'Symptoms',
                                      //           textStyle: TextStyle(
                                      //               color: Color(0xFF126086),
                                      //               overflow: TextOverflow.ellipsis,
                                      //               fontWeight: FontWeight.bold,
                                      //               fontSize:
                                      //               MediaQuery
                                      //                   .of(context)
                                      //                   .size
                                      //                   .height *
                                      //                   0.014),
                                      //         ),
                                      //       ],
                                      //       repeatForever: true,
                                      //       pause: Duration(milliseconds: 500),
                                      //       onTap: () {
                                      //         Navigator.of(context).push(
                                      //           MaterialPageRoute(
                                      //             builder: (BuildContext context) {
                                      //               return QuickSearchWithoutData();
                                      //             },
                                      //           ),
                                      //         );
                                      //         print("Tap Event");
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),

                                      Spacer(),
                                      // Pushes the search icon to the end of the Row
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.02,
                                        ),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.black45,
                                          size: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.02,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   padding: EdgeInsets.only(
                      //       top: MediaQuery.of(context).size.height * 0.0,
                      //       bottom: MediaQuery.of(context).size.height * 0.00,
                      //       left: MediaQuery.of(context).size.height * 0.00,
                      //       right: MediaQuery.of(context).size.height * 0.00),
                      //   margin: EdgeInsets.only(
                      //       right: MediaQuery.of(context).size.height * 0.02,
                      //       top: MediaQuery.of(context).size.height * 0.0,
                      //       bottom: MediaQuery.of(context).size.height * 0.01,
                      //       left: MediaQuery.of(context).size.height * 0.02),
                      //   child: TextFormField(
                      //     controller: SearchEditTextController,
                      //     inputFormatters: [
                      //       LengthLimitingTextInputFormatter(15),
                      //       FilteringTextInputFormatter.allow(
                      //           RegExp('[a-zA-Z0-9]'))
                      //     ],
                      //     textCapitalization: TextCapitalization.characters,
                      //     style: TextStyle(color: Colors.black45),
                      //     keyboardType: TextInputType.emailAddress,
                      //     validator: (input) => input!.length < 3
                      //         ? "Search should be more than 3 characters"
                      //         : null,
                      //     decoration: InputDecoration(
                      //       isDense: true,
                      //       contentPadding:
                      //       EdgeInsets.all(screenHeight * 0.012),
                      //       filled: true,
                      //       fillColor: Colors.grey[200],
                      //       hintText: "Search By health condition",
                      //       hintStyle: TextStyle(
                      //         color: Colors.black26,
                      //         fontSize: screenHeight * 0.016,
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(5.0),
                      //         borderSide: BorderSide(color: Colors.grey),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(5.0)),
                      //         borderSide: BorderSide(color: Colors.white),
                      //       ),
                      //       suffixIcon: Icon(
                      //         Icons.search,
                      //         color: Colors.black45,
                      //         size: MediaQuery
                      //             .of(context)
                      //             .size
                      //             .height * 0.02,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Browse by health condition
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.02,
                            right: MediaQuery.of(context).size.height * 0.02,
                            bottom: MediaQuery.of(context).size.height * 0.016),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                    right: MediaQuery.of(context).size.height *
                                        0.00,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Top health condition",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.016,
                                  ),
                                ),
                              ),

                            ]),
                      ),

                      // Browse by health condition Grid
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
                            mybrowsebyhealthcond.length,
                                (index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Add specific actions for each index
                                    if (index == 0) {
                                      /*  Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return DiagnosticMain();
                                          },
                                        ),
                                      );*/
                                    } else if (index == 1) {
                                      /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return DoctorHCMain();
                                          },
                                        ),
                                      );*/
                                    }else if (index == 2) {
                                      /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return NurseHCMain();
                                          },
                                        ),
                                      );*/
                                    }else if (index == 3) {
                                      /* Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PhysioHCMain();
                                          },
                                        ),
                                      );*/
                                    } else if (index == 4) {
                                      /*  Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return MedicalEquipHCMain();
                                          },
                                        ),
                                      );*/
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return RecommendedViewAll(usernameValue: "Health Package",);
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
                                            mybrowsebyhealthcond[index][0]),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child:  Container(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.00,
                                      bottom: MediaQuery.of(context).size.height * 0.00,
                                      left: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.height * 0.005,
                                    ),
                                    child: Text(
                                      mybrowsebyhealthcond[index][1],
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
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardVisible ? null : CustomFloatingActionButton(),

      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }








  void getSpecialitiesList() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        /* progressDialog.showMaterial(
            title: "Loading Data", message: "Please wait");*/
        progressDialog.show();
        dynamic user = await apiService.findspecialitieslist();

        if (user.message != null) {
          progressDialog.hide();
          final snackBar = SnackBar(content: Text(user.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        // Get the list data and show it

        else if (user.response!.length > 0) {
          progressDialog.hide();

          setState(() {
            responselist = user.response;
          });

          /* final snackBar = SnackBar(
            content: Text("Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );*/
        } else {
          progressDialog.hide();
          final snackBar = SnackBar(
            content: Text("Specialities Not Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // customalert.showError(context, user.error);
        }
      } else {
        // No-Internet Case
        final snackBar = SnackBar(
          content: Text("No Internet, Check Connectivity!"),
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
