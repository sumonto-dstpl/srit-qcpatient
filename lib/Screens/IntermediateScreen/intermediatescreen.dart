import 'package:flutter/material.dart';
import 'package:newfolder/Screens/OnBoarding/onboarding_screen.dart';
import 'package:newfolder/Screens/Utils/customloader.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';

/**
 * Author: KrishnaBabuReddy
 */

class IntermediatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntermediatePagePageState();
}

class _IntermediatePagePageState extends State<IntermediatePage> {
  String? LoggedValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  Future<Null> getSharedPrefs() async {
    final storedloggedvalue = await UserSecureStorage.getIfLogged() ?? 'NO';
    setState(() {
      LoggedValue = storedloggedvalue;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (LoggedValue) {
      case "YES":
        return Container();
      // return NavigationHomeScreen("Main");
      case "NO":
        return OnboardingScreen();
      // return LoginScreen();
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          isLoading
              ? Center(
                  child: ColorLoader2(
                    color1: Colors.redAccent,
                    color2: Colors.deepPurple,
                    color3: Colors.green,
                  ),
                )
              : Stack(),
        ],
      ),
    );
  }
}
