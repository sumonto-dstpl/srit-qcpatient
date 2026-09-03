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
    // 🌟 FAST & OPTIMIZED: showDialog ka use kiya gaya hai bina heavy animations ke
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5), // Blur ki jagah dim background (No Glitch)
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .02,
                vertical: screenHeight * .02,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Jisko jitni jagah chahiye utni hi lega
                children: [
                  // 🔻 Emergency Info Card
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.01),
                    height: screenHeight * 0.06,
                    width: screenHeight * 0.06,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(251, 234, 233, 1.0),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        icon,
                        fit: BoxFit.contain,
                        width: screenHeight * 0.03,
                        height: screenHeight * 0.03,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenHeight * 0.02,
                    ),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF6A6E83),
                        fontWeight: FontWeight.w400,
                        fontSize: screenHeight * 0.02,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  // Buttons Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              negativeText,
                              style: const TextStyle(color: Colors.black87, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: positiveButtonColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              positiveText,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}