import 'package:flutter/material.dart';

class AppointmentIconBadge extends StatefulWidget {
  final String appointmentcount;

  AppointmentIconBadge({Key? key, required this.appointmentcount})
      : super(key: key);

  @override
  _IconBadgeState createState() => _IconBadgeState();
}

class _IconBadgeState extends State<AppointmentIconBadge> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        /* Container(
          margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.height * 0.01,
            top: MediaQuery.of(context).size.height * 0.005,
            bottom: MediaQuery.of(context).size.height * 0.00,
            left: MediaQuery.of(context).size.height * 0.0,
          ),
          width: MediaQuery.of(context).size.height * 0.035,
          height: MediaQuery.of(context).size.height * 0.035,
          decoration: BoxDecoration(
            // color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/AddCarticon.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),*/

        Container(
          margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.height * 0.005,
            top: MediaQuery.of(context).size.height * 0.005,
            bottom: MediaQuery.of(context).size.height * 0.005,
            left: MediaQuery.of(context).size.height * 0.0,
          ),
          width: MediaQuery.of(context).size.height * 0.018,
          height: MediaQuery.of(context).size.height * 0.018,
          child: Image.asset(
            'assets/AddCarticon.png', // Path to your asset
            fit: BoxFit.contain, // Adjusts the icon to fit within the container
          ),
        ),

        /*  Icon(
          // Icons.g,
          Icons.add_card_sharp,
          size: MediaQuery.of(context).size.height * 0.050,
          color: Colors.white,
        ),*/
        Positioned(
          right: -3,
          top: 0,
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
              child: Text(
                "1",
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
      ],
    );
  }
}
