import 'package:flutter/material.dart';

class PhysicalVirtualFooter extends StatelessWidget {
  // Model for dynamic data
 final String feesType ;
 final String qr ;
 final String butotnName;
  final VoidCallback onBookAppointment;
  final List<Color> colors ;

  const PhysicalVirtualFooter({
    Key? key,
    required this.feesType,
    required this.qr,
    required this.butotnName,
    required this.onBookAppointment,
    required this.colors
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
   final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, -3), // Makes the shadow appear above
            blurRadius: 6,
          ),
        ],
      ),
      // height: MediaQuery.of(context).size.height * 0.150,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          // Consultation Fees
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.height * 0.05,
              right: MediaQuery.of(context).size.height * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${feesType}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize:
                    MediaQuery.of(context).size.height * 0.015,
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
                      bottom:
                      MediaQuery.of(context).size.height * 0.00),
                  child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          height: MediaQuery.of(context).size.height *
                              0.005,
                          width: MediaQuery.of(context).size.height *
                              0.005,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00),
                                child: Text(
                                  'QR 999',
                                  style: TextStyle(
                                    // color: Colors.blue[600],
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      decorationThickness: 2,
                                      fontSize: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.014
                                  ),
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.005,
                                  right: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00,
                                  top: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00,
                                  bottom: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.00),
                              child: Text(
                                "${qr}",
                                style: TextStyle(
                                  // color: Colors.blue[600],
                                    color: Color(0xFF12B76A),
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.014
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ],
            ),
          ),

          // Book Appointment

          GestureDetector(
            onTap: () {
              onBookAppointment();
            },
            child:
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height *
                        0.0,
                    bottom: MediaQuery.of(context).size.height *
                        0.00,
                    left: MediaQuery.of(context).size.height *
                        0.005,
                    right: MediaQuery.of(context).size.height *
                        0.005),
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height *
                        0.04,
                    top: MediaQuery.of(context).size.height *
                        0.01,
                    bottom: MediaQuery.of(context).size.height *
                        0.01,
                    left: MediaQuery.of(context).size.height *
                        0.04),
                child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
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
                                  colors:  colors)),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 0.0),
                          child: TextButton(
                            onPressed: () {
                              onBookAppointment();
                            },
                            child: Text( "${butotnName}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                    MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.02)
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // ← Adjust this
                              minimumSize: Size(0, 0), // Removes minimum button constraints
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap padding
                            ),

                          ),
                        ),
                      ),
                    ])),
          ),
          SizedBox(height: screenHeight * 0.015,),
        ],
      ),
    );
  }
}



