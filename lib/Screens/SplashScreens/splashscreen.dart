import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/IntermediateScreen/intermediatescreen.dart';
import 'package:newfolder/Screens/Login/loginpage.dart';
import 'package:newfolder/Screens/OnBoarding/onboarding_screen.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String AllReadyLoggedValue = "";
  String AllReadyLoggedOutValue = "";
  String LoggedGuestValue = "";
  String usertypevalue = "";

  startTimeout() {
    return Timer(Duration(seconds: 5), changeScreen);
  }

  changeScreen() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final prefUserLoggedInvalue = await UserSecureStorage.getIfLogged() ?? 'NO';
    final prefUserLoggedOutvalue =
        await UserSecureStorage.getIfLogged() ?? 'NO';
    final prefGuestUserLoggedInvalue =
        await UserSecureStorage.getIfGuestLogged() ?? 'NO';
    final prefusertypevalue = await UserSecureStorage.getUserType() ?? 'NA';

    setState(() {
      AllReadyLoggedValue = prefUserLoggedInvalue;
      AllReadyLoggedOutValue = prefUserLoggedOutvalue;
      LoggedGuestValue = prefGuestUserLoggedInvalue;
      usertypevalue =
          prefusertypevalue; // whether registered user / guest user etc...
      print(usertypevalue);
    });

    if (AllReadyLoggedValue == "YES" && AllReadyLoggedOutValue == "YES") {
      print(AllReadyLoggedValue);
      print(AllReadyLoggedOutValue);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else if (AllReadyLoggedValue == "YES") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePageMain()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.height * 0.00,
          right: MediaQuery.of(context).size.height * 0.00),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.030,
                  right: MediaQuery.of(context).size.height * 0.030),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Now display the GIF
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.090, // Set the height to match the text size
                    width: double
                        .infinity, // Set the width based on your requirements
                    child: Image.asset(
                      'assets/Logoanimation.gif', // Your GIF file
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    /* new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Expanded(
          child:  Container(color: Colors.white,),
          flex: 2,
        ),
        Expanded(
          flex: 5,
          child: Container(
              color: Colors.white,
              child: new Image.asset('assets/ysrsplash.png', fit: BoxFit.fill)),
        ),
        new Expanded(
          child: Container(color: Colors.white,),
          flex: 2,
        )
      ],
    );
*/

    /*  Container(
        child: new Image.asset('assets/Splashscreen_image.png', fit: BoxFit.fill));*/
  }
}
