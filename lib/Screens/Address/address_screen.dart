import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Maps/google_map_screen.dart';
import 'package:progress_dialog2/progress_dialog2.dart';

class AddressScreen extends StatefulWidget {
  int selectedIndex = 0;

  AddressScreen({
    super.key,
  });

  @override
  State<AddressScreen> createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {


  // ConnectivityService connectivityservice = ConnectivityService();
  // APIService apiService = new APIService();
  late ProgressDialog progressDialog;
  // AuthFailed customalert = new AuthFailed();

  TextEditingController SearchEditTextController = TextEditingController();

  bool hasStartedTyping = false ;
  bool showAddressList = false;

  void checkTextFieldEmpty(String text){


    if(text.length > 0){
      print("text length  : ${text}");
      setState(() {
        showAddressList = false;
      });
    }
    else {
      print("text length  : ${text}");
      setState(() {
       showAddressList = true;
      });
    }

  }

  @override
  void initState() {

    super.initState();
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
          strokeWidth: MediaQuery
              .of(context)
              .size
              .height * 0.002,
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
            fontSize: MediaQuery
                .of(context)
                .size
                .height * 0.018,
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

                      ],
                    ),
                  ),

                  // Main Content Section
                  Expanded(
                    child: Container(
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
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.025,
                              left: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.025,
                              right: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.025,
                              bottom: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.00,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize
                                  .min,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          Navigator.pop(
                                              context),
                                      child: Container(
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
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .grey[100]!
                                              .withOpacity(
                                              0.9),
                                          shape: BoxShape
                                              .circle,
                                        ),
                                        child: Icon(
                                          Icons
                                              .arrow_back_ios_sharp,
                                          color: Color(
                                              0xFF999999),
                                          size: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.02,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.01),
                                    // Add spacing between widgets
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            height : MediaQuery.of(context).size.height  * 0.05,
                                            alignment: Alignment
                                                .centerRight,
                                            margin: EdgeInsets
                                                .only(
                                                top : MediaQuery.of(context).size.height * 0.005,
                                                bottom: MediaQuery
                                                    .of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.01),
                                            child: TextFormField(

                                              controller: SearchEditTextController,
                                              onChanged: (value) {

                                              },
                                              style: TextStyle(
                                                color: Colors
                                                    .black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: MediaQuery.of(context).size.height  * 0.015,
                                              ),
                                              keyboardType: TextInputType
                                                  .emailAddress,

                                              decoration: InputDecoration(

                                                isDense: true,
                                                contentPadding: EdgeInsets.only(
                                                  left : MediaQuery.of(context).size.height  * 0.025,

                                                  top : MediaQuery.of(context).size.height  * 0.02,

                                                ),

                                                filled: true,
                                                fillColor: Color(
                                                    0xFFF7F5F6),
                                                hintText: "Search for area,street name,locality...",
                                                hintStyle: TextStyle(
                                                  color: Color(
                                                      0xFF1F1F1F),
                                                  fontSize: MediaQuery
                                                      .of(
                                                      context)
                                                      .size
                                                      .height *
                                                      0.014,
                                                  fontWeight: FontWeight
                                                      .w400,
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      12.0),
                                                  borderSide:
                                                  BorderSide(
                                                      color: Colors
                                                          .white),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius
                                                      .all(
                                                      Radius
                                                          .circular(
                                                          12.0)),
                                                  borderSide:
                                                  BorderSide(
                                                      color: Colors
                                                          .white),
                                                ),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .search,
                                                    color: Colors
                                                        .black45,
                                                    size: MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.03,
                                                  ),
                                                  onPressed:  () {

                                                    FocusScope.of(context).unfocus();
                                                    setState(() {
                                                       hasStartedTyping = true;
                                                       showAddressList = true;
                                                    });



                                                  },
                                                ),
                                                // errorText: _errorMessage,
                                              ),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                         if(hasStartedTyping)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return GoogleMapScreen();
                                  },
                                ),
                              );
                            },
                            child:Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.025,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.025,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.015),
                              decoration: BoxDecoration(
                                color: Color(0xFFA8B1CE).withOpacity(0.1), // Background color of the container
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
                                      0.0,
                                  top: MediaQuery.of(context)
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
                                          Color(0xFFA8B1CE).withOpacity(0.1),
                                          Color(0xFFA8B1CE).withOpacity(0.1),
                                        ])),

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
                                            0.005,
                                        right:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.025,
                                        top:
                                        MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.00,
                                        bottom:
                                        MediaQuery.of(context)
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
                                                left: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                              ),
                                              child:   Container(
                                                margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.height * 0.01,
                                                  right: MediaQuery.of(context).size.height * 0.01,
                                                  top: MediaQuery.of(context).size.height * 0.01,
                                                  bottom: MediaQuery.of(context).size.height * 0.01,
                                                ),
                                                height: MediaQuery.of(context).size.height * 0.018,
                                                width: MediaQuery.of(context).size.height * 0.018,
                                                child:
                                                Image.asset(
                                                  'assets/myhealthhelp.png',
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
                                                    "Choose Current Location",
                                                    style:
                                                    TextStyle(
                                                      color: Color(0xFF454545),
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      fontSize: MediaQuery.of(context)
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

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),


                         if(showAddressList)
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context,index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (BuildContext context) {
                                    //       return HelpscreenMain();
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  child:Container(
                                    margin: EdgeInsets.only(
                                        left: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.025,
                                        right: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.025,
                                        bottom: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.005,
                                        top: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.015),


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
                                            0.0,
                                        top: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.00),
                                    // color: Colors.white,
                                    child: Container(
                                      // color: Colors.white,



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
                                                  0.005,
                                              right:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.025,
                                              top:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.00,
                                              bottom:
                                              MediaQuery.of(context)
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
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                        EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                        ),
                                                        child:   Container(
                                                          margin: EdgeInsets.only(
                                                            left: MediaQuery.of(context).size.height * 0.01,
                                                            right: MediaQuery.of(context).size.height * 0.01,
                                                            top: MediaQuery.of(context).size.height * 0.01,
                                                            bottom: MediaQuery.of(context).size.height * 0.005,
                                                          ),
                                                          height: MediaQuery.of(context).size.height * 0.018,
                                                          width: MediaQuery.of(context).size.height * 0.018,
                                                          child:
                                                          Image.asset(
                                                            'assets/location.png',
                                                            fit:
                                                            BoxFit.fill,
                                                            color: Colors.black,
                                                          ),
                                                        ),

                                                      ),
                                                      Text(
                                                        "100 m",
                                                        style : TextStyle(
                                                          color : Color(0xFF5C5C5C),
                                                          fontSize: screenHeight * 0.01,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.of(
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
                                                          "Building Name",
                                                          style:
                                                          TextStyle(
                                                            color: Color(0xFF454545),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400,
                                                            fontSize: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.0135,
                                                          ),
                                                        ),
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
                                                              0.0,
                                                          bottom: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.00,
                                                        ),
                                                        child: Text(
                                                          "Location name, Area name",
                                                          style:
                                                          TextStyle(
                                                            color: Color(0xFF898989),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400,
                                                            fontSize: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.01,
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                // Adding the side arrow at the end

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                            },
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




}
