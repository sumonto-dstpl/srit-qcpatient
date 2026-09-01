import 'dart:async';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Core/Data/dummy_data.dart';
import 'package:newfolder/Core/TextField/textfiled_search_filter.dart';
import 'package:newfolder/Core/no-data_found.dart';

import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Data/Models/doctorslistres.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';

import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:progress_dialog2/progress_dialog2.dart';
import 'package:newfolder/Core/Header/header.dart';

import 'package:newfolder/Core/Filter/filter_model.dart';
import 'package:newfolder/Core/Filter/filter_screen.dart';
class FindDoctorsListMain extends StatefulWidget {
  final String? physical_virtual_mode;
  final String? consulttype;

  final String category    ;
  FindDoctorsListMain(
      this.consulttype,
      {
        Key? key,
        this.physical_virtual_mode = "physical",
        this.category = 'all',

      }) : super(key: key);


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


  final myimageslist = [
    ["assets/appointmentimg1.png"],
    ["assets/appointmentimg2.png"],
    ["assets/appointmentimg3.png"],
    ["assets/appointmentimg5.png"],
  ];




  // Tracks the selected category
  int selectedCategoryIndex = 0;

  bool showNoDataFound = false;


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

                  Header(userName: usernameValue),
                  Expanded(

                  child: Container(
                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(screenHeight * 0.03),
                                        topRight: Radius.circular(screenHeight * 0.03),

                                      ),
                                    ),
                    child : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: screenHeight * 0.02,
                          right: screenHeight * 0.02,
                          top: screenHeight * 0.015,
                          bottom: screenHeight * 0.015,
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
                            // fillColor: Colors.grey[200],
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

                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [

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
                                child:
                                showNoDataFound
                                    ?   NoDataFound() // Aapka custom widget
                                    :
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: ScrollPhysics(), // Ensures scrolling
                                  shrinkWrap:
                                  true, // Prevents ListView from taking up extra space
                                  scrollDirection: Axis.vertical, // Makes the ListView horizontal
                                  itemCount: filterresponselist!.length!, // You can adjust the item count
                                  itemBuilder: (BuildContext context, int index) {

                                    final item = filterresponselist[index] ;
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
                                                                          item.name != null ?  item.name! : "" ,

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
                                                                  item.speciality != null ?  "${item.speciality!} " : "" ,

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
                                                      (item.experience ?? "") + " - "+   (item.qualification ??  ""),
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
                                                  // Container(
                                                  //
                                                  //   child: Row(
                                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                                  //     mainAxisAlignment: MainAxisAlignment.start,
                                                  //     children: <Widget>[
                                                  //
                                                  //       // Image
                                                  //       Container(
                                                  //         margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.0),
                                                  //         padding: EdgeInsets.all(0),
                                                  //         width: MediaQuery.of(context).size.height * 0.2,
                                                  //         height: MediaQuery.of(context).size.height * 0.06,
                                                  //         decoration: BoxDecoration(
                                                  //           borderRadius: BorderRadius.circular(16),
                                                  //           color: Colors.white,
                                                  //         ),
                                                  //         child: Stack(
                                                  //           children: [
                                                  //             // Row for displaying images from myimageslist
                                                  //             Positioned.fill(
                                                  //               child:
                                                  //
                                                  //                  Container(
                                                  //         padding: EdgeInsets.only(
                                                  //         left: MediaQuery
                                                  //             .of(context)
                                                  //             .size
                                                  //             .height *
                                                  //             0.015,
                                                  //           top: MediaQuery
                                                  //               .of(context)
                                                  //               .size
                                                  //               .height *
                                                  //               0.01, ),
                                                  //       child:
                                                  //
                                                  //       SizedBox(
                                                  //         height: MediaQuery.of(context).size.height * 0.05,
                                                  //         child: Stack(
                                                  //           children: myimageslist.asMap().entries.map((entry) {
                                                  //             int index = entry.key;
                                                  //             String imagePath = entry.value[0];
                                                  //
                                                  //             double imageSize = MediaQuery.of(context).size.height * 0.045;
                                                  //
                                                  //             return Positioned(
                                                  //               left: index * (imageSize * 0.9), // Slight overlap but visible borders
                                                  //               child: Container(
                                                  //                 decoration: BoxDecoration(
                                                  //                   borderRadius: BorderRadius.circular(8),
                                                  //                   boxShadow: [
                                                  //                     BoxShadow(
                                                  //                       color: Colors.black.withOpacity(0.25), // subtle shadow
                                                  //                       blurRadius: 6, // soft spread
                                                  //                       spreadRadius: -1, // keeps shadow inside outer area
                                                  //                       offset: Offset(2, 2), // direction of shadow
                                                  //                     ),
                                                  //                   ],
                                                  //                 ),
                                                  //                 child: ClipRRect(
                                                  //                   borderRadius: BorderRadius.circular(8),
                                                  //                   child: Image.asset(
                                                  //                     imagePath,
                                                  //                     width: imageSize,
                                                  //                     height: imageSize,
                                                  //                     fit: BoxFit.cover,
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             );
                                                  //           }).toList(),
                                                  //         ),
                                                  //       ),
                                                  //
                                                  //
                                                  //         ),
                                                  //
                                                  //
                                                  //
                                                  //
                                                  //
                                                  //
                                                  //             ),
                                                  //             // "+3" text at the right edge
                                                  //             Positioned(
                                                  //               right: 0, // Adjusted to ensure +3 is fully visible
                                                  //               top: 0,
                                                  //               bottom: 0,
                                                  //               child: Align(
                                                  //                 alignment: Alignment.centerRight,
                                                  //                 child: Container(
                                                  //                   decoration: BoxDecoration(
                                                  //                     color: Colors.white,
                                                  //                     borderRadius: BorderRadius.circular(12),
                                                  //                   ),
                                                  //                   padding: EdgeInsets.symmetric(
                                                  //                     horizontal: MediaQuery.of(context).size.height * 0.008,
                                                  //                     vertical: MediaQuery.of(context).size.height * 0.005,
                                                  //                   ),
                                                  //                   child: Text(
                                                  //                     "+3",
                                                  //                     style: TextStyle(
                                                  //                       color: Color(0xFF126086),
                                                  //                       fontWeight: FontWeight.w600,
                                                  //                       fontSize: MediaQuery.of(context).size.height * 0.012, // Slightly increased for better visibility
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //
                                                  //       // Address
                                                  //       Expanded(
                                                  //         flex: 7,
                                                  //         child: Column(
                                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                                  //           mainAxisAlignment: MainAxisAlignment.center,
                                                  //           children: <Widget>[
                                                  //             Container(
                                                  //
                                                  //               child: Text(
                                                  //                 maxLines: 1,
                                                  //
                                                  //                 "2 QuadraCyte, Qatar 560002",
                                                  //                 style: TextStyle(
                                                  //                   color: Colors.black54,
                                                  //                   overflow: TextOverflow.ellipsis,
                                                  //                   fontWeight: FontWeight.bold,
                                                  //                   fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //
                                                  //             Container(
                                                  //
                                                  //               child: Text(
                                                  //                 maxLines: 1,
                                                  //
                                                  //                 "2 Km . From Your Location",
                                                  //                 style: TextStyle(
                                                  //                   color: Color(0xFF7F7F7F),
                                                  //                   overflow: TextOverflow.ellipsis,
                                                  //                   fontWeight: FontWeight.w500,
                                                  //                   fontSize: MediaQuery.of(context).size.height * 0.012,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //
                                                  //       // Share icon
                                                  //       CircleAvatar(
                                                  //         backgroundColor: Colors.blue.shade50,
                                                  //           radius: 10,
                                                  //         child: Image.asset(
                                                  //           height: 10,
                                                  //           width: 10,
                                                  //           "assets/send.png",
                                                  //           fit: BoxFit.fill,
                                                  //         ),
                                                  //       ),
                                                  //
                                                  //        SizedBox(width : screenWidth * 0.015)
                                                  //
                                                  //
                                                  //     ],
                                                  //   ),
                                                  // ),

                                                  // Bottom Row

                                                  Padding(
                                                    // Equal left aur right padding set ki gayi hai
                                                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        // Image Stack Group
                                                        Container(
                                                          width: MediaQuery.of(context).size.height * 0.15, // Size reduced (pehle 0.17 tha)
                                                          height: MediaQuery.of(context).size.height * 0.055, // Size reduced (pehle 0.06 tha)
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(16),
                                                            color: Colors.white,
                                                          ),
                                                          child: Stack(
                                                            clipBehavior: Clip.none,
                                                            alignment: Alignment.centerLeft,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.012),
                                                                child: SizedBox(
                                                                  height: MediaQuery.of(context).size.height * 0.04,
                                                                  child: Stack(
                                                                    children: myimageslist.asMap().entries.map((entry) {
                                                                      int index = entry.key;
                                                                      String imagePath = entry.value[0];
                                                                      // Image size slightly reduced
                                                                      double imageSize = MediaQuery.of(context).size.height * 0.038;

                                                                      return Positioned(
                                                                        left: index * (imageSize * 0.85),
                                                                        child: Container(
                                                                          height: imageSize,
                                                                          width: imageSize,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(8),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.black.withOpacity(0.2), // Shadow optimized
                                                                                blurRadius: 4,
                                                                                offset: const Offset(2, 2),
                                                                              ),
                                                                            ],
                                                                            // ClipRRect ki jagah DecorationImage use kiya jo jyada optimized hai
                                                                            image: DecorationImage(
                                                                              image: AssetImage(imagePath),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ),
                                                              ),
                                                              // "+3" Badge
                                                              Positioned(
                                                                right: -10,

                                                                child: Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),



                                                                    child: Text(
                                                                      "+3",
                                                                      style: TextStyle(
                                                                        color: const Color(0xFF126086),
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: MediaQuery.of(context).size.height * 0.011, // Font reduced
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        const SizedBox(width: 15),

                                                        // Address Area
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "2 QuadraCyte, Qatar 560002",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  color: Colors.black54,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.011, // Font reduced
                                                                ),
                                                              ),
                                                              const SizedBox(height: 2),
                                                              Text(
                                                                "2 Km. From Your Location",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                  color: const Color(0xFF7F7F7F),
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: MediaQuery.of(context).size.height * 0.011, // Font reduced
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        const SizedBox(width: 8),

                                                        // Share Icon
                                                        if(item.isCallAvailable == true)
                                                        CircleAvatar(
                                                          backgroundColor: Colors.blue.shade50,
                                                          radius: 12, // Radius reduced (pehle 10 tha)
                                                          child: Image.asset(
                                                            "assets/send.png",
                                                            height: 12,
                                                            width: 12,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
                                                                                            '${item.regularFee}',
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
                                                                                        Text( "${item.discountFee}",
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
                                                                            padding: EdgeInsets.zero,
                                                                            child:

                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: <Widget>[
                                                                                if(item.isCallAvailable == true) ...[
                                                                                  GestureDetector(
                                                                                  onTap: () {},
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
                                                                                    child: Text("Call",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                                                                  ),
                                                                                ),
                                                                                  const SizedBox(width : 10),],

                                                                                GestureDetector(
                                                                                  onTap: () async {

                                                                                    print("Tap on Doctor Card");
                                                                                    Navigator.of(context).push(
                                                                                      MaterialPageRoute(
                                                                                        builder:
                                                                                            (BuildContext context) {

                                                                                           return SelectTimeSlot(
                                                                                             "Practitioner/f002",
                                                                                             doctorDetail: {
                                                                                               'doctorId' : item.doctorId,
                                                                                               "name" : item.name ,
                                                                                                     "speciality" : item.speciality ,
                                                                                                     "experience" : (item.experience ?? "") + " - "+   (item.qualification ??  ""),
                                                                                               'category' : item.category,

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
                                                                                    child: Text(  item.isCallAvailable == true ? "Book" :  "Consult",
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
                                ) ,
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

  Map<String, List<String>> activeFilters = {
    "experienceYears":  [],
    "feeRange":  [],
    "availability":  [],
    "area":  [],
    "gender":  [],
    "language":  [],
    "city":  [],
  };

  final List<String> experienceYearsOptions = ['0-5 years', '6-10 years', '11-16 years', '17-21 years'];
  final List<String> feeRangeOptions = ['QR 100-500', 'QR 500-1000', 'QR 1000-5000'];
  final List<String> availabilityOptions = ['Now', 'Today', 'Tomorrow', 'Next 3 Days'];
  final List<String> areaOptions = ['Adult Allergist', 'Allergy and Immunology', 'Asthma Specialist', 'Bariatrics Dietitan', 'Bariatrics Medicine'];
  final List<String> genderOptions = ['Male', 'Female', ];
  final List<String> languageOptions = ['English', 'Tamil', 'Kannada', 'Hindi', 'Telugu', 'Urdu', ];
  final List<String> cityOptions = ['Bangalore', 'Hosur', 'Chennai', 'Mumbai', 'Agra'];

  void showBottomSheet() async {


    List<FilterCategory> categoriesToPass = [
      FilterCategory(
        key: 'experienceYears', // यह key आपकी activeFilters map से मेल खानी चाहिए
        title: 'Experience', // यह BottomSheet के Category Panel पर दिखेगा
        options: experienceYearsOptions,
        initialSelectedOptions: activeFilters['experienceYears'],
        hasSearchBar: false,
      ),
      FilterCategory(
        key: 'feeRange', // यह key आपकी activeFilters map से मेल खानी चाहिए
        title: 'Fees', // यह BottomSheet के Category Panel पर दिखेगा
        options: feeRangeOptions,
        initialSelectedOptions: activeFilters['feeRange'],
        hasSearchBar: false,
      ),
      FilterCategory(
        key: 'availability', // यह key आपकी activeFilters map से मेल खानी चाहिए
        title: 'Availability', // यह BottomSheet के Category Panel पर दिखेगा
        options: availabilityOptions,
        initialSelectedOptions: activeFilters['availability'],
        hasSearchBar: false,
      ),
      FilterCategory(
        key: 'area', // यह key आपकी activeFilters map से मेल खानी चाहिए
        title: 'Area of Expertise', // यह BottomSheet के Category Panel पर दिखेगा
        options: areaOptions,
        initialSelectedOptions: activeFilters['area'],
        hasSearchBar: true,
      ),
      FilterCategory(
        key: 'gender', // यह key आपकी activeFilters map से मेल खानी चाहिए
        title: 'Gender', // यह BottomSheet के Category Panel पर दिखेगा
        options: genderOptions,
        initialSelectedOptions: activeFilters['gender'],
        hasSearchBar: false,
      ),
      FilterCategory(
        key: 'language', // यह key आपकी activeFilters map से मेल खानी चाहिए
        title: 'Language', // यह BottomSheet के Category Panel पर दिखेगा
        options: languageOptions,
        initialSelectedOptions: activeFilters['language'],
        hasSearchBar: false,
      ),
      FilterCategory(
        key: 'city', // यह key आपकी activeFilters map से मेल खानी चाहिए
        title: 'City', // यह BottomSheet के Category Panel पर दिखेगा
        options: cityOptions,
        initialSelectedOptions: activeFilters['city'],
        hasSearchBar: false,
      ),

    ];

    final result = await FilterScreen.show(
        context,
        categories: categoriesToPass,
        initialChildSize: 0.45,
        left_right_size: MediaQuery.of(context).size.height * 0.29
    );

     print("selected Filter Result : $result");

     if(result != null) {
       activeFilters = result as Map<String, List<String>>;
       _applyActiveFilters();
     }
     else {
       setState(() {
         filterresponselist = responselist ;
           activeFilters = {
           "experienceYears":  [],
           "feeRange":  [],
           "availability":  [],
           "area":  [],
           "gender":  [],
           "language":  [],
           "city":  [],
         };
         showNoDataFound = false;
       });

     }

  }

  void _applyActiveFilters({String searchQuery = ""}) {
     List<DoctorsListResponse> tmp = responselist.where((DoctorsListResponse item) {

        // 1. Gender Filter
        final selGenderList = List<String>.from(activeFilters['gender'] ?? []);
        if (selGenderList.isNotEmpty) {
          // Model properties ko dot (.) laga kar access karte hain
          final itemGender = item.gender ?? '';
          if (!selGenderList.contains(itemGender)) return false;
        }

        // 2. Category / Speciality Filter
        final selCategoryList = List<String>.from(activeFilters['category'] ?? []);
        if (selCategoryList.isNotEmpty) {
          final itemCategory = item.category ?? '';
          if (!selCategoryList.contains(itemCategory)) return false;
        }

        // 3. Language Filter
        final selLanguageList = List<String>.from(activeFilters['language'] ?? []);
        if (selLanguageList.isNotEmpty) {
          final itemLanguage = item.language ?? '';
          if (!selLanguageList.contains(itemLanguage)) return false;
        }

        // 4. City / Location Filter
        final selCityList = List<String>.from(activeFilters['city'] ?? []);
        if (selCityList.isNotEmpty) {
          final itemCity = item.city ?? '';
          if (!selCityList.contains(itemCity)) return false;
        }

        // 5. Experience Range Filter
        final selExperienceList = List<String>.from(activeFilters['experienceYears'] ?? []);
        if (selExperienceList.isNotEmpty) {
          final itemExperience = item.experienceYears ?? '';
          if (!selExperienceList.contains(itemExperience)) return false;
        }

        // 6. Fee Range Filter
        final selFeeRangeList = List<String>.from(activeFilters['feeRange'] ?? []);
        if (selFeeRangeList.isNotEmpty) {
          final itemFeeRange = item.feeRange ?? '';
          if (!selFeeRangeList.contains(itemFeeRange)) return false;
        }

        // 7. Availability Filter
        final selAvailabilityList = List<String>.from(activeFilters['availability'] ?? []);
        if (selAvailabilityList.isNotEmpty) {
          final itemAvailability = item.availability ?? '';
          if (!selAvailabilityList.contains(itemAvailability)) return false;
        }

        // 8. Search Query Filter (Search by Name)
        if (searchQuery.isNotEmpty) {
          final itemName = (item.name ?? '').toLowerCase();
          if (!itemName.contains(searchQuery.toLowerCase())) return false;
        }

        return true;
      }).toList();
      setState(() {
        filterresponselist = tmp;
        showNoDataFound = tmp.isEmpty;
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




      print('widget.category : ${widget.category}');
      final List<Map<String, dynamic>> staticDoctorList = DummyData.getAppointmentsDoctorsByCategory(category: widget.category);
      print("staticDoctor List : ${staticDoctorList.length}");
      print("staticDoctor : ${staticDoctorList}");
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
              showNoDataFound = false;
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
      // Show all if query empty
      if (query.trim().isEmpty) {
        filterresponselist = responselist;
        return;
      }

      final lowerQuery = query.toLowerCase().trim();

      // Helper to split a field into words (splits on spaces and common punctuation)
      List<String> _words(String? s) {
        if (s == null || s.isEmpty) return [];
        // split on whitespace, dots, commas, slashes, hyphens, parentheses etc.
        return s
            .toLowerCase()
            .split(RegExp(r'[\s\.,\/\-\(\)]+'))
            .where((w) => w.isNotEmpty)
            .toList();
      }

      filterresponselist = responselist.where((item) {
        // Collect the fields you want to search across
        final fields = <String?>[
          item.name,
          item.qualification,
          item.speciality,
          item.experience,
          item.regularFee,
          item.discountFee,
          item.rating,
          item.workLocation,
          item.photo?.toString(),
          item.availiability, // note: your data used "availiability"
          item.gender,
          item.language,
          item.city,
        ];

        // For each field, split into words and see if any word starts with query
        for (final f in fields) {
          for (final w in _words(f)) {
            if (w.startsWith(lowerQuery)) return true;
          }
        }

        return false;
      }).toList();
      showNoDataFound = filterresponselist.isEmpty;
    });
  }





}
