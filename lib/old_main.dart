import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/APIServices/MyHttpOverrides.dart';
import 'package:newfolder/Screens/SplashScreens/splashscreen.dart';
import 'dart:io';

// Author: KrishnaBabuReddy

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF126086),
    ));

    return MaterialApp(
      title: "QC Patient",
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent, // Remove splash color globally
        highlightColor: Colors.transparent, // Remove highlight color globally
      ),

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: SplashScreen(),
    );
  }
}
