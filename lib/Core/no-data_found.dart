import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height ;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/NoData.png',
          height:  height *0.340,
          width:  height *0.340, // Adjust the width of the image
        ),
        Container(
          padding: EdgeInsets.zero,
          child: Text(
            "No Data Found",
            style: TextStyle(
              fontSize:  height *0.016,
              color: Color(0xFF126086),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ) ;
  }

}