import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Address/address_screen.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithdata.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/appointmentsmainfindDoctors.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/HRecommendedDoctors/home_doctordetails.dart';
import 'package:newfolder/Screens/HRecommendedDoctors/home_selecttimeslot.dart';
import 'package:newfolder/Screens/HomeCare/diagnosticmain.dart';
import 'package:newfolder/Screens/HomeCare/doctorhcmain.dart';
import 'package:newfolder/Screens/HomeCare/homecaremain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Insurance/insuranceman.dart';
import 'package:newfolder/Screens/LabTests/labtestmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Maps/google_map_screen.dart';
import 'package:newfolder/Screens/Medications/medicationsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Radiology/radiologymain.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/Timeline/timelinemain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/authfail.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';

class HomePageMain extends StatefulWidget {
  int selectedIndex = 0;

  HomePageMain({
    super.key,
  });

  @override
  State<HomePageMain> createState() => HomePageMainstate();
}

class HomePageMainstate extends State<HomePageMain> with SingleTickerProviderStateMixin {
  String usernameValue = "Hello, Priya Krishnamurty";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;

  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  // late ProgressDialog progressDialog;
  AuthFailed customalert = new AuthFailed();

  final myCatagories = [
    ["assets/CategoryAppoinment.png", "Appoinment"],
    ["assets/CategoryHomeCare.png", "Home Care"],
    ["assets/CategoryMedications.png", "Medications"],
    ["assets/CategoryLab.png", "Lab"],
    ["assets/CategoryRadiology.png", "Radiology"],
    ["assets/CategoryTimelin.png", "Timeline"],
    ["assets/CategoryInsurance.png", "Insurance"],
  ];

  final myOtherServices = [
    ["assets/OtherServicesDiagnostic.png", "Diagnostic"],
    ["assets/OtherServicesDoctor.png", "Doctor"],
    ["assets/OtherServicesNurse.png", "Nurse"],
    ["assets/OtherServicesPhysio.png", "Physio"],
    ["assets/OtherServicesMedicalEquipment's.png", "Medical Equipment's"],
  ];

