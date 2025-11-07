import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newfolder/Screens/AddToCart/addtocarPackageDetails.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';

import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/LabTests/labtestmain.dart';
import 'package:newfolder/Screens/Medications/bottomsheet_for_payment.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/dotteddivider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  bool isExpanded = false; // For collapse/expand toggle

  String saveForLaterKey = "saveForLater";

  List<Map<String, dynamic>> carttoplist = [
      // {"id" : 1,"plan" : "QCT Prime Health Plan" , "test" : "89", "qr" : "QR 1999"},
      // {"id" : 2,"plan" : "QCT Superoir Health Plan" , "test" : "100" , "qr" : "QR 1999"},
      // {"id" : 3,"plan" : "QCT Full Body Checkup Female" , "test" : "100" , "qr" : "QR 1999"},


    ];

  List<Map<String, dynamic>> savedbottomlist = [


    // {"id" : 11,"plan" : "QCT Prime Health Plan" , "test" : "89", "qr" : "QR 1999"},
    // {"id" : 12,"plan" : "QCT Superoir Health Plan" , "test" : "100" , "qr" : "QR 1999"},
    // {"id" : 13,"plan" : "QCT Full Body Checkup Female" , "test" : "100" , "qr" : "QR 1999"},


  ];

  List<Map<String, dynamic>> _currentList = [];




  //Asgar
  bool isSavedForLater = true;
  int saveForLaterCount = 0;

  //sumonto
  int cartPrice = 0;
  int disPrice = 99;
  int platformPrice = 9;


  @override
  void initState() {
    super.initState();
    _loadCart();

  }

  @override
  Widget build(BuildContext context) {

    saveForLaterCount = savedbottomlist.length;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

      cartPrice = 0;
      for(int counter=0; counter<_currentList.length; counter++){
        int cartValue = int.parse(_currentList[counter]['qr'].split(' ')[1]);

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
                  child: (_currentList.isEmpty && savedbottomlist.isEmpty) ?
                  ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
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
                                  0.00,
                              top: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.00),
                          // color: Colors.white,
                          child: Card(
                            elevation: 0.0,
                            color: Colors.white,
                            // color: Colors.blueGrey[50],
                            // color:    [Colors.green[400], Colors.green[300]],
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
                                        Colors.white,
                                        Colors.white
                                      ])),
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.006,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.006,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.003,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.003),
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
                                          left: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.020,
                                          right: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.020,
                                          top: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.030,
                                          bottom: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.00),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: <Widget>[



                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: <Widget>[



                                                Image.asset(
                                                  'assets/Cart_Empty_vector.png',
                                                  height: MediaQuery.of(context).size.height * 0.4,
                                                  fit: BoxFit.fill,
                                                ),


                                                Container(
                                                  padding:
                                                  EdgeInsets
                                                      .only(
                                                    top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.01,
                                                    bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.02,
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                  ),
                                                  child: Text(
                                                    "Your cart is empty",
                                                    textAlign:
                                                    TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color: Color(0x66000000),
                                                        fontWeight:
                                                        FontWeight
                                                            .w400,
                                                        fontSize:
                                                        MediaQuery.of(context).size.height *
                                                            0.014,
                                                        fontFamily: "Inter"

                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                          // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (BuildContext context) {
                                  return LabTestsMain();
                                },
                              ),
                            );
                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(
                                  top:
                                  MediaQuery.of(context).size.height * 0.0,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.00,
                                  left:
                                  MediaQuery.of(context).size.height * 0.00,
                                  right: MediaQuery.of(context).size.height *
                                      0.00),
                              margin: EdgeInsets.only(
                                  right:
                                  MediaQuery.of(context).size.height * 0.07,
                                  top:
                                  MediaQuery.of(context).size.height * 0.0,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.01,
                                  left: MediaQuery.of(context).size.height *
                                      0.07),
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
                                                  Color(0xFF126086),
                                                  Color(0xFF126086),
                                                ])),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(left: 0.0),
                                        child: TextButton(
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return LabTestsMain();
                                                },
                                              ),
                                            );
                                          },
                                          child: Text("Add package to Continue",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.018,
                                                  fontWeight: FontWeight.w700

                                              )

                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                        )
                      ])
                      :
                  ListView(
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
                          itemCount: _currentList.length,
                          itemBuilder: (context, index) {
                            final file = _currentList[index]['plan'];
                            final item = _currentList[index];
                            // return Dismissible(
                            //     key: UniqueKey(), // Unique key for each item
                            //     direction: DismissDirection
                            //         .horizontal, // Allow both left & right swipes
                            //     background: Container(
                            //       color: Colors.white,
                            //       alignment: Alignment.centerLeft,
                            //       padding: EdgeInsets.symmetric(horizontal: 20),
                            //       child: Row(
                            //         children: [
                            //           Image.asset(
                            //             "assets/addtofoldersaveicon.png", // Path to your local image
                            //             width: 24, // Adjust width
                            //             height: 24, // Adjust height
                            //             color:
                            //                 Colors.green, // Apply white color
                            //             colorBlendMode: BlendMode
                            //                 .srcIn, // Blend mode to colorize
                            //           ),
                            //           SizedBox(width: 10),
                            //           Text(
                            //             "Saved",
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     secondaryBackground: Container(
                            //       color: Colors.white,
                            //       alignment: Alignment.centerRight,
                            //       padding: EdgeInsets.symmetric(horizontal: 20),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.end,
                            //         children: [
                            //           Text("Delete",
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.bold)),
                            //           SizedBox(width: 10),
                            //           Icon(Icons.delete, color: Colors.red),
                            //         ],
                            //       ),
                            //     ),
                            //     onDismissed: (direction) {
                            //       if (direction ==
                            //           DismissDirection.endToStart) {
                            //         // setState((){
                            //              // carttoplist.removeAt(index);
                            //              // ScaffoldMessenger.of(context).showSnackBar(
                            //              //    SnackBar(content: Text("$file deleted"), duration: Duration(seconds: 2)),
                            //              // );
                            //         // });
                            //       _deleteCart(item['id']);
                            //       showTopNotification(
                            //         context,
                            //         title: "Cart Delete",
                            //         message: "Cart is deleted Successfully",
                            //         type: NotificationType.error,
                            //       );
                            //       } else if (direction ==
                            //           DismissDirection.startToEnd) {
                            //         showTopNotification(
                            //           context,
                            //           title: "Cart Save For Later",
                            //           message: "Cart is Saved for Later Successfully",
                            //           type: NotificationType.success,
                            //         );
                            //
                            //         if (index >= carttoplist.length) {
                            //
                            //
                            //           savedbottomlist
                            //               .add(carttoplist.last);
                            //
                            //           carttoplist.removeLast();
                            //           setState(() {});
                            //           return;
                            //         }
                            //
                            //         setState(() {
                            //           // Swiped Left to Right (Move to another list)
                            //           // if (endtextbottomlist.length > 0)
                            //           savedbottomlist.insert(
                            //               0, carttoplist[index]);
                            //           // else {
                            //           //   endtextbottomlist
                            //           //       .add(uploadfilestime[index]);
                            //           // }
                            //
                            //           carttoplist.removeAt(index);
                            //
                            //         });
                            //         // Mark item as "Saved" when swiped left to right
                            //         // ScaffoldMessenger.of(context).showSnackBar(
                            //         //   SnackBar(
                            //         //     content: Text(
                            //         //       "$file Saved",
                            //         //       style: TextStyle(
                            //         //           color: Colors.white,
                            //         //           fontWeight: FontWeight.bold),
                            //         //     ),
                            //         //     backgroundColor: Colors
                            //         //         .green, // Set background color to green
                            //         //     duration: Duration(seconds: 2),
                            //         //   ),
                            //         // );
                            //       }
                            //     },
                            return Slidable(
                                // key: ValueKey(plan["title"]),
                                key : UniqueKey(),
                                closeOnScroll: true,
                                endActionPane: ActionPane(
                                  extentRatio: 0.15,
                                  motion: const ScrollMotion(),
                                  children: [
                                    Container(
                                      width: 50,
                                      height: double.infinity,

                                      child: Column(
                                        children: [
                                          // Upper icon (Save)
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: (){
                                                        showTopNotification(
                                                          context,
                                                          title: "Cart Save For Later",
                                                          message: "Cart is Saved for Later Successfully",
                                                          type: NotificationType.success,
                                                        );

                                                        if (index >= _currentList.length) {


                                                          savedbottomlist
                                                              .add(_currentList.last);

                                                          _currentList.removeLast();
                                                          setState(() {});
                                                          return;
                                                        }

                                                        setState(() {

                                                          // savedbottomlist.insert(
                                                          //     0, _currentList[index]);

                                                          addToCart(item['id'],item['plan'],item['test'],item['qr'],key: saveForLaterKey);
                                                          print("${item['id']} ${item['plan']} ${item['test']} ${item['qr']}");

                                                          _currentList.removeAt(index);

                                                        });
                                                        _deleteCart(item['id'],index);

                                              },

                                              child: Container(

                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  "assets/addtofoldersaveicon.png",
                                                  width: 20,
                                                  height: 20,
                                                  color: Colors.black,
                                                  colorBlendMode: BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Lower icon (Delete)
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: (){
                                                _deleteCart(item['id'],index);
                                                showTopNotification(
                                                  context,
                                                  title: "Cart Delete",
                                                  message: "Cart is deleted Successfully",
                                                  type: NotificationType.error,
                                                );
                                              },
                                              child: Container(

                                                alignment: Alignment.center,
                                                child: Icon(Icons.delete, color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (BuildContext context) {
                                          return AddtocardPackageDetails(id: item['id'],plan: item['plan'],qr: item['qr'],test: item['test'],);
                                        },
                                      ),
                                    );
                                  },
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
                                        child: MediaQuery(
                                          data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.1),),
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
                                                            "assets/Harmonebackground.png",
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
                                                              item['plan'],
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
                                                              item['test'] + " tests included",
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
                                                                  item['qr'],
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
                                  ),
                                )
                            );
                          },
                        ),
                      ),

                      // Price Details

                      _currentList.isEmpty ?
                         Container() :
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

                      // down card savedbottomlist.isEmpty
                      _currentList.isEmpty ?
                      Container() :
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
                                                  "Price ("+_currentList.length.toString()+" Package)",
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
                                                    'You saved QR '+(_currentList.length<=0?0:disPrice).toString(),
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
                                                    'QR '+(_currentList.length<=0?0:platformPrice).toString(),
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
                                                    'QR '+(_currentList.length<=0?0:(cartPrice-disPrice+platformPrice)).toString(),
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

                      // Saved for later Text
                      savedbottomlist.isEmpty
                          ? Container()
                          : GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded; // Toggle collapse/expand
                          });
                        },
                            child: Container(

                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.height * 0.01,
                                            bottom: MediaQuery.of(context).size.height * 0.015,
                                  left: MediaQuery.of(context).size.height * 0.020,
                                  right: MediaQuery.of(context).size.height * 0.020,
                                ),
                                padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.height * 0.01,
                                vertical: MediaQuery.of(context).size.height * 0.008),
                                decoration: BoxDecoration(
                                color: Colors.white,
                                  // color : Colors.blue,
                                borderRadius: BorderRadius.circular(6), // 6px radius
                                border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.14), // rgba(0,0,0,0.14)
                                width: 0.5,
                                ),
                                ),
                                child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                // Icon on the left
                                InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                height: MediaQuery.of(context).size.height * 0.02,
                                width: MediaQuery.of(context).size.height * 0.02,
                                child: Image.asset(
                                'assets/addcartFolder.png',
                                height: MediaQuery.of(context).size.height * 0.015,
                                width: MediaQuery.of(context).size.height * 0.015,
                                ),
                                ),
                                ),

                                SizedBox(width: MediaQuery.of(context).size.height * 0.01),

                                // Saved For Later Text
                                Expanded(
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                                "Saved For Later ($saveForLaterCount)",
                                style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.014,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w500,
                                ),
                                ),

                                // Dropdown arrow
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = !isExpanded; // Toggle collapse/expand
                                      });
                                    },
                                    child: Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      size: MediaQuery.of(context).size.height * 0.02,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                                ),
                                ),
                                ],
                                ),
                                ),
                          )
    ,

                      // Bottom ListView
                      isExpanded && savedbottomlist.isNotEmpty
                          ? Container(
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
                                  final file = savedbottomlist[index]['plan'];
                                  final item = savedbottomlist[index];
                                  // return Dismissible(
                                  //     key:UniqueKey(), // Unique key for each item
                                  //     direction: DismissDirection.endToStart, // Allow swipe from right to left
                                  //     background: Container(
                                  //       color: Colors.white,
                                  //       alignment: Alignment.centerRight,
                                  //       padding: EdgeInsets.symmetric(
                                  //           horizontal: 20),
                                  //       child: Icon(
                                  //         Icons.delete,
                                  //         color: Colors.red,
                                  //       ),
                                  //     ),
                                  //     onDismissed: (direction) {
                                  //       // Remove the item immediately from the list
                                  //       // endtextbottomlist.removeAt(index);
                                  //       showTopNotification(
                                  //         context,
                                  //         title: "Cart Delete",
                                  //         message: "Saved For Later Cart is deleted Successfully",
                                  //         type: NotificationType.error,
                                  //       );
                                  //       setState(() {
                                  //         savedbottomlist.removeAt(index);
                                  //       });
                                  //       // If the list is empty, show a message
                                  //       if (savedbottomlist.isEmpty) {
                                  //
                                  //
                                  //         isSavedForLater = false;
                                  //       }
                                  //       /* setState(() {
                                  //
                                  //   });*/
                                  //
                                  //       // Show a snackbar for feedback
                                  //       /* ScaffoldMessenger.of(context).showSnackBar(
                                  //                               SnackBar(
                                  //                                 content: Text("$file deleted"),
                                  //                                 duration: Duration(seconds: 2),
                                  //                               ),
                                  //                             );*/
                                  //     },
                                  return Slidable(
                                    // key: ValueKey(plan["title"]),
                                      key : UniqueKey(),
                                      closeOnScroll: true,
                                      endActionPane: ActionPane(
                                        extentRatio: 0.15,
                                        motion: const ScrollMotion(),
                                        // children: [
                                        //   Container(
                                        //     width: 50,
                                        //     height: double.infinity,
                                        //
                                        //     child: Column(
                                        //       children: [
                                        //
                                        //
                                        //
                                        //         // Lower icon (Delete)
                                        //         Expanded(
                                        //           child: GestureDetector(
                                        //             onTap: (){
                                        //
                                        //                     showTopNotification(
                                        //                       context,
                                        //                       title: "Cart Delete",
                                        //                       message: "Saved For Later Cart is deleted Successfully",
                                        //                       type: NotificationType.error,
                                        //                     );
                                        //                     setState(() {
                                        //                       savedbottomlist.removeAt(index);
                                        //                     });
                                        //                     // If the list is empty, show a message
                                        //                     if (savedbottomlist.isEmpty) {
                                        //
                                        //
                                        //                       isSavedForLater = false;
                                        //                     }
                                        //
                                        //
                                        //
                                        //             },
                                        //             child: Container(
                                        //
                                        //               alignment: Alignment.center,
                                        //               child: Icon(Icons.delete, color: Colors.red),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ],

                                        children: [
                                          Container(
                                            width: 50,
                                            height: double.infinity,

                                            child: Column(
                                              children: [
                                                // Upper icon (Save)
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {

                                                      addToCart(item['id'],item['plan'],item['test'],item['qr']);
                                                      // print("${item['id']} ${item['plan']} ${item['test']} ${item['qr']}");

                                                      _deleteCart(item['id'],index,key: saveForLaterKey);
                                                      showTopNotification(
                                                        context,
                                                        title: "Cart Added",
                                                        message: "Saved For Later Cart is added back to Cart",
                                                        type: NotificationType.success,
                                                      );



                                                      setState(() {
                                                        savedbottomlist.removeAt(index);
                                                      });
                                                      // If the list is empty, show a message
                                                      if (savedbottomlist.isEmpty) {


                                                        isSavedForLater = false;
                                                      }





                                                    },

                                                    child: Container(

                                                      alignment: Alignment.center,
                                                      child: Image.asset(
                                                        "assets/Add to cart.png",
                                                        width: 20,
                                                        height: 20,
                                                        color: Colors.black,
                                                        colorBlendMode: BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                // Lower icon (Delete)
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: (){
                                                                            showTopNotification(
                                                                              context,
                                                                              title: "Cart Delete",
                                                                              message: "Saved For Later Cart is deleted Successfully",
                                                                              type: NotificationType.error,
                                                                            );
                                                                            setState(() {
                                                                              // savedbottomlist.removeAt(index);
                                                                              _deleteCart(item['id'],index,key: saveForLaterKey);
                                                                            });
                                                                            // If the list is empty, show a message
                                                                            if (savedbottomlist.isEmpty) {


                                                                              isSavedForLater = false;
                                                                            }
                                                    },
                                                    child: Container(

                                                      alignment: Alignment.center,
                                                      child: Icon(Icons.delete, color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) {
                                                return AddtocardPackageDetails(id: item['id'],plan: item['plan'],qr: item['qr'],test: item['test'],);
                                              },
                                            ),
                                          );
                                        },
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
                                              child: MediaQuery(
                                                data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.1),),
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
                                                                      "assets/Harmonebackground.png",
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
                                                                    savedbottomlist[index]['plan'],
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
                                                                    savedbottomlist[index]['test'] + " Tests Included",
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
                                                                            index]['qr'],
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
                                        ),
                                      ));
                                },
                              ),
                            ):
                      Container()
                          ,
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
      bottomNavigationBar: (_currentList.isEmpty && savedbottomlist.isEmpty)  ? null : Container(
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
            right: MediaQuery.of(context).size.height * 0.00,
          ),
          margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.height * 0.04,
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.height * 0.04,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque, // ✅ makes the whole container tappable
                  onTap: () async {
                    showPaymentmethodsBottomSheet();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.012,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.center,
                        stops: [0.5, 0.9],
                        colors: [
                          Color(0xFF126086),
                          Color(0xFF126086),
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 0.0),
                    child: TextButton(
                      onPressed: () async {
                        showPaymentmethodsBottomSheet();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 9.5,
                          horizontal: 12.0,
                        ),
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Next",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          MediaQuery.of(context).size.height * 0.018,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )

        ],
        ),
      )   ,
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

  void showPaymentmethodsBottomSheet() => showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent, // Transparent for blur
    barrierColor: Colors.transparent, // Disable dark overlay
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
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
              decoration: const BoxDecoration(
                color: Colors.white, // White background for popup
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: BottomSheetForPaymentForMedication(),
            ),
          ),
        ],
      );
    },


    //     StatefulBuilder(
    //   builder: (BuildContext context,
    //       StateSetter setState /*You can rename this!*/) =>
    //       Padding(
    //         padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(context).viewInsets.bottom),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Container(
    //               padding: EdgeInsets.only(
    //                   left: MediaQuery.of(context).size.height * 0.020,
    //                   right: MediaQuery.of(context).size.height * 0.020,
    //                   top: MediaQuery.of(context).size.height * 0.030,
    //                   bottom: MediaQuery.of(context).size.height * 0.00),
    //               child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: <Widget>[
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Text(
    //                           "Payment Methods",
    //                           style: TextStyle(
    //                               color: Colors.black,
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: MediaQuery.of(context).size.height *
    //                                   0.024),
    //                         ),
    //                         Container(
    //                           padding: EdgeInsets.only(
    //                             top: MediaQuery.of(context).size.height * 0.00,
    //                             bottom:
    //                             MediaQuery.of(context).size.height * 0.02,
    //                             left: MediaQuery.of(context).size.height * 0.00,
    //                             right:
    //                             MediaQuery.of(context).size.height * 0.00,
    //                           ),
    //                           child: Text(
    //                             "Please Select a payment method",
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                                 color: Colors.black54,
    //                                 fontSize:
    //                                 MediaQuery.of(context).size.height *
    //                                     0.018),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //
    //                   // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
    //                 ],
    //               ),
    //             ),
    //
    //             // Payment mode
    //             // 1
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/visapay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           '**** **** 3434',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Visa',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 2
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/paypalpay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           '**** **** 3434',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Paypal',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 3
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/applepay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Priya Krishamurty',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Apple Pay',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 4
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/googlepay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Priya Krishamurty',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Google Pay',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // Continue
    //             GestureDetector(
    //               onTap: () async {
    //                 showsucessalertBottomSheet();
    //               },
    //               child: Container(
    //                   alignment: Alignment.centerRight,
    //                   padding: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.00,
    //                       left: MediaQuery.of(context).size.height * 0.00,
    //                       right: MediaQuery.of(context).size.height * 0.00),
    //                   margin: EdgeInsets.only(
    //                       right: MediaQuery.of(context).size.height * 0.03,
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.03),
    //                   child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Expanded(
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(
    //                                     MediaQuery.of(context).size.height *
    //                                         0.012),
    //                                 gradient: LinearGradient(
    //                                     begin: Alignment.centerRight,
    //                                     end: Alignment.center,
    //                                     stops: [
    //                                       0.5,
    //                                       0.9
    //                                     ],
    //                                     colors: [
    //                                       Color(0xFF126086),
    //                                       Color(0xFF126086),
    //                                     ])),
    //                             alignment: Alignment.center,
    //                             padding: EdgeInsets.only(left: 0.0),
    //                             child: TextButton(
    //                               onPressed: () async {
    //                                 showsucessalertBottomSheet();
    //                               },
    //                               child: Text("Continue",
    //                                   textAlign: TextAlign.center,
    //                                   style: TextStyle(
    //                                       color: Colors.white,
    //                                       fontSize: MediaQuery.of(context)
    //                                           .size
    //                                           .height *
    //                                           0.02)),
    //                             ),
    //                           ),
    //                         ),
    //                       ])),
    //             ),
    //           ],
    //         ),
    //       ),
    // ),
  );



  void _loadCart() async {
      bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
      String? username =  await UserSecureStorage.getUsernameid();

      if(isGuestUser) {
        username = "GUEST";
      }
      print("username : $username");


      List<dynamic> _loadedCart2  = await UserSecureStorage.getAddToCart("addToCart2",username ?? '');
      List<dynamic> saveForLater  = await UserSecureStorage.getAddToCart(saveForLaterKey,username ?? '');


      print("_loadedCart2 : $_loadedCart2");
      print("saveForLater : $saveForLater");




      // Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _currentList = [..._loadedCart2,];
          savedbottomlist = [...saveForLater];
        });
      // });

      // Future.delayed(const Duration(milliseconds: 500), () {
      //   setState(() {
      //
      //   });
      // });

  }

  void _deleteCart(int id,int index,{String? key}) async {

    bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
    String? username =  await UserSecureStorage.getUsernameid();

    if(isGuestUser) {
      username = "GUEST";
    }

    if(key == null || key.isEmpty){

      List<dynamic> addToCart2 = await UserSecureStorage.getAddToCart("addToCart2",username ?? '');
      bool _loadedCartCache = addToCart2.any((item) => item['id'] == id);

      if(_loadedCartCache){
        await UserSecureStorage.deleteFromAddToCart(
          key: "addToCart2", // tumhara constant key name
          userId: username ?? '',
          index: index,
        );
      }



    }
    else if(key.isNotEmpty && key == saveForLaterKey){
      List<dynamic> saveForLaterCache = await UserSecureStorage.getAddToCart(saveForLaterKey,username ?? '');
      bool _loadedCartCache = saveForLaterCache.any((item) => item['id'] == id);

      if(_loadedCartCache){
        await UserSecureStorage.deleteFromAddToCart(
          key: saveForLaterKey, // tumhara constant key name
          userId: username ?? '',
          index: index,
        );
      }
    }

    _loadCart();
  }

  void addToCart(int id,String plan,String test,String qr,{String? key}) async{
    Map<String,dynamic> addToCart = {
      "id": id,
      "plan" : plan,
      "test" : test,
      "qr" : qr
    };

    bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
    print("isGuestUser : $isGuestUser");
    String? username =  await UserSecureStorage.getUsernameid();

    Map<String, dynamic>? user = await UserSecureStorage.getUser(username ?? '');


    String userId = "";
    if(isGuestUser){
      userId  = "GUEST";
    }
    else {
        userId = username ?? '';
    }

    if(key == saveForLaterKey){
      UserSecureStorage.saveAddToCard(key: key!,userId: userId, newData: addToCart);
    }
    else {
      UserSecureStorage.saveAddToCard(key: "addToCart2",userId: userId, newData: addToCart);
    }
    _loadCart();
  }


}


