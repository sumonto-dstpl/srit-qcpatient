import 'package:flutter/material.dart';
import 'package:newfolder/Core/Data/dummy_data.dart';
import 'package:newfolder/Screens/Address/PreferredAddressLocation.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';

class Header extends StatelessWidget {
  final String userName;
  String? address ;
  final String? profileImage;
  final bool showBackButton;
  final bool showProfile;
  final bool showCartNotProfile ;

  Header({
    super.key,
    required this.userName,
      this.address = '',

    this.profileImage,

    this.showBackButton = true,
    this.showProfile = true ,
    this.showCartNotProfile = true,

  });

  @override
  Widget build(BuildContext context) {


    final h = MediaQuery.of(context).size.height ;
    final w = MediaQuery.of(context).size.width ;

    return Container(
      padding: EdgeInsets.only(
        top: h * 0.07,
        // left: w * 0.045,
        // right: w * 0.045,
        bottom: w * 0.06,
      ),
      margin: EdgeInsets.only(
        bottom: h * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: w * 0.045,),
          if(showBackButton)
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: h * 0.035,
              width: h * 0.035,
              margin: EdgeInsets.only(
                right: h * 0.02,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF126086).withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(width: 0.0, color: Color(0xFF126086)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(130.0),
                child: Image.asset(
                  'assets/medicationBack.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(



                  child: Text(
                    userName,
                    style: TextStyle(
                      fontSize:h * 0.018,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,

                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: h * 0.005,),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) {
                          return PreferredHospitalLocationScreen();
                        },
                      ),
                    );
                  },
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // Align items to the start
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          color: Colors.transparent,
                          child: ValueListenableBuilder<String>(
                            valueListenable: DummyData.hospitalLocationNotifier,
                            builder: (context, currentAddress, child) {
                              return Text(
                                currentAddress, // Ye variable hamesha latest location hold karega
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: h * 0.012,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                                softWrap: true,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.keyboard_arrow_down,

                          color: Colors.white,
                          size: h * 0.02, // Responsive size
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),


          // Action Bar 2nd half
          if(showCartNotProfile)
          Container(
            // color : Colors.yellow ,
            color : Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Cart
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) {
                          return AddToCartMain();
                        },
                      ),
                    );
                  },
                  child:
                  Container(
                    // color: Colors.green,
                    color: Colors.transparent,
                    child: AppointmentIconBadge(
                      appointmentcount: "",
                    ),
                  ),
                ),


                // Notification
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) {
                          return NotificationMain();
                        },
                      ),
                    );
                  },
                  child:
                  Container(
                    // color: Colors.red,
                    color: Colors.transparent,
                    child: IconBadge(
                      notificationcount: "",
                    ),
                  ),
                ),


                // Profile Image
                if(showProfile)
                  SizedBox(width:  w * 0.015, ),
                if(showProfile)
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProfileMain();
                          },
                        ),
                      );
                    }, child: Container(
                    height: h *
                        0.04,
                    width: h *
                        0.04,

                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.white,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(130.0),
                      child: Image.asset(
                        'assets/drsujeet.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  )

              ],
            ),
          ),

          SizedBox(width: showProfile ?  w * 0.045 : w * 0.025, ),
        ],
      ),
    );

  }

}