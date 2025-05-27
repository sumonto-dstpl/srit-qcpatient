import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


class EmergencyHomeCall {
  showticket(context) async {
    await Future.delayed(Duration(microseconds: 1));

    showDialog(
        // barrierColor: Colors.white30,
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          String contentText = "Content of Dialog";
          return StatefulBuilder(builder: (context, setState) {
            return


                Dialog(
                    backgroundColor: Colors.transparent,
                    // backgroundColor : Colors.black12,
                    insetPadding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.010),
                    child:

                        Container(
                      child: Stack(children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.550,
                          margin: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.00),
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.060,
                              left: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.0),
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 5.0,
                            color: Colors.white,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child:

                                      // ListView.builder(

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
                                                      // color: Colors.red,
                                                      /* height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.16,*/
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.010,
                                                          right: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.010,
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
                                                                  'assets/ambulancealert.png',
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.15,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Text(
                                                                  "Emergency Call",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFFD42620),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.024),
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
                                                                    "You are about to call ambulance for an emergency. Are you sure you want to proceed?",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Colors.black54,
                                                                        /* fontWeight:
                                                                            FontWeight
                                                                                .bold,*/
                                                                        fontSize: MediaQuery.of(context).size.height * 0.018),
                                                                  ),
                                                                ),
                                                                /*  Text(
                                                                  "applicant Successfully",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.024),
                                                                ),*/
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
                                        Container(
                                          decoration: BoxDecoration(
                                            // color:Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          // color:Colors.green[100],
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
                                                  0.00,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.00),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () async {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.050,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.120,
                                                  padding: new EdgeInsets.only(
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
                                                              0.01,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                  decoration: BoxDecoration(
                                                    // color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Color(
                                                          0xFF126086), // Border color
                                                      width: 1, // Border width
                                                    ),
                                                  ),

                                                  margin: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
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
                                                            0.00,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                  ),
                                                  // color: Colors.grey[300],
                                                  alignment: Alignment.center,
                                                  // height:
                                                  // MediaQuery.of(context).size.height * 0.070,
                                                  child: Text("Close",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.014)),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  // Navigator.of(context,
                                                  //         rootNavigator: true)
                                                  //     .pop();
                                                  _makePhoneCall('1234567890');

                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.050,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.120,
                                                  padding: new EdgeInsets.only(
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
                                                              0.01,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD42620),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),

                                                  margin: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
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
                                                            0.00,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.005,
                                                  ),
                                                  // color: Colors.grey[300],
                                                  alignment: Alignment.center,
                                                  // height:
                                                  // MediaQuery.of(context).size.height * 0.070,
                                                  child: Text("Call Now",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.016)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
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
                                                  0.03),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "*",
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .height *
                                                      0.02, // Adjust size based on screen height
                                                  color: Colors
                                                      .red, // Color of the asterisk
                                                ),
                                              ),
                                              Text(
                                                " This service might be Chargeable",
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .height *
                                                      0.016, // Adjust size based on screen height
                                                  color: Colors
                                                      .black54, // Color of the text
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    )
                    /* ),
                    ),*/

                    // ),
                    );
          });
        });
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Show error message or fallback UI
      print("Cannot make phone call");
    }
  }
}
