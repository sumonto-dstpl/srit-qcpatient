import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Login/loginpage.dart';


// class LoginBottomSheet {
//   static void show(BuildContext context,bool popStatus) {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         // isDismissible: true, // Tap outside to dismiss
//         enableDrag: false,   // Prevent swipe-to-dismiss
//         backgroundColor: Colors.transparent,
//         barrierColor: Colors.transparent,
//         transitionAnimationController: AnimationController(
//         duration: const Duration(milliseconds: 200),
//     vsync: Navigator.of(context),
//     ),
//     builder: (BuildContext context) {
//     return Stack(
//     children: [
//     // ✅ Background blur with outside tap-to-dismiss
//     GestureDetector(
//     onTap: () => Navigator.of(context).pop(),
//     child: BackdropFilter(
//     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//     child: Container(
//     color: Colors.transparent,
//     width: double.infinity,
//     height: double.infinity,
//     ),
//     ),
//     ),
//
//     // ✅ Bottom fixed white sheet
//     Align(
//     alignment: Alignment.bottomCenter,
//     child: Container(
//     decoration: const BoxDecoration(
//     borderRadius: BorderRadius.only(
//     topLeft: Radius.circular(24),
//     topRight: Radius.circular(24),
//     ),
//     color: Colors.transparent,
//     ),
//     child: Material(
//     color: Colors.white,
//     borderRadius: const BorderRadius.only(
//     topLeft: Radius.circular(24),
//     topRight: Radius.circular(24),
//     ),
//     child: StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) {
//     return Padding(
//     padding: EdgeInsets.only(
//     bottom: MediaQuery.of(context).viewInsets.bottom,
//     ),
//     child: Container(
//       height: MediaQuery.of(context).size.height * 0.2, // Half screen height
//     decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: const BorderRadius.only(
//     topLeft: Radius.circular(24),
//     topRight: Radius.circular(24),
//     ),
//     boxShadow: [
//     BoxShadow(
//     color: Colors.black.withOpacity(0.3),
//     blurRadius: 10,
//     spreadRadius: 5,
//     offset: const Offset(0, -4),
//     ),
//     ],
//     ),
//     child: Column(
//     mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Center(
//                     child: Container(
//                       padding: EdgeInsets.only(
//                         top: MediaQuery.of(context).size.height * 0.01,
//                         bottom: MediaQuery.of(context).size.height * 0.03,
//                         left: MediaQuery.of(context).size.height * 0.18,
//                         right: MediaQuery.of(context).size.height * 0.18,
//                       ),
//                       width: MediaQuery.of(context).size.width * 0.23,
//                       height: MediaQuery.of(context).size.height * 0.006,
//                       decoration: BoxDecoration(
//                         color: Color(0x2413678F),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.02,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Login to Continue?",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             overflow: TextOverflow.ellipsis,
//                             fontSize: MediaQuery.of(context).size.height * 0.02,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: MediaQuery.of(context).size.height * 0.03,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//
//                             Navigator.of(context).pop();
//                             if(popStatus)
//                               Navigator.of(context).pop();
//                           },
//                           child: Container(
//                             height: MediaQuery.of(context).size.height * 0.04,
//                             width: MediaQuery.of(context).size.height * 0.17,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: Color(0xFFA8B1CE),
//                                 width: 1,
//                               ),
//                             ),
//                             child: Text(
//                               "Close",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize:
//                                 MediaQuery.of(context).size.height * 0.014,
//                               ),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(builder: (context) => LoginPage()),
//                                     (Route<dynamic> route) => false);
//                           },
//                           child: Container(
//                             height: MediaQuery.of(context).size.height * 0.04,
//                             width: MediaQuery.of(context).size.height * 0.17,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: Color(0xFFD42620).withOpacity(0.5),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Text(
//                               "Okay",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize:
//                                 MediaQuery.of(context).size.height * 0.016,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//     ),
//     ),
//     );
//     },
//     ),
//     ),
//     ),
//     ),
//     ],
//     );
//     },
//     );
//   }
// }

class LoginBottomSheet {
  static void show(BuildContext context,bool popStatus) {
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
    transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 200),
    vsync: Navigator.of(context),
    ),
      context: context,
    builder: (BuildContext context) {
    return Stack(
    children: [
    // ✅ Background blur with outside tap-to-dismiss
    GestureDetector(
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    child: Container(
    color: Colors.transparent,
    width: double.infinity,
    height: double.infinity,
    ),
    ),
    ),

    // ✅ Bottom fixed white sheet
    Align(
    alignment: Alignment.bottomCenter,
    child: Container(
    decoration: const BoxDecoration(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(24),
    topRight: Radius.circular(24),
    ),
    color: Colors.transparent,
    ),
    child: Material(
    color: Colors.white,
    borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(24),
    topRight: Radius.circular(24),
    ),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.height * 0.18,
                        right: MediaQuery.of(context).size.height * 0.18,
                      ),
                      width: MediaQuery.of(context).size.width * 0.23,
                      height: MediaQuery.of(context).size.height * 0.006,
                      decoration: BoxDecoration(
                        color: Color(0x2413678F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login to Continue?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {

                            Navigator.of(context).pop();
                            if(popStatus)
                              Navigator.of(context).pop();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.height * 0.17,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xFFA8B1CE),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "Close",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.014,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => LoginPage()),
                                    (Route<dynamic> route) => false);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.height * 0.17,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFD42620).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              "Okay",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.016,
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
          );
        },
      ),
    ),),)]);
  }); }
}
