import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';

class Successfulychangenum {

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

              /* ClipPath(
                    clipper: MyClipper(),
                    child:*/
              Dialog(
                  backgroundColor: Colors.transparent,
                  // backgroundColor : Colors.black12,
                  insetPadding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.010),
                  child:
                  /*  Scrollbar(
                      child:
                      SingleChildScrollView(
                        // physics: ScrollPhysics(),
                        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
                        child:*/
                  Container(
                    child: Stack(children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.500,
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.00),
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.060,
                            left: 10.0,
                            right: 10.0,
                            bottom: 10.0),
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
                                                                'assets/paymentsucess.png',
                                                                height: MediaQuery.of(context).size.height * 0.15,
                                                                fit: BoxFit.fill,
                                                              ),

                                                              Text(
                                                                "Congratulations 🎉",
                                                                style: TextStyle(
                                                                    color: Color(0xFF126086),
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
                                                                  "Your Mobile Number Updated Successfully",
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      /* fontWeight:
                                                                            FontWeight
                                                                                .bold,*/
                                                                      fontSize:
                                                                      MediaQuery.of(context).size.height *
                                                                          0.018),
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
                                      GestureDetector(
                                        onTap: () async {
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(builder: (context) => HomePageMain()),
                                                  (Route<dynamic> route) => false);
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
                                                                Color(0xFF126086),
                                                                Color(0xFF126086),
                                                              ])),
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.only(left: 0.0),
                                                      child: TextButton(
                                                        onPressed: () async {
                                                          Navigator.of(context).pushAndRemoveUntil(
                                                              MaterialPageRoute(builder: (context) => HomePageMain()),
                                                                  (Route<dynamic> route) => false);
                                                        },
                                                        child: Text("Back to Home",
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize:
                                                                MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.02)),
                                                      ),
                                                    ),
                                                  ),
                                                ])),
                                      )
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
}
