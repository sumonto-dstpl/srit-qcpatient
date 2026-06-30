import 'package:flutter/material.dart';

class AppDeleteIcon extends StatelessWidget {
  final double iconSize;

  const AppDeleteIcon({
    Key? key,
    this.iconSize = 15.0,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,

        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Image.asset(
          'assets/deleteicon.png',
          height: 20,
          width: 20,

        )
    );
  }
}

