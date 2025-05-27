


import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = (screenHeight! / 100);
  }
}


// use below code at spectific widgets
/*
SizeConfig().init(context);// declare at build method
height: SizeConfig.blockSizeVertical * 20,
width: SizeConfig.blockSizeHorizontal * 50,*/




// Use Below for Text Widget
/*
MediaQueryData queryData;//at Global declaration

// Below @ Build method

queryData = MediaQuery.of(context);
double devicePixelRatio = queryData.devicePixelRatio;
TextStyle style38 = new TextStyle(
  inherit: true,
  fontSize: 38.0,
);
TextStyle style20 = new TextStyle(
  inherit: true,
  fontSize: 20.0,
);*/

