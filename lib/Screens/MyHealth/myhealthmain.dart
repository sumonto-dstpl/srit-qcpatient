import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newfolder/Core/Dialog/delete_dialog.dart';
import 'package:newfolder/Core/size.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Medications/medicationsmain.dart';
import 'package:newfolder/Screens/MyHealth/helpscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/PaymentHistory/paymenthistory.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Radiology/pastupcomingtestscan.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/Timeline/timelinemain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class MyHealthMain extends StatefulWidget {
  final int selectedIndex ;
  MyHealthMain({
    super.key,
    this.selectedIndex = 4,
  });
  @override
  State<MyHealthMain> createState() => MyHealthMainstate();
}

class MyHealthMainstate extends State<MyHealthMain> {
  String usernameValue = "My Health";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";


  final mytopspecialities = [
    ["assets/myhealthMyPrescription.png", "My Prescription"],
    ["assets/myhealthTestReports.png", "Test Reports"],
    ["assets/Medications_ls.png", "My Medications"],
    ["assets/myhealthmyhealthHealthRecords.png", "Health Records"],
    ["assets/myhealthRadiology.png", "Radiology"],
    ["assets/myhealthTimeline.png", "Timeline"],
    ["assets/myhealthHospitalInvoice.png", "Hospital Invoice"],
  ];

  final List<String> uploadfilestime = [
    "Now",
    "15 min ago",
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _loadData();
  }

  void _loadData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating API call
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
        decoration: !_isLoading
            ? const BoxDecoration(
                image: DecorationImage(
                  // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
                  image: AssetImage("assets/Background Pattern.png"),
                  fit:
                      BoxFit.cover, // Adjusts how the image fills the container
                ),
              )
            : const BoxDecoration(
                color: Colors.white,
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
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: AppSize.headerHeight,),

