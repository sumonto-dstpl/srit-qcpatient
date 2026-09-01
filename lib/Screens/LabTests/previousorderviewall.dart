import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Core/Data/dummy_data.dart';
import 'package:newfolder/Core/no-data_found.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/LabTests/bottomsheet.dart';
import 'package:newfolder/Screens/LabTests/labsmartreportslist.dart';
import 'package:newfolder/Screens/LabTests/labviewreportslist.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class PreviousOrderViewAll extends StatefulWidget {
  int selectedIndex = 0;
  PreviousOrderViewAll({
    super.key,
  });
  @override
  State<PreviousOrderViewAll> createState() => PreviousOrderViewAllstate();
}

class PreviousOrderViewAllstate extends State<PreviousOrderViewAll> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> healthCheckupList = [];
  List<Map<String, dynamic>> filterHealthCheckupList = [];
  bool showNoDataFound = false;


  @override
  void initState(){

    super.initState();

    _loadData();


  }

  void _loadData() async {
    setState(() {
       healthCheckupList = DummyData.healthCheckupList;

      if(healthCheckupList.isNotEmpty){
        filterHealthCheckupList = healthCheckupList ;
        showNoDataFound = false;
      }
      else {
        filterHealthCheckupList = [] ;
        showNoDataFound = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
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
              Header(userName: 'Full Body Checkup'),

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
                            .height * 0.0,
                        right: MediaQuery
                            .of(context)
                            .size
                            .height * 0.0,
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .height * 0.0),
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
  Container(

                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          left: screenWidth * 0.0,
                          right: screenWidth * 0.01,
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

                            SizedBox(
                                width: screenHeight *
                                    0.005), // Add spacing between widgets
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

                                      style: TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) => input!.length < 3
                                          ? "Search should be more than 3 characters"
                                          : null,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(
                                          top :   screenHeight * 0.012,
                                          left :   screenHeight * 0.02,
                                          right :   screenHeight * 0.012,
                                          bottom :   screenHeight * 0.012,
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFF7F5F6),
                                        hintText: "Search by tests & packages",
                                        hintStyle: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: screenHeight * 0.014,
                                            fontWeight: FontWeight.w400
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          borderSide:
                                          BorderSide(color: Color(0xFFF7F5F6)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                        ),
                                        suffixIcon: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min, // Ensures the Row only takes as much space as needed
                                            children: [
                                              // Search Icon
                                              Icon(
                                                Icons.search,
                                                color: Colors.black45,
                                                size: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.025,
                                              ),
                                              // Divider
                                              Container(
                                                width: 1, // Width of the divider
                                                height: 20, // Height of the divider
                                                color: Colors.grey, // Color of the divider
                                                margin: EdgeInsets.symmetric(horizontal: 8), // Spacing around the divider
                                              ),
                                              // Icon from Assets
                                              InkWell(
                                                onTap: () {

                                                  showBottomSheet();


                                                },
                                                child: Image.asset(
                                                  'assets/scansearch.png', // Replace with your actual asset path
                                                  height: 15, // Height of the asset icon
                                                  width: 15,  // Width of the asset icon
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
                      ),
                      ]
                  ),
              ),
                 Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.00),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,

                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // Search Input Field
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
                                MediaQuery.of(context).size.height * 0.01,
                                top: MediaQuery.of(context).size.height * 0.00),
                            // height: MediaQuery.of(context).size.height * 0.190,
                            child:
                            showNoDataFound
                                ?   NoDataFound() // Aapka custom widget
                                :

                            ListView.builder(
                               padding: EdgeInsets.zero, // ✅ Remove extra top space
                              physics: ScrollPhysics(), // Ensures scrolling
                              shrinkWrap: true, // Prevents ListView from taking up extra space
                              scrollDirection: Axis.vertical, // Makes the ListView horizontal
                              itemCount: filterHealthCheckupList.length, // You can adjust the item count
                              itemBuilder: (BuildContext context, int index) {
                                final item = filterHealthCheckupList[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Add your onTap logic here
                                  },
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child:  Container(
                                      width:MediaQuery.of(context).size.height * 0.410,
                                      padding:EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height * 0.00,
                                          right: MediaQuery.of(context).size.height * 0.00,
                                          bottom: MediaQuery.of(context).size.height * 0.00,
                                          top: MediaQuery.of(context).size.height * 0.00),
                                      color: Colors.white,
                                      child:
                                      Container(
                                        // color: Colors.white,

                                        decoration: BoxDecoration(
                                          color: Colors
                                              .white, // Background color of the container
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
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Rounded corners
                                        ),
                                        margin:EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.00,
                                            right: MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                            top: MediaQuery.of(context).size.height * 0.00),
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.005,
                                            right: MediaQuery.of(context).size.height * 0.005,
                                            bottom: MediaQuery.of(context).size.height * 0.005,
                                            top: MediaQuery.of(context).size.height * 0.005),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              Container(

                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                    top: MediaQuery.of(context).size.height * 0.01,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),

                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      height : MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.055,
                                                      margin: EdgeInsets.only(
                                                        left:
                                                        MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.005,
                                                      ),

                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(130.0),
                                                        child: Image.asset(
                                                          'assets/Harmonebackground.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.height *
                                                            0.015),

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
                                                                top: MediaQuery.of(context).size.height * 0.0,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              // "QCT Full Body Checkup Female ",
                                                              "${item['name']}",
                                                              style: TextStyle(
                                                                  color: Colors.black87,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.014),
                                                            ),
                                                          ),
                                                          SizedBox(height : screenHeight * 0.005)  ,

                                                          Container(

                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "Booking ID : ${item['bookingId']}",
                                                              style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012),
                                                            ),
                                                          ),
                                                          SizedBox(height : screenHeight * 0.005)  ,

                                                          Container(

                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "Report Received Date : ${item['reportReceiveDate']}",
                                                              style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w600,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012),
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
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    // ✅ LEFT SIDE — “More Details”
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => MyReportsMain(initialTabIndex: 1),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.005,
                                                              ),
                                                              child: Stack(
                                                                alignment: Alignment.bottomLeft,
                                                                children: [
                                                                  Text(
                                                                    "More Details",
                                                                    style: TextStyle(
                                                                      color: Color(0xFF12B76A),
                                                                      fontWeight: FontWeight.w500,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontSize: MediaQuery.of(context).size.height * 0.01,
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom: 0,
                                                                    left: 0,
                                                                    right: 0,
                                                                    child: Container(
                                                                      height: 1,
                                                                      color: Color(0xFF12B76A),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),


                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                builder: (BuildContext context) {
                                                                  return LabSmartReports();
                                                                },
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: MediaQuery.of(context).size.height * 0.015,
                                                              vertical: MediaQuery.of(context).size.height * 0.007,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFF126086),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            margin: EdgeInsets.only(
                                                              right: MediaQuery.of(context).size.height * 0.01,
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              "Smart Report",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: MediaQuery.of(context).size.height * 0.01,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => MyReportsMain(initialTabIndex: 1),
                                                              ),
                                                            );
                                                          },
                                                          // onTap: () async {
                                                          //   Navigator.of(context).push(
                                                          //     MaterialPageRoute(
                                                          //       builder: (BuildContext context) {
                                                          //         return LabViewReports();
                                                          //       },
                                                          //     ),
                                                          //   );
                                                          // },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: MediaQuery.of(context).size.height * 0.015,
                                                              vertical: MediaQuery.of(context).size.height * 0.007,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFF126086),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              "View Reports",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: MediaQuery.of(context).size.height * 0.01,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              )









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



                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                    ],
                  ),
                ),
              ),

               ],
                    ),
                  ),
              )

              // Main Content Section

            ],
          ),
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardVisible ? null : CustomFloatingActionButton(),

      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }


  Map<String, List<String>> activeFilters = {
    "mustHavetests":  [],
    "category":  [],

  };
  void showBottomSheet() async {

    final result = await showModalBottomSheet(
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
                child: AddFilterForFullBodyCheckup(
                  initialFilters: activeFilters,
                ),
              ),
            ),
          ],
        );
      },
    );

    print("result : $result");

    if(result != null) {
      activeFilters = result as Map<String, List<String>>;
      _applyActiveFilters();
    }
    else {
      setState(() {
        filterHealthCheckupList = healthCheckupList ;
        activeFilters = {
          "mustHavetests": [],
          "category": [],
        };
        showNoDataFound = false;
      });

    }
  }

  void _applyActiveFilters({String searchQuery = ""}) {
    List<Map<String, dynamic>> tmp = healthCheckupList.where((item) {

      if (searchQuery.isNotEmpty) {
        final plan = (item['name'] ?? '').toString().toLowerCase();
        final test = (item['bookingId'] ?? '').toString().toLowerCase();
        final searchLower = searchQuery.toLowerCase();

        // Agar plan ya test ke naam me search text nahi milta, toh false return karo
        if (!plan.contains(searchLower) && !test.contains(searchLower)) {
          return false;
        }
      }

      // 2. Category / Speciality Filter
      final selCategoryList = List<String>.from(activeFilters['category'] ?? []);
      if (selCategoryList.isNotEmpty) {
        final itemCategory = item['category'] ?? '';
        if (!selCategoryList.contains(itemCategory)) return false;
      }

      // 3. Language Filter
      final selLanguageList = List<String>.from(activeFilters['mustHavetests'] ?? []);
      if (selLanguageList.isNotEmpty) {
        final itemLanguage = item['mustHavetests'] ?? '';
        if (!selLanguageList.contains(itemLanguage)) return false;
      }





      return true;
    }).toList();
    setState(() {
      filterHealthCheckupList = tmp;
      showNoDataFound = tmp.isEmpty;

    });


  }
}
