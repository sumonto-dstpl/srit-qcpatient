import 'package:flutter/material.dart';

class IconBadge extends StatefulWidget {
  final String notificationcount;

  IconBadge({Key? key, required this.notificationcount}) : super(key: key);

  @override
  _IconBadgeState createState() => _IconBadgeState();
}

class _IconBadgeState extends State<IconBadge> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.height * 0.022,
            top: MediaQuery.of(context).size.height * 0.005,
            bottom: MediaQuery.of(context).size.height * 0.005,
            left: MediaQuery.of(context).size.height * 0.022,
          ),
          width: MediaQuery.of(context).size.height * 0.0205,
          height: MediaQuery.of(context).size.height * 0.0205,
          child: Image.asset(
            'assets/notificationicon.png', // Path to your asset
            fit: BoxFit.contain, // Adjusts the icon to fit within the container
          ),
        ),
        Positioned(
          right: 15,
          top : 0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(9),
            ),
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.height * 0.015,
              minHeight: MediaQuery.of(context).size.height * 0.015,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2)),
                child: Text(
                  "12",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.008,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
