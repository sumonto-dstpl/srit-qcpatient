import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class AppointmentCancel {
  showticket(context) async {
    await Future.delayed(Duration(microseconds: 1));
    TextEditingController? tracktextcontroller = TextEditingController();

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
                insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal: MediaQuery.of(context).size.width * 0.04,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IntrinsicHeight( // Let it adapt to content height
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // -- Your Icon and Message Here --
                              Container(
                                height: MediaQuery.of(context).size.height * 0.065,
                                width: MediaQuery.of(context).size.height * 0.065,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent[100]!.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.warning_amber,
                                  color: Colors.red,
                                  size: MediaQuery.of(context).size.height * 0.03,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height * 0.02,
                                  horizontal: MediaQuery.of(context).size.height * 0.01,
                                ),
                                child: Text(
                                  "Are you sure to cancel the Selected Appointment?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF6A6E83),
                                    fontSize: MediaQuery.of(context).size.height * 0.015,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              // -- TextField for reason --
                              TextFormField(
                                controller: tracktextcontroller,
                                maxLines: 3,
                                style: TextStyle(color: Colors.black), // Set text color
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white10, // Slight transparent background
                                  hintText: "Enter your reason minimum 20 words",
                                  hintStyle: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                    color: Color(0x4D111111), // Semi-transparent hint color
                                    fontWeight: FontWeight.w500,
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height * 0.02,
                                    MediaQuery.of(context).size.height * 0.00,
                                    MediaQuery.of(context).size.height * 0.025,
                                    MediaQuery.of(context).size.height * 0.015,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  isDense: true,
                                ),
                              ),
                              SizedBox(height: 20),

                              // -- Buttons Row --
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: MediaQuery.of(context).size.width * 0.05, // space between buttons
                                runSpacing: MediaQuery.of(context).size.height * 0.01, // space between lines
                                children: [
                                  // Close Button
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      side: BorderSide(color: Color(0xFFA8B1CE), width: 1),
                                      padding: EdgeInsets.symmetric(
                                        vertical: MediaQuery.of(context).size.height * 0.004,
                                        horizontal: MediaQuery.of(context).size.height * 0.06,
                                      ),
                                      textStyle: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.014,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Close"),
                                  ),

                                  // Okay Button
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0x80D42620),
                                      foregroundColor: Colors.white,
                                      shadowColor: Colors.transparent,

                                      padding: EdgeInsets.symmetric(
                                        vertical: MediaQuery.of(context).size.height * 0.004,
                                        horizontal: MediaQuery.of(context).size.height * 0.06,
                                      ),
                                      textStyle: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Optional: Navigator.pop(context); for double pop
                                    },
                                    child: Text("Okay"),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            Dialog(
                backgroundColor: Colors.transparent,
                // backgroundColor : Colors.black12,
                insetPadding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * 0.010),
                child:

                Container(
                  child: Stack(children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.400,
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.00),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.060,
                          left: MediaQuery.of(context).size.height * 0.03,
                          right: MediaQuery.of(context).size.height * 0.03,
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
                                                  0.00,
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
                                                  0.00,
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
                                                          0.015,
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
                                                            Container(
                                                              height: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.065,
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height *
                                                                  0.065,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .redAccent[
                                                                100]!
                                                                    .withOpacity(
                                                                    0.2),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .warning_amber,
                                                                color: Colors
                                                                    .red,
                                                                size: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.03,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                              EdgeInsets
                                                                  .only(
                                                                top: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.005,
                                                                bottom: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01,
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
                                                                "Are you sure to cancel the Selected Appointment?",
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: TextStyle(
                                                                  color: Color(0xFF6A6E83),

                                                                  fontSize: MediaQuery.of(context).size.height * 0.0145,
                                                                  fontWeight: FontWeight.w500,
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
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.035,
                                          right: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.035,
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          bottom: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.02),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        maxLines: 3,
                                        onChanged: (value) {
                                          setState(() {
                                            /*  _trackErrorval = (value == null || value.isEmpty)
                                                        ? 'Please enter Application Number'
                                                        : "";*/

                                            /*_trackErrorval = (value == null || value.isEmpty)
                              ? 'Please enter your email'
                              : (RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{3,3}$')
                                      .hasMatch(value))
                                  ? ''
                                  : 'Invalid email format';*/
                                          });
                                        },

                                        controller: tracktextcontroller,
                                        style:
                                        TextStyle(color: Colors.black),
                                        // onSaved: (input) => loginRequestModel.email = input,

                                        /*  validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },*/

                                        decoration: InputDecoration(
                                          // errorText: _trackErrorval,
                                          errorStyle: TextStyle(
                                            // height: 0.1,
                                              color: Colors.red,
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.020),
                                          errorMaxLines: 2,
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              // width: 2.0,
                                            ),
                                          ),

                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFF1F1F1)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFF1F1F1)),
                                          ),

                                          isDense: true,
                                          contentPadding:
                                          EdgeInsets.fromLTRB(
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.02,
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.00,
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.025,
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.015,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white10,
                                          hintText:
                                          "Enter your reason minimum 20 words",
                                          hintStyle: TextStyle(
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.012,
                                              color: Color(0x4D111111),
                                              fontWeight: FontWeight.w500
                                          ),
                                          // prefixIcon: Icon(Icons.person, color: Colors.black45,),
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
                                              0.06,
                                          right: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.06,
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.007,
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
                                                  0.035,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.1,
                                              padding: new EdgeInsets.only(
                                                  left:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  right:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  top:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  bottom:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005),
                                              decoration: BoxDecoration(
                                                // color: Colors.grey[300],
                                                borderRadius:
                                                BorderRadius.circular(
                                                    7),
                                                border: Border.all(
                                                  color: Color(0xFFA8B1CE),
                                                  // Border color
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
                                                      FontWeight.w500,
                                                      fontSize: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.01)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.035,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.1,
                                              padding: new EdgeInsets.only(
                                                  left:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  right:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.01,
                                                  top:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005,
                                                  bottom:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.005),
                                              decoration: BoxDecoration(
                                                // color: Colors.grey[300],
                                                borderRadius:
                                                BorderRadius.circular(
                                                    7),
                                                color : Color(0x80D42620),
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
                                              child: Text("Okay",
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.01)),
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
}
