import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:newfolder/Screens/Login/loginpage.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/custom_alert.dart';

class AuthFailed {
  showError(BuildContext context) async {
    SizeConfig().init(context);
    final double height = MediaQuery.of(context).size.height;

    await Future.delayed(const Duration(microseconds: 1));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false, // Prevent dismissing on back button
        child: CustomAlert(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF126086).withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(height * 0.01)),
            ),
            child: Padding(
              padding: EdgeInsets.all(height * 0.02),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.05),
                    child: Text(
                      "Please Sign-In Again ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF126086),
                        fontSize: height * 0.026,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          // await UserSecureStorage.setIfLoggedOut("YES");
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Container(
                          height: SizeConfig.blockSizeVertical! * 6,
                          width: SizeConfig.blockSizeVertical! * 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.3, 0.9],
                              colors: [Color(0xFF126086), Color(0xFF126086)],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Sign-In",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
