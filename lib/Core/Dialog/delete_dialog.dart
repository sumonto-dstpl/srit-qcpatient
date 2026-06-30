import 'dart:ui';
import 'package:flutter/material.dart';

class DeleteDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String message,

    String positiveText = "Delete",
    String negativeText = "Cancel",

    Color positiveButtonColor = const Color(0xFFC60000),

    String icon = "assets/Error_ls.png",
    String barrierLabel = ''
  }) {
    return showGeneralDialog(
      barrierLabel: barrierLabel,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),

            Center(
              child: StatefulBuilder(

                builder: (context, setState) {
                   return WillPopScope(
                     onWillPop: () async => false,
                     child: Dialog(
                       backgroundColor: Colors.white,

                       insetPadding: EdgeInsets.symmetric(
                           horizontal: MediaQuery
                               .of(context)
                               .size
                               .width * 0.08),

                       child: LayoutBuilder(

                         builder: (context, constraints){
                           return ConstrainedBox(
                             constraints: BoxConstraints(
                               maxHeight: MediaQuery
                                   .of(context)
                                   .size
                                   .height * 0.9,
                             ),
                             child: Container(
                               padding: EdgeInsets.symmetric(
                                 horizontal: screenWidth * .02,
                                 vertical: screenHeight * .02,
                               ),

                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 boxShadow: [
                                   BoxShadow(
                                     color: Color(0xFFD9D9D9),
                                     blurRadius: 100,

                                   ),
                                 ],
                                 borderRadius: BorderRadius.circular(10),
                               ),

                               child: IntrinsicHeight(
                                 child: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [

                                     // 🔻 Emergency Info Card
                                     Container(
                                       margin: EdgeInsets.symmetric(
                                         horizontal: screenWidth * 0.015,
                                         vertical: screenHeight * 0.003,
                                       ),
                                       padding: EdgeInsets.symmetric(
                                         horizontal: screenWidth * 0.0,
                                         vertical: screenHeight * 0.005,
                                       ),
                                       child: Column(
                                         children: [

                                           Container(
                                             height:
                                             MediaQuery
                                                 .of(context)
                                                 .size
                                                 .height * 0.06,
                                             width: MediaQuery
                                                 .of(context)
                                                 .size
                                                 .height * 0.06,
                                             decoration: const BoxDecoration(
                                               // color: Color(0xFFFBEAE9),
                                               color: Color.fromRGBO(251, 234, 233,
                                                   1.0), // Same color with full opacity

                                               shape: BoxShape.circle,
                                             ),

                                             child: Center(
                                               child: Image.asset(
                                                 'assets/Error_ls.png',
                                                 fit: BoxFit.contain,
                                                 width: MediaQuery
                                                     .of(context)
                                                     .size
                                                     .height *
                                                     0.03,
                                                 height: MediaQuery
                                                     .of(context)
                                                     .size
                                                     .height *
                                                     0.03,
                                               ),
                                             ),

                                           ),


                                           Container(

                                             padding: EdgeInsets.symmetric(
                                               vertical: screenHeight * 0.01,
                                               horizontal: screenHeight * 0.04,
                                             ),
                                             child: Text(
                                               message,
                                               textAlign: TextAlign.center,
                                               style: TextStyle(
                                                 color: Color(0xFF6A6E83),
                                                 fontWeight: FontWeight.w400,
                                                 fontSize: screenHeight * 0.02,
                                               ),
                                             ),
                                           ),

                                         ],
                                       ),
                                     ),


                                     SizedBox(height: screenHeight * 0.01,),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                       child: Row(
                                         children: [
                                           Expanded(
                                             child: OutlinedButton(
                                               onPressed: () => Navigator.pop(context,false),
                                               style: OutlinedButton.styleFrom(
                                                 padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(24),
                                                 ),
                                               ),
                                               child:   Text(
                                                 negativeText,
                                                 style: TextStyle(color: Colors.black87, fontSize: 14),
                                               ),
                                             ),
                                           ),
                                           const SizedBox(width: 12),
                                           Expanded(
                                             child: ElevatedButton(
                                               onPressed: () => Navigator.pop(context,true),
                                               style: ElevatedButton.styleFrom(
                                                 backgroundColor: const Color(0xFFC60000),
                                                 padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(24),
                                                 ),
                                               ),
                                               child:   Text(
                                                 positiveText,
                                                 style: TextStyle(color: Colors.white, fontSize: 14),
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                     SizedBox(height: screenHeight * 0.01,),
                                   ],
                                 ),
                               ),
                             ),
                           ) ;
                         },
                       ),
                     ),
                   ) ;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}