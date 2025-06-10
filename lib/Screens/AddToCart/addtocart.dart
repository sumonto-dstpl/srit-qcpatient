import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/bottomsheet_for_payment.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Widgets/dotteddivider.dart';

class AddToCartMain extends StatefulWidget {
  int selectedIndex = 4;

  AddToCartMain({
    super.key,
  });

  @override
  State<AddToCartMain> createState() => AddToCartMainstate();
}

class AddToCartMainstate extends State<AddToCartMain> {
  String usernameValue = "My Health";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 4;

  final List<Map<String, dynamic>> carttoplist = [
    {"images": "assets/Harmonebackground.png", "uploadfilestime": "QR 999",
    "cartname": "QCT Superior Health Plan", "teststotal": "50"},

    {"images": "assets/Harmonebackground.png", "uploadfilestime": "QR 99",
    "cartname": "QCT Diabetic Health Plan", "teststotal": "100"},

    {"images": "assets/Harmonebackground.png", "uploadfilestime": "QR 1009",
    "cartname": "QCT Master Health Check Package", "teststotal": "200"},
  
  ];

  final List<Map<String, dynamic>> savedbottomlist = [
    {"images": "assets/Harmonebackground.png", "uploadfilestime": "QR 999",
    "cartname": "QCT Master Health Check Package", "teststotal": "100"},

    {"images": "assets/Harmonebackground.png", "uploadfilestime": "QR 1999",
    "cartname": "QCT Diabetic Health Plan", "teststotal": "100"},

    {"images": "assets/Harmonebackground.png", "uploadfilestime": "QR 1999",
    "cartname": "QCT Master Health Check Package", "teststotal": "200"},
  
  ];

  // final List<String> uploadfilestime = [
  //   "QR 999",
  //   "QR 99",
  //   "QR 1009",
  // ];
  // final List<String> imagestoplist = [
  //   "assets/Harmonebackground.png",
  //   "assets/Harmonebackground.png",
  //   "assets/Harmonebackground.png",
  // ];
  // final List<String> cartnametoplist = [
  //   "QCT Superior Health Plan",
  //   "QCT Diabetic Health Plan",
  //   "QCT Master Health Check Package",
  // ];
  // final List<int> teststotaltoplist = [
  //   50,
  //   100,
  //   200,
  // ];

  // final List<String> endtextbottomlist = [
  //   "QR 1999",
  //   "QR 1999",
  //   "QR 999",
  // ];
  // final List<String> imagesbottomlist = [
  //   "assets/Harmonebackground.png",
  //   "assets/Harmonebackground.png",
  //   "assets/Harmonebackground.png",
  // ];
  // final List<String> cartnameottomlist = [
  //   "QCT Master Health Check Package",
  //   "QCT Diabetic Health Plan",
  //   "QCT Master Health Check Package",
  // ];
  // final List<int> teststotalbottomlist = [
  //   50,
  //   100,
  //   200,
  // ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();

  //Asgar
  bool isSavedForLater = true;
  int saveForLaterCount = 0;

  //sumonto
  int cartPrice = 0;
  int disPrice = 99;
  int platformPrice = 9;
  // for(int counter=0; counter>=carttoplist.length; counter++){
  //   int cartValue = cartnametoplist[counter]['uploadfilestime'].split(' ')[1];
  //   print(cartValue);
  //   // cartPrice+=carttoplist[counter]
  // }

