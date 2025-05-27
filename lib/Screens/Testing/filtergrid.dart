import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/Models/doctorslistres.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/appointmentsmainfindDoctors.dart';
import 'package:newfolder/Screens/Appointments/doctordetailpage.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Testing/filtersearch.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';

import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';

import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';


class FindDoctorsListMain extends StatefulWidget {


  final String? consulttype;
  FindDoctorsListMain(this.consulttype, {Key? key}) : super(key: key);


  @override
  State<FindDoctorsListMain> createState() => FindDoctorsListMainstate();
}

class FindDoctorsListMainstate extends State<FindDoctorsListMain> {
  String usernameValue = "Find Doctors";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  TextEditingController SearchEditTextController = TextEditingController();
  TextEditingController SearchfilterEditTextController = TextEditingController();

  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;
  List<DoctorsListResponse>? responselist = [];

  // List of diseases
  final List<String> diseases = [
    "Adult Allergist",
    "Allergy and Immunology Practitioner",
    "Allergy and Immunology Specialist",
    "Asthma Specialist",
    "Bariatric Dietitian",
    "Bariatric Medicine Specialist",
  ];

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

  final myimageslist = [
    ["assets/CategoryAppoinment.png"],
    ["assets/CategoryHomeCare.png"],
    ["assets/CategoryMedications.png"],
    ["assets/CategoryLab.png"],
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  // List of filter categories
  final List<String> categories = [
    'Experience',
    'Fees',
    'Availability',
    'Areas of Expertise',
    'Gender',
    'Language',
    'City',
  ];

  // Tracks the selected category
  int selectedCategoryIndex = 0;

  // Right-side filter data
  final Map<String, Widget> filterOptions = {
    'Experience': ExperienceFilterWidget(),
    'Fees': FeesFilterWidget(),
    'Availability': AvailabilityFilterWidget(),
    'Areas of Expertise': AvailabilityFilterWidget(),
    'Gender': GenderFilterWidget(),
    'Language': LanguageFilterWidget(),
    'City': CityFilterWidget(),
  };


  @override
  void initState() {
    getSharedPrefs();
    super.initState();
  }

  Future getSharedPrefs() async {
    // CheckSession();
    getDoctorsList();
  }



  @override
  Widget build(BuildContext context) {

    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.035,
                            width: MediaQuery.of(context).size.height * 0.035,
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF126086).withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 0.0, color: Color(0xFF126086)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(130.0),
                              child: Image.asset(
                                'assets/medicationBack.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.00,
                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                  left: MediaQuery.of(context).size.height * 0.00,
                                  right: MediaQuery.of(context).size.height * 0.00,
                                ),
                                child: Text(
                                  usernameValue,
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.00,
                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                  left: MediaQuery.of(context).size.height * 0.00,
                                  right: MediaQuery.of(context).size.height * 0.00,
                                ),
                                child: Text(
                                  useraddressValue,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize:
                                    MediaQuery.of(context).size.height * 0.014,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
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
                                    0.045,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.045,
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

                  // Main Content Section
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.00,
                          top: MediaQuery.of(context).size.height * 0.015,
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
                        shrinkWrap: true,
                        children: [

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
                                          color: Colors.black54
                                              .withOpacity(0.5),
                                          // overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.016),
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
                                              .height * 0.016),
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
                                                    0.016), // Red text
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
                                                    .height * 0.016),
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
                                                    0.016), // Red text
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

                                  // Divider
                                  Container(
                                    width: 1, // Width of the divider
                                    height: 24, // Height of the divider
                                    color: Colors.grey, // Color of the divider
                                    margin: EdgeInsets.symmetric(horizontal: 4), // Spacing around the divider
                                  ),
                                  // Icon from Assets
                                  InkWell(
                                    onTap: () {

                                      showBottomSheet();
                                      /*  Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (BuildContext context) {
                                                            return FilterScreen();
                                                          },
                                                        ),
                                                      );*/

                                    },
                                    child:   Padding(
                                      padding: EdgeInsets.only(
                                        right: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.01,
                                      ),
                                      child: Image.asset(
                                        'assets/scansearch.png', // Replace with your actual asset path
                                        height: 20, // Height of the asset icon
                                        width: 20,  // Width of the asset icon
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),


                          // Search Input Field

                          /*  Container(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.0,
                              left: screenWidth * 0.0,
                              right: screenWidth * 0.0,
                              bottom: screenWidth * 0.0,
                            ),
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.0,
                                bottom: MediaQuery.of(context).size.height * 0.0,
                                left: MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               *//* InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: screenHeight * 0.045,
                                    width: screenHeight * 0.045,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100]!.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_sharp,
                                      color: Color(0xFF126086),
                                      size: screenHeight * 0.025,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: screenHeight *
                                        0.005),*//* // Add spacing between widgets
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(
                                            bottom: screenHeight * 0.01),
                                        child: TextFormField(
                                          controller: SearchEditTextController,
                                          *//* inputFormatters: [
                                        LengthLimitingTextInputFormatter(15),
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-zA-Z0-9]')),
                                      ],*//*
                                          *//*textCapitalization:
                                          TextCapitalization.characters,*//*
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.emailAddress,
                                          validator: (input) => input!.length < 3
                                              ? "Search should be more than 3 characters"
                                              : null,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(
                                                screenHeight * 0.012),
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintText: "Search By Doctor",
                                            hintStyle: TextStyle(
                                              color: Colors.black26,
                                              fontSize: screenHeight * 0.016,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(5.0),
                                              borderSide:
                                              BorderSide(color: Colors.grey),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide:
                                              BorderSide(color: Colors.white),
                                            ),
                                            suffixIcon: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min, // Ensures the Row only takes as much space as needed
                                                children: [
                                                  // Search Icon
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    icon: const Icon(
                                                      Icons.search_sharp,
                                                      color: Colors.black45,
                                                    ),
                                                    onPressed: () {
                                                      // showBottomSheet();
                                                    },
                                                  ),
                                                  // Divider
                                                  Container(
                                                    width: 1, // Width of the divider
                                                    height: 24, // Height of the divider
                                                    color: Colors.grey, // Color of the divider
                                                    margin: EdgeInsets.symmetric(horizontal: 4), // Spacing around the divider
                                                  ),
                                                  // Icon from Assets
                                                  InkWell(
                                                    onTap: () {

                                                      showBottomSheet();
                                                    *//*  Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (BuildContext context) {
                                                            return FilterScreen();
                                                          },
                                                        ),
                                                      );*//*

                                                    },
                                                    child: Image.asset(
                                                      'assets/scansearch.png', // Replace with your actual asset path
                                                      height: 20, // Height of the asset icon
                                                      width: 20,  // Width of the asset icon
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),*/

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // Provide a width constraint using SizedBox or Expanded
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.00,
                                    right:
                                    MediaQuery.of(context).size.height * 0.00,
                                    bottom:
                                    MediaQuery.of(context).size.height * 0.005,
                                    top: MediaQuery.of(context).size.height * 0.00),
                                // height: MediaQuery.of(context).size.height * 0.190,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: ScrollPhysics(), // Ensures scrolling
                                  shrinkWrap:
                                  true, // Prevents ListView from taking up extra space
                                  scrollDirection: Axis.vertical, // Makes the ListView horizontal
                                  itemCount: responselist!.length!, // You can adjust the item count
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {

                                        /*  Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder:
                                                (BuildContext context) {
                                              return DoctorDetilPage(responselist![index].id!);
                                            },
                                          ),
                                        );*/




                                        /*  if (index == 0) {
                                          print("Custom FAB pressed!");
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return DoctorDetilPage();
                                              },
                                            ),
                                          );
                                        } else if (index == 1) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return DoctorDetilPage();
                                              },
                                            ),
                                          );
                                        } else {
                                          // Handle other indices
                                          print("Button $index clicked!");
                                        }*/
                                      },
                                      child:
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.01,
                                            right: MediaQuery.of(context).size.height * 0.01,
                                            top: MediaQuery.of(context).size.height * 0.0,
                                            bottom: MediaQuery.of(context).size.height * 0.0),
                                        decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(32),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),  // Shadow color
                                              offset: Offset(0, 0),  // Shadow offset (all sides)
                                              blurRadius: 3,  // How blurry the shadow is
                                              spreadRadius: 1,  // How much the shadow expands outside the card
                                            ),
                                          ],
                                        ),
                                        child:
                                        Card(
                                          elevation: 0.0,
                                          color: Colors.white,
                                          child:  Container(
                                            width:MediaQuery.of(context).size.height * 0.450,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(32),

                                            ),
                                            padding:EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.005,
                                                right: MediaQuery.of(context).size.height * 0.005,
                                                bottom: MediaQuery.of(context).size.height * 0.005,
                                                top: MediaQuery.of(context).size.height * 0.005),
                                            // color: Colors.white,
                                            child:
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[



                                                  Container(
                                                    // color: Colors.red,
                                                    // height: MediaQuery.of(context).size.height * 0.12,
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                        right: MediaQuery.of(context).size.height * 0.005,
                                                        top: MediaQuery.of(context).size.height * 0.00,
                                                        bottom: MediaQuery.of(context).size.height * 0.00),
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
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                          Container(

                                                            padding: EdgeInsets.only(
                                                              left:
                                                              MediaQuery.of(context).size.height * 0.00,
                                                            ),

                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(130.0),
                                                              child: Image.asset(
                                                                'assets/NutanBhatt.png',
                                                                fit: BoxFit.fill,
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
                                                            width: MediaQuery.of(context).size.height *
                                                                0.010),

                                                        Expanded(
                                                          flex: 8,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[


                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                    left: MediaQuery.of(context).size.height * 0.00,
                                                                    right: MediaQuery.of(context).size.height * 0.00,
                                                                    top: MediaQuery.of(context).size.height * 0.01,
                                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                                child:
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                            top: MediaQuery.of(context).size.height * 0.0,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:
                                                                        Text(
                                                                          responselist![index].doctorName != null ?  responselist![index].doctorName! : "" ,

                                                                          style: TextStyle(
                                                                              color: Colors.black87,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                                  0.02),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color:Color(0xFFF3F5F9),
                                                                          borderRadius: BorderRadius.circular(8),
                                                                        ),
                                                                        padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.005,
                                                                            right: MediaQuery.of(context).size.height * 0.012,
                                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:
                                                                        Row(
                                                                          children: <Widget>[

                                                                            Icon(
                                                                              Icons.star,
                                                                              color: Colors.amber,
                                                                              size: MediaQuery.of(context).size.height * 0.025,
                                                                            ),
                                                                            Text(
                                                                              "4.2",
                                                                              style: TextStyle(
                                                                                  color: Colors.black87,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: MediaQuery.of(context)
                                                                                      .size
                                                                                      .height *
                                                                                      0.02),
                                                                            )
                                                                          ],
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                        ),
                                                                      ),
                                                                    ]
                                                                ),
                                                              ),





                                                              Container(

                                                                padding: EdgeInsets.only(
                                                                    left: MediaQuery.of(context).size.height * 0.00,
                                                                    right: MediaQuery.of(context).size.height * 0.00,
                                                                    top: MediaQuery.of(context).size.height * 0.00,
                                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                                child:
                                                                Text(
                                                                  responselist![index].speciality != null ?  responselist![index].speciality! : "" ,

                                                                  style: TextStyle(
                                                                      color: Colors.black54,
                                                                      fontWeight: FontWeight.bold,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontSize: MediaQuery.of(context)
                                                                          .size
                                                                          .height *
                                                                          0.018),
                                                                ),
                                                              ),




                                                            ],
                                                          ),
                                                        ),



                                                      ],
                                                    ),
                                                  ),


                                                  Container(

                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.018,
                                                        right: MediaQuery.of(context).size.height * 0.00,
                                                        top: MediaQuery.of(context).size.height * 0.00,
                                                        bottom: MediaQuery.of(context).size.height * 0.00),
                                                    child:
                                                    Text(
                                                      responselist![index].qualification != null ?  responselist![index].qualification! : "",
                                                      style: TextStyle(
                                                          color: Color(0xFF126086),
                                                          fontWeight: FontWeight.bold,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.013),
                                                    ),
                                                  ),






                                                  // parallel square images
                                                  Container(
                                                    margin: EdgeInsets.all(0),
                                                    padding: EdgeInsets.all(0),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 9,
                                                          child: Container(
                                                            margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.02),
                                                            padding: EdgeInsets.all(0),
                                                            width: MediaQuery.of(context).size.height * 0.280,
                                                            height: MediaQuery.of(context).size.height * 0.090,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(16),
                                                              color: Colors.white,
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                // Row for displaying images from myimageslist
                                                                Positioned.fill(
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: List.generate(
                                                                      myimageslist.length,
                                                                          (index) => Padding(
                                                                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.005),
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(8),
                                                                          child: Image.asset(
                                                                            myimageslist[index][0], // Use the first element of each sublist
                                                                            width: MediaQuery.of(context).size.height * 0.042,
                                                                            height: MediaQuery.of(context).size.height * 0.042,
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // "+3" text at the right edge
                                                                Positioned(
                                                                  right: 0, // Adjusted to ensure +3 is fully visible
                                                                  top: 0,
                                                                  bottom: 0,
                                                                  child: Align(
                                                                    alignment: Alignment.centerRight,
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(12),
                                                                      ),
                                                                      padding: EdgeInsets.symmetric(
                                                                        horizontal: MediaQuery.of(context).size.height * 0.008,
                                                                        vertical: MediaQuery.of(context).size.height * 0.005,
                                                                      ),
                                                                      child: Text(
                                                                        "+3",
                                                                        style: TextStyle(
                                                                          color: Color(0xFF126086),
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: MediaQuery.of(context).size.height * 0.014, // Slightly increased for better visibility
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 7,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                  top: MediaQuery.of(context).size.height * 0.0,
                                                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                                                ),
                                                                child: Text(
                                                                  maxLines: 2,
                                                                  responselist![index].workLocation != null ?  responselist![index].workLocation! : "",
                                                                  style: TextStyle(
                                                                    color: Colors.black54,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          ),
                                                        ),


                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                          InkWell(
                                                            onTap: () {
                                                              // Navigator.pop(context);
                                                            },

                                                            child: Container(
                                                              height: screenHeight * 0.035,
                                                              width: screenHeight * 0.035,
                                                              decoration: BoxDecoration(
                                                                // color: Colors.blue[100]!.withOpacity(0.9),
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: Center( // Ensures the image is centered
                                                                child: Image.asset(
                                                                  'assets/Directionicon.png', // Replace with your actual asset path
                                                                  // color: Color(0xFF126086), // Optional: Apply color tint
                                                                  height: screenHeight * 0.035,
                                                                  width: screenHeight * 0.035,
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        ),


                                                      ],
                                                    ),
                                                  ),





                                                  // Bottom Row
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                        right: MediaQuery.of(context).size.height * 0.005,
                                                        top: MediaQuery.of(context).size.height * 0.00,
                                                        bottom: MediaQuery.of(context).size.height * 0.005),
                                                    width: double.infinity,
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(06),
                                                            ),
                                                            padding: EdgeInsets.only(
                                                              left: MediaQuery.of(context).size.height * 0.01,
                                                              right: MediaQuery.of(context).size.height * 0.01,
                                                              top: MediaQuery.of(context).size.height * 0.00,
                                                              bottom: MediaQuery.of(context).size.height * 0.00,),
                                                            child: Row(
                                                              // mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: <Widget>[
                                                                  Expanded(
                                                                    child:
                                                                    Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          // Date
                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                              // color:Colors.white,
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                            // color:Colors.green[100],
                                                                            padding: EdgeInsets.only(
                                                                                left: MediaQuery.of(context).size.height * 0.0,
                                                                                right: MediaQuery.of(context).size.height * 0.0,
                                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                                            child:

                                                                            Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: <Widget>[

                                                                                  Container(
                                                                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                                                                    height: MediaQuery.of(context).size.height * 0.01,
                                                                                    width: MediaQuery.of(context).size.height * 0.01,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.black,
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),

                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                          padding: EdgeInsets.only(
                                                                                              left: MediaQuery.of(context).size.height * 0.005,
                                                                                              right: MediaQuery.of(context).size.height * 0.00,
                                                                                              top: MediaQuery.of(context).size.height * 0.00,
                                                                                              bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                          child:
                                                                                          Text(
                                                                                            'QR 299',
                                                                                            style: TextStyle(
                                                                                              // color: Colors.blue[600],
                                                                                                color: Colors.black,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                decoration: TextDecoration.lineThrough,
                                                                                                decorationThickness: 2,
                                                                                                fontSize: MediaQuery.of(context)
                                                                                                    .size
                                                                                                    .height *
                                                                                                    0.018),
                                                                                          )


                                                                                      ),
                                                                                      Container(
                                                                                        padding: EdgeInsets.only(
                                                                                            left: MediaQuery.of(context).size.height * 0.005,
                                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                        child:
                                                                                        Text( "QR 199",
                                                                                          style: TextStyle(
                                                                                            // color: Colors.blue[600],
                                                                                              color: Color(0xFF12B76A),
                                                                                              fontWeight: FontWeight.bold,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              fontSize: MediaQuery.of(context)
                                                                                                  .size
                                                                                                  .height *
                                                                                                  0.018),
                                                                                        ),

                                                                                      ),

                                                                                      Container(
                                                                                        margin: EdgeInsets.only(
                                                                                            left: MediaQuery.of(context).size.height * 0.005,
                                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                        height: screenHeight * 0.02,
                                                                                        width: screenHeight * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          // color: Colors.blue[100]!.withOpacity(0.9),
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Center( // Ensures the image is centered
                                                                                          child: Image.asset(
                                                                                            'assets/Offersicon.png', // Replace with your actual asset path
                                                                                            // color: Color(0xFF126086), // Optional: Apply color tint
                                                                                            height: screenHeight * 0.02,
                                                                                            width: screenHeight * 0.02,
                                                                                          ),
                                                                                        ),
                                                                                      ),

                                                                                    ],
                                                                                  )


                                                                                ]
                                                                            ),

                                                                          ),


                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                              // color:Colors.white,
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                            // color:Colors.green[100],
                                                                            padding: EdgeInsets.only(
                                                                                left: MediaQuery.of(context).size.height * 0.0,
                                                                                right: MediaQuery.of(context).size.height * 0.0,
                                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                                            child:

                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: <Widget>[

                                                                                GestureDetector(
                                                                                  onTap: () async {
                                                                                    Navigator.of(context).push(
                                                                                      MaterialPageRoute(
                                                                                        builder:
                                                                                            (BuildContext context) {
                                                                                          return SelectTimeSlot(responselist![index].doctorId!);
                                                                                        },
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: new EdgeInsets.only(
                                                                                        left: MediaQuery.of(context).size.height * 0.015,
                                                                                        right: MediaQuery.of(context).size.height * 0.015,
                                                                                        top: MediaQuery.of(context).size.height * 0.01,
                                                                                        bottom: MediaQuery.of(context).size.height * 0.01),
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFF126086),
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                    ),


                                                                                    margin: EdgeInsets.only(
                                                                                      left: MediaQuery.of(context).size.height * 0.00,
                                                                                      top: MediaQuery.of(context).size.height * 0.00,
                                                                                      bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                      right: MediaQuery.of(context).size.height * 0.005,
                                                                                    ),
                                                                                    // color: Colors.grey[300],
                                                                                    alignment: Alignment.center,
                                                                                    // height:
                                                                                    // MediaQuery.of(context).size.height * 0.070,
                                                                                    child: Text("Consult",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontSize:  MediaQuery.of(context).size.height * 0.014)),
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


            ]
        ),
      ),



    );
  }


  void showBottomSheet() => showModalBottomSheet(
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
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) =>
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.025,
                      right: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.015),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.0,
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                      ),
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.0,
                        bottom: MediaQuery.of(context).size.height * 0.0,
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0,
                              bottom: MediaQuery.of(context).size.height * 0.04,
                              left: MediaQuery.of(context).size.height * 0.18,
                              right: MediaQuery.of(context).size.height * 0.18,
                            ),
                            child: Divider(
                              height: 0,
                              indent: 0,
                              thickness: MediaQuery.of(context).size.height * 0.008,
                              color:Color(0xFF95C8D6).withOpacity(0.3),
                            ),
                          ),

                          // Add Filters (1)
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.0,
                                right: MediaQuery.of(context).size.height * 0.02,
                                bottom: MediaQuery.of(context).size.height * 0.00),
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
                                      "Add Filters (1)",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {

                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height *
                                              0.00,
                                          right:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          top: MediaQuery.of(context).size.height *
                                              0.00,
                                          bottom:
                                          MediaQuery.of(context).size.height *
                                              0.00),
                                      child: Text(
                                        "Clear all",
                                        style: TextStyle(
                                          color: Color(0xFF126086),
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),



                        ],
                      ),
                    ),
                  ),
                ),



                Row(
                  children: [

                    // Left Side: Categories List
                    Expanded(
                      flex : 2,
                      child:
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF95C8D6).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.020,
                            right: MediaQuery.of(context).size.height * 0.0,
                            top: MediaQuery.of(context).size.height * 0.0,
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        // width: MediaQuery.of(context).size.height * 0.2,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategoryIndex = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedCategoryIndex == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    if (selectedCategoryIndex ==
                                        index) // Show the side line only for the selected cell
                                      Positioned(
                                        top: 6, // Gap from the top
                                        left: 0,
                                        bottom: 6, // Gap from the bottom
                                        child: Container(
                                          width: 2.0, // Same as border width
                                          color:  Color(0xFF126086), // Border color
                                        ),
                                      ),
                                    Container(
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
                                      child: Text(
                                        categories[index],
                                        style: TextStyle(
                                          color: selectedCategoryIndex == index
                                              ? Color(0xFF126086) : Colors.black87,
                                          fontSize: MediaQuery.of(context).size.height * 0.018,
                                          fontWeight: selectedCategoryIndex == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Right Side: Filter Options
                    Expanded(
                      flex : 3,
                      child:
                      Container(
                        // width: MediaQuery.of(context).size.height * 0.28,
                        height: MediaQuery.of(context).size.height * 0.35,
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
                        child: _getFilterWidget(categories[selectedCategoryIndex], context),
                      ),
                    ),
                  ],
                ),



                GestureDetector(
                  onTap: () async {

                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          top:
                          MediaQuery.of(context).size.height * 0.01,
                          bottom:
                          MediaQuery.of(context).size.height * 0.00,
                          left:
                          MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height *
                              0.00),
                      margin: EdgeInsets.only(
                          right:
                          MediaQuery.of(context).size.height * 0.02,
                          top:
                          MediaQuery.of(context).size.height * 0.01,
                          bottom:
                          MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height *
                              0.02),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.012),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.center,
                                        stops: [
                                          0.5,
                                          0.9
                                        ],
                                        colors: [
                                          Color(0xFFA8B1CE),
                                          Color(0xFFA8B1CE),
                                        ])),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 0.0),
                                child: TextButton(
                                  onPressed: () async {

                                  },
                                  child: Text("Apply Filters",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.026)),
                                ),
                              ),
                            ),
                          ])),
                )



              ],
            ),
          ),
    ),
  );

  // Dynamically return the filter widget based on the selected category
  Widget _getFilterWidget(String category, BuildContext context) {
    switch (category) {
      case 'Experience':
        return _experienceFilterWidget(context);
      case 'Fees':
        return _feesFilterWidget(context);
      case 'Availability':
        return _availabilityFilterWidget(context);
      case 'Areas of Expertise':
        return _AreaofExpertiseFilterWidget(context);
      case 'Gender':
        return _genderFilterWidget(context);
      case 'Language':
        return _languageFilterWidget(context);
      case 'City':
        return _cityFilterWidget(context);
      default:
        return Container();
    }
  }

  // Experience Filter Widget
  Widget _experienceFilterWidget(BuildContext context) {
    // Experience range list
    final experienceRanges = [
      '0-5 years',
      '6-10 years',
      '11-16 years',
      '17-21 years',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "0-5 Years",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "6-10 years",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ]),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "11-16 years",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "17-21 years",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  // Fees Filter Widget
  Widget _feesFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "QR 100 -500",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "QR 500-1000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ]),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "QR 1000 - 5000 ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ]),
        ),
      ],
    );
  }

  // Availability Filter Widget
  Widget _availabilityFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Now",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Today",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Tomorrow",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ]),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Next 3 Days",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ]),
        ),
      ],
    );
  }

  // Area of Expertise
  Widget _AreaofExpertiseFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input Field
        GestureDetector(
          onTap: () {

          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.0,
              bottom: MediaQuery.of(context).size.height * 0.00,
              left: MediaQuery.of(context).size.height * 0.00,
              right: MediaQuery.of(context).size.height * 0.00,
            ),
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.height * 0.01,
              top: MediaQuery.of(context).size.height * 0.0,
              bottom: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.height * 0.01,
            ),
            child: AbsorbPointer(
              // Prevents the field from gaining focus or triggering gestures
              child: TextFormField(
                readOnly: true,
                controller: SearchfilterEditTextController,
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
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText:
                  "Search",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: MediaQuery.of(context).size.height * 0.016,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey.shade200),
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

                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.00,
                right: MediaQuery.of(context).size.height * 0.00,
                bottom: MediaQuery.of(context).size.height * 0.0,
                top: MediaQuery.of(context).size.height * 0.00,
              ),
              child: ListView.builder(
                physics: ScrollPhysics(), // Ensures scrolling
                shrinkWrap: true, // Prevents ListView from taking up extra space
                scrollDirection: Axis.vertical, // Keeps the ListView vertical
                itemCount: diseases.length, // Use the diseases list length
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Add your onTap logic here
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.0,
                      ),
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.00,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                        left: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.00,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max, // Full width
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.005,
                              right: MediaQuery.of(context).size.height * 0.005,
                              top: MediaQuery.of(context).size.height * 0.005,
                              bottom: MediaQuery.of(context).size.height * 0.005,
                            ),
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.0,
                              right: MediaQuery.of(context).size.height * 0.0,
                              top: MediaQuery.of(context).size.height * 0.0,
                              bottom: MediaQuery.of(context).size.height * 0.0,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, // Center content
                              children: <Widget>[
                                Text(
                                  diseases[index], // Display disease name
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w400,
                                    fontSize: MediaQuery.of(context).size.height * 0.014,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
    );
  }

  // Gender Filter Widget
  Widget _genderFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Male",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Female",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ]),
        ),

      ],
    );
  }

  // Language Filter Widget
  Widget _languageFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "English",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Tamil",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Kannada",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ]),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Hindi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Telugu",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Urdu",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.018,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  // City Filter Widget
  Widget _cityFilterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input Field
        GestureDetector(
          onTap: () {

          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.0,
              bottom: MediaQuery.of(context).size.height * 0.00,
              left: MediaQuery.of(context).size.height * 0.00,
              right: MediaQuery.of(context).size.height * 0.00,
            ),
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.height * 0.01,
              top: MediaQuery.of(context).size.height * 0.0,
              bottom: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.height * 0.01,
            ),
            child: AbsorbPointer(
              // Prevents the field from gaining focus or triggering gestures
              child: TextFormField(
                readOnly: true,
                controller: SearchfilterEditTextController,
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
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText:
                  "Search",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: MediaQuery.of(context).size.height * 0.016,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey.shade200),
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

                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Bangalore",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.016,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Hosur",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.016,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Chennai",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.016,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ]),
        ),
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.00,
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
            right: MediaQuery.of(context).size.height * 0.0,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Mumbai",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.016,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Agra",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.016,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.0,
                  ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.00,
                    bottom:
                    MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right:
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .max, // Ensure the Row takes up the full available width
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),

                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.0,
                          right: MediaQuery.of(context).size.height * 0.0,
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                        ),

                        decoration: BoxDecoration(
                          color:  Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content
                          children: <Widget>[
                            Text(
                              "Delhi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.016,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ]),
        ),
      ],
    );
  }


  void getDoctorsList() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        /* progressDialog.showMaterial(
            title: "Loading Data", message: "Please wait");*/
        progressDialog.show();
        dynamic user = await apiService.findDoctorslist(widget.consulttype);

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

          /*final snackBar = SnackBar(
            content: Text("Found"),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar,
          );*/
        } else {
          progressDialog.hide();
          final snackBar = SnackBar(
            content: Text("Details Not Found"),
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