                      !_isLoading
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.025,
                                  right:
                                      MediaQuery.of(context).size.height * 0.0,
                                  top: MediaQuery.of(context).size.height *
                                      0.0,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.00),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Your health at your fingertips",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.014,
                                    color: Color(0xFF1F1F1F),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                  right:
                                      MediaQuery.of(context).size.height * 0.02,
                                  left:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                height: screenHeight * 0.008,
                                width: screenWidth * 0.4,
                                decoration: BoxDecoration(
                                  // color : Colors.red,
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    tileMode: TileMode.clamp,
                                    colors: [
                                      Color(0xFFCCCCCC),
                                      Color(0x99E8E8E8),
                                      Color(0xFFC4C4C4),
                                    ],
                                  ),
                                ),
                              ),
                            ),



                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.height * 0.02,
                            // ⬇️ पहली row–container gap कम करने के लिए 0 कर सकते हैं
                            mainAxisSpacing: 0,
                            childAspectRatio: 0.9,
                          ),
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.02,
                          ),
                          itemCount: mytopspecialities.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  // ---------- Icon Button ----------
                                  TextButton(
                                    onPressed: () async {
                                      print("index : $index");
                                        if (index == 0) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return MyReportsMain(initialTabIndex: 0,selectedIndex: widget.selectedIndex,);
                                              },
                                            ),
                                          );
                                        } else if (index == 1) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return MyReportsMain(initialTabIndex: 1,selectedIndex: widget.selectedIndex,);
                                              },
                                            ),
                                          );
                                        } else if (index == 2) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return MedicationsMain(selectedIndex: widget.selectedIndex,);
                                              },
                                            ),
                                          );
                                        } else if (index == 3) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return MyReportsMain(initialTabIndex: 1,selectedIndex: widget.selectedIndex,);
                                              },
                                            ),
                                          );
                                        } else if (index == 4) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return PastUpcomingscanMain(selectedIndex: widget.selectedIndex,);
                                              },
                                            ),
                                          );
                                        }
                                        else if (index == 5) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return TimelineMain(selectedIndex: widget.selectedIndex,);
                                              },
                                            ),
                                          );
                                        } else if (index == 6) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) {
                                                    return PaymentHistoryMain();
                                                  },
                                              )
                                          );
                                        }
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFFE8F0F3),
                                      // backgroundColor : Colors.red,
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

                                  SizedBox(height: screenHeight * 0.008),

                                  // ---------- Label ----------
                                  Expanded(
                                    child: Text(
                                      mytopspecialities[index][1],
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        height: 0.95,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // ✅ Only show the title if there are uploaded prescriptions
                      if (uploadfilestime.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.025,
                              right: MediaQuery.of(context).size.height * 0.0,
                              top: MediaQuery.of(context).size.height * 0.015,
                              bottom: MediaQuery.of(context).size.height * 0.00),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Uploaded Health Records",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                color: Color(0xFF1F1F1F),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),

                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.015,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: uploadfilestime.length,
                          itemBuilder: (context, index) {
                            final file = uploadfilestime[index];

                            return Dismissible(
                              key: Key(file),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                // color: Colors.red,

                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Image.asset(
                                    'assets/deleteicon.png',
                                    height: 20,
                                    width: 20,

                                  )
                              ),
                              confirmDismiss: (direction) async {

                                return await DeleteDialog.show(
                                  context: context,
                                  barrierLabel: "MyHealthDelete",
                                  message: "Are you sure to Remove the Selected Medication ?",

                                );



                              },
                              onDismissed: (direction) {
                                showTopNotification(
                                  context,
                                  title: "Deleted Successfully",
                                  message: "The prescription has been removed.",
                                  type: NotificationType.error,
                                );
                                setState(() {
                                  uploadfilestime.removeAt(index);
                                });

                              },
                              child: GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 0.0,
                                  color: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.00,
                                      right: MediaQuery.of(context).size.height * 0.00,
                                      bottom: MediaQuery.of(context).size.height * 0.0,
                                      top: MediaQuery.of(context).size.height * 0.00,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          stops: [0.5, 0.9],
                                          colors: [Color(0xFFffffff), Color(0xFFffffff)],
                                        ),
                                      ),
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context).size.height * 0.005,
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: screenHeight * 0.06,
                                                  width: screenHeight * 0.06,
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: screenHeight * 0.01,
                                                    vertical: screenHeight * 0.005,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(130.0),
                                                    child: Image.asset(
                                                      'assets/medicationjpg.png',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.height * 0.010,
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        "Prescription_1.jpg",
                                                        style: TextStyle(
                                                          color: Colors.black87,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: MediaQuery.of(context).size.height * 0.014,
                                                        ),
                                                      ),
                                                      Text(
                                                        "5 Mb",
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight: FontWeight.bold,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: MediaQuery.of(context).size.height * 0.012,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(right: screenHeight * 0.01),
                                                  child: Text(
                                                    uploadfilestime[index],
                                                    style: TextStyle(
                                                      fontSize: screenHeight * 0.011,
                                                      color: Color(0xFF126086),
                                                      fontWeight: FontWeight.w500,
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
                                ),
                              ),
                            );
                          },
                        ),
                      ),


                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return HelpscreenMain();
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.025,
                              right: MediaQuery.of(context).size.height * 0.025,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005,
                              top: MediaQuery.of(context).size.height * 0.015),
                          decoration: BoxDecoration(
                            color: Color(0xFFA8B1CE).withOpacity(
                                0.1), // Background color of the container
                            /*  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(
                                          0.1), // Shadow color
                                      blurRadius:
                                      5, // Spread of the shadow
                                      offset: Offset(0,
                                          0), // Offset in x and y direction
                                    ),
                                  ],*/
                            borderRadius: BorderRadius.circular(
                                8), // Optional: Rounded corners
                          ),

                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.0,
                              top: MediaQuery.of(context).size.height * 0.00),
                          // color: Colors.white,
                          child: Container(
                            // color: Colors.white,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [
                                      0.5,
                                      0.9
                                    ],
                                    colors: [
                                      Color(0xFFA8B1CE).withOpacity(0.1),
                                      Color(0xFFA8B1CE).withOpacity(0.1),
                                    ])),

                            padding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.005,
                                right:
                                    MediaQuery.of(context).size.height * 0.005,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.005,
                                top:
                                    MediaQuery.of(context).size.height * 0.005),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.005,
                                    right: MediaQuery.of(context).size.height *
                                        0.025,
                                    top: MediaQuery.of(context).size.height *
                                        0.00,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.00,
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            child: Image.asset(
                                              'assets/myhealthhelp.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.010),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00,
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.0,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00,
                                              ),
                                              child: Text(
                                                "Help & Support",
                                                style: TextStyle(
                                                  color: Color(0xFF126086),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MediaQuery.of(context)
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
                                        Icons.arrow_forward_ios,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.014, // Dynamic icon size
                                        color: Color(0xFF126086),
                                      ),
                                    ],
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
      floatingActionButton:  CustomFloatingActionButton(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: widget.selectedIndex),
    );
  }


}
