import 'package:flutter/material.dart';

class AppDeleteIcon extends StatelessWidget {
  final double iconSize;
  final bool isCenter ;

  const AppDeleteIcon({
    Key? key,
    this.iconSize = 20.0,
    this.isCenter = false ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,

        alignment: isCenter ? Alignment.center : Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal:isCenter ? 0 : 20),

        child: Image.asset(
          'assets/deleteicon.png',
          height: iconSize,
          width: iconSize,

        )
    );
  }
}