  final myhealyhblogbanner = [
    ["assets/healthblogbanner1.png", "Appoinment"],
    ["assets/healthblogbanner2.png", "Home Care"],
    ["assets/healthblogbanner3.png", "Medications"],
    ["assets/healthblogbanner4.png", "Lab"],
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();
  TextEditingController SearchEditTextController = TextEditingController();
  bool _isDialogShowing = false;

  double rating = 3;

  @override
  void initState() {
    getSharedPrefs();
    super.initState();
  }


  Future getSharedPrefs() async {

    // progressDialog = ProgressDialog(context,
    //     type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    // progressDialog.style(
    //     message: 'Loading..' '\nPlease Wait',
    //     borderRadius: 10.0,
    //     backgroundColor: Colors.white,
    //     progressWidget: CircularProgressIndicator(
    //       color: Colors.blueAccent,
    //       strokeWidth: MediaQuery
    //           .of(context)
    //           .size
    //           .height * 0.002,
    //     ),
    //     elevation: 10.0,
    //     insetAnimCurve: Curves.easeInOut,
    //     progress: 0.0,
    //     maxProgress: 100.0,
    //     progressTextStyle: TextStyle(
    //       color: Colors.blueAccent,
    //       fontSize: 13.0,
    //     ),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black,
    //         fontSize: MediaQuery
    //             .of(context)
    //             .size
    //             .height * 0.018,
    //         fontWeight: FontWeight.w600));
    getSpecialitiesList();
  }


  bool isRefreshing = false;
  double dragOffset = 0.0;




  @override
  Widget build(BuildContext context) {
    // progressDialog = ProgressDialog(context,
    //     type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    // progressDialog.style(
    //     message: 'Loading..' '\nPlease Wait',
    //     borderRadius: 10.0,
    //     backgroundColor: Colors.white,
    //     progressWidget: CircularProgressIndicator(
    //       color: Colors.blueAccent,
    //       strokeWidth: MediaQuery
    //           .of(context)
    //           .size
    //           .height * 0.002,
    //     ),
    //     elevation: 10.0,
    //     insetAnimCurve: Curves.easeInOut,
    //     progress: 0.0,
    //     maxProgress: 100.0,
    //     progressTextStyle: TextStyle(
    //       color: Colors.blueAccent,
    //       fontSize: 13.0,
    //     ),
    //     messageTextStyle: TextStyle(
    //         color: Colors.black,
    //         fontSize: MediaQuery
    //             .of(context)
    //             .size
    //             .height * 0.018,
    //         fontWeight: FontWeight.w600));
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return IgnorePointer(
      ignoring: _isDialogShowing,
      child: Scaffold(
        body:


        Container(
          width: double.infinity,


          decoration: const BoxDecoration(
            image: DecorationImage(
              // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
              image: AssetImage("assets/Background Pattern.png"),
              fit: BoxFit.cover, // Adjusts how the image fills the container
            ),
          ),
          child:
          Stack(
              children: [

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[


                    Container(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.07,
                        left: screenWidth * 0.045,
                        right: screenWidth * 0.045,
                        bottom: screenWidth * 0.06,
                      ),
                      margin: EdgeInsets.only(
                        right: screenHeight * 0.0,
                        top: screenHeight * 0.0,
                        bottom: screenHeight * 0.01,
                        left: screenHeight * 0.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.005,
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                ),
                                child: Text(
                                  usernameValue,
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.018,
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              // Google Map
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (BuildContext context) {
                                        // return GoogleMapScreen();
                                        return AddressScreen();
                                      },
                                    ),
                                  );
                                },
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // Align items to the start
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.00,
                                        horizontal: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.00,
                                      ),
                                      child: Text(
                                        useraddressValue,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.012,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      // Downward pointing arrow
                                      color: Colors.white,
                                      size: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.02, // Responsive size
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),


                          // Action Bar 2nd half
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                // Cart
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (BuildContext context) {
                                          return AddToCartMain();
                                        },
                                      ),
                                    );
                                  },
                                  child:
                                  AppointmentIconBadge(
                                    appointmentcount: "",
                                  ),
                                ),


                                // Notification
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (BuildContext context) {
                                          return NotificationMain();
                                        },
                                      ),
                                    );
                                  },
                                  child:
                                  IconBadge(
                                    notificationcount: "",
                                  ),
                                ),


                                // Profile Image
                                userprofilepValue != "NA"
                                    ?

                                GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return ProfileMain();
                                          },
                                        ),
                                      );
                                    }, child:
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.050,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.050,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.white,
                                    ),
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: Image
                                          .memory(
                                          base64Decode(userprofilepValue))
                                          .image,
                                    ),
                                  ),
                                )
                                )
                                    : GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return ProfileMain();
                                        },
                                      ),
                                    );
                                  }, child: Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.04,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.04,
                                  padding: EdgeInsets.only(
                                    left: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(130.0),
                                    child: Image.asset(
                                      'assets/drsujeet.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                )










                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


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
                              .height * 0.0,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00),
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
                            // Logo Image
                            Container(
                              margin: EdgeInsets.only(
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
                                      .height * 0.02,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.03),

                              child: Image.asset(
                                'assets/splashqc.png',
                                height: screenHeight * 0.03,
                                fit: BoxFit.contain,
                              ),
                            ),


                            // Search Animation
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
                                  color: Color(0xFFA8B1CE).withOpacity(0.2),
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
                                      .height * 0.02,
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
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
                                        "Search by",
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


                                    Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.008,
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
                                      child:
                                      DefaultTextStyle(
                                        style: TextStyle(
                                            color: Color(0xFF126086),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.014),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            RotateAnimatedText(
                                              'Doctor',
                                              textStyle: TextStyle(
                                                  color: Color(0xFF126086),
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height *
                                                      0.014), // Red text
                                            ),
                                            RotateAnimatedText(
                                              'Speciality',
                                              textStyle: TextStyle(
                                                  color: Color(0xFF126086),
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.014),
                                            ),

                                            RotateAnimatedText(
                                              'Symptoms',
                                              textStyle: TextStyle(
                                                  color: Color(0xFF126086),
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height *
                                                      0.014), // Red text
                                            ),
                                          ],
                                          repeatForever: true,
                                          pause: Duration(milliseconds: 500),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return QuickSearchWithoutData();
                                                },
                                              ),
                                            );
                                            print("Tap Event");
                                          },
                                        ),
                                      ),
                                    ),

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


                    // Main Content Section
                    Flexible(
                      child: Container(

                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,


                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [


                            /*  // Search Input Field
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
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(
                                          top: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.0,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.00,
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
                                              .height * 0.0,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.01,
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
                                            textCapitalization: TextCapitalization
                                                .characters,
                                            style: TextStyle(color: Colors.black45),
                                            keyboardType: TextInputType.emailAddress,
                                            validator: (input) =>
                                            input!.length < 3
                                                ? "Search should be more than 3 characters"
                                                : null,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                              EdgeInsets.all(screenHeight * 0.012),
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              hintText:
                                              "Search By Doctor / Speciality / Symptoms",
                                              hintStyle: TextStyle(
                                                color: Colors.black26,
                                                fontSize: screenHeight * 0.016,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(5.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                  Icons.search_sharp,
                                                  color: Colors.black45,
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
                                    ),*/




                            HomeSliderWidget(),

                            // Categories Section
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.03,
                                  top: MediaQuery.of(context).size.height *
                                      0.015,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.005),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Categories",
                                  style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.014,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),

                            // Categories Grid
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                  top: MediaQuery.of(context).size.height *
                                      0.01,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.005
                              ),
                              child: GridView.count(
                                shrinkWrap: true,
                                // Ensures the GridView takes up as much space as needed
                                physics: NeverScrollableScrollPhysics(),
                                // Disable scrolling inside GridView
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
                                      .height * 0.005,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                ),
                                crossAxisCount: 4,
                                crossAxisSpacing: screenHeight * 0.02,
                                mainAxisSpacing: screenHeight * 0.01,
                                children: myCatagories
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final int index = entry.key; // Get the index
                                  final List<String> i = entry
                                      .value; // Get the value (image path and text)

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          // Example logic for handling button click
                                          if (index == 0) {
                                            print("Custom FAB pressed!");
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return AppointmentsMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 1) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return HomeCareMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 2) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return MedicationsMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 3) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return LabTestsMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 4) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return RadiologyMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 5) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return TimelineMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 6) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return InsuranceMain();
                                                },
                                              ),
                                            );
                                          } else {
                                            // Handle other indices
                                            print("Button $index clicked!");
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFFE8F0F3),
                                          padding: EdgeInsets.all(
                                              screenHeight * 0.01),
                                          minimumSize: Size(
                                            screenHeight * 0.04,
                                            screenHeight * 0.04,
                                          ),
                                        ),
                                        child: Container(
                                          width: screenHeight * 0.03,
                                          height: screenHeight * 0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(i[0]),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height :screenHeight * 0.01 ),

                                      Expanded(child:
                                      Padding(
                                        padding: EdgeInsets.all(
                                            screenHeight * 0.00),
                                        child: Text(
                                          i[1],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.012,
                                            fontWeight: FontWeight.w400,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),


                            // Upcoming Appointments
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.03,
                                  top: MediaQuery.of(context).size.height *
                                      0.01,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.005),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Upcoming Appointments",
                                  style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.014,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),


                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return AppointmentsFootMain();
                                    },
                                  ),
                                );
                              },
                              child:
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
                                    bottom: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.00,
                                    top: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.015),
                                color: Colors.white,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  // color: Colors.blueGrey[50],
                                  // color:    [Colors.green[400], Colors.green[300]],
                                  child:
                                  Container(
                                    // color: Colors.white,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.5, 0.9],
                                            colors: [
                                              Color(0xFFE8F0F3),
                                              Color(0xFFE8F0F3)
                                            ])),
                                    margin: EdgeInsets.only(
                                        left: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.006,
                                        right: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.006,
                                        bottom: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.003,
                                        top: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.003),
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
                                            .height * 0.005),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[


                                          Container(
                                            // color: Colors.red,
                                            // height: MediaQuery.of(context).size.height * 0.12,
                                            padding: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.01,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.005,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.005,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.00),

                                            /*  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),*/
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child:
                                                  Container(

                                                    padding: EdgeInsets.only(
                                                      left:
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.00,
                                                    ),

                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(130.0),
                                                      child: Image.asset(
                                                        'assets/drsujeet.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),



                                                ),

                                                SizedBox(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height *
                                                        0.015),

                                                Expanded(
                                                  flex: 8,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: <Widget>[
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
                                                                .height * 0.00,
                                                            bottom: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005),
                                                        child:
                                                        Text(
                                                          "Dr. Sujeet Kumar",
                                                          style: TextStyle(
                                                              color: Colors.black87,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.013),
                                                        ),
                                                      ),


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
                                                                .height * 0.005,
                                                            bottom: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.005),
                                                        child:
                                                        Text(
                                                          "Therapist",
                                                          style: TextStyle(
                                                              color: Colors.black87,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.01),
                                                        ),
                                                      ),

                                                      Container(

                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius
                                                                .circular(16),
                                                          ),

                                                          padding: EdgeInsets.only(
                                                              left: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.001,
                                                              right: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.001,
                                                              top: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.001,
                                                              bottom: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.00),
                                                          child:
                                                          // RatingBar(
                                                          //   initialRating: 1,
                                                          //   direction: Axis
                                                          //       .horizontal,
                                                          //   allowHalfRating: true,
                                                          //   itemCount: 5,
                                                          //   itemSize: MediaQuery
                                                          //       .of(context)
                                                          //       .size
                                                          //       .height * 0.015,
                                                          //   ratingWidget: RatingWidget(
                                                          //     full: Icon(
                                                          //       Icons
                                                          //           .star_rate_rounded,
                                                          //       color: Color(
                                                          //           0xFFFFD700),
                                                          //     ),
                                                          //     half: Icon(
                                                          //       Icons
                                                          //           .star_half_rounded,
                                                          //       color: Color(
                                                          //           0xFFFFD700),
                                                          //     ),
                                                          //     empty: Icon(
                                                          //       Icons
                                                          //           .star_border_rounded,
                                                          //       color: Color(
                                                          //           0xFFFFD700),
                                                          //     ),
                                                          //   ),
                                                          //   itemPadding:
                                                          //   EdgeInsets.zero,
                                                          //   onRatingUpdate: (rating) {
                                                          //     print(rating);
                                                          //   },
                                                          // ),

                                                          // RatingBarIndicator(
                                                          //   rating: 3.5,  // Fixed rating, non-interactive
                                                          //   itemCount: 5, // Number of stars
                                                          //   itemSize: MediaQuery.of(context).size.height * 0.015, // Adjust size
                                                          //   direction: Axis.horizontal,
                                                          //   itemBuilder: (context, index) => Icon(
                                                          //     Icons.star_rate_rounded,
                                                          //     color: Color(0xFFFFD700),  // Gold color
                                                          //   ),
                                                          // )

                                                          RatingBarIndicator(
                                                            rating: rating,  // Fixed rating (non-clickable)
                                                            itemCount: 5,  // Number of stars
                                                            itemSize: MediaQuery.of(context).size.height * 0.015,  // Adjust size
                                                            direction: Axis.horizontal,
                                                            itemBuilder: (context, index) {
                                                              // Dynamic logic for full, half, and empty stars based on the rating
                                                              if (index < rating) {
                                                                // Display gold (full star) if the index is less than the rating
                                                                return Icon(
                                                                  Icons.star_rate_rounded,
                                                                  color: Color(0xFFFFD700),  // Gold color for filled stars
                                                                );
                                                              } else if (index == rating.floor() && rating != rating.floor()) {
                                                                // Display half star if the index is equal to the floor value of rating and rating is a decimal
                                                                return Icon(
                                                                  Icons.star_half_rounded,
                                                                  color: Color(0xFFFFD700),  // Gold color for half star
                                                                );
                                                              } else {
                                                                // Display empty star if the index is greater than the rating
                                                                return Icon(
                                                                  Icons.star_border_rounded,
                                                                  color: Colors.white,  // White color for empty stars
                                                                );
                                                              }
                                                            },
                                                          )





                                                      ),
                                                    ],
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),

                                          SizedBox(height : MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.007,),
                                          // Date and Time
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.01,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.005,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.005,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.005),
                                            width: double.infinity,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF126086),
                                                      borderRadius: BorderRadius
                                                          .circular(09),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.015,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.015,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,),
                                                    child: Row(
                                                      // mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .end,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child:
                                                            Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .center,
                                                                children: <Widget>[
                                                                  // Date
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      // color:Colors.white,
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          15),
                                                                    ),
                                                                    // color:Colors.green[100],
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        top: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        bottom: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00),
                                                                    child:

                                                                    Row(
                                                                        mainAxisAlignment: MainAxisAlignment
                                                                            .spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .center,
                                                                        children: <
                                                                            Widget>[

                                                                          Icon(Icons
                                                                              .calendar_month,
                                                                              color: Colors
                                                                                  .white,
                                                                              size: MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.02),




                                                                          Column(
                                                                            children: <
                                                                                Widget>[
                                                                              Container(
                                                                                padding: EdgeInsets
                                                                                    .only(
                                                                                    left: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .height *
                                                                                        0.005,
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
                                                                                        0.00,
                                                                                    bottom: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .height *
                                                                                        0.00),
                                                                                child:
                                                                                Text(
                                                                                  "Today, December 17",
                                                                                  style: TextStyle(
                                                                                    // color: Colors.blue[600],
                                                                                      color: Colors
                                                                                          .white,
                                                                                      fontWeight: FontWeight
                                                                                          .w600,
                                                                                      overflow: TextOverflow
                                                                                          .ellipsis,
                                                                                      fontSize: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.014),
                                                                                ),
                                                                              ),

                                                                            ],
                                                                          )


                                                                        ]
                                                                    ),

                                                                  ),

                                                                  // Time
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      // color:Colors.white,
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          15),
                                                                    ),
                                                                    // color:Colors.green[100],
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        top: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        bottom: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00),
                                                                    child:

                                                                    Row(
                                                                        mainAxisAlignment: MainAxisAlignment
                                                                            .spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .center,
                                                                        children: <
                                                                            Widget>[

                                                                          Icon(Icons
                                                                              .access_time_sharp,
                                                                              color: Colors
                                                                                  .white,
                                                                              size: MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.022),

                                                                          /* IconButton(
                                                                                padding: EdgeInsets.zero,
                                                                                icon: Icon(Icons.directions,
                                                                                  color: Colors.orangeAccent,
                                                                                  size: MediaQuery.of(context).size.height * 0.042,),
                                                                                onPressed: () async {
                                                                                }
                                                                            ),*/

                                                                          /* Icon(brightness_1_rounded,
                                                                                color: Color(0xff036c33),
                                                                                size:  MediaQuery.of(context).size.height * 0.015),*/

                                                                          // SizedBox(width: width * 0.02), // give it width
                                                                          Column(
                                                                            children: <
                                                                                Widget>[
                                                                              Container(
                                                                                padding: EdgeInsets
                                                                                    .only(
                                                                                    left: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .height *
                                                                                        0.005,
                                                                                    right: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .height *
                                                                                        0.005,
                                                                                    top: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .height *
                                                                                        0.00,
                                                                                    bottom: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .height *
                                                                                        0.00),
                                                                                child:
                                                                                Text(
                                                                                  "10:00 - 11:00 AM",
                                                                                  style: TextStyle(
                                                                                    // color: Colors.blue[600],
                                                                                      color: Colors
                                                                                          .white,
                                                                                      fontWeight: FontWeight
                                                                                          .w600,
                                                                                      overflow: TextOverflow
                                                                                          .ellipsis,
                                                                                      fontSize: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.014),
                                                                                ),
                                                                              ),

                                                                            ],
                                                                          )


                                                                        ]
                                                                    ),

                                                                  ),


                                                                ]
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ]),
                                          ),


                                        ]),
                                  ),
                                ),


                              ),
                            ),

                            // Other Services Section
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.03,
                                  top: MediaQuery.of(context).size.height *
                                      0.015,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.005),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Other Services",
                                  style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.014,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),

                            // Other Services Grid
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                  top: MediaQuery.of(context).size.height *
                                      0.01,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.01
                              ),
                              child: GridView.count(
                                shrinkWrap: true,
                                // Ensure the GridView only occupies necessary space
                                physics: NeverScrollableScrollPhysics(),
                                // Disable scrolling inside GridView
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
                                      .height * 0.005,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                ),
                                crossAxisCount: 4,
                                crossAxisSpacing: screenHeight * 0.02,
                                mainAxisSpacing: screenHeight * 0.01,
                                children: List.generate(
                                    myOtherServices.length, (index) {
                                  return Column(
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          if (index == 0) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return DiagnosticMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 1) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return DoctorHCMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 2) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return NurseHCMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 3) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return PhysioHCMain();
                                                },
                                              ),
                                            );
                                          } else if (index == 4) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return MedicalEquipHCMain();
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFFE8F0F3),
                                          padding: EdgeInsets.all(
                                              screenHeight * 0.01),
                                          minimumSize: Size(screenHeight * 0.04,
                                              screenHeight * 0.04),
                                        ),
                                        child: Container(
                                          width: screenHeight * 0.03,
                                          height: screenHeight * 0.03,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  myOtherServices[index][0]),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height :screenHeight * 0.004 ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              screenHeight * 0.0),

                                          child: Text(
                                            myOtherServices[index][1],
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.012,
                                              fontWeight: FontWeight.w400,
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            )
                            ,


                            // Health Blogs
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.03,
                                  top: MediaQuery.of(context).size.height *
                                      0.01,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.03,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.005),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[

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
                                              .height * 0.005,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.005),
                                      child:
                                      Text(
                                        "Health Blogs",
                                        style: TextStyle(
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.014,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

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
                                              .height * 0.00,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.00),
                                      child:
                                      Text(
                                        "View All",
                                        style: TextStyle(
                                          color: Color(0xFF126086),
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.012,
                                        ),
                                      ),
                                    ),


                                  ]

                              ),
                            ),


                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // Provide a width constraint using SizedBox or Expanded
                                Container(
                                  margin : EdgeInsets.only(
                                    top : MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.2,
                                  child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    // Prevents ListView from taking up extra space
                                    scrollDirection: Axis.horizontal,
                                    // Makes the ListView horizontal
                                    itemCount: 4,
                                    // You can adjust the item count
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Add your onTap logic here
                                        },
                                        child: Card(
                                          elevation: 0,
                                          child: Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.435,
                                            padding: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.02,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.00,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0
                                            ),
                                            color: Colors.white,
                                            child: Container(
                                              margin: EdgeInsets.all(0.0),
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.12,
                                              decoration: BoxDecoration(
                                                // color: Color(0xFFC80000), // Fallback color if image fails to load
                                                borderRadius: BorderRadius
                                                    .circular(6),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      myhealyhblogbanner[index][0]),
                                                  // Path to your banner image
                                                  fit: BoxFit
                                                      .cover, // Ensure image fills the container
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Theme
                                                        .of(context)
                                                        .hintColor
                                                        .withOpacity(0.0),
                                                    offset: Offset(0, 4),
                                                    blurRadius: 9,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    flex: 6,
                                                    // 6 out of 10 for the text section
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                "Neurosurgery",
                                                                style: TextStyle(
                                                                  overflow: TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                textAlign: TextAlign
                                                                    .left,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .center,
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    height: screenHeight *
                                                                        0.025,
                                                                    width: screenHeight *
                                                                        0.025,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue[100]!
                                                                          .withOpacity(
                                                                          0.2),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .bookmark,
                                                                      color: Colors
                                                                          .white,
                                                                      size: screenHeight *
                                                                          0.015,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.005,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        bottom: MediaQuery
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
                                                                            0.00),
                                                                    height: screenHeight *
                                                                        0.025,
                                                                    width: screenHeight *
                                                                        0.025,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue[100]!
                                                                          .withOpacity(
                                                                          0.2),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .forward_5_outlined,
                                                                      color: Colors
                                                                          .white,
                                                                      size: screenHeight *
                                                                          0.015,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "10 Frequently asked questions about Brain Tumors",
                                                            style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.014,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                            ),
                                                            textAlign: TextAlign
                                                                .left,
                                                          ),
                                                          SizedBox(height: 5),
                                                          Text(
                                                            "1. What is a Brain Tumor?",
                                                            style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.009,
                                                              color: Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .left,
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text(
                                                            "It is a mass of abnormal tissue growing in any part of the brain or outside within the skull.",
                                                            style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.009,
                                                              color: Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .left,
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text(
                                                            "2. Is a brain tumor treatable?",
                                                            style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.009,
                                                              color: Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .left,
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text(
                                                            "Modern neurosurgery is to cure or at least control a brain tumor and offer a productive, symptoms-free life to a patient.",
                                                            style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.009,
                                                              color: Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .left,
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text(
                                                            "3. What is the difference between benign and malignant tumors?",
                                                            style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.009,
                                                              color: Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .left,
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text(
                                                            "Benign tumors grow slowly and do not spread. Surgical excision can be curative.",
                                                            style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.009,
                                                              color: Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .left,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),


                            // Recommend doctors
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.03,
                                  top: MediaQuery.of(context).size.height *
                                      0.015,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.03,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.005),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[

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
                                              .height * 0.00,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.00),
                                      child:
                                      Text(
                                        "Recommend Doctors",
                                        style: TextStyle(
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.014,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

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
                                              .height * 0.00,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.00),
                                      child:
                                      Text(
                                        "View All",
                                        style: TextStyle(
                                          color: Color(0xFF126086),
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.012,
                                        ),
                                      ),
                                    ),


                                  ]

                              ),
                            ),

                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // Provide a width constraint using SizedBox or Expanded
                                Container(

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
                                          .height * 0.120,
                                      top: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.015),
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.15,
                                  child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // Add your onTap logic here
                                        },
                                        child: Card(
                                          elevation: 0.0,
                                          color: Colors.white,
                                          child: Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.35,
                                            padding: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.00,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.00,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.00,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.00),
                                            color: Colors.white,
                                            child:
                                            Container(
                                              // color: Colors.white,

                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .white,
                                                // Background color of the container
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(
                                                        0.1), // Shadow color
                                                    blurRadius:
                                                    5, // Spread of the shadow
                                                    offset: Offset(0,
                                                        0), // Offset in x and y direction
                                                  ),
                                                ],
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    8), // Optional: Rounded corners
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00,
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00,
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00,
                                                  top: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00),
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.01,
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
                                                      .height * 0.01),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: <Widget>[

                                                    Container(
                                                      // color: Colors.red,
                                                      // height: MediaQuery.of(context).size.height * 0.12,
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.005,
                                                          right: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.005,
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                          bottom: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00),
                                                      // width: double.infinity,
                                                      // height: SizeConfig.blockSizeVertical * 15,
                                                      /* decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.045),
                                         color: Colors.blueGrey[50],
                                      border: Border.all(
                                        color: Colors.blueGrey[50]!,
                                        width: MediaQuery.of(context).size.height * 0.001,
                                      ),
                                    ),*/
                                                      /*  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),*/
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 2,
                                                            child:
                                                            Container(

                                                              padding: EdgeInsets
                                                                  .only(
                                                                left:
                                                                MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.00,
                                                              ),

                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                    130.0),
                                                                child: Image
                                                                    .asset(
                                                                  'assets/NutanBhatt.png',
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),


                                                            // with Custom circle around img
                                                            /*    CircleAvatar(
                                          minRadius: MediaQuery.of(context).size.height * 0.082,
                                          backgroundColor: Colors.blue,
                                          child:
                                          FinalProfileimageURI == null ?
                                          Image.asset('assets/ic_profile_edit.png',
                                            height: MediaQuery.of(context).size.height * 0.10,
                                            width: MediaQuery.of(context).size.height * 0.10,) :
                                          new CircleAvatar(backgroundImage: new FileImage(FinalProfileimageURI!), radius: MediaQuery.of(context).size.height * 0.05),
                                        ),*/


                                                          ),

                                                          SizedBox(
                                                              width: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.010),

                                                          Expanded(
                                                            flex: 8,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              children: <Widget>[


                                                                // Dr Nutan bhat text & Icon
                                                                Container(
                                                                  padding: EdgeInsets
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
                                                                          0.01,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.00),
                                                                  child:
                                                                  Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                          .center,
                                                                      children: [
                                                                        Container(
                                                                          padding: EdgeInsets
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
                                                                                  0.00),
                                                                          child:
                                                                          Text(
                                                                            "Dr. Nutan Bhatt",
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .black87,
                                                                                overflow: TextOverflow
                                                                                    .ellipsis,
                                                                                fontWeight: FontWeight
                                                                                    .w600,
                                                                                fontSize: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .height *
                                                                                    0.014
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .blue[100]!
                                                                                .withOpacity(
                                                                                0.2),
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                8),
                                                                          ),
                                                                          padding: EdgeInsets
                                                                              .only(
                                                                              left: MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.005,
                                                                              right: MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.012,
                                                                              top: MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.003,
                                                                              bottom: MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.003
                                                                          ),
                                                                          child:
                                                                          Row(
                                                                            children: <
                                                                                Widget>[

                                                                              Icon(
                                                                                Icons
                                                                                    .star,
                                                                                color: Colors
                                                                                    .amber,
                                                                                size: MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .height *
                                                                                    0.015,
                                                                              ),

                                                                              Padding(
                                                                                padding:   EdgeInsets.only(
                                                                                  left : MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.003,
                                                                                ),
                                                                                child: Text(
                                                                                  "4.3",
                                                                                  style: TextStyle(
                                                                                      color: Colors
                                                                                          .black87,
                                                                                      fontWeight: FontWeight
                                                                                          .bold,
                                                                                      overflow: TextOverflow
                                                                                          .ellipsis,
                                                                                      fontSize: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.01),
                                                                                ),
                                                                              )
                                                                            ],
                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                .center,
                                                                          ),
                                                                        ),
                                                                      ]
                                                                  ),
                                                                ),


                                                                // General physician Text
                                                                Container(

                                                                  padding: EdgeInsets
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
                                                                          0.00,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.00),
                                                                  child:
                                                                  Text(
                                                                    "General physician",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight: FontWeight
                                                                            .w500,
                                                                        overflow: TextOverflow
                                                                            .ellipsis,
                                                                        fontSize: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.011
                                                                    ),
                                                                  ),
                                                                ),

                                                                // 41 YEARS - MBBS, DIPLOMA IN FAMILY MEDICINE  Text
                                                                Container(

                                                                  padding: EdgeInsets
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
                                                                          0.00,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.00),
                                                                  child:
                                                                  Text(
                                                                    "41 YEARS - MBBS, DIPLOMA IN FAMILY MEDICINE",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFF126086),
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        overflow: TextOverflow
                                                                            .ellipsis,
                                                                        fontSize: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.008
                                                                    ),
                                                                  ),
                                                                ),


                                                              ],
                                                            ),
                                                          ),


                                                        ],
                                                      ),
                                                    ),


                                                    // Bottom Row
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.005,
                                                          right: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.005,
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                          bottom: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00),
                                                      width: double.infinity,
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(06),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                left: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01,
                                                                right: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01,
                                                                top: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.015,
                                                                bottom: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.015,),
                                                              child: Row(
                                                                // mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .center,
                                                                          children: <
                                                                              Widget>[

                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                // color:Colors.white,
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    15),
                                                                              ),
                                                                              // color:Colors.green[100],
                                                                              padding: EdgeInsets
                                                                                  .only(
                                                                                  left: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.0,
                                                                                  right: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.0,
                                                                                  top: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.00,
                                                                                  bottom: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.00),
                                                                              child:

                                                                              Row(
                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                      .spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .center,
                                                                                  children: <
                                                                                      Widget>[

                                                                                    Container(
                                                                                      margin: EdgeInsets
                                                                                          .symmetric(
                                                                                          horizontal: 2),
                                                                                      height: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.01,
                                                                                      width: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .height *
                                                                                          0.01,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors
                                                                                            .black,
                                                                                        shape: BoxShape
                                                                                            .circle,
                                                                                      ),
                                                                                    ),

                                                                                    Row(
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Container(
                                                                                            padding: EdgeInsets
                                                                                                .only(
                                                                                                left: MediaQuery
                                                                                                    .of(
                                                                                                    context)
                                                                                                    .size
                                                                                                    .height *
                                                                                                    0.005,
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
                                                                                                    0.00,
                                                                                                bottom: MediaQuery
                                                                                                    .of(
                                                                                                    context)
                                                                                                    .size
                                                                                                    .height *
                                                                                                    0.00),
                                                                                            child:
                                                                                            Text(
                                                                                              'QR 299',
                                                                                              style: TextStyle(
                                                                                                // color: Colors.blue[600],
                                                                                                  color: Colors
                                                                                                      .black,
                                                                                                  fontWeight: FontWeight
                                                                                                      .bold,
                                                                                                  overflow: TextOverflow
                                                                                                      .ellipsis,
                                                                                                  decoration: TextDecoration
                                                                                                      .lineThrough,
                                                                                                  decorationThickness: 1.5,
                                                                                                  fontSize: MediaQuery
                                                                                                      .of(
                                                                                                      context)
                                                                                                      .size
                                                                                                      .height *
                                                                                                      0.014
                                                                                              ),
                                                                                            )


                                                                                        ),
                                                                                        Container(
                                                                                          padding: EdgeInsets
                                                                                              .only(
                                                                                              left: MediaQuery
                                                                                                  .of(
                                                                                                  context)
                                                                                                  .size
                                                                                                  .height *
                                                                                                  0.005,
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
                                                                                                  0.00,
                                                                                              bottom: MediaQuery
                                                                                                  .of(
                                                                                                  context)
                                                                                                  .size
                                                                                                  .height *
                                                                                                  0.00),
                                                                                          child:
                                                                                          Text(
                                                                                            "QR 199",
                                                                                            style: TextStyle(
                                                                                              // color: Colors.blue[600],
                                                                                                color: Color(
                                                                                                    0xFF12B76A),
                                                                                                fontWeight: FontWeight
                                                                                                    .w500,
                                                                                                overflow: TextOverflow
                                                                                                    .ellipsis,
                                                                                                fontSize: MediaQuery
                                                                                                    .of(
                                                                                                    context)
                                                                                                    .size
                                                                                                    .height *
                                                                                                    0.014),
                                                                                          ),

                                                                                        ),

                                                                                      ],
                                                                                    )


                                                                                  ]
                                                                              ),

                                                                            ),

                                                                            // Time
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                // color:Colors.white,
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    15),
                                                                              ),
                                                                              // color:Colors.green[100],
                                                                              padding: EdgeInsets
                                                                                  .only(
                                                                                  left: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.0,
                                                                                  right: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.0,
                                                                                  top: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.00,
                                                                                  bottom: MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.00),
                                                                              child:

                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment
                                                                                    .spaceEvenly,
                                                                                children: <
                                                                                    Widget>[
                                                                                  GestureDetector(
                                                                                    onTap: () async {
                                                                                      Navigator.of(context).push(
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => HomeDoctorDetilPage(),
                                                                                        ),
                                                                                      );
                                                                                      // Navigator.of(context, rootNavigator: true).pop();
                                                                                    },
                                                                                    child: Container(
                                                                                      padding: new EdgeInsets
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
                                                                                              0.005,
                                                                                          bottom: MediaQuery
                                                                                              .of(
                                                                                              context)
                                                                                              .size
                                                                                              .height *
                                                                                              0.005),
                                                                                      decoration: BoxDecoration(
                                                                                        // color: Colors.grey[300],
                                                                                        borderRadius: BorderRadius
                                                                                            .circular(
                                                                                            5),
                                                                                        border: Border
                                                                                            .all(
                                                                                          color: Color(
                                                                                              0xFF126086),
                                                                                          // Border color
                                                                                          width: 1, // Border width
                                                                                        ),
                                                                                      ),


                                                                                      margin: EdgeInsets
                                                                                          .only(
                                                                                        left: MediaQuery
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
                                                                                            0.00,
                                                                                        bottom: MediaQuery
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
                                                                                            0.01,
                                                                                      ),
                                                                                      // color: Colors.grey[300],
                                                                                      alignment: Alignment
                                                                                          .center,
                                                                                      // height:
                                                                                      // MediaQuery.of(context).size.height * 0.070,
                                                                                      child: Text(
                                                                                          "View Profile",
                                                                                          textAlign: TextAlign
                                                                                              .center,
                                                                                          style: TextStyle(
                                                                                              color: Color(
                                                                                                  0xFF126086),
                                                                                              fontWeight: FontWeight
                                                                                                  .bold,
                                                                                              fontSize: MediaQuery
                                                                                                  .of(
                                                                                                  context)
                                                                                                  .size
                                                                                                  .height *
                                                                                                  0.007 )),
                                                                                    ),
                                                                                  ),
                                                                                  GestureDetector(
                                                                                    onTap: () async {
                                                                                      Navigator.of(context).push(
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => HomeSelectTimeSlot(),
                                                                                        ),
                                                                                      );
                                                                                      // Navigator.of(context, rootNavigator: true).pop();
                                                                                    },
                                                                                    child: Container(
                                                                                      padding: new EdgeInsets
                                                                                          .only(
                                                                                          left: MediaQuery
                                                                                              .of(
                                                                                              context)
                                                                                              .size
                                                                                              .height *
                                                                                              0.015,
                                                                                          right: MediaQuery
                                                                                              .of(
                                                                                              context)
                                                                                              .size
                                                                                              .height *
                                                                                              0.015,
                                                                                          top: MediaQuery
                                                                                              .of(
                                                                                              context)
                                                                                              .size
                                                                                              .height *
                                                                                              0.005,
                                                                                          bottom: MediaQuery
                                                                                              .of(
                                                                                              context)
                                                                                              .size
                                                                                              .height *
                                                                                              0.005),
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(
                                                                                            0xFF126086),
                                                                                        borderRadius: BorderRadius
                                                                                            .circular(
                                                                                            5),
                                                                                      ),


                                                                                      margin: EdgeInsets
                                                                                          .only(
                                                                                        left: MediaQuery
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
                                                                                            0.00,
                                                                                        bottom: MediaQuery
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
                                                                                            0.005,
                                                                                      ),
                                                                                      // color: Colors.grey[300],
                                                                                      alignment: Alignment
                                                                                          .center,
                                                                                      // height:
                                                                                      // MediaQuery.of(context).size.height * 0.070,
                                                                                      child: Text(
                                                                                          "Book",
                                                                                          textAlign: TextAlign
                                                                                              .center,
                                                                                          style: TextStyle(
                                                                                              color: Colors
                                                                                                  .white,
                                                                                              fontWeight: FontWeight
                                                                                                  .bold,
                                                                                              fontSize: MediaQuery
                                                                                                  .of(
                                                                                                  context)
                                                                                                  .size
                                                                                                  .height *
                                                                                                  0.007)),
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              ),

                                                                            ),


                                                                          ]
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ]),
                                                    ),


                                                  ]),
                                            ),


                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // Additional widgets can be added here
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Positioned(
                  bottom: 30.0, // Position it at the bottom of the screen
                  right: 15.0, // Position it towards the right
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.06,
                    width: MediaQuery
                        .of(context)
                        .size
                        .height * 0.06,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFC80000), // Button color

                    ),
                    child: IconButton(
                      icon: Image.asset(
                        // 'assets/emergencycall.png',
                          'assets/Emergency Call Button.png',
                          // Replace with your asset path
                          fit: BoxFit.cover,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                          width : MediaQuery
                              .of(context)
                              .size
                              .height * 0.04
                      ),
                      onPressed: () {
                        print("Custom FAB pressed!");
                        emergencycallalert.showticket(context);

                        // appointmentcancelalert.showticket(context);

                      },
                    ),
                  ),
                )
              ]
          ),
        ),


        // First  - Center Docked
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: screenHeight * 0.07,  // Outer circle height (adjust as needed)
          width: screenHeight * 0.07, // Outer circle width (adjust as needed)
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // Padding color (background ring)
          ),
          child: Padding(
            padding: EdgeInsets.all(
                screenHeight * 0.008), // Padding inside the outer circle
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Color(0xFF126086),
              // Button color
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return UploadPrescriptionMain();
                    },
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(screenHeight * 0.008),
                width: screenHeight * 0.03, // Adjust image width
                height: screenHeight * 0.03, // Adjust image height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/Upload.png'), // Replace with your asset path
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              elevation: 0.0,
              shape: CircleBorder(), // Ensures the button remains circular
            ),
          ),
        ),
        bottomNavigationBar: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    blurRadius: 20, // Spread of the shadow
                    offset: Offset(
                        0, -4), // Position the shadow above the BottomAppBar
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent, // Remove splash color
                  highlightColor: Colors.transparent, // Remove highlight color
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType
                      .fixed,
                  // Set fixed type for equal spacing
                  currentIndex: _selectedIndex,
                  // Track the selected tab
                  // Track the selected tab
                  onTap: _onItemTapped,

                  backgroundColor: Colors.white,
                  selectedItemColor:
                  Color(0xFF126086),
                  // Color for the selected item
                  unselectedItemColor:
                  Color(0xFF484C52),
                  // Color for unselected items
                  selectedFontSize: MediaQuery
                      .of(context)
                      .size
                      .height *
                      0.014,
                  // Hide the label font for selected items
                  unselectedFontSize: MediaQuery
                      .of(context)
                      .size
                      .height *
                      0.012,
                  // Hide the label font for unselected items
                  elevation: 0,
                  // Disable elevation
                  items: [
                    BottomNavigationBarItem(
                      icon: Container(
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
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.005,
                        ), // Add padding
                        child: Image.asset(
                          'assets/Homeactive.png',
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                        ),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
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
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.005,
                        ), // Add padding
                        child: Image.asset(
                          'assets/MyReports.png',
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                        ),
                      ),
                      label: 'My Reports',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
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
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.025,
                        ), // Add padding
                        child: Image.asset(
                          'assets/Appoinments.png',
                          width: 0,
                          height: 0,
                        ),
                      ),
                      label: 'Upload',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
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
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.005,
                        ), // Add padding
                        child: Image.asset(
                          'assets/Appoinments.png',
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                        ),
                      ),
                      label: 'Appointments',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
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
                              .height * 0.00,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.005,
                        ), // Add padding
                        child: Image.asset(
                          'assets/MyHealth.png',
                          width: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.027,
                        ),
                      ),
                      label: 'My Health',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     int selected = index;
  //
  //     if (selected == 0) {
  //       /* Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => HomePageMain()),
  //           (Route<dynamic> route) => false);*/
  //     } else if (selected == 1) {
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) {
  //             return MyReportsMain();
  //           },
  //         ),
  //       );
  //     } else if (selected == 2) {
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) {
  //             return UploadPrescriptionMain();
  //           },
  //         ),
  //       );
  //     } else if (selected == 3) {
  //       showBottomSheet();
  //     }
  //     else if (selected == 4) {
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (BuildContext context) {
  //             return MyHealthMain();
  //           },
  //         ),
  //       );
  //     }
  //
  //     /* widget.selectedIndex = index;
  //     _selectedIndex = widget.selectedIndex;*/
  //
  //     // Fluttertoast.showToast(msg: "test", toastLength: Toast.LENGTH_LONG);
  //     print(selected);
  //   });
  // }

  void _onItemTapped(int index) {
    print("_isDialogShowing : $_isDialogShowing");
    if (_isDialogShowing) return; // Prevent interaction while loading

    int selected = index;

    // Don't call setState before navigation, especially if the widget can be disposed
    // We'll track selected index only if needed in UI
    // setState(() {
    //   _selectedIndex = selected;
    // });

    if (selected == 0) {
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => HomePageMain()),
      //   (Route<dynamic> route) => false);
    } else if (selected == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MyReportsMain()),
      );
    } else if (selected == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => UploadPrescriptionMain()),
      );
    } else if (selected == 3) {
      showBottomSheet();
    } else if (selected == 4) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MyHealthMain()),
      );
    }

    print(selected);
  }

  // void getSpecialitiesList() {
  //   connectivityservice.checkconnectivity().then((intenet) async {
  //     if (intenet != null && intenet) {
  //       /* progressDialog.showMaterial(
  //           title: "Loading Data", message: "Please wait");*/
  //       setState(() {
  //         _isDialogShowing = true;
  //       });
  //       progressDialog.show();
  //       dynamic user = await apiService.findspecialitieslist();
  //
  //       final preNRStatuscodeval = await UserSecureStorage
  //           .getNRStatuscodeval() ?? 'NA';
  //
  //       if (preNRStatuscodeval == "401") {
  //         /*progressDialog.hide();
  //         customalert.showError(context);*/
  //
  //         // Below code once refresh token works for session
  //         var user = await apiService.refreshtoken();
  //         final preNRStatuscodevalforrefresh = await UserSecureStorage
  //             .getNRStatuscodeval() ?? 'NA';
  //         if (preNRStatuscodevalforrefresh == "200") {
  //           getSpecialitiesList();
  //         } else if (preNRStatuscodevalforrefresh == "401") {
  //           progressDialog.hide();
  //           setState(() {
  //             _isDialogShowing = false;
  //           });
  //           customalert.showError(context);
  //         } else if (preNRStatuscodevalforrefresh == "400") {
  //           progressDialog.hide();
  //           setState(() {
  //             _isDialogShowing = false;
  //           });
  //           customalert.showError(context);
  //         }
  //       } else {
  //         if (user.message != null) {
  //           progressDialog.hide();
  //           setState(() {
  //             _isDialogShowing = false;
  //           });
  //           final snackBar = SnackBar(content: Text(user.message));
  //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         }
  //
  //         // Get the list data and show it
  //
  //         else if (user.response!.length > 0) {
  //           progressDialog.hide();
  //           setState(() {
  //             _isDialogShowing = false;
  //           });
  //
  //           /* setState(() {
  //           responselist = user.response;
  //         });*/
  //
  //           /* final snackBar = SnackBar(
  //           content: Text("Found"),
  //           behavior: SnackBarBehavior.floating,
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           snackBar,
  //         );*/
  //         } else {
  //           progressDialog.hide();
  //           setState(() {
  //             _isDialogShowing = false;
  //           });
  //           final snackBar = SnackBar(
  //             content: Text("Specialities Not Found"),
  //             behavior: SnackBarBehavior.floating,
  //           );
  //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //           // customalert.showError(context, user.error);
  //         }
  //       }
  //     } else {
  //       // No-Internet Case
  //       final snackBar = SnackBar(
  //         content: Text("No Internet, Check Connectivity!"),
  //         behavior: SnackBarBehavior.floating,
  //       );
  //
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   });
  // }

  Future<void> getSpecialitiesList() async {
    try {
      final isConnected = await connectivityservice.checkconnectivity();

      if (isConnected == null || !isConnected) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("No Internet, Check Connectivity!"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        return;
      }

      if (mounted) {
        setState(() {
          _isDialogShowing = true;
        });
        // await progressDialog.show();
      }

      dynamic user = await apiService.findspecialitieslist();
      final preNRStatuscodeval = await UserSecureStorage.getNRStatuscodeval() ?? 'NA';

      if (preNRStatuscodeval == "401") {
        // Try refresh token
        var user = await apiService.refreshtoken();
        final preNRStatuscodevalforrefresh = await UserSecureStorage.getNRStatuscodeval() ?? 'NA';
        print('preNRStatuscodevalforrefresh : $preNRStatuscodevalforrefresh');

        if (preNRStatuscodevalforrefresh == "200") {
          // Retry original API call
          await getSpecialitiesList();
        }
        else if(preNRStatuscodevalforrefresh == "401") {
          if (mounted) {
            customalert.showError(context);
          }
        }
        else if(preNRStatuscodevalforrefresh == "400") {
          if (mounted) {
            customalert.showError(context);
          }
        }

        else {
          if (mounted) {
            customalert.showError(context);
          }
        }

      } else {
        if (user.message != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(user.message)),
          );
        } else if (user.response != null && user.response!.isNotEmpty && mounted) {
          // Set your list here if needed
          // setState(() {
          //   responselist = user.response;
          // });
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Specialities Not Found"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint("Error fetching specialities: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred")),
        );
      }
    } finally {
      if (mounted) {
        // await progressDialog.hide();
        setState(() {
          _isDialogShowing = false;
        });
      }
    }
  }



  void showBottomSheet() =>
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
        context: context,
        builder: (context) =>
            StatefulBuilder(
              builder: (BuildContext context,
                  StateSetter setState /*You can rename this!*/) =>
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery
                            .of(context)
                            .viewInsets
                            .bottom),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Container(
                                  //   padding: EdgeInsets.only(
                                  //     top: MediaQuery
                                  //         .of(context)
                                  //         .size
                                  //         .height * 0.0,
                                  //     bottom: MediaQuery
                                  //         .of(context)
                                  //         .size
                                  //         .height * 0.03,
                                  //     left: MediaQuery
                                  //         .of(context)
                                  //         .size
                                  //         .height * 0.18,
                                  //     right: MediaQuery
                                  //         .of(context)
                                  //         .size
                                  //         .height * 0.18,
                                  //   ),
                                  //   child: Divider(
                                  //     height: 0,
                                  //     indent: 0,
                                  //     thickness: MediaQuery
                                  //         .of(context)
                                  //         .size
                                  //         .height * 0.008,
                                  //     color: Color(0xFF95C8D6).withOpacity(0.3),
                                  //   ),
                                  // ),

                                  // Select the Type of Appointment

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
                                          color: Color(0xFFD9D9D9), // Divider color
                                          borderRadius: BorderRadius.circular(
                                              10), // Rounded edges
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height : MediaQuery.of(context).size.height * 0.02),

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
                                                color: Color(0xFF2F3335),
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
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
                                          builder: (BuildContext context) {
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
                                        color: Color(0xFFA8B1CE).withOpacity(
                                            0.1),

                                        borderRadius: BorderRadius.circular(
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
                                            BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                                begin:
                                                Alignment.centerLeft,
                                                end:
                                                Alignment.centerRight,
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
                                              padding: EdgeInsets.only(
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
                                                      EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                      ),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
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
                                                              .height * 0.01,
                                                        ),
                                                        height: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.025,
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.025,
                                                        child:
                                                        Image.asset(
                                                          'assets/AppointmentBs.png',
                                                          fit:
                                                          BoxFit.fill,
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
                                                      children: <Widget>[
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
                                                                  .of(context)
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
                                                    Color(0xFF126086),
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
                                          builder: (BuildContext context) {
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
                                        color: Color(0xFFA8B1CE).withOpacity(
                                            0.1),

                                        borderRadius: BorderRadius.circular(
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
                                            BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                                begin:
                                                Alignment.centerLeft,
                                                end:
                                                Alignment.centerRight,
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
                                              padding: EdgeInsets.only(
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
                                                      EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                      ),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
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
                                                              .height * 0.01,
                                                        ),
                                                        height: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.025,
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.025,
                                                        child:
                                                        Image.asset(
                                                          'assets/TestServicesBs.png',
                                                          fit:
                                                          BoxFit.fill,
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
                                                      children: <Widget>[
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
                                                                  .of(context)
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
                                                    Color(0xFF126086),
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
      );


}
