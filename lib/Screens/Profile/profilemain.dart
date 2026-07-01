import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:newfolder/Screens/AboutUs/aboutusmain.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/Alerts/addmemberbottomsheet.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Feedback/feedback.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Login/loginpage.dart';
import 'package:newfolder/Screens/Maps/google_map_screen.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyUploads/profilemyuploads.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/PaymentHistory/paymenthistory.dart';
import 'package:newfolder/Screens/Settings/settings.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:newfolder/Screens/Alerts/loginbottomsheet.dart';

import '../Utils/profile_avatar.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class ProfileMain extends StatefulWidget {
  int selectedIndex = 0;

  ProfileMain({
    super.key,
  });

  @override
  State<ProfileMain> createState() => ProfileMainstate();
}

class ProfileMainstate extends State<ProfileMain> {
  String usernameValue = "";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  bool isGuestUser =false;
  File? selectedImage;
  String UHID = "UHID";
  String mobileNumber = "Mobile Number";


  List<Map<String, dynamic>> myimageslist = [
    {
      "image": "assets/profileM4.png",
      "firstName": "",
      "lastName": "",
      "uhid": "",
      "mobileNumber": "",
      "email": "",
      "relationship": "",
      "gender": "",
    },
    {
      "image": "assets/profileM1.png",
      "firstName": "Nutan",
      "lastName": "Bhatt",
      "uhid": "UHID002",
      "mobileNumber": "9123456789",
      "email": "nutan@example.com",
      "relationship": "Mother",
      "gender": "Female",
    },
    {
      "image": "",
      "firstName": "Asgar",
      "lastName": "Kumar",
      "uhid": "UHID003",
      "mobileNumber": "9988776655",
      "email": "rohan@example.com",
      "relationship": "Brother",
      "gender": "Male",
    },
    {
      "image": "assets/profileM3.png",
      "firstName": "Priya",
      "lastName": "Sharma",
      "uhid": "UHID004",
      "mobileNumber": "8877665544",
      "email": "priya@example.com",
      "relationship": "Sister",
      "gender": "Female",
    },

  ];


  @override
  void initState(){
    _loadData();
    // checkGuestUser();
    super.initState();
  }
  void _loadData() async {
    // await Future.delayed(const Duration(seconds: 2));// Simulating API call
    isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";


    // Dynamic naming: Guest01 for guest, otherwise use stored user name
    setState(() {});
    if (isGuestUser) {
      usernameValue = "Guest";
    } else {
      String? username = await UserSecureStorage.getUsernameid();
      Map<String, dynamic>? user = await UserSecureStorage.getUser(username!);
      print("user 111: $user");
      if (user != null && user['data'] != null) {
        String? fname = user['data']['fname'];
        String? lname = user['data']['lname'];
        usernameValue = ((fname ?? "") + " " + (lname ?? "")).trim();
        mobileNumber = user['data']['mobile'] ?? "Mobile Number";
      } else {
        usernameValue = "ashdsaj";
      }
    }

    myimageslist = isGuestUser ? [myimageslist[0]] : myimageslist;



    if (isGuestUser) {
      Timer(Duration(seconds: 0), () {
        LoginBottomSheet.show(context, true);
      });
    }
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
                Header(userName: 'My Profile',showProfile: false,),


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
                              left: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.00,
                              right: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.00,
                              top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                              bottom: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.00),
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
                                GestureDetector(
                                  onTap: () async {
                                    if (isGuestUser) return; // disable picking for guest users

                                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                    );

                                    if (result != null) {
                                      setState(() {
                                        selectedImage = File(result.files.single.path!);
                                      });
                                    }
                                  },
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        isGuestUser
                                            ? ProfileAvatar(
                                          name: "Guest User",
                                          radius: MediaQuery.of(context).size.height * 0.06,
                                          backgroundColor: Color(0x66D9D9D9),
                                          textColor: Colors.white,
                                        )
                                            : ClipRRect(
                                          borderRadius: BorderRadius.circular(130.0),
                                          child: selectedImage != null
                                              ? Image.file(
                                            selectedImage!,
                                            height: MediaQuery.of(context).size.height * 0.12,
                                            width: MediaQuery.of(context).size.height * 0.12,
                                            fit: BoxFit.cover,
                                          )
                                              : Image.asset(
                                            'assets/drsujeet.png',
                                            height: MediaQuery.of(context).size.height * 0.12,
                                            width: MediaQuery.of(context).size.height * 0.12,
                                            fit: BoxFit.fill,
                                          ),
                                        ),

