import 'package:flutter/material.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';


class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen height yahan calculate kar lein
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.07,
      width: screenHeight * 0.07,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white, // Padding color (background ring)
      ),
      child: Padding(
        padding: EdgeInsets.all(screenHeight * 0.008),
        child: FloatingActionButton(
          heroTag: null, // Ye bahut zaruri hai taaki Hero animation ke errors na aayein jab ye multiple screens par ho
          backgroundColor: const Color(0xFF126086),
          elevation: 0.0,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return  UploadPrescriptionMain(); // Ensure the class name matches
                },
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(screenHeight * 0.008),
            width: screenHeight * 0.03,
            height: screenHeight * 0.03,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Upload.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}