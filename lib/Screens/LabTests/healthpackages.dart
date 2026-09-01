import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Core/TextField/textfiled_search_filter.dart';
import 'package:newfolder/Core/no-data_found.dart';
import 'package:newfolder/Data/Models/findspecialitiesres.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';

import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/LabTests/recomendtestviewall.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';

import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class HealthPackagesViewall extends StatefulWidget {
  const HealthPackagesViewall({
    super.key,
  });
  @override
  State<HealthPackagesViewall> createState() =>
      HealthCondiViewallstate();
}

class HealthCondiViewallstate
    extends State<HealthPackagesViewall> {
  ConnectivityService connectivityservice = ConnectivityService();
  APIService apiService = new APIService();
  late ProgressDialog progressDialog;
  int _selectedIndex = 0;
  List<SpecialityResponse>? responselist = [];

  String usernameValue = "Find health packages";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  final mybrowsebyhealthcond = [
    ["assets/Harmone.png", "Full Body Checkup"],
    ["assets/Diabetes.png", "Men’s Wellness"],
    ["assets/JointPain.png", "Women’s Health"],
    ["assets/Thyroid.png", "Thyroid Package"],
    ["assets/Heart.png", "Heart Package"],
    ["assets/Bone.png", "Diabetes package"],
    ["assets/BloodSugar.png", "Blood Studies Package"],
    ["assets/Vitamin.png", "Vitamin package"],
    ["assets/HairFall.png", "Hairfall package"],
    ["assets/Liver.png", "Liver Package"],
    ["assets/Kidney.png", "Kidney Package"],
    ["assets/Fever.png", "Fever Package"],
  ];


  List<List<String>> filteredHealthConditions = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // getSharedPrefs();
    super.initState();

    filteredHealthConditions = List.from(mybrowsebyhealthcond);
  }

  void searchHealthCondition(String query) {
    final searchText = query.trim().toLowerCase();

    setState(() {
      if (searchText.isEmpty) {
        filteredHealthConditions = List.from(mybrowsebyhealthcond);
      } else {
        filteredHealthConditions = mybrowsebyhealthcond.where((item) {
          final healthCondition = item[1].toLowerCase();

          return healthCondition.contains(searchText);
        }).toList();

        print("filteredHealthConditions lenght : ${filteredHealthConditions.length}");
      }
    });
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
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.02,
                            right: MediaQuery.of(context).size.height * 0.02,
                            bottom: MediaQuery.of(context).size.height * 0.016),
                        child: CustomTextField(
                          hintText: "Search by Health Packages",
                          controller: searchController,
                          showFilterIcon: false,
                          onSearchTap: (){
                            searchHealthCondition(searchController.text.toString());
                          },

                          onChanged: (val) {
                            searchHealthCondition(val);
                          },
                        ),
                      ),

                      // Browse by health packages
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.height * 0.01,
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.02,
                                    right: MediaQuery.of(context).size.height *
                                        0.02,
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Top health packages",
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
                      filteredHealthConditions.length == 0
                          ? NoDataFound()
                      : Container(
                        color: Colors.white,
                        child: GridView.count(
                          shrinkWrap:
                          true, // GridView takes only as much space as needed
                          physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.02,
                            right: MediaQuery.of(context).size.height * 0.02,
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

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return RecommendedViewAll(
                                            usernameValue: "Health Package",
                                            mode: 'health_package',
                                              categoryName: mybrowsebyhealthcond[index][1]

                                          );
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

  /*void CheckSession() {
    connectivityservice.checkconnectivity().then((intenet) async {
      final prefusertypevalue = await UserSecureStorage.getUserType() ?? 'NA';
      progressDialog = ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: true,
          showLogs: false);
      progressDialog.style(
          message: 'Loading Data..' '\nPlease Wait',
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
      if (intenet != null && intenet) {
        progressDialog.show();
        var user = await apiService.GetDashboardDetailsnew();
        final preNRStatuscodeval =
            await UserSecureStorage.getNRStatuscodeval() ?? 'NA';

        if (preNRStatuscodeval == "401") {
          var user = await apiService.refreshtoken();
          final preNRStatuscodevalforrefresh =
              await UserSecureStorage.getNRStatuscodeval() ?? 'NA';

          if (preNRStatuscodevalforrefresh == "200") {
            CheckSession();
          } else if (preNRStatuscodevalforrefresh == "401") {
            progressDialog.hide();
            customalert.showError(context);
          } else if (preNRStatuscodevalforrefresh == "400") {
            progressDialog.hide();
            customalert.showError(context);
          }
        } else {
          getPendingRecordList();
        }
      } else {
        final snackBar =
            SnackBar(content: Text("No Internet, Check Connectivity!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }*/






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