  @override
  Widget build(BuildContext context) {
    print('build');
    saveForLaterCount = savedbottomlist.length;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

      cartPrice = 0;
      for(int counter=0; counter<carttoplist.length; counter++){
        int cartValue = int.parse(carttoplist[counter]['uploadfilestime'].split(' ')[1]);
        print(cartValue);
        cartPrice+=cartValue;
      }

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
                  children: [],
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
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.03),
                    topRight: Radius.circular(screenHeight * 0.03),
                  ),
                ),
                child: Column(children: [
                  // Inkwell & Cart Text
                  Container(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.0,
                      left: screenWidth * 0.0,
                      right: screenWidth * 0.0,
                      bottom: screenWidth * 0.01,
                    ),
                    margin: EdgeInsets.only(
                      right: screenHeight * 0.0,
                      top: screenHeight * 0.01,
                      bottom: screenHeight * 0.01,
                      left: screenHeight * 0.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.01,
                            ),
                            height: screenHeight * 0.035,
                            width: screenHeight * 0.035,
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F5F6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Color(0xFF999999),
                              size: screenHeight * 0.018,
                            ),
                          ),
                        ),

                        // Help Text (Centered)
                        Expanded(
                          child: Center(
                            child: Text(
                              "Cart",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        // Placeholder to Balance Row (Keeps Help Text Centered)
                        SizedBox(width: screenHeight * 0.035),
                      ],
                    ),
                  ),
                ]),
              ),
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
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(screenHeight * 0.03),
                    //   topRight: Radius.circular(screenHeight * 0.03),
                    // ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // Top ListView

                      // Top 3 Cards
                      Container(
                        margin: EdgeInsets.only(
                          right: screenHeight * 0.015,
                          top: screenHeight * 0.0,
                          bottom: screenHeight * 0.0,
                          left: screenHeight * 0.015,
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height *
                              0.005, // Dynamic top padding
                          bottom: MediaQuery.of(context).size.height *
                              0.0, // Dynamic bottom padding
                          left: MediaQuery.of(context).size.height *
                              0.0, // Dynamic left padding
                          right: MediaQuery.of(context).size.height *
                              0.0, // Dynamic right padding
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true, // Prevents infinite height
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: carttoplist.length,
                          itemBuilder: (context, index) {
                            final file = carttoplist[index]['cartname'];

                            return Dismissible(
                                key: UniqueKey(), // Unique key for each item
                                direction: DismissDirection
                                    .horizontal, // Allow both left & right swipes
                                background: Container(
                                  color: Colors.white,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/addtofoldersaveicon.png", // Path to your local image
                                        width: 24, // Adjust width
                                        height: 24, // Adjust height
                                        color:
                                            Colors.green, // Apply white color
                                        colorBlendMode: BlendMode
                                            .srcIn, // Blend mode to colorize
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Saved",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.white,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Delete",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 10),
                                      Icon(Icons.delete, color: Colors.red),
                                    ],
                                  ),
                                ),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    setState((){
                                      print('if');
                                    print('index : $index');
                                    // uploadfilestime.removeAt(index);
                                    carttoplist.removeAt(index);
                                     ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("$file deleted"), duration: Duration(seconds: 2)),
                                    );
                                    });    
                                    
                                  } else if (direction ==
                                      DismissDirection.startToEnd) {
                                        print('index : $index');
                                    print("DismissDirection.startToEnd");
                                    if (index >= carttoplist.length) {
                                      print("index >= carttoplist.length");
                                      print(
                                          'lenght : ${carttoplist.length}');
                                      savedbottomlist
                                          .add(carttoplist.last);
                                      print(
                                          'lenght : ${savedbottomlist.length}');
                                      carttoplist.removeLast();
                                      setState(() {});
                                      return;
                                    }
                                    print('else if');
                                    setState(() {
                                      // Swiped Left to Right (Move to another list)
                                      // if (endtextbottomlist.length > 0)
                                      savedbottomlist.insert(
                                          0, carttoplist[index]);
                                      // else {
                                      //   endtextbottomlist
                                      //       .add(uploadfilestime[index]);
                                      // }

                                      carttoplist.removeAt(index);
                                      print(
                                          'lenght : ${savedbottomlist.length}');
                                    });
                                    // Mark item as "Saved" when swiped left to right
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "$file Saved",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        backgroundColor: Colors
                                            .green, // Set background color to green
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Background color of the container
                                        border: Border.all(
                                          color: Colors.black
                                              .withOpacity(0.1), // Border color
                                          width: 1, // Border width
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8), // Optional: Rounded corners
                                      ),

                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.00,
                                          right:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.00,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      // color: Colors.white,
                                      child: Container(
                                        // color: Colors.white,

                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                stops: [
                                                  0.5,
                                                  0.9
                                                ],
                                                colors: [
                                                  Color(0xFFffffff),
                                                  Color(0xFFffffff)
                                                ])),
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.00,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.00,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.00,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.00),
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.015,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.015,
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.005,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
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
                                                          carttoplist[index]['images'],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02),
                                                  Expanded(
                                                    flex: 6,
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
                                                              EdgeInsets.only(
                                                            left: MediaQuery.of(
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
                                                                0.0,
                                                            bottom: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.00,
                                                          ),
                                                          child: Text(
                                                            carttoplist[
                                                                index]['cartname'],
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.014,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: screenHeight *
                                                              0.005,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: MediaQuery.of(
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
                                                                0.00,
                                                          ),
                                                          child: Text(
                                                            carttoplist[index]['teststotal'] + " tests included",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black54,
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
                                                                  0.012,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Adding the side arrow at the end

                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        // color:Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      // color:Colors.green[100],
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.0,
                                                          right:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.0,
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
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          2),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.005,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.005,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF12B76A),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.00,
                                                                bottom: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.00,
                                                                left: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.002,
                                                                right: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.00,
                                                              ),
                                                              child: Text(
                                                                carttoplist[index]['uploadfilestime'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.014,
                                                                  color: Color(
                                                                      0xFF12B76A),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ),
                                                          ]),
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
                                ));
                          },
                        ),
                      ),

                      // Price Details
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.02,
                            right: MediaQuery.of(context).size.height * 0.0,
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Price Details",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.016,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),

                      // down card
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0,
                          bottom: MediaQuery.of(context).size.height * 0.0,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            // color: Color(0xFF126086).withOpacity(0.1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // color: Color(0xFFA8B1CE).withOpacity(0.1),
                                    color: Color(0xFFF8F8F8),
                                    borderRadius: BorderRadius.circular(
                                        8), // Optional: Rounded corners
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
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
                                                0.005,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00),
                                                child: Text(
                                                  "Price ("+carttoplist.length.toString()+" Package)",
                                                  style: TextStyle(
                                                    color: Color(0x80000000),
                                                    fontWeight: FontWeight.w400,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00),
                                                  child: Text(
                                                    'QR '+cartPrice.toString(),
                                                    style: TextStyle(
                                                        // color: Colors.blue[600],
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        // decoration: TextDecoration.lineThrough,
                                                        // decorationThickness: 2,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014),
                                                  )),
                                            ]),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
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
                                                0.005,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00),
                                                child: Text(
                                                  "Discount",
                                                  style: TextStyle(
                                                    color: Color(0x80000000),
                                                    fontWeight: FontWeight.w400,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00),
                                                  child: Text(
                                                    '- QR '+(carttoplist.length<=0?0:disPrice).toString(),
                                                    style: TextStyle(
                                                        // color: Colors.blue[600],
                                                        color:
                                                            Color(0xFF12B76A),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        // decoration: TextDecoration.lineThrough,
                                                        // decorationThickness: 2,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014),
                                                  )),
                                            ]),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
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
                                                0.005,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00),
                                                child: Text(
                                                  "Platform Fee",
                                                  style: TextStyle(
                                                    color: Color(0x80000000),
                                                    fontWeight: FontWeight.w400,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00),
                                                  child: Text(
                                                    'QR '+(carttoplist.length<=0?0:platformPrice).toString(),
                                                    style: TextStyle(
                                                        // color: Colors.blue[600],
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        // decoration: TextDecoration.lineThrough,
                                                        // decorationThickness: 2,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014),
                                                  )),
                                            ]),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
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
                                                0.01),
                                        child: DottedDivider(
                                          color: Color(0x4D000000),
                                          strokeWidth: 0.5,
                                          gap: 5.0,
                                          height:
                                              0.0, // Specify the height of the divider
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
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
                                                0.005,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.00,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00),
                                                child: Text(
                                                  'Total Amount',
                                                  style: TextStyle(
                                                      // color: Colors.blue[600],
                                                      color: Color(0xFF000000),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.014),
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.00),
                                                  child: Text(
                                                    'QR '+(carttoplist.length<=0?0:(cartPrice-disPrice+platformPrice)).toString(),
                                                    style: TextStyle(
                                                        // color: Colors.blue[600],
                                                        color:
                                                            Color(0xFF000000),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        // decoration: TextDecoration.lineThrough,
                                                        // decorationThickness: 2,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014),
                                                  )),
                                            ]),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),

                      isSavedForLater == false
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                              ), // Removed margin
                              padding: EdgeInsets.all(0), // Removed padding
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Ensures alignment starts from the left
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        height: screenHeight * 0.02,
                                        width: screenHeight * 0.02,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/addcartFolder.png',
                                          height: screenHeight * 0.015,
                                          width: screenHeight * 0.015,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 15,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.008,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Saved For Later ",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.014,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              "($saveForLaterCount)",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.014,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      // Bottom ListView
                      isSavedForLater == false
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(
                                right: screenHeight * 0.015,
                                left: screenHeight * 0.015,
                              ),
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    0.0, // Dynamic top padding
                                bottom: MediaQuery.of(context).size.height *
                                    0.0, // Dynamic bottom padding
                                left: MediaQuery.of(context).size.height *
                                    0.0, // Dynamic left padding
                                right: MediaQuery.of(context).size.height *
                                    0.0, // Dynamic right padding
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true, // Prevents infinite height
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: savedbottomlist.length,
                                itemBuilder: (context, index) {
                                  final file = savedbottomlist[index]['cartname'];

                                  return Dismissible(
                                      key:
                                          UniqueKey(), // Unique key for each item
                                      direction: DismissDirection
                                          .endToStart, // Allow swipe from right to left
                                      background: Container(
                                        color: Colors.white,
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      onDismissed: (direction) {
                                        // Remove the item immediately from the list
                                        // endtextbottomlist.removeAt(index);

                                        setState(() {
                                          savedbottomlist.removeAt(index);
                                        });
                                        // If the list is empty, show a message
                                        if (savedbottomlist.isEmpty) {
                                          print('savedbottomlist.isEmpty');

                                          isSavedForLater = false;
                                        }
                                        /* setState(() {

                                    });*/

                                        // Show a snackbar for feedback
                                        /* ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text("$file deleted"),
                                                                  duration: Duration(seconds: 2),
                                                                ),
                                                              );*/
                                      },
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Card(
                                          elevation: 0.0,
                                          color: Colors.white,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .white, // Background color of the container
                                              border: Border.all(
                                                color: Colors.black.withOpacity(
                                                    0.1), // Border color
                                                width: 1, // Border width
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                  8), // Optional: Rounded corners
                                            ),

                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
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
                                                        Color(0xFFffffff),
                                                        Color(0xFFffffff)
                                                      ])),
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00),
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
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
                                                              child:
                                                                  Image.asset(
                                                                savedbottomlist[index]['images'],
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02),
                                                        Expanded(
                                                          flex: 6,
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
                                                                  left: MediaQuery.of(
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
                                                                      0.0,
                                                                  bottom: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.00,
                                                                ),
                                                                child: Text(
                                                                  savedbottomlist[index]['cartname'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.014,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenHeight *
                                                                        0.005,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: MediaQuery.of(
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
                                                                      0.00,
                                                                ),
                                                                child: Text(
                                                                  savedbottomlist[index]['teststotal'] + " Tests Included",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.012,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Adding the side arrow at the end

                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              // color:Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            // color:Colors.green[100],
                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(
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
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <Widget>[
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                            horizontal:
                                                                                2),
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.005,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.005,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF12B76A),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      top: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.00,
                                                                      bottom: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.00,
                                                                      left: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.002,
                                                                      right: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.00,
                                                                    ),
                                                                    child: Text(
                                                                      savedbottomlist[
                                                                          index]['uploadfilestime'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.height *
                                                                                0.014,
                                                                        color: Color(
                                                                            0xFF12B76A),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                    ),
                                                                  ),
                                                                ]),
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
                                      ));
                                },
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

      // Bottom Navigation with another  positioned on the right
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, -2), // Makes the shadow appear above
              blurRadius: 6,
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Book Appointment
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                    bottom: MediaQuery.of(context).size.height * 0.00,
                    left: MediaQuery.of(context).size.height * 0.00,
                    right: MediaQuery.of(context).size.height * 0.00),
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.04,
                    top: MediaQuery.of(context).size.height * 0.01,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.04),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.012),
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.center,
                                  stops: [
                                    0.5,
                                    0.9
                                  ],
                                  colors: [
                                    Color(0xFF126086),
                                    Color(0xFF126086),
                                  ])),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 0.0),
                          child: TextButton(
                            onPressed: () async {
                              showPaymentmethodsBottomSheet();
                            },
                            child: Text("Next",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                  fontWeight: FontWeight.w600,
                                )),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 9.5,
                                  horizontal: 12.0), // ← Adjust this
                              minimumSize: Size(
                                  0, 0), // Removes minimum button constraints
                              tapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // Removes extra tap padding
                            ),
                          ),
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      int selected = index;

      if (selected == 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePageMain()),
            (Route<dynamic> route) => false);
      } else if (selected == 1) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyReportsMain();
            },
          ),
        );
      } else if (selected == 2) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return UploadPrescriptionMain();
            },
          ),
        );
      } else if (selected == 3) {
        showBottomSheet();
      } else if (selected == 4) {
        /*  Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyHealthMain();
            },
          ),
        );*/
      }

      /* widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;*/

      // Fluttertoast.showToast(msg: "test", toastLength: Toast.LENGTH_LONG);
      print(selected);
    });
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
                              bottom: MediaQuery.of(context).size.height * 0.03,
                              left: MediaQuery.of(context).size.height * 0.18,
                              right: MediaQuery.of(context).size.height * 0.18,
                            ),
                            child: Divider(
                              height: 0,
                              indent: 0,
                              thickness:
                                  MediaQuery.of(context).size.height * 0.008,
                              color: Color(0xFF95C8D6).withOpacity(0.3),
                            ),
                          ),

                          // Select the Type of Appointment
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.0,
                                right:
                                    MediaQuery.of(context).size.height * 0.02,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.00),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.00),
                                    child: Text(
                                      "Select the Type of Appointment",
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
                                  left: MediaQuery.of(context).size.height *
                                      0.005,
                                  right: MediaQuery.of(context).size.height *
                                      0.025,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.005,
                                  top: MediaQuery.of(context).size.height *
                                      0.015),
                              decoration: BoxDecoration(
                                color: Color(0xFFA8B1CE).withOpacity(0.1),
                                // Background color of the container
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
                                  left:
                                      MediaQuery.of(context).size.height * 0.00,
                                  right:
                                      MediaQuery.of(context).size.height * 0.00,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.0,
                                  top: MediaQuery.of(context).size.height *
                                      0.00),
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
                                    left: MediaQuery.of(context).size.height *
                                        0.005,
                                    right: MediaQuery.of(context).size.height *
                                        0.005,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                    top: MediaQuery.of(context).size.height *
                                        0.005),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                    0.025,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.025,
                                                child: Image.asset(
                                                  'assets/AppointmentBs.png',
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
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.0,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                  ),
                                                  child: Text(
                                                    "Appointments",
                                                    style: TextStyle(
                                                      color: Color(0xFF126086),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                                            Icons.arrow_forward_ios,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            // Dynamic icon size
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
                                  left: MediaQuery.of(context).size.height *
                                      0.005,
                                  right: MediaQuery.of(context).size.height *
                                      0.025,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.005,
                                  top: MediaQuery.of(context).size.height *
                                      0.015),
                              decoration: BoxDecoration(
                                color: Color(0xFFA8B1CE).withOpacity(0.1),
                                // Background color of the container
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
                                  left:
                                      MediaQuery.of(context).size.height * 0.00,
                                  right:
                                      MediaQuery.of(context).size.height * 0.00,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.0,
                                  top: MediaQuery.of(context).size.height *
                                      0.00),
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
                                    left: MediaQuery.of(context).size.height *
                                        0.005,
                                    right: MediaQuery.of(context).size.height *
                                        0.005,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                    top: MediaQuery.of(context).size.height *
                                        0.005),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                    0.025,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.025,
                                                child: Image.asset(
                                                  'assets/TestServicesBs.png',
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
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.0,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.00,
                                                  ),
                                                  child: Text(
                                                    "Test & Services",
                                                    style: TextStyle(
                                                      color: Color(0xFF126086),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                                            Icons.arrow_forward_ios,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            // Dynamic icon size
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
                ),
              ],
            ),
          ),
        ),
      );

  // Payment methods
  // void showPaymentmethodsBottomSheet() => showModalBottomSheet(
  //   enableDrag: false,
  //   isScrollControlled: true,
  //   isDismissible: true,
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(24),
  //       topRight: Radius.circular(24),
  //     ),
  //   ),
  //   barrierColor: Colors.grey.withOpacity(0.9),
  //   context: context,
  //   builder: (context) => StatefulBuilder(
  //     builder: (BuildContext context,
  //         StateSetter setState /*You can rename this!*/) =>
  //         Padding(
  //           padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Container(
  //                 padding: EdgeInsets.only(
  //                     left: MediaQuery.of(context).size.height * 0.020,
  //                     right: MediaQuery.of(context).size.height * 0.020,
  //                     top: MediaQuery.of(context).size.height * 0.030,
  //                     bottom: MediaQuery.of(context).size.height * 0.00),
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: <Widget>[
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: <Widget>[
  //                           Text(
  //                             "Payment Methods",
  //                             style: TextStyle(
  //                                 color: Colors.black,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: MediaQuery.of(context).size.height *
  //                                     0.024),
  //                           ),
  //                           Container(
  //                             padding: EdgeInsets.only(
  //                               top: MediaQuery.of(context).size.height * 0.00,
  //                               bottom:
  //                               MediaQuery.of(context).size.height * 0.02,
  //                               left: MediaQuery.of(context).size.height * 0.00,
  //                               right:
  //                               MediaQuery.of(context).size.height * 0.00,
  //                             ),
  //                             child: Text(
  //                               "Please Select a payment method",
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                   color: Colors.black54,
  //                                   fontSize:
  //                                   MediaQuery.of(context).size.height *
  //                                       0.018),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //
  //                     // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
  //                   ],
  //                 ),
  //               ),
  //
  //               // Payment mode
  //               // 1
  //               Container(
  //                 margin: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.00,
  //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //                   left: MediaQuery.of(context).size.height * 0.01,
  //                   right: MediaQuery.of(context).size.height * 0.01,
  //                 ),
  //                 padding: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.00,
  //                   bottom: MediaQuery.of(context).size.height * 0.00,
  //                   left: MediaQuery.of(context).size.height * 0.01,
  //                   right: MediaQuery.of(context).size.height * 0.00,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                     color: Colors.grey,
  //                     width: 1.0,
  //                   ),
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     // Image from assets
  //                     Container(
  //                       width: MediaQuery.of(context).size.height * 0.07,
  //                       height: MediaQuery.of(context).size.height * 0.07,
  //                       margin: EdgeInsets.only(
  //                         top: MediaQuery.of(context).size.height * 0.01,
  //                         bottom: MediaQuery.of(context).size.height * 0.01,
  //                         left: MediaQuery.of(context).size.height * 0.01,
  //                         right: MediaQuery.of(context).size.height * 0.01,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(4.0),
  //                         image: DecorationImage(
  //                           image: AssetImage(
  //                               'assets/visapay.png'), // Replace with your asset path
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                     // Column with two Text widgets
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             '**** **** 3434',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.018,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                           Text(
  //                             'Visa',
  //                             style: TextStyle(
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.016,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     // Circular Radio Button
  //                     Radio<int>(
  //                       value: 1, // The value for this radio button
  //                       groupValue: 0, // The currently selected value
  //                       onChanged: (int? value) {
  //                         // Handle radio button change
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //               // 2
  //               Container(
  //                 margin: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.00,
  //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //                   left: MediaQuery.of(context).size.height * 0.01,
  //                   right: MediaQuery.of(context).size.height * 0.01,
  //                 ),
  //                 padding: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.00,
  //                   bottom: MediaQuery.of(context).size.height * 0.00,
  //                   left: MediaQuery.of(context).size.height * 0.01,
  //                   right: MediaQuery.of(context).size.height * 0.00,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                     color: Colors.grey,
  //                     width: 1.0,
  //                   ),
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     // Image from assets
  //                     Container(
  //                       width: MediaQuery.of(context).size.height * 0.07,
  //                       height: MediaQuery.of(context).size.height * 0.07,
  //                       margin: EdgeInsets.only(
  //                         top: MediaQuery.of(context).size.height * 0.01,
  //                         bottom: MediaQuery.of(context).size.height * 0.01,
  //                         left: MediaQuery.of(context).size.height * 0.01,
  //                         right: MediaQuery.of(context).size.height * 0.01,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(4.0),
  //                         image: DecorationImage(
  //                           image: AssetImage(
  //                               'assets/paypalpay.png'), // Replace with your asset path
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                     // Column with two Text widgets
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             '**** **** 3434',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.018,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                           Text(
  //                             'Paypal',
  //                             style: TextStyle(
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.016,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     // Circular Radio Button
  //                     Radio<int>(
  //                       value: 1, // The value for this radio button
  //                       groupValue: 0, // The currently selected value
  //                       onChanged: (int? value) {
  //                         // Handle radio button change
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //               // 3
  //               Container(
  //                 margin: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.00,
  //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //                   left: MediaQuery.of(context).size.height * 0.01,
  //                   right: MediaQuery.of(context).size.height * 0.01,
  //                 ),
  //                 padding: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.00,
  //                   bottom: MediaQuery.of(context).size.height * 0.00,
  //                   left: MediaQuery.of(context).size.height * 0.01,
  //                   right: MediaQuery.of(context).size.height * 0.00,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                     color: Colors.grey,
  //                     width: 1.0,
  //                   ),
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     // Image from assets
  //                     Container(
  //                       width: MediaQuery.of(context).size.height * 0.07,
  //                       height: MediaQuery.of(context).size.height * 0.07,
  //                       margin: EdgeInsets.only(
  //                         top: MediaQuery.of(context).size.height * 0.01,
  //                         bottom: MediaQuery.of(context).size.height * 0.01,
  //                         left: MediaQuery.of(context).size.height * 0.01,
  //                         right: MediaQuery.of(context).size.height * 0.01,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(4.0),
  //                         image: DecorationImage(
  //                           image: AssetImage(
  //                               'assets/applepay.png'), // Replace with your asset path
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                     // Column with two Text widgets
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             'Priya Krishamurty',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.018,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                           Text(
  //                             'Apple Pay',
  //                             style: TextStyle(
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.016,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     // Circular Radio Button
  //                     Radio<int>(
  //                       value: 1, // The value for this radio button
  //                       groupValue: 0, // The currently selected value
  //                       onChanged: (int? value) {
  //                         // Handle radio button change
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //               // 4
  //               Container(
  //                 margin: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.00,
  //                   bottom: MediaQuery.of(context).size.height * 0.00,
  //                   left: MediaQuery.of(context).size.height * 0.01,
  //                   right: MediaQuery.of(context).size.height * 0.01,
  //                 ),
  //                 padding: EdgeInsets.only(
  //                   top: MediaQuery.of(context).size.height * 0.00,
  //                   bottom: MediaQuery.of(context).size.height * 0.00,
  //                   left: MediaQuery.of(context).size.height * 0.01,
  //                   right: MediaQuery.of(context).size.height * 0.00,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                     color: Colors.grey,
  //                     width: 1.0,
  //                   ),
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     // Image from assets
  //                     Container(
  //                       width: MediaQuery.of(context).size.height * 0.07,
  //                       height: MediaQuery.of(context).size.height * 0.07,
  //                       margin: EdgeInsets.only(
  //                         top: MediaQuery.of(context).size.height * 0.01,
  //                         bottom: MediaQuery.of(context).size.height * 0.01,
  //                         left: MediaQuery.of(context).size.height * 0.01,
  //                         right: MediaQuery.of(context).size.height * 0.01,
  //                       ),
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(4.0),
  //                         image: DecorationImage(
  //                           image: AssetImage(
  //                               'assets/googlepay.png'), // Replace with your asset path
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                     // Column with two Text widgets
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             'Priya Krishamurty',
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.018,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                           Text(
  //                             'Google Pay',
  //                             style: TextStyle(
  //                               fontSize:
  //                               MediaQuery.of(context).size.height * 0.016,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     // Circular Radio Button
  //                     Radio<int>(
  //                       value: 1, // The value for this radio button
  //                       groupValue: 0, // The currently selected value
  //                       onChanged: (int? value) {
  //                         // Handle radio button change
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //               // Continue
  //               GestureDetector(
  //                 onTap: () async {
  //                   showsucessalertBottomSheet();
  //                 },
  //                 child: Container(
  //                     alignment: Alignment.centerRight,
  //                     padding: EdgeInsets.only(
  //                         top: MediaQuery.of(context).size.height * 0.01,
  //                         bottom: MediaQuery.of(context).size.height * 0.00,
  //                         left: MediaQuery.of(context).size.height * 0.00,
  //                         right: MediaQuery.of(context).size.height * 0.00),
  //                     margin: EdgeInsets.only(
  //                         right: MediaQuery.of(context).size.height * 0.03,
  //                         top: MediaQuery.of(context).size.height * 0.01,
  //                         bottom: MediaQuery.of(context).size.height * 0.01,
  //                         left: MediaQuery.of(context).size.height * 0.03),
  //                     child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: <Widget>[
  //                           Expanded(
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(
  //                                       MediaQuery.of(context).size.height *
  //                                           0.012),
  //                                   gradient: LinearGradient(
  //                                       begin: Alignment.centerRight,
  //                                       end: Alignment.center,
  //                                       stops: [
  //                                         0.5,
  //                                         0.9
  //                                       ],
  //                                       colors: [
  //                                         Color(0xFF126086),
  //                                         Color(0xFF126086),
  //                                       ])),
  //                               alignment: Alignment.center,
  //                               padding: EdgeInsets.only(left: 0.0),
  //                               child: TextButton(
  //                                 onPressed: () async {
  //                                   showsucessalertBottomSheet();
  //                                 },
  //                                 child: Text("Continue",
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         color: Colors.white,
  //                                         fontSize: MediaQuery.of(context)
  //                                             .size
  //                                             .height *
  //                                             0.02)),
  //                               ),
  //                             ),
  //                           ),
  //                         ])),
  //               ),
  //             ],
  //           ),
  //         ),
  //   ),
  // );

  // Success alert bottomsheet

  void showPaymentmethodsBottomSheet() => showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    transitionAnimationController: AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: Navigator.of(context),
    ),
    builder: (BuildContext context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1,
                    spreadRadius: 0.5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.020,
                                  right: MediaQuery.of(context).size.height * 0.020,
                                  top: MediaQuery.of(context).size.height * 0.030,
                                  bottom: MediaQuery.of(context).size.height * 0.00),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Payment Methods",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context).size.height *
                                                  0.024),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context).size.height * 0.00,
                                            bottom:
                                            MediaQuery.of(context).size.height * 0.02,
                                            left: MediaQuery.of(context).size.height * 0.00,
                                            right:
                                            MediaQuery.of(context).size.height * 0.00,
                                          ),
                                          child: Text(
                                            "Please Select a payment method",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize:
                                                MediaQuery.of(context).size.height *
                                                    0.018),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
                                ],
                              ),
                            ),

                            // Payment mode
                            // 1
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.01,
                              ),
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.00,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image from assets
                                  Container(
                                    width: MediaQuery.of(context).size.height * 0.07,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.01,
                                      bottom: MediaQuery.of(context).size.height * 0.01,
                                      left: MediaQuery.of(context).size.height * 0.01,
                                      right: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/visapay.png'), // Replace with your asset path
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Column with two Text widgets
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '**** **** 3434',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.018,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Visa',
                                          style: TextStyle(
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.016,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Circular Radio Button
                                  Radio<int>(
                                    value: 1, // The value for this radio button
                                    groupValue: 0, // The currently selected value
                                    onChanged: (int? value) {
                                      // Handle radio button change
                                    },
                                  ),
                                ],
                              ),
                            ),

                            // 2
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.01,
                              ),
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.00,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image from assets
                                  Container(
                                    width: MediaQuery.of(context).size.height * 0.07,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.01,
                                      bottom: MediaQuery.of(context).size.height * 0.01,
                                      left: MediaQuery.of(context).size.height * 0.01,
                                      right: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/paypalpay.png'), // Replace with your asset path
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Column with two Text widgets
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '**** **** 3434',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.018,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Paypal',
                                          style: TextStyle(
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.016,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Circular Radio Button
                                  Radio<int>(
                                    value: 1, // The value for this radio button
                                    groupValue: 0, // The currently selected value
                                    onChanged: (int? value) {
                                      // Handle radio button change
                                    },
                                  ),
                                ],
                              ),
                            ),

                            // 3
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.01,
                              ),
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.00,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image from assets
                                  Container(
                                    width: MediaQuery.of(context).size.height * 0.07,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.01,
                                      bottom: MediaQuery.of(context).size.height * 0.01,
                                      left: MediaQuery.of(context).size.height * 0.01,
                                      right: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/applepay.png'), // Replace with your asset path
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Column with two Text widgets
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Priya Krishamurty',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.018,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Apple Pay',
                                          style: TextStyle(
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.016,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Circular Radio Button
                                  Radio<int>(
                                    value: 1, // The value for this radio button
                                    groupValue: 0, // The currently selected value
                                    onChanged: (int? value) {
                                      // Handle radio button change
                                    },
                                  ),
                                ],
                              ),
                            ),

                            // 4
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.01,
                              ),
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom: MediaQuery.of(context).size.height * 0.00,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.00,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image from assets
                                  Container(
                                    width: MediaQuery.of(context).size.height * 0.07,
                                    height: MediaQuery.of(context).size.height * 0.07,
                                    margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.01,
                                      bottom: MediaQuery.of(context).size.height * 0.01,
                                      left: MediaQuery.of(context).size.height * 0.01,
                                      right: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/googlepay.png'), // Replace with your asset path
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Column with two Text widgets
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Priya Krishamurty',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.018,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Google Pay',
                                          style: TextStyle(
                                            fontSize:
                                            MediaQuery.of(context).size.height * 0.016,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Circular Radio Button
                                  Radio<int>(
                                    value: 1, // The value for this radio button
                                    groupValue: 0, // The currently selected value
                                    onChanged: (int? value) {
                                      // Handle radio button change
                                    },
                                  ),
                                ],
                              ),
                            ),

                            // Continue
                            GestureDetector(
                              onTap: () async {
                                showsucessalertBottomSheet();
                              },
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.01,
                                      bottom: MediaQuery.of(context).size.height * 0.00,
                                      left: MediaQuery.of(context).size.height * 0.00,
                                      right: MediaQuery.of(context).size.height * 0.00),
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.height * 0.03,
                                      top: MediaQuery.of(context).size.height * 0.01,
                                      bottom: MediaQuery.of(context).size.height * 0.01,
                                      left: MediaQuery.of(context).size.height * 0.03),
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    MediaQuery.of(context).size.height *
                                                        0.012),
                                                gradient: LinearGradient(
                                                    begin: Alignment.centerRight,
                                                    end: Alignment.center,
                                                    stops: [
                                                      0.5,
                                                      0.9
                                                    ],
                                                    colors: [
                                                      Color(0xFF126086),
                                                      Color(0xFF126086),
                                                    ])),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: TextButton(
                                              onPressed: () async {
                                                showsucessalertBottomSheet();
                                              },
                                              child: Text("Continue",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.02)),
                                            ),
                                          ),
                                        ),
                                      ])),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      );
    },
  );

  // void showPaymentmethodsBottomSheet() => showModalBottomSheet(
  //     enableDrag: false,
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(24),
  //         topRight: Radius.circular(24),
  //       ),
  //     ),
  //     barrierColor: Colors.grey.withOpacity(0.9),
  //     context: context,
  //     builder: (context) {
  //       return BottomSheetForPayment();
  //     }
  //
  //     //     StatefulBuilder(
  //     //   builder: (BuildContext context,
  //     //           StateSetter setState /*You can rename this!*/) =>
  //     //       Padding(
  //     //     padding: EdgeInsets.only(
  //     //         bottom: MediaQuery.of(context).viewInsets.bottom),
  //     //     child: Column(
  //     //       mainAxisSize: MainAxisSize.min,
  //     //       children: <Widget>[
  //     //         GestureDetector(
  //     //
  //     //
  //     //           child: Center(
  //     //             child: Container(
  //     //
  //     //               padding: EdgeInsets.only(
  //     //                 top: MediaQuery
  //     //                     .of(context)
  //     //                     .size
  //     //                     .height * 0.01 ,
  //     //                 bottom: MediaQuery
  //     //                     .of(context)
  //     //                     .size
  //     //                     .height * 0.03,
  //     //                 left: MediaQuery
  //     //                     .of(context)
  //     //                     .size
  //     //                     .height * 0.18,
  //     //                 right: MediaQuery
  //     //                     .of(context)
  //     //                     .size
  //     //                     .height * 0.18,
  //     //               ),
  //     //
  //     //
  //     //               width: MediaQuery
  //     //                   .of(context)
  //     //                   .size
  //     //                   .width * 0.23,
  //     //               // Same thickness as Divider
  //     //               height: MediaQuery
  //     //                   .of(context)
  //     //                   .size
  //     //                   .height * 0.006,
  //     //               // Same thickness as Divider
  //     //               decoration: BoxDecoration(
  //     //                 color: Color(0xFFD9D9D9), // Divider color
  //     //                 borderRadius: BorderRadius.circular(
  //     //                     10), // Rounded edges
  //     //               ),
  //     //             ),
  //     //           ),
  //     //         ),
  //     //         SizedBox(height : MediaQuery.of(context).size.height * 0.02),
  //     //
  //     //         Container(
  //     //           padding: EdgeInsets.only(
  //     //               left: MediaQuery.of(context).size.height * 0.020,
  //     //               right: MediaQuery.of(context).size.height * 0.020,
  //     //               top: MediaQuery.of(context).size.height * 0.030,
  //     //               bottom: MediaQuery.of(context).size.height * 0.00),
  //     //           child: Row(
  //     //             crossAxisAlignment: CrossAxisAlignment.center,
  //     //             mainAxisAlignment: MainAxisAlignment.start,
  //     //             children: <Widget>[
  //     //               Expanded(
  //     //                 child: Column(
  //     //                   crossAxisAlignment: CrossAxisAlignment.start,
  //     //                   mainAxisAlignment: MainAxisAlignment.center,
  //     //                   children: <Widget>[
  //     //                     Text(
  //     //                       "Payment Methods",
  //     //                       style: TextStyle(
  //     //                           color: Colors.black,
  //     //                           fontWeight: FontWeight.bold,
  //     //                           fontSize: MediaQuery.of(context).size.height *
  //     //                               0.024),
  //     //                     ),
  //     //                     Container(
  //     //                       padding: EdgeInsets.only(
  //     //                         top: MediaQuery.of(context).size.height * 0.00,
  //     //                         bottom:
  //     //                             MediaQuery.of(context).size.height * 0.02,
  //     //                         left: MediaQuery.of(context).size.height * 0.00,
  //     //                         right:
  //     //                             MediaQuery.of(context).size.height * 0.00,
  //     //                       ),
  //     //                       child: Text(
  //     //                         "Please Select a payment method",
  //     //                         textAlign: TextAlign.center,
  //     //                         style: TextStyle(
  //     //                             color: Colors.black54,
  //     //                             fontSize:
  //     //                                 MediaQuery.of(context).size.height *
  //     //                                     0.018),
  //     //                       ),
  //     //                     ),
  //     //                   ],
  //     //                 ),
  //     //               ),
  //     //
  //     //               // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
  //     //             ],
  //     //           ),
  //     //         ),
  //     //
  //     //         // Payment mode
  //     //         // 1
  //     //         Container(
  //     //           margin: EdgeInsets.only(
  //     //             top: MediaQuery.of(context).size.height * 0.00,
  //     //             bottom: MediaQuery.of(context).size.height * 0.01,
  //     //             left: MediaQuery.of(context).size.height * 0.01,
  //     //             right: MediaQuery.of(context).size.height * 0.01,
  //     //           ),
  //     //           padding: EdgeInsets.only(
  //     //             top: MediaQuery.of(context).size.height * 0.00,
  //     //             bottom: MediaQuery.of(context).size.height * 0.00,
  //     //             left: MediaQuery.of(context).size.height * 0.01,
  //     //             right: MediaQuery.of(context).size.height * 0.00,
  //     //           ),
  //     //           decoration: BoxDecoration(
  //     //             border: Border.all(
  //     //               color: Colors.grey,
  //     //               width: 1.0,
  //     //             ),
  //     //             borderRadius: BorderRadius.circular(8.0),
  //     //           ),
  //     //           child: Row(
  //     //             mainAxisAlignment: MainAxisAlignment.start,
  //     //             crossAxisAlignment: CrossAxisAlignment.center,
  //     //             children: [
  //     //               // Image from assets
  //     //               Container(
  //     //                 width: MediaQuery.of(context).size.height * 0.07,
  //     //                 height: MediaQuery.of(context).size.height * 0.07,
  //     //                 margin: EdgeInsets.only(
  //     //                   top: MediaQuery.of(context).size.height * 0.01,
  //     //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //     //                   left: MediaQuery.of(context).size.height * 0.01,
  //     //                   right: MediaQuery.of(context).size.height * 0.01,
  //     //                 ),
  //     //                 decoration: BoxDecoration(
  //     //                   borderRadius: BorderRadius.circular(4.0),
  //     //                   image: DecorationImage(
  //     //                     image: AssetImage(
  //     //                         'assets/visapay.png'), // Replace with your asset path
  //     //                     fit: BoxFit.cover,
  //     //                   ),
  //     //                 ),
  //     //               ),
  //     //               // Column with two Text widgets
  //     //               Expanded(
  //     //                 child: Column(
  //     //                   crossAxisAlignment: CrossAxisAlignment.start,
  //     //                   children: [
  //     //                     Text(
  //     //                       '**** **** 3434',
  //     //                       style: TextStyle(
  //     //                         fontWeight: FontWeight.bold,
  //     //                         fontSize:
  //     //                             MediaQuery.of(context).size.height * 0.018,
  //     //                         color: Colors.black,
  //     //                       ),
  //     //                     ),
  //     //                     Text(
  //     //                       'Visa',
  //     //                       style: TextStyle(
  //     //                         fontSize:
  //     //                             MediaQuery.of(context).size.height * 0.016,
  //     //                         color: Colors.black,
  //     //                       ),
  //     //                     ),
  //     //                   ],
  //     //                 ),
  //     //               ),
  //     //               // Circular Radio Button
  //     //               Radio<int>(
  //     //                 value: 1, // The value for this radio button
  //     //                 groupValue: 0, // The currently selected value
  //     //                 onChanged: (int? value) {
  //     //                   // Handle radio button change
  //     //                 },
  //     //               ),
  //     //             ],
  //     //           ),
  //     //         ),
  //     //
  //     //         // 2
  //     //         Container(
  //     //           margin: EdgeInsets.only(
  //     //             top: MediaQuery.of(context).size.height * 0.00,
  //     //             bottom: MediaQuery.of(context).size.height * 0.01,
  //     //             left: MediaQuery.of(context).size.height * 0.01,
  //     //             right: MediaQuery.of(context).size.height * 0.01,
  //     //           ),
  //     //           padding: EdgeInsets.only(
  //     //             top: MediaQuery.of(context).size.height * 0.00,
  //     //             bottom: MediaQuery.of(context).size.height * 0.00,
  //     //             left: MediaQuery.of(context).size.height * 0.01,
  //     //             right: MediaQuery.of(context).size.height * 0.00,
  //     //           ),
  //     //           decoration: BoxDecoration(
  //     //             border: Border.all(
  //     //               color: Colors.grey,
  //     //               width: 1.0,
  //     //             ),
  //     //             borderRadius: BorderRadius.circular(8.0),
  //     //           ),
  //     //           child: Row(
  //     //             mainAxisAlignment: MainAxisAlignment.start,
  //     //             crossAxisAlignment: CrossAxisAlignment.center,
  //     //             children: [
  //     //               // Image from assets
  //     //               Container(
  //     //                 width: MediaQuery.of(context).size.height * 0.07,
  //     //                 height: MediaQuery.of(context).size.height * 0.07,
  //     //                 margin: EdgeInsets.only(
  //     //                   top: MediaQuery.of(context).size.height * 0.01,
  //     //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //     //                   left: MediaQuery.of(context).size.height * 0.01,
  //     //                   right: MediaQuery.of(context).size.height * 0.01,
  //     //                 ),
  //     //                 decoration: BoxDecoration(
  //     //                   borderRadius: BorderRadius.circular(4.0),
  //     //                   image: DecorationImage(
  //     //                     image: AssetImage(
  //     //                         'assets/paypalpay.png'), // Replace with your asset path
  //     //                     fit: BoxFit.cover,
  //     //                   ),
  //     //                 ),
  //     //               ),
  //     //               // Column with two Text widgets
  //     //               Expanded(
  //     //                 child: Column(
  //     //                   crossAxisAlignment: CrossAxisAlignment.start,
  //     //                   children: [
  //     //                     Text(
  //     //                       '**** **** 3434',
  //     //                       style: TextStyle(
  //     //                         fontWeight: FontWeight.bold,
  //     //                         fontSize:
  //     //                             MediaQuery.of(context).size.height * 0.018,
  //     //                         color: Colors.black,
  //     //                       ),
  //     //                     ),
  //     //                     Text(
  //     //                       'Paypal',
  //     //                       style: TextStyle(
  //     //                         fontSize:
  //     //                             MediaQuery.of(context).size.height * 0.016,
  //     //                         color: Colors.black,
  //     //                       ),
  //     //                     ),
  //     //                   ],
  //     //                 ),
  //     //               ),
  //     //               // Circular Radio Button
  //     //               Radio<int>(
  //     //                 value: 1, // The value for this radio button
  //     //                 groupValue: 0, // The currently selected value
  //     //                 onChanged: (int? value) {
  //     //                   // Handle radio button change
  //     //                 },
  //     //               ),
  //     //             ],
  //     //           ),
  //     //         ),
  //     //
  //     //         // 3
  //     //         Container(
  //     //           margin: EdgeInsets.only(
  //     //             top: MediaQuery.of(context).size.height * 0.00,
  //     //             bottom: MediaQuery.of(context).size.height * 0.01,
  //     //             left: MediaQuery.of(context).size.height * 0.01,
  //     //             right: MediaQuery.of(context).size.height * 0.01,
  //     //           ),
  //     //           padding: EdgeInsets.only(
  //     //             top: MediaQuery.of(context).size.height * 0.00,
  //     //             bottom: MediaQuery.of(context).size.height * 0.00,
  //     //             left: MediaQuery.of(context).size.height * 0.01,
  //     //             right: MediaQuery.of(context).size.height * 0.00,
  //     //           ),
  //     //           decoration: BoxDecoration(
  //     //             border: Border.all(
  //     //               color: Colors.grey,
  //     //               width: 1.0,
  //     //             ),
  //     //             borderRadius: BorderRadius.circular(8.0),
  //     //           ),
  //     //           child: Row(
  //     //             mainAxisAlignment: MainAxisAlignment.start,
  //     //             crossAxisAlignment: CrossAxisAlignment.center,
  //     //             children: [
  //     //               // Image from assets
  //     //               Container(
  //     //                 width: MediaQuery.of(context).size.height * 0.07,
  //     //                 height: MediaQuery.of(context).size.height * 0.07,
  //     //                 margin: EdgeInsets.only(
  //     //                   top: MediaQuery.of(context).size.height * 0.01,
  //     //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //     //                   left: MediaQuery.of(context).size.height * 0.01,
  //     //                   right: MediaQuery.of(context).size.height * 0.01,
  //     //                 ),
  //     //                 decoration: BoxDecoration(
  //     //                   borderRadius: BorderRadius.circular(4.0),
  //     //                   image: DecorationImage(
  //     //                     image: AssetImage(
  //     //                         'assets/applepay.png'), // Replace with your asset path
  //     //                     fit: BoxFit.cover,
  //     //                   ),
  //     //                 ),
  //     //               ),
  //     //               // Column with two Text widgets
  //     //               Expanded(
  //     //                 child: Column(
  //     //                   crossAxisAlignment: CrossAxisAlignment.start,
  //     //                   children: [
  //     //                     Text(
  //     //                       'Priya Krishamurty',
  //     //                       style: TextStyle(
  //     //                         fontWeight: FontWeight.bold,
  //     //                         fontSize:
  //     //                             MediaQuery.of(context).size.height * 0.018,
  //     //                         color: Colors.black,
  //     //                       ),
  //     //                     ),
  //     //                     Text(
  //     //                       'Apple Pay',
  //     //                       style: TextStyle(
  //     //                         fontSize:
  //     //                             MediaQuery.of(context).size.height * 0.016,
  //     //                         color: Colors.black,
  //     //                       ),
  //     //                     ),
  //     //                   ],
  //     //                 ),
  //     //               ),
  //     //               // Circular Radio Button
  //     //               Radio<int>(
  //     //                 value: 1, // The value for this radio button
  //     //                 groupValue: 0, // The currently selected value
  //     //                 onChanged: (int? value) {
  //     //                   // Handle radio button change
  //     //                 },
  //     //               ),
  //     //             ],
  //     //           ),
  //     //         ),
  //     //
  //     //         // 4
  //     //         Container(
  //     //           margin: EdgeInsets.only(
  //     //             top: MediaQuery.of(context).size.height * 0.00,
  //     //             bottom: MediaQuery.of(context).size.height * 0.00,
  //     //             left: MediaQuery.of(context).size.height * 0.01,
  //     //             right: MediaQuery.of(context).size.height * 0.01,
  //     //           ),
  //     //           padding: EdgeInsets.only(
  //     //             top: MediaQuery.of(context).size.height * 0.00,
  //     //             bottom: MediaQuery.of(context).size.height * 0.00,
  //     //             left: MediaQuery.of(context).size.height * 0.01,
  //     //             right: MediaQuery.of(context).size.height * 0.00,
  //     //           ),
  //     //           decoration: BoxDecoration(
  //     //             border: Border.all(
  //     //               color: Colors.grey,
  //     //               width: 1.0,
  //     //             ),
  //     //             borderRadius: BorderRadius.circular(8.0),
  //     //           ),
  //     //           child: Row(
  //     //             mainAxisAlignment: MainAxisAlignment.start,
  //     //             crossAxisAlignment: CrossAxisAlignment.center,
  //     //             children: [
  //     //               // Image from assets
  //     //               Container(
  //     //                 width: MediaQuery.of(context).size.height * 0.07,
  //     //                 height: MediaQuery.of(context).size.height * 0.07,
  //     //                 margin: EdgeInsets.only(
  //     //                   top: MediaQuery.of(context).size.height * 0.01,
  //     //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //     //                   left: MediaQuery.of(context).size.height * 0.01,
  //     //                   right: MediaQuery.of(context).size.height * 0.01,
  //     //                 ),
  //     //                 decoration: BoxDecoration(
  //     //                   borderRadius: BorderRadius.circular(4.0),
  //     //                   image: DecorationImage(
  //     //                     image: AssetImage(
  //     //                         'assets/googlepay.png'), // Replace with your asset path
  //     //                     fit: BoxFit.cover,
  //     //                   ),
  //     //                 ),
  //     //               ),
  //     //               // Column with two Text widgets
  //     //               Expanded(
  //     //                 child: Column(
  //     //                   crossAxisAlignment: CrossAxisAlignment.start,
  //     //                   children: [
  //     //                     Text(
  //     //                       'Priya Krishamurty',
  //     //                       style: TextStyle(
  //     //                         fontWeight: FontWeight.bold,
  //     //                         fontSize:
  //     //                             MediaQuery.of(context).size.height * 0.018,
  //     //                         color: Colors.black,
  //     //                       ),
  //     //                     ),
  //     //                     Text(
  //     //                       'Google Pay',
  //     //                       style: TextStyle(
  //     //                         fontSize:
  //     //                             MediaQuery.of(context).size.height * 0.016,
  //     //                         color: Colors.black,
  //     //                       ),
  //     //                     ),
  //     //                   ],
  //     //                 ),
  //     //               ),
  //     //               // Circular Radio Button
  //     //               Radio<int>(
  //     //                 value: 1, // The value for this radio button
  //     //                 groupValue: 0, // The currently selected value
  //     //                 onChanged: (int? value) {
  //     //                   // Handle radio button change
  //     //                 },
  //     //               ),
  //     //             ],
  //     //           ),
  //     //         ),
  //     //
  //     //         // Continue
  //     //         GestureDetector(
  //     //           onTap: () async {
  //     //             showsucessalertBottomSheet();
  //     //           },
  //     //           child: Container(
  //     //               alignment: Alignment.centerRight,
  //     //               padding: EdgeInsets.only(
  //     //                   top: MediaQuery.of(context).size.height * 0.01,
  //     //                   bottom: MediaQuery.of(context).size.height * 0.00,
  //     //                   left: MediaQuery.of(context).size.height * 0.00,
  //     //                   right: MediaQuery.of(context).size.height * 0.00),
  //     //               margin: EdgeInsets.only(
  //     //                   right: MediaQuery.of(context).size.height * 0.03,
  //     //                   top: MediaQuery.of(context).size.height * 0.01,
  //     //                   bottom: MediaQuery.of(context).size.height * 0.01,
  //     //                   left: MediaQuery.of(context).size.height * 0.03),
  //     //               child: Row(
  //     //                   crossAxisAlignment: CrossAxisAlignment.start,
  //     //                   mainAxisAlignment: MainAxisAlignment.center,
  //     //                   children: <Widget>[
  //     //                     Expanded(
  //     //                       child: Container(
  //     //                         decoration: BoxDecoration(
  //     //                             borderRadius: BorderRadius.circular(
  //     //                                 MediaQuery.of(context).size.height *
  //     //                                     0.012),
  //     //                             gradient: LinearGradient(
  //     //                                 begin: Alignment.centerRight,
  //     //                                 end: Alignment.center,
  //     //                                 stops: [
  //     //                                   0.5,
  //     //                                   0.9
  //     //                                 ],
  //     //                                 colors: [
  //     //                                   Color(0xFF126086),
  //     //                                   Color(0xFF126086),
  //     //                                 ])),
  //     //                         alignment: Alignment.center,
  //     //                         padding: EdgeInsets.only(left: 0.0),
  //     //                         child: TextButton(
  //     //                           onPressed: () async {
  //     //                             showsucessalertBottomSheet();
  //     //                           },
  //     //                           child: Text("Continue",
  //     //                               textAlign: TextAlign.center,
  //     //                               style: TextStyle(
  //     //                                   color: Colors.white,
  //     //                                   fontSize: MediaQuery.of(context)
  //     //                                           .size
  //     //                                           .height *
  //     //                                       0.02)),
  //     //                         ),
  //     //                       ),
  //     //                     ),
  //     //                   ])),
  //     //         ),
  //     //       ],
  //     //     ),
  //     //   ),
  //     // ),
  //     );
  void showsucessalertBottomSheet() => showModalBottomSheet(
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
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.020,
                      right: MediaQuery.of(context).size.height * 0.020,
                      top: MediaQuery.of(context).size.height * 0.030,
                      bottom: MediaQuery.of(context).size.height * 0.00),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/paymentsucess.png',
                              height: MediaQuery.of(context).size.height * 0.30,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Thank you!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.024),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.00,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                    MediaQuery.of(context).size.height * 0.00,
                              ),
                              child: Text(
                                "Payment Done Successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
                    ],
                  ),
                ),

                // Reschedule
                /*GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) {
                          return MedicatiSelectTimeSlot(
                              "widget.doctoridval");
                        },
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                    ),
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.03,
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.height * 0.03,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF126086), // Border color
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.012),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 0.0),
                            child: TextButton(
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) {
                                      return MedicatiSelectTimeSlot(
                                          "widget.doctoridval");
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Reschedule",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.026,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/

                // Back to Home
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePageMain(),
                      ),
                      (Route route) => false,
                    );
                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.00),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.03,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.03),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.012),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.center,
                                        stops: [
                                          0.5,
                                          0.9
                                        ],
                                        colors: [
                                          Color(0xFF126086),
                                          Color(0xFF126086),
                                        ])),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 0.0),
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePageMain(),
                                      ),
                                      (Route route) => false,
                                    );
                                  },
                                  child: Text("Back to Home",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02)),
                                ),
                              ),
                            ),
                          ])),
                ),
              ],
            ),
          ),
        ),
      );
}