                                        if (!isGuestUser)
                                          Positioned(
                                            bottom: 6,
                                            right: 4,
                                            child: Container(
                                              width: MediaQuery.of(context).size.height * 0.018,
                                              height: MediaQuery.of(context).size.height * 0.018,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green,
                                                border: Border.all(
                                                  width: MediaQuery.of(context).size.height * 0.002,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),

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
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,


                            ),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: [
                                //  Family members
                                GestureDetector(
                                  onTap: () {},


                                  child: _buildCard(context, 'Family Members', 'assets/profileFamilymembers.png',isIcon: false),
                                ),

                                // Family Members Details
                                Container(
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row( // <-- Main parent ab ek Row hai, SingleChildScrollView nahi
                                    children: [

                                      // ==========================================
                                      // 1. FIXED ELEMENT (Index 0)
                                      // ==========================================
                                      if (myimageslist.isNotEmpty) // Safety check
                                        GestureDetector(
                                          onTap: () async {
                                            final result = await AddMemberBottomSheet.show(context);
                                            print("result : $result");

                                            if (result != null) {
                                              setState(() {
                                                myimageslist.insert(1, result);
                                              });
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: screenHeight * 0.02,
                                              right: screenHeight * 0.01,

                                              bottom: screenHeight * 0.01,

                                            ),
                                            height: screenHeight * 0.07,
                                            width: screenHeight * 0.07,
                                            child: Image.asset(
                                              myimageslist[0]['image'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),

                                      // ==========================================
                                      // 2. SCROLLABLE ELEMENTS (Index 1 to End)
                                      // ==========================================
                                      Expanded(
                                        // Expanded isliye use kiya taaki list baaki bachi hui jagah le le
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            // yahan list size (length - 1) kar diya hai
                                            children: List.generate(myimageslist.length - 1, (i) {

                                              int index = i + 1; // Actual index 1 se start hoga
                                              final item = myimageslist[index];

                                              bool isImageNotAvailable = item['image'].toString().isEmpty;
                                              String firstChar = isImageNotAvailable ? item['firstName'][0] : "A";

                                              Widget imageWidget;
                                              if (isImageNotAvailable) {
                                                // No image → show first character
                                                imageWidget = Container(
                                                  margin: EdgeInsets.only(
                                                    left: index == 1 ? 0 : screenHeight * 0.01,
                                                    bottom: screenHeight * 0.01,
                                                  ),
                                                  height: screenHeight * 0.07,
                                                  width: screenHeight * 0.07,
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xFFCF8D41),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    firstChar,
                                                    style: TextStyle(
                                                      fontSize: screenHeight * 0.038,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xFFFFFFFF),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                final imagePath = item['image'].toString();

                                                if (imagePath.startsWith("/")) {
                                                  // Local file path → cache / camera image
                                                  imageWidget = Container(
                                                    margin: EdgeInsets.only(
                                                      left: index == 1 ? 0 : screenHeight * 0.01,

                                                      bottom: screenHeight * 0.01,
                                                    ),
                                                    height: screenHeight * 0.07,
                                                    width: screenHeight * 0.07,
                                                    child: ClipOval(
                                                      child: Image.file(
                                                        File(imagePath),
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  // Asset image
                                                  imageWidget = Container(
                                                    margin: EdgeInsets.only(
                                                      left: index == 1 ? 0 : screenHeight * 0.01,

                                                      bottom: screenHeight * 0.01,
                                                    ),
                                                    height: screenHeight * 0.07,
                                                    width: screenHeight * 0.07,
                                                    alignment: Alignment.center,
                                                    child: Image.asset("assets/profileM2.png"),
                                                  );
                                                }
                                              }

                                              return GestureDetector(
                                                onTap: () async {
                                                  debugPrint("Tapped on image ${myimageslist[index]}");
                                                  print("index : $index");
                                                  final result = await AddMemberBottomSheet.show(
                                                    context,
                                                    editDetail: item,
                                                    operation: "edit",
                                                  );
                                                  print("result : $result");
                                                  if (result != null) {
                                                    setState(() {
                                                      myimageslist[index] = result;
                                                    });
                                                  }
                                                },
                                                child: imageWidget,
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    showBottomSheet();
                                  },
                                  child: _buildCard(context, 'Appointments', 'assets/profileAppointments.png'),
                                ),

                                //  Uploads
                                GestureDetector(
                                    onTap: () async {
                                      final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";

                                      if (isLoggedIn == "YES") {
                                        // Show login bottom sheet for guest users
                                        Timer(const Duration(milliseconds: 0), () {
                                          LoginBottomSheet.show(context, false);
                                        });
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return ProfileMyUploadMain();
                                        },
                                      ),
                                    );
                                  }
                                      },
                                  child: _buildCard(context, 'Uploads', 'assets/profileUploads.png'),
                                ),
                                //  Payment history
                                GestureDetector(
                                    onTap: () async {
                                      final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";

                                      if (isLoggedIn == "YES") {
                                        // Show login bottom sheet for guest users
                                        Timer(const Duration(milliseconds: 0), () {
                                          LoginBottomSheet.show(context, false);
                                        });
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return PaymentHistoryMain();
                                        },
                                      ),
                                    );
                                  }
                                      },
                                  child: _buildCard(context, 'Payment History', 'assets/profilePaymenthistory.png'),
                                ),

                                //  My Address
                                GestureDetector(
                                    onTap: () async {
                                      final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";

                                      if (isLoggedIn == "YES") {
                                        // Show login bottom sheet for guest users
                                        Timer(const Duration(milliseconds: 0), () {
                                          LoginBottomSheet.show(context, false);
                                        });
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return GoogleMapScreen();
                                            },
                                          ),
                                        );
                                      }
                                      },
                                  child: _buildCard(context, 'My Address', 'assets/profileMyAddress.png'),
                                ),

                                // Feedback
                                GestureDetector(
                                    onTap: () async {
                                      final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";

                                      if (isLoggedIn == "YES") {
                                        // Show login bottom sheet for guest users
                                        Timer(const Duration(milliseconds: 0), () {
                                          LoginBottomSheet.show(context, false);
                                        });
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return FeedbackMain();
                                            },
                                          ),
                                        );
                                      }
                                      },
                                  child: _buildCard(context, 'Feedback', 'assets/profileFeedback.png'),
                                ),

                                //  About us
                                GestureDetector(
                                    onTap: () async {
                                      final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";

                                      if (isLoggedIn == "YES") {
                                        // Show login bottom sheet for guest users
                                        Timer(const Duration(milliseconds: 0), () {
                                          LoginBottomSheet.show(context, false);
                                        });
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return AboutUsMain();
                                            },
                                          ),
                                        );
                                      }
                                      },
                                  child: _buildCard(context, 'About Us', 'assets/profileAboutus.png'),
                                ),

                                //  Settings
                                GestureDetector(
                                    onTap: () async {
                                      final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";

                                      if (isLoggedIn == "YES") {
                                        // Show login bottom sheet for guest users
                                        Timer(const Duration(milliseconds: 0), () {
                                          LoginBottomSheet.show(context, false);
                                        });
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return SettingsMain(mobileNumber: mobileNumber,);
                                        },
                                      ),
                                    );
                                  }
                                      },
                                  child: _buildCard(context, 'Settings', 'assets/profileSettings.png'),
                                ),

                                // Log out
                                GestureDetector(
                                  onTap: () {
                                    showBottomSheetforlogout();
                                  },
                                  child: _buildCard(context, 'Log out', 'assets/profileLogout.png'),
                                ),

                                SizedBox(height: screenHeight * 0.1,),
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  CustomFloatingActionButton(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }



  void showBottomSheet() =>
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent, // Make modal background transparent
          barrierColor: Colors.transparent,
          transitionAnimationController: AnimationController(
            duration: const Duration(milliseconds: 200),
            vsync: Navigator.of(context),
          ),// No default barrier color
          builder: (BuildContext context) {
            return Stack(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, -2), // Shadow appears above the sheet
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ), // Keep your content background
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter setState) =>
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.025,
                                          right: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.0,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.015),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
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
                                                .height * 0.00,
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00,
                                          ),
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
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[


                                              GestureDetector(


                                                child: Center(
                                                  child: Container(

                                                    padding: EdgeInsets.only(
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.03,
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.18,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.18,
                                                    ),


                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.23,
                                                    // Same thickness as Divider
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.006,
                                                    // Same thickness as Divider
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFD9D9D9),
                                                      // Divider color
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          10), // Rounded edges
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.02),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.0,
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.02,
                                                    bottom: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.00),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
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
                                                                0.00),
                                                        child: Text(
                                                          "Select the Type of Appointment",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF2F3335),
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontSize:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.016,
                                                          ),
                                                        ),
                                                      ),

                                                    ]),
                                              ),


                                              //  Appointments
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) {
                                                        return AppointmentsFootMain();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.025,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.015),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFA8B1CE)
                                                        .withOpacity(
                                                        0.1),

                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        8), // Optional: Rounded corners
                                                  ),

                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00),
                                                  // color: Colors.white,
                                                  child: Container(
                                                    // color: Colors.white,

                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        gradient: LinearGradient(
                                                            begin:
                                                            Alignment
                                                                .centerLeft,
                                                            end:
                                                            Alignment
                                                                .centerRight,
                                                            stops: [
                                                              0.5,
                                                              0.9
                                                            ],
                                                            colors: [
                                                              Color(0x0A056390),
                                                              Color(0x0A056390),
                                                            ])),

                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        right: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                            left:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            right:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            top:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                    left: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.00,
                                                                  ),
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                      left: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      right: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      top: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                    ),
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    child:
                                                                    Image.asset(
                                                                      'assets/AppointmentBs.png',
                                                                      fit:
                                                                      BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: MediaQuery
                                                                      .of(
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
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        top: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        bottom: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                      ),
                                                                      child: Text(
                                                                        "Appointments",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xFF126086),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontSize: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.014,
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
                                                                size: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                                // Dynamic icon size
                                                                color:
                                                                Color(
                                                                    0xFF126086),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //  Test And Services
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) {
                                                        return TestAndServicesMain();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.025,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.015),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFA8B1CE)
                                                        .withOpacity(
                                                        0.1),

                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        8), // Optional: Rounded corners
                                                  ),

                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00),
                                                  // color: Colors.white,
                                                  child: Container(
                                                    // color: Colors.white,

                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        gradient: LinearGradient(
                                                            begin:
                                                            Alignment
                                                                .centerLeft,
                                                            end:
                                                            Alignment
                                                                .centerRight,
                                                            stops: [
                                                              0.5,
                                                              0.9
                                                            ],
                                                            colors: [
                                                              Color(0x0A056390),
                                                              Color(0x0A056390),
                                                            ])),

                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        right: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                            left:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            right:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            top:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                    left: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.00,
                                                                  ),
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                      left: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      right: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      top: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                    ),
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    child:
                                                                    Image.asset(
                                                                      'assets/TestServicesBs.png',
                                                                      fit:
                                                                      BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),

                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: MediaQuery
                                                                      .of(
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
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        top: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        bottom: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                      ),
                                                                      child: Text(
                                                                        "Test & Services",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xFF126086),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontSize: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.014,
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
                                                                size: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                                // Dynamic icon size
                                                                color:
                                                                Color(
                                                                    0xFF126086),
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
                                    ),


                                  ],
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ]
            );
          }
      );



  void showBottomSheetforlogout() {

    final height = MediaQuery.of(context).size.height ;
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      barrierColor: Colors.grey.withOpacity(0.9),
      backgroundColor: Color(0xFFFFFFFF),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) =>
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the bottom sheet
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      blurRadius: 10, // Blur intensity
                      spreadRadius: 5, // Spread radius
                      offset: const Offset(0, -4), // Moves shadow upwards
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: height * 0.025,

                          bottom: height * 0.015),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: height * 0.01,
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Center(
                                child: Container(

                                  padding: EdgeInsets.only(
                                    top:  height * 0.01,
                                    bottom:  height * 0.03,
                                    left: height * 0.18,
                                    right:  height * 0.18,
                                  ),


                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.23,

                                  height:  height * 0.006,

                                  decoration: BoxDecoration(
                                    color: Color(0x2413678F),    // Divider color

                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded edges
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  top : height * 0.02,

                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.zero, // No need for individual padding here
                                      child: Text(
                                        "Do you want to Logout?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: height * 0.02,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(15),
                                ),
                                // color:Colors.green[100],
                                padding: EdgeInsets.only(
                                  top:  height *
                                      0.03,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[

                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.of(context, rootNavigator: true).pop();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: height * 0.015,
                                          vertical: height * 0.01,
                                        ),
                                        width: height * 0.17,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Color(0xFFA8B1CE),
                                            width: 1,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(
                                          right: height * 0.01,
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "No",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: height * 0.014, // Slightly increased for visibility
                                            ),
                                            textScaleFactor: _getLimitedTextScaleFactor(context),
                                          ),
                                        ),
                                      ),
                                    ),


                                    GestureDetector(
                                      onTap: () async {
                                        // await UserSecureStorage.setIfLogged(
                                        //     "NO");
                                        // await UserSecureStorage.clearAllExceptUsers();
                                        await UserSecureStorage.clearSessionDataOnly();

                                        Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginPage(),
                                          ),
                                              (Route route) => false,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: height * 0.015,
                                          vertical: height * 0.01,
                                        ),
                                        width: height * 0.17,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF126086),
                                          borderRadius: BorderRadius.circular(12),

                                        ),
                                        margin: EdgeInsets.only(
                                          right: height * 0.01,
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "Yes",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: height * 0.014, // Slightly increased for visibility
                                            ),
                                            textScaleFactor: _getLimitedTextScaleFactor(context),
                                          ),
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

                  ],
                ),
              ),
            ),
      ),
    );

  }
  double _getLimitedTextScaleFactor(BuildContext context, {double maxScaleFactor = 1.2}) {
    double systemScale = MediaQuery.of(context).textScaleFactor;
    return systemScale > maxScaleFactor ? maxScaleFactor : systemScale;
  }


  Widget _buildCard(BuildContext context,String title, String image,{bool isIcon = true}) {
    final h = MediaQuery.of(context).size.height ;
    final w = MediaQuery.of(context).size.width ;
     return Card(
       elevation: 0.0,
       color: Colors.white,
       child: Container(
         margin: EdgeInsets.symmetric(horizontal: h * 0.01,),
         child: Container(
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               gradient: LinearGradient(
                   begin: Alignment.centerLeft,
                   end: Alignment.centerRight,
                   stops: [0.4,0.6,0.8,0.9,0.95],
                   colors: [
                     Color(0xFFA8B1CE).withOpacity(0.07),
                     Color(0xFFA8B1CE).withOpacity(0.05),
                     Color(0xFFA8B1CE).withOpacity(0.001),
                     Color(0xFFA8B1CE).withOpacity(0.001),
                     Color(0xFFA8B1CE).withOpacity(0.00),
                   ])),
           padding: EdgeInsets.symmetric(horizontal: h * 0.005,vertical: h * 0.002,),

           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 padding: EdgeInsets.symmetric(horizontal: h * 0.005,),
                 child: Row(
                   crossAxisAlignment:CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.start,

                   children: <Widget>[
                     Expanded(
                       flex: 1,
                       child: Container(
                         padding: EdgeInsets.all( h * 0.01,),

                         child: ClipRRect(
                           borderRadius:
                           BorderRadius.circular(0.0),
                           child: Image.asset(
                             image,
                             fit: BoxFit.fill,
                           ),
                         ),
                       ),
                     ),
                     SizedBox(width:  h *0.010),
                     Expanded(
                       flex: 8,
                       child: Column(
                         crossAxisAlignment:CrossAxisAlignment.start,
                         mainAxisAlignment:MainAxisAlignment.center,
                         children: <Widget>[
                           Container(
                             child: Text(
                               title,
                               style: TextStyle(
                                 color: Color(0xFF1F1F1F),
                                 overflow:
                                 TextOverflow.ellipsis,
                                 fontWeight:
                                 FontWeight.w500,
                                 fontSize: h * 0.014,

                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     // Adding the side arrow at the end
                     if(isIcon)
                     Icon(
                       Icons.arrow_forward_ios,
                       size: h *0.015,
                       color: Color(0xFF5F5F5F),
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
