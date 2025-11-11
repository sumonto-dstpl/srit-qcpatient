import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Data/Models/doctorslistres.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/addFilterForFindDoctorList.dart';
import 'package:newfolder/Screens/Appointments/doctordetailpage.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Testing/filtersearch.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:progress_dialog2/progress_dialog2.dart';


class FindDoctorsListMain extends StatefulWidget {

  final String? physical_virtual_mode;
  final String? consulttype;
  FindDoctorsListMain(this.consulttype, {Key? key,this.physical_virtual_mode = "physical",}) : super(key: key);


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
  List<DoctorsListResponse> responselist = [];
  List<DoctorsListResponse> filterresponselist = [];

  final List<String> hints = ["Doctor", "Speciality", "Symptoms"];



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
    ["assets/appointmentimg1.png"],
    ["assets/appointmentimg2.png"],
    ["assets/appointmentimg3.png"],
    ["assets/appointmentimg5.png"],
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();



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
    getCommonDoctorList();
    // getSharedPrefs();
    // checkGuestUser();
    super.initState();
  }

  Future getSharedPrefs() async {
    // CheckSession();
    // getDoctorsList();
    final isLoggedIn = await UserSecureStorage.getIfGuestLogged() ?? "NO";


    if (isLoggedIn == "YES") {
      getGuestDoctorsList();
    }
    else
    {
      getDoctorsList();
    }

  }

  void checkGuestUser() async {

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body:


      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
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

                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.035,
                            width: MediaQuery.of(context).size.height * 0.035,
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.02,
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
                                    .height * 0.001,
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


                            GestureDetector(
                              onTap: () {
                                /* Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) {
                                      return GoogleMapScreen();
                                    },
                                  ),
                                );*/
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
                        margin: EdgeInsets.only(
                          left: screenHeight * 0.02,
                          right: screenHeight * 0.02,
                          top: screenHeight * 0.015,
                        ),
                        alignment: Alignment.centerRight,

                        child: TextFormField(
                          controller: SearchEditTextController,
                          onChanged: (value){
                            _search(SearchEditTextController.text.toString());
                          },
                          // focusNode: searchFocusNode,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                            // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                          ],
                          textCapitalization: TextCapitalization.words,

                          style: const TextStyle(color: Colors.black45),
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => input!.length < 3
                              ? "Search should be more than 3 characters"
                              : null,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(
                              screenHeight * 0.02,
                              screenHeight * 0.012,
                              screenHeight * 0.012,
                              screenHeight * 0.012,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF7F5F6),
                            // hintText: "Search By Doctor",
                            hintText: null,
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: screenHeight * 0.016,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            // suffixIcon: IconButton(
                            //   icon: Icon(
                            //     Icons.search,
                            //     color: Colors.black45,
                            //     size: screenHeight * 0.024,
                            //   ),
                            //   onPressed: () {
                            //
                            //     // showDetails(SearchEditTextController.text);
                            //   },
                            // ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                InkWell(
                                  onTap: () {
                                    // your search action
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black45,
                                    size: MediaQuery.of(context).size.height * 0.025,
                                  ),
                                ),


                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  width: 1,
                                  height: 24,
                                  color: Colors.grey,
                                ),


                                GestureDetector(
                                  behavior: HitTestBehavior.translucent, // ensures full area is tappable
                                  onTap: () async {
                                    print("filter");
                                    FocusScope.of(context).unfocus();
                                    await Future.delayed(const Duration(milliseconds: 200));
                                    showBottomSheet();
                                  },
                                  child: Container(

                                    height: MediaQuery.of(context).size.height * 0.05,
                                    width: MediaQuery.of(context).size.height * 0.05,
                                    // color: Colors.red,
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/scansearch.png',
                                      height: 18,
                                      width: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Search by ",
                                  style: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: screenHeight * 0.016,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: TextStyle(
                                    color: Color(0xFF126086),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenHeight * 0.016,
                                  ),
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    pause: Duration(milliseconds: 700),
                                    animatedTexts: hints
                                        .map((e) => RotateAnimatedText(
                                      e,
                                      textStyle: TextStyle(
                                        color: Color(0xFF126086),
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight * 0.016,
                                      ),
                                    ))
                                        .toList(),
                                    onTap: () {
                                      // Optional — navigate to search page

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ),
                  // main content
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0,
                         ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(screenHeight * 0.03),
                        //   topRight: Radius.circular(screenHeight * 0.03),
                        // ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [



                          


                          // Search Input Field

                          // Container(
                          //   padding: EdgeInsets.only(
                          //     top: screenHeight * 0.0,
                          //     left: screenWidth * 0.0,
                          //     right: screenWidth * 0.0,
                          //     bottom: screenWidth * 0.0,
                          //   ),
                          //   margin: EdgeInsets.only(
                          //       right: MediaQuery.of(context).size.height * 0.01,
                          //       top: MediaQuery.of(context).size.height * 0.0,
                          //       bottom: MediaQuery.of(context).size.height * 0.0,
                          //       left: MediaQuery.of(context).size.height * 0.01),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //
                          //  InkWell(
                          //         onTap: () => Navigator.pop(context),
                          //         child: Container(
                          //           height: screenHeight * 0.045,
                          //           width: screenHeight * 0.045,
                          //           decoration: BoxDecoration(
                          //             color: Colors.grey[100]!.withOpacity(0.9),
                          //             shape: BoxShape.circle,
                          //           ),
                          //           child: Icon(
                          //             Icons.arrow_back_ios_sharp,
                          //             color: Color(0xFF126086),
                          //             size: screenHeight * 0.025,
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(
                          //           width: screenHeight *
                          //               0.005),
                          //  // Add spacing between widgets
                          //       Expanded(
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Container(
                          //               alignment: Alignment.centerRight,
                          //               margin: EdgeInsets.only(
                          //                   bottom: screenHeight * 0.01),
                          //               child: TextFormField(
                          //                 controller: SearchEditTextController,
                          //
                          //  inputFormatters: [
                          //               LengthLimitingTextInputFormatter(15),
                          //               FilteringTextInputFormatter.allow(
                          //                   RegExp('[a-zA-Z0-9]')),
                          //             ],
                          //                 textCapitalization:
                          //                 TextCapitalization.characters,
                          //                 style: TextStyle(color: Colors.black),
                          //                 keyboardType: TextInputType.emailAddress,
                          //                 validator: (input) => input!.length < 3
                          //                     ? "Search should be more than 3 characters"
                          //                     : null,
                          //                 decoration: InputDecoration(
                          //                   isDense: true,
                          //                   contentPadding: EdgeInsets.all(
                          //                       screenHeight * 0.012),
                          //                   filled: true,
                          //                   fillColor: Colors.grey[200],
                          //                   hintText: "Search By Doctor",
                          //                   hintStyle: TextStyle(
                          //                     color: Colors.black26,
                          //                     fontSize: screenHeight * 0.016,
                          //                   ),
                          //                   focusedBorder: OutlineInputBorder(
                          //                     borderRadius:
                          //                     BorderRadius.circular(5.0),
                          //                     borderSide:
                          //                     BorderSide(color: Colors.grey),
                          //                   ),
                          //                   enabledBorder: OutlineInputBorder(
                          //                     borderRadius: BorderRadius.all(
                          //                         Radius.circular(5.0)),
                          //                     borderSide:
                          //                     BorderSide(color: Colors.white),
                          //                   ),
                          //                   suffixIcon: Container(
                          //                     padding: EdgeInsets.symmetric(horizontal: 8),
                          //                     child: Row(
                          //                       mainAxisSize: MainAxisSize.min, // Ensures the Row only takes as much space as needed
                          //                       children: [
                          //                         // Search Icon
                          //                         IconButton(
                          //                           padding: EdgeInsets.zero,
                          //                           icon: const Icon(
                          //                             Icons.search_sharp,
                          //                             color: Colors.black45,
                          //                           ),
                          //                           onPressed: () {
                          //                             // showBottomSheet();
                          //                           },
                          //                         ),
                          //                         // Divider
                          //                         Container(
                          //                           width: 1, // Width of the divider
                          //                           height: 24, // Height of the divider
                          //                           color: Colors.grey, // Color of the divider
                          //                           margin: EdgeInsets.symmetric(horizontal: 4), // Spacing around the divider
                          //                         ),
                          //                         // Icon from Assets
                          //                         InkWell(
                          //                           onTap: () {
                          //
                          //                             showBottomSheet();
                          //                             Navigator.of(context).push(
                          //                               MaterialPageRoute(
                          //                                 builder: (BuildContext context) {
                          //                                   return FilterScreen();
                          //                                 },
                          //                               ),
                          //                             );
                          //
                          //                           },
                          //                           child: Image.asset(
                          //                             'assets/scansearch.png', // Replace with your actual asset path
                          //                             height: 20, // Height of the asset icon
                          //                             width: 20,  // Width of the asset icon
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // Provide a width constraint using SizedBox or Expanded
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height * 0.01,
                                    right:
                                    MediaQuery.of(context).size.height * 0.01,
                                    bottom:
                                    MediaQuery.of(context).size.height * 0.010,
                                    top: MediaQuery.of(context).size.height * 0.00),
                                // height: MediaQuery.of(context).size.height * 0.190,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: ScrollPhysics(), // Ensures scrolling
                                  shrinkWrap:
                                  true, // Prevents ListView from taking up extra space
                                  scrollDirection: Axis.vertical, // Makes the ListView horizontal
                                  itemCount: filterresponselist!.length!, // You can adjust the item count
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                      },
                                      child:
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.01,
                                            right: MediaQuery.of(context).size.height * 0.01,
                                            top: MediaQuery.of(context).size.height * 0.01,
                                            bottom: MediaQuery.of(context).size.height * 0.0),
                                        decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(32),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                  0.1), // Shadow color
                                              blurRadius:
                                              5, // Spread of the shadow
                                              offset: Offset(0,
                                                  0), // Offset in x and y direction
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
                                              top: MediaQuery.of(context).size.height * 0.01),
                                          // color: Colors.white,
                                          child:
                                          Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[


                                                  // Image & Dr profile & Icon
                                                  Container(
                                                    // color: Colors.red,
                                                    // height: MediaQuery.of(context).size.height * 0.12,
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                        right: MediaQuery.of(context).size.height * 0.005,
                                                        top: MediaQuery.of(context).size.height * 0.01,
                                                        bottom: MediaQuery.of(context).size.height * 0.00
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.start,

                                                      children: <Widget>[
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.01),
                                                        Container(
                                                          height : MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.055,
                                                          padding:
                                                          EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                130.0),
                                                            child: Image.asset(
                                                              'assets/NutanBhatt.png',
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),

                                                        SizedBox(
                                                            width: MediaQuery.of(context).size.height *
                                                                0.015),

                                                        Expanded(

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
                                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.00,
                                                                            right: MediaQuery.of(context).size.height * 0.00,
                                                                            top: MediaQuery.of(context).size.height * 0.0,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:
                                                                        Text(
                                                                          filterresponselist![index].doctorName != null ?  filterresponselist![index].doctorName! : "" ,

                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .black87,
                                                                              overflow: TextOverflow
                                                                                  .ellipsis,
                                                                              fontWeight: FontWeight
                                                                                  .w600,
                                                                              fontSize:
                                                                              MediaQuery.of(context).size.height * 0.016),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          color:Color(0xFFF3F5F9),
                                                                          borderRadius: BorderRadius.circular(8),
                                                                        ),
                                                                        padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height *
                                                                                0.005,
                                                                            right: MediaQuery.of(context).size.height *
                                                                                0.012,
                                                                            top: MediaQuery.of(context).size.height *
                                                                                0.003,
                                                                            bottom: MediaQuery.of(context).size.height *
                                                                                0.003),
                                                                        child:
                                                                        Row(
                                                                          children: <Widget>[

                                                                            Icon(
                                                                              Icons
                                                                                  .star,
                                                                              color:
                                                                              Colors.amber,
                                                                              size: MediaQuery.of(context).size.height *
                                                                                  0.015,
                                                                            ),
                                                                            SizedBox(width: MediaQuery.of(context).size.height * 0.005 ,),
                                                                            Text(
                                                                              "4.2",
                                                                              style: TextStyle(
                                                                                  color: Colors.black87,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: MediaQuery.of(context).size.height * 0.012),
                                                                            )
                                                                          ],
                                                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                                                        ),
                                                                      ),
                                                                    ]
                                                                ),
                                                              ),


                                                              SizedBox(height: screenHeight * 0.005,),


                                                              Container(

                                                                padding: EdgeInsets.only(
                                                                    left: MediaQuery
                                                                        .of(
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
                                                                        0.00,
                                                                    bottom: MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.00),
                                                                child:
                                                                Text(
                                                                  filterresponselist![index].speciality != null ?  filterresponselist![index].speciality! : "" ,

                                                                  style: TextStyle(
                                                                      color: Color(0x80000000),

                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      fontSize: MediaQuery.of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.014,
                                                                    fontFamily: "Inter",
                                                                  ),
                                                                ),
                                                              ),




                                                            ],
                                                          ),
                                                        ),



                                                      ],
                                                    ),
                                                  ),


                                                  // Qualification
                                                  Container(

                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.height * 0.018,
                                                        right: MediaQuery.of(context).size.height * 0.00,
                                                        top: MediaQuery.of(context).size.height * 0.008,
                                                        bottom: MediaQuery.of(context).size.height * 0.00),
                                                    child:
                                                    Text(
                                                      (filterresponselist![index].experience ?? "") + " - "+   (filterresponselist![index].qualification ??  ""),
                                                      style: TextStyle(
                                                          color: Color(0xFF126086),
                                                          fontWeight: FontWeight.w600,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.012
                                                      ),
                                                    ),
                                                  ),

                                                  // parallel square images
                                                  Container(

                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[

                                                        // Image
                                                        Container(
                                                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0),
                                                          padding: EdgeInsets.all(0),
                                                          width: MediaQuery.of(context).size.height * 0.2,
                                                          height: MediaQuery.of(context).size.height * 0.06,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(16),
                                                            color: Colors.white,
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              // Row for displaying images from myimageslist
                                                              Positioned.fill(
                                                                child:

                                                                   Container(
                                                          padding: EdgeInsets.only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height *
                                                              0.015,
                                                            right: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            top: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.01,
                                                            bottom: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.0),
                                                        child:

                                                                SizedBox(
                                                                  height: MediaQuery.of(context).size.height * 0.045, // Ensures correct height
                                                                  child: Stack(
                                                                    children: myimageslist.asMap().entries.map((entry) {
                                                                      int index = entry.key;
                                                                      String imagePath = entry.value[0]; // First element of each sublist

                                                                      return Positioned(
                                                                        left: index * (MediaQuery.of(context).size.height * 0.042), // Overlaps images
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.only(
                                                                            topLeft: index == 0 ? Radius.circular(8) : Radius.zero,
                                                                            bottomLeft: index == 0 ? Radius.circular(8) : Radius.zero,
                                                                            topRight: index == myimageslist.length - 1 ? Radius.circular(8) : Radius.zero,
                                                                            bottomRight: index == myimageslist.length - 1 ? Radius.circular(8) : Radius.zero,
                                                                          ),
                                                                          child: Image.asset(
                                                                            imagePath,
                                                                            width: MediaQuery.of(context).size.height * 0.045,
                                                                            height: MediaQuery.of(context).size.height * 0.045,
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).toList(),
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
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: MediaQuery.of(context).size.height * 0.01, // Slightly increased for better visibility
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        // Address
                                                        Expanded(
                                                          flex: 7,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Container(

                                                                child: Text(
                                                                  maxLines: 1,

                                                                  "2 QuadraCyte, Qatar 560002",
                                                                  style: TextStyle(
                                                                    color: Colors.black54,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                  ),
                                                                ),
                                                              ),

                                                              Container(

                                                                child: Text(
                                                                  maxLines: 1,

                                                                  "2 Km . From Your Location",
                                                                  style: TextStyle(
                                                                    color: Color(0xFF7F7F7F),
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        // Share icon
                                                        Expanded(
                                                      flex: 1,
                                                      child:
                                                      InkWell(
                                                        onTap: () {
                                                          // Navigator.pop(context);
                                                          },

                                                        child: Container(
                                                          height: screenHeight * 0.03,
                                                          width: screenHeight * 0.03,
                                                          decoration: BoxDecoration(
                                                            // color: Colors.blue[100]!.withOpacity(0.9),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          // child: Center( // Ensures the image is centered
                                                          //   child: Image.asset(
                                                          //     'assets/Directionicon.png', // Replace with your actual asset path
                                                          //     // color: Color(0xFF126086), // Optional: Apply color tint
                                                          //     height: screenHeight * 0.027,
                                                          //     width: screenHeight * 0.027,
                                                          //   ),
                                                          // ),
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
                                                              top: MediaQuery.of(context).size.height * 0.01,
                                                              bottom: MediaQuery.of(context).size.height * 0.00,),
                                                            child: Row(

                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: <Widget>[
                                                                  Expanded(
                                                                    child:
                                                                    Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          // Dot , QR 299
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
                                                                                    height: MediaQuery.of(context).size.height * 0.005,
                                                                                    width: MediaQuery.of(context).size.height * 0.005,
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
                                                                                                fontWeight: FontWeight.w500,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                decoration: TextDecoration.lineThrough,
                                                                                                decorationThickness: 2,
                                                                                                fontSize: MediaQuery.of(context)
                                                                                                    .size
                                                                                                    .height *
                                                                                                    0.014),
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
                                                                                              fontWeight: FontWeight.w500,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              fontSize: MediaQuery.of(context)
                                                                                                  .size
                                                                                                  .height *
                                                                                                  0.014),
                                                                                        ),

                                                                                      ),


                                    Visibility(
                                    visible: index < filterresponselist!.length , // Toggle this value to show/hide
                                    child:
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
                                                                                            height: screenHeight * 0.01,
                                                                                            width: screenHeight * 0.01
                                                                                          ),
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

                                                                                    print("Tap on Doctor Card");
                                                                                    Navigator.of(context).push(
                                                                                      MaterialPageRoute(
                                                                                        builder:
                                                                                            (BuildContext context) {
                                                                                          // return SelectTimeSlot(filterresponselist![index].doctorId!);
                                                                                          //     return DoctorDetilPage(
                                                                                          //       "Practitioner/f002",
                                                                                          //       doctorDetail : {
                                                                                          //       "doctorName" : filterresponselist[index].doctorName ,
                                                                                          //       "speciality" : filterresponselist[index].speciality ,
                                                                                          //       "experience" : (filterresponselist![index].experience ?? "") + " - "+   (filterresponselist![index].qualification ??  ""),
                                                                                          //         } ,
                                                                                          //       physical_virtual_mode: widget.physical_virtual_mode,
                                                                                          //     );
                                                                                           return SelectTimeSlot(
                                                                                             "Practitioner/f002",
                                                                                             doctorDetail: {
                                                                                               "doctorName" : filterresponselist[index].doctorName ,
                                                                                                     "speciality" : filterresponselist[index].speciality ,
                                                                                                     "experience" : (filterresponselist![index].experience ?? "") + " - "+   (filterresponselist![index].qualification ??  ""),

                                                                                             },
                                                                                             physical_virtual_mode: widget.physical_virtual_mode,
                                                                                           )   ;

                                                                                        },
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: new EdgeInsets.only(
                                                                                        left: MediaQuery.of(context).size.height * 0.015,
                                                                                        right: MediaQuery.of(context).size.height * 0.015,
                                                                                        top: MediaQuery.of(context).size.height * 0.005,
                                                                                        bottom: MediaQuery.of(context).size.height * 0.005),
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
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontSize:  MediaQuery.of(context).size.height * 0.01)),
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
                  ),
              )
                ],
              ),
            ],

        ),
      ),

    );
    
  }


  void showBottomSheet() async {
     final selectedFilters = await
     showModalBottomSheet(
       enableDrag: false,
       isScrollControlled: true,
       isDismissible: true,
       backgroundColor: Colors.transparent, // Make modal background transparent
       barrierColor: Colors.transparent,    // Disable default barrier color
       context: context,
       builder: (context) {
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
                 decoration: const BoxDecoration(
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black26,
                       blurRadius: 10,
                       spreadRadius: 2,
                       offset: Offset(0, -2), // Shadow appears above the sheet
                     ),
                   ],
                   color: Colors.white, // White background for the bottom sheet
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(24),
                     topRight: Radius.circular(24),
                   ),
                 ),
                 child: AddFilterForFindDoctorList(responselist: responselist),
               ),
             ),
           ],
         );
       },
     );


     print("selectedFilters : $selectedFilters");

     Map<String, List<String>> activeFilters = {};

     selectedFilters.forEach((category, options) {
       final selectedKeys = (options as Map<String, dynamic>)
           .entries
           .where((entry) => entry.value == true)
           .map((entry) => entry.key.toLowerCase()) // lowercase for safe compare
           .toList();

       if (selectedKeys.isNotEmpty) {
         activeFilters[category] = selectedKeys;
       }
     });

     print("Active Filters: $activeFilters");

     List<DoctorsListResponse> filteredDoctors = responselist.where((doctor) {
       bool matches = true;

       // 🔹 Availability Filter
       if (activeFilters.containsKey("availiability")) {
         matches = matches &&
             activeFilters["availiability"]!.contains(
               doctor.availiability?.toLowerCase() ?? "",
             );
       }

       // 🔹 Gender Filter
       if (activeFilters.containsKey("genders")) {
         matches = matches &&
             activeFilters["genders"]!.contains(
               doctor.gender?.toLowerCase() ?? "",
             );
       }

       // 🔹 City Filter
       if (activeFilters.containsKey("city")) {
         matches = matches &&
             activeFilters["city"]!.contains(
               doctor.city?.toLowerCase() ?? "",
             );
       }

       // 🔹 Language Filter
       if (activeFilters.containsKey("language")) {
         matches = matches &&
             activeFilters["language"]!.contains(
               doctor.language?.toLowerCase() ?? "",
             );
       }

       // 🔹 Experience Filter (simple example, adjust as needed)
       if (activeFilters.containsKey("experience")) {
         String exp = doctor.experience?.toLowerCase() ?? "";
         matches = matches &&
             activeFilters["experience"]!.any((e) => exp.contains(e));
       }

       // 🔹 Fees Filter (example based on keyword)
       if (activeFilters.containsKey("fees")) {
         String fee = doctor.discountFee?.toLowerCase() ?? "";
         matches = matches &&
             activeFilters["fees"]!.any((f) => fee.contains(f.replaceAll("qr", "₹")));
       }

       return matches;
     }).toList();

     print("filteredDoctors : $filteredDoctors");

     setState(() {
       filterresponselist = filteredDoctors;
     });
  }




  void getDoctorsList() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        /* progressDialog.showMaterial(
            title: "Loading Data", message: "Please wait");*/
        progressDialog.show();

        dynamic user = await apiService.findDoctorslist(widget.consulttype);
        print("status code : ${user.status}");
        print("message : ${user.message}");

        if (user.message != null) {
          progressDialog.hide();
          final snackBar = SnackBar(content: Text(user.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }



        else if (user.response!.length > 0) {
          progressDialog.hide();

          setState(() {
            responselist = user.response;
            filterresponselist = responselist;
          });



          // print("status code : ${responselist.to}");

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
  void getGuestDoctorsList() {
    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        /* progressDialog.showMaterial(
            title: "Loading Data", message: "Please wait");*/
        progressDialog.show();

        dynamic user = await apiService.findGuestDoctorslist(widget.consulttype);

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
            filterresponselist = responselist;
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

  void getCommonDoctorList() async{

    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {



        final List<Map<String, dynamic>> staticDoctorList = [
          {
            "doctorId": "1",
            "doctorName": "Dr. Arjun Mehta",
            "qualification": "MBBS, MD (General Medicine)",
            "speciality": "General Physician / Internal Medicine",
            "experience": "18 YEARS Experience",
            "regularFee": "₹800",
            "discountFee": "₹600",
            "rating": "4.8",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
            "availiability" : "today",
            "gender" : "Male",
            "language" : "English",
            "city" : "Bangalore"
          },
          {
            "doctorId": "2",
            "doctorName": "Dr. Priya Nair",
            "qualification": "MBBS, DNB (General Medicine)",
            "speciality": "General Physician / Internal Medicine",
            "experience": "15 YEARS Experience",
            "regularFee": "₹750",
            "discountFee": "₹550",
            "rating": "4.7",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
            "availiability" : "today",
            "gender" : "FeMale",
            "language" : "Hindi",
            "city" : "Hosur"
          },
          {
            "doctorId": "3",
            "doctorName": "Dr. Sameer Khan",
            "qualification": "MBBS, MD (Internal Medicine)",
            "speciality": "General Physician / Internal Medicine",
            "experience": "20 YEARS Experience",
            "regularFee": "₹900",
            "discountFee": "₹700",
            "rating": "4.9",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
            "availiability" : "now",
            "gender" : "FeMale",
            "language" : "Hindi",
            "city" : "Delhi"
          },
          {
            "doctorId": "4",
            "doctorName": "Dr. Neha Sharma",
            "qualification": "MBBS, Diploma in Family Medicine",
            "speciality": "General Physician / Internal Medicine",
            "experience": "12 YEARS Experience",
            "regularFee": "₹700",
            "discountFee": "₹500",
            "rating": "4.6",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
            "availiability" : "tomorrow",
            "gender" : "FeMale",
            "language" : "Hindi",
            "city" : "Delhi"
          },
          {
            "doctorId": "5",
            "doctorName": "Dr. Rajesh Patel",
            "qualification": "MBBS, MD (General Medicine)",
            "speciality": "General Physician / Internal Medicine",
            "experience": "20 YEARS Experience",
            "regularFee": "₹850",
            "discountFee": "₹650",
            "rating": "4.5",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
            "availiability" : "next",
            "gender" : "FeMale",
            "language" : "Hindi",
            "city" : "Delhi"
          },
          {
            "doctorId": "6",
            "doctorName": "Dr. Anjali Verma",
            "qualification": "MBBS, DNB (General Medicine)",
            "speciality": "General Physician / Internal Medicine",
            "experience": "17 YEARS Experience",
            "regularFee": "₹800",
            "discountFee": "₹600",
            "rating": "4.9",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
          },
          {
            "doctorId": "7",
            "doctorName": "Dr. Harish Reddy",
            "qualification": "MBBS, Diploma in Family Medicine",
            "speciality": "General Physician / Internal Medicine",
            "experience": "20 YEARS Experience",
            "regularFee": "₹950",
            "discountFee": "₹750",
            "rating": "4.8",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
          },
          {
            "doctorId": "8",
            "doctorName": "Dr. Meenakshi Rao",
            "qualification": "MBBS, MD (Internal Medicine)",
            "speciality": "General Physician / Internal Medicine",
            "experience": "19 YEARS Experience",
            "regularFee": "₹880",
            "discountFee": "₹700",
            "rating": "4.7",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
          },
          {
            "doctorId": "9",
            "doctorName": "Dr. Aditya Deshmukh",
            "qualification": "MBBS, Diploma in Family Medicine",
            "speciality": "General Physician / Internal Medicine",
            "experience": "14 YEARS Experience",
            "regularFee": "₹720",
            "discountFee": "₹520",
            "rating": "4.6",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
          },
          {
            "doctorId": "10",
            "doctorName": "Dr. Kavita Singh",
            "qualification": "MBBS, MD (General Medicine)",
            "speciality": "General Physician / Internal Medicine",
            "experience": "21 YEARS Experience",
            "regularFee": "₹950",
            "discountFee": "₹750",
            "rating": "5.0",
            "workLocation": "2 QuadraCyte, Qatar 560002 2 Km . From Your Location",
            "photo": null,
          },
        ];

        progressDialog.show();

// simulate delay (ya API ke jagah ye static data)
        Future.delayed(Duration(milliseconds: 1000), () {
          final DoctorsListB staticResponse = DoctorsListB(
            status: 200,
            message: null,
            response: staticDoctorList.map((e) => DoctorsListResponse.fromJson(e)).toList(),
          );

          var newres = staticResponse;

          if (newres.message != null) {
            progressDialog.hide();
            final snackBar = SnackBar(content: Text(newres.message!));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (newres.response != null && newres.response!.isNotEmpty) {
            setState(() {
              responselist = newres.response!;
              filterresponselist = responselist;
            });

            progressDialog.hide(); // <-- ab hide reliably ho jayega
            print(responselist.toString());
          } else {
            progressDialog.hide();
            final snackBar = SnackBar(content: Text("Details Not Found"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });





      } else {

        final snackBar = SnackBar(
          content: Text("No Internet, Check Connectivity!"),
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

  }

  void _search(String query) {

    setState(() {
      if (query.isEmpty || query.length < 3) {

          filterresponselist = responselist;


      } else {
        final pattern = RegExp(RegExp.escape(query), caseSensitive: false);

          filterresponselist = responselist.where((item) {
            final name = item.doctorName ?? '';
            final uhid = item.speciality ?? '';
            return pattern.hasMatch(name) || pattern.hasMatch(uhid) ;
          }).toList();



        }



    });
  }



}
