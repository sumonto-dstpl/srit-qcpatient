import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';


class NotificationMain extends StatefulWidget {
  final int initialTabIndex;

    NotificationMain(
        {
          Key? key,
          this.initialTabIndex = 0
        }

    ) : super(key: key);



  @override
  State<NotificationMain> createState() => NotificationMainstate();
}

class NotificationMainstate extends State<NotificationMain> with SingleTickerProviderStateMixin{
  String usernameValue = "My Health";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;













  String notificationSelectedFilter = "All" ;
  String allSelectedFilter = "All";


  final List<Map<String, dynamic>> dataList = [
    {
      "id": 0,
      "date": "2025-10-10",
      "time": "10:30 AM",
      "image": "assets/NutanBhatt.png",
      "title": "Appointments",
      "subtitle1": "Dr. Sharma",
      "subtitle2": "Dental Checkup",
      "buttonSelected": "Appointments",
      "markAllRead" : false,
    },
    {
      "id": 1,
      "date": "2025-10-10",
      "time": "12:00 PM",
      "image": "assets/profileProfile1.png",
      "title": "Test & Service",
      "subtitle1": "Blood Test",
      "subtitle2": "PathLab",
      "buttonSelected": "Reports",
      "markAllRead" : true,
    },
    {
      "id": 2,
      "date": "2025-10-10",
      "time": "11:30 AM",
      "image": "assets/NutanBhatt.png",
      "title": "Appointments",
      "subtitle1": "Dr. Sharma",
      "subtitle2": "Dental Checkup",
      "buttonSelected": "Appointments",
      "markAllRead" : true,
    },
    {
      "id": 3,
      "date": "2025-10-10",
      "time": "12:00 PM",
      "image": "assets/profileProfile1.png",
      "title": "Test & Service",
      "subtitle1": "Blood Test",
      "subtitle2": "PathLab",
      "buttonSelected": "Reports",
      "markAllRead" : true,
    },
    {
      "id": 4,
      "date": "2025-10-09",
      "time": "9:00 AM",
      "image": "assets/NutanBhatt.png",
      "title": "Appointments",
      "subtitle1": "Eye Checkup",
      "subtitle2": "Dr. Mehta",
      "buttonSelected": "Appointments",
      "markAllRead" : false,
    },

    {
      "id": 5,
      "date": "2025-10-09",
      "time": "10:30 AM",
      "image": "assets/NutanBhatt.png",
      "title": "Appointments",
      "subtitle1": "Dr. Sharma",
      "subtitle2": "Dental Checkup",
      "buttonSelected": "Appointments",
      "markAllRead" : true,
    },
    {
      "id": 6,
      "date": "2025-10-09",
      "time": "12:00 PM",
      "image": "assets/profileProfile1.png",
      "title": "Test & Service",
      "subtitle1": "Blood Test",
      "subtitle2": "PathLab",
      "buttonSelected": "Reports",
      "markAllRead" : true,
    },

    {
      "id": 7,
      "date": "2025-10-08",
      "time": "10:30 AM",
      "image": "assets/NutanBhatt.png",
      "title": "Appointments",
      "subtitle1": "Dr. Sharma",
      "subtitle2": "Dental Checkup",
      "buttonSelected": "Appointments",
      "markAllRead" : true,
    },
    {
      "id": 8,
      "date": "2025-10-08",
      "time": "12:00 PM",
      "image": "assets/profileProfile1.png",
      "title": "Test & Service",
      "subtitle1": "Blood Test",
      "subtitle2": "PathLab",
      "buttonSelected": "Reports",
      "markAllRead" : true,
    },
    {
      "id": 9,
      "date": "2025-10-08",
      "time": "10:30 AM",
      "image": "assets/NutanBhatt.png",
      "title": "Appointments",
      "subtitle1": "Dr. Sharma",
      "subtitle2": "Dental Checkup",
      "buttonSelected": "Appointments",
      "markAllRead" : true,
    },
    {
      "id": 10,
      "date": "2025-10-08",
      "time": "12:00 PM",
      "image": "assets/profileProfile1.png",
      "title": "Test & Service",
      "subtitle1": "Blood Test",
      "subtitle2": "PathLab",
      "buttonSelected": "Reports",
      "markAllRead" : true,
    },
  ];
  DateTime today = DateTime.now();



  int allCount = 0;
  int offerCount = 3;
  int notificationCount = 0;
  late TabController _tabController; // 👈 yahan define kiya

  int selectedTabIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCount = offerCount + dataList.length;

    notificationCount = dataList.length;
    _tabController = TabController(length: 3, vsync: this); // 3 tabs

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
         selectedTabIndex =  _tabController.index;
        });
      }
    });

  }


  @override
  Widget build(BuildContext context) {

    print("dataList : $dataList");

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

    DateTime today = DateTime.now();



    Map<String, List<Map<String, dynamic>>> notificationGroupedData = getNotificationFilteredGroupedData();
    List<String>  notificationUniqueDates = notificationGroupedData.keys.toList();
    notificationUniqueDates.sort((a, b) {
        DateTime dateA = DateTime.parse(a);
        DateTime dateB = DateTime.parse(b);
        if (dateA.isAtSameMomentAs(today)) return -1;
        if (dateB.isAtSameMomentAs(today)) return 1;
        return dateB.compareTo(dateA);
      });

    Map<String, List<Map<String, dynamic>>> allGroupedData = getAllFilteredGroupedData();
    List<String>  allUniqueDates = allGroupedData.keys.toList();
    allUniqueDates.sort((a, b) {
      DateTime dateA = DateTime.parse(a);
      DateTime dateB = DateTime.parse(b);
      if (dateA.isAtSameMomentAs(today)) return -1;
      if (dateB.isAtSameMomentAs(today)) return 1;
      return dateB.compareTo(dateA);
    });






    List idList = [];
    return
      DefaultTabController(
        length: 3,
        initialIndex: widget.initialTabIndex,
        child:

        Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),
        child: Stack(children: [
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  bottom: screenWidth * 0.02,
                ),
                margin: EdgeInsets.only(
                  right: screenHeight * 0.0,
                  top: screenHeight * 0.0,
                  bottom: screenHeight * 0.01,
                  left: screenHeight * 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ),

              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.00),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.03),
                      topRight: Radius.circular(screenHeight * 0.03),
                    ),
                  ),
                  child: Column(
                    children: [


                      Container(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.0,
                          left: screenWidth * 0.0,
                          right: screenWidth * 0.0,
                          bottom: screenWidth * 0.01,
                        ),
                        margin: EdgeInsets.only(
                          right: screenHeight * 0.0,
                          top: screenHeight * 0.03,
                          bottom: screenHeight * 0.0,
                          left: screenHeight * 0.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height * 0.01,
                                ),
                                height: screenHeight * 0.035,
                                width: screenHeight * 0.035,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7F5F6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: Color(0xFF999999),
                                  size: screenHeight * 0.018,
                                ),
                              ),
                            ),

                            // Help Text (Centered)
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Notification",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.018,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            // Placeholder to Balance Row (Keeps Help Text Centered)
                            SizedBox(width: screenHeight * 0.035),

                          ],
                        )
                        ,
                      ),



                      // TabBar Section
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.04,
                            right:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.04,
                            bottom:
                            MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.045,
                        decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                          color: Color(0x66D9D9D9),
                          border: Border.all(
                             // Add a red border
                            color: Color(0x66D9D9D9),// Red color for the border
                            width: 0.5, // Border width
                          ),
                        ),
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),),
                          child: TabBar(
                            padding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            controller: _tabController,
                              onTap: (index) {
                                setState(() {
                                  selectedTabIndex = index;
                                });
                              },
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            labelColor: Color(0xFF126086),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.0135
                            ),
                            unselectedLabelColor: Color(0xB2000000),
                            unselectedLabelStyle:
                            TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.0135
                            ),
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "All",
                                    ),
                                    if (selectedTabIndex == 0)
                                      Text(" ($allCount)")
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Offers",
                                    ),
                                    if (selectedTabIndex == 1)
                                      Text(" ($offerCount)")
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Notificitation",
                                    ),
                                    if (selectedTabIndex == 2)
                                      Text(" ($notificationCount)")
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),

                      // TabBarView Section
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
  height: double
      .infinity,

  width: double
      .infinity,

  color: Colors
      .white,
  child: Column(
    children: [
      // 🔘 Toggle buttons
      Container(

        child: Padding(
          padding:  EdgeInsets.only(
            left:screenHeight * 0.015,
            right:screenHeight * 0.015,
            top :   screenHeight * 0.01,

          ),
          child: Row(
            children: [
              Text(
                "Filter By",
                style: TextStyle(
                    color : Color(0xFF126086),
                    fontSize: screenHeight * 0.014
                ),
              ),
              Row(

                children: [
                  _allBuildTypeButton("Appointments"),
                  SizedBox(width: 10),
                  _allBuildTypeButton("Reports"),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: allUniqueDates.length,
          itemBuilder: (context,index){


            String dateKey = allUniqueDates[index];
            List<Map<String, dynamic>> items = allGroupedData[dateKey]!;

            List<int> idsToMark = items.map((e) => e["id"] as int).toList();

            idList.addAll(idsToMark);

            bool isToday = dateKey ==
                DateFormat('yyyy-MM-dd').format(today);
            String formattedDate = isToday
                ? "Today, ${DateFormat('MMM d').format(today)}"
                : DateFormat('MMM d, yyyy')
                .format(DateTime.parse(dateKey));




            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container
                      (
                      margin : EdgeInsets.only(
                        left : screenHeight * 0.015,
                      ),
                      child: Text(
                        formattedDate,
                        style: TextStyle(color : Color(0xFF1F1F1F),
                            fontSize: screenHeight * 0.014, fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (index == 0)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            for(var id in idList){

                              dataList[id]['markAllRead'] = false;

                            }
                          });

                        },
                        child: Text(
                            "Mark all Read",
                            style : TextStyle(
                              color : Color(0xFF126086),
                              fontSize: screenHeight * 0.012,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                      ),
                  ],
                ),
                if(index == 0 )
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: screenHeight * 0.02,
                        top: screenHeight * 0.01,
                        bottom: screenHeight * 0.01,
                        left: screenHeight * 0.02,
                      ), // Re

                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(

                            topLeft: Radius.circular(15),
                            topRight : Radius.circular(15),
                            bottomLeft: Radius.circular(15), // Set the curve radius
                            bottomRight: Radius.circular(15),
                          ),

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                right: screenHeight * 0.0,
                                top: screenHeight * 0.0,
                                bottom: screenHeight * 0.0,
                                left: screenHeight * 0.0,
                              ), // Responsive margin
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.14,
                              decoration: BoxDecoration(
                                /*color: Color(
                        0xFFC80000), */// Fallback color if image fails to load
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/B1_ls.png'), // Path to your banner image
                                  fit: BoxFit.fill, // Adjust to cover the entire container
                                ),


                              ),
                              child: Row(
                                children: <Widget>[

                                  Flexible(
                                    flex: 7, // 6 out of 10 for the text section
                                    child: Container(

                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height * 0.00,
                                          right: MediaQuery.of(context).size.height * 0.00,
                                          bottom: MediaQuery.of(context).size.height * 0.0,
                                          top: MediaQuery.of(context).size.height * 0.01),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Container(
                                            padding: EdgeInsets.only(
                                              top: screenHeight * 0.0,
                                              bottom: screenHeight * 0.00,
                                              left: screenHeight * 0.02,
                                              right: screenHeight * 0.00,
                                            ),
                                            child: Text(
                                              "Do not ignore your symptoms!",
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.015,
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: screenHeight * 0.0,
                                              bottom: screenHeight * 0.0,
                                              left: screenHeight * 0.02,
                                              right: screenHeight * 0.00,
                                            ),
                                            child: Text(
                                              "Find out what could be causing them ",
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: screenHeight * 0.011,
                                                color: Colors.white,
                                                fontWeight : FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                              left : screenHeight * 0.02,
                                            ),

                                            child: Row(
                                              children: [
                                                Container(
                                                  padding : EdgeInsets.symmetric(
                                                    vertical : screenHeight * 0.005,
                                                    horizontal : screenHeight * 0.005,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color : Color(0x40FFFFFF),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft : Radius.circular(2),
                                                        bottomLeft : Radius.circular(8),
                                                        topRight : Radius.circular(8),
                                                        bottomRight : Radius.circular(2),
                                                      )
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          "START ASSESSMENT",
                                                          style : TextStyle(
                                                            fontSize: screenHeight * 0.0085,
                                                            color : Color(0xFFFFFFFF),
                                                            fontWeight: FontWeight.w600,
                                                          )
                                                      ),
                                                      SizedBox(width :MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.008,  ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.01, // Dynamic icon size
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width : screenHeight * 0.005),
                                                Text(
                                                    "Offer Vali: 12/12/2020 - 12/12/2025",
                                                    style : TextStyle(
                                                      fontSize: screenHeight * 0.0085,
                                                      color : Color(0xFFFFFFFF),
                                                      fontWeight: FontWeight.w600,
                                                    )
                                                ),
                                              ],
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2, // 6 out of 10 for the text section
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(
                                      15), // Apply curved corners here
                                  bottomLeft: Radius.circular(15),
                                ),
                                border: Border(
                                  left: BorderSide(color: Color(0x1A000000), width: 0.5),
                                  right: BorderSide(color: Color(0x1A000000), width: 0.5),
                                  bottom: BorderSide(color: Color(0x1A000000), width: 0.5),
                                ),

                              ),
                              child:GestureDetector(
                                onTap: () {},
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(

                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[

                                            Container(
                                              padding:
                                              EdgeInsets.only(
                                                left: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                              ),
                                              child:   Container(
                                                margin: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.height * 0.01,
                                                  right: MediaQuery.of(context).size.height * 0.008,
                                                  top: MediaQuery.of(context).size.height * 0.0,
                                                  bottom: MediaQuery.of(context).size.height * 0.0,
                                                ),
                                                height: MediaQuery.of(context).size.height * 0.017,
                                                width: MediaQuery.of(context).size.height * 0.02,
                                                child:
                                                Image.asset(
                                                  'assets/notificaiocn.png',
                                                  fit:
                                                  BoxFit.fill,
                                                ),
                                              ),

                                            ),


                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.010),
                                            Expanded(
                                              flex: 8,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      bottom: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                    ),
                                                    child: Text(
                                                      "Reported Symptoms",
                                                      style: TextStyle(
                                                        color: Color(0xFF6A6E83),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.011,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Adding the side arrow at the end

                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.00,
                                                right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01,
                                                top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                                bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                              ),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01, // Dynamic icon size
                                                color: Color(0xFF6A6E83),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ),








                          ],
                        ),
                      ),
                    ),


                    // violet
                    Container(
                      margin: EdgeInsets.only(
                        right: screenHeight * 0.02,
                        top: screenHeight * 0.0,
                        bottom: screenHeight * 0.01,
                        left: screenHeight * 0.02,
                      ), // Responsive margin
                      height:  MediaQuery
                          .of(context)
                          .size
                          .height * 0.14,
                      decoration: BoxDecoration(
                        color: Color(
                            0xFFC80000), // Fallback color if image fails to load
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/B3_ls.png'), // Path to your banner image
                          fit: BoxFit.fill,
                          // Adjust to cover the entire container
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.0),
                            offset: Offset(0, 4),
                            blurRadius: 9,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Row(
                          children: <Widget>[
                            // Flexible(
                            //   flex: 6, // 6 out of 10 for the text section
                            //   child: Padding(
                            //     padding: EdgeInsets.all(MediaQuery
                            //         .of(context)
                            //         .size
                            //         .height * 0.005),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: <Widget>[
                            //
                            //         Container(
                            //           padding: EdgeInsets.only(
                            //             top: screenHeight * 0.01,
                            //             bottom: screenHeight * 0.00,
                            //             left: screenHeight * 0.01,
                            //             right: screenHeight * 0.02,
                            //           ),
                            //           child: ShaderMask(
                            //             shaderCallback: (Rect bounds) {
                            //               return LinearGradient(
                            //                 begin: Alignment.centerLeft,
                            //                 end: Alignment.centerRight,
                            //                 colors: [Color(0xFFFFB300), Color(0xFFF9F3E5)],
                            //                 tileMode: TileMode.clamp,
                            //               ).createShader(bounds);
                            //             },
                            //             child: Text(
                            //               "Caring for you, every step of the way",
                            //               style: TextStyle(
                            //                 fontSize: screenHeight * 0.018,
                            //                 color: Colors.white, // This color will be overridden by the gradient
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //               textAlign: TextAlign.left,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Flexible(
                              flex: 6, // 6 out of 10 for the text section
                              child: Padding(
                                padding: EdgeInsets.all( screenHeight * 0.02),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Container(
                                      padding: EdgeInsets.only(
                                        top: screenHeight * 0.01,
                                        bottom: screenHeight * 0.00,
                                        left: screenHeight * 0.00,
                                        right: screenHeight * 0.00,
                                      ),
                                      child:
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [Color(0xFFFFB300), Color(0xFFF9F3E5)],
                                            tileMode: TileMode.clamp,
                                          ).createShader(bounds);
                                        },
                                        child: Text(
                                          "Caring for you, every step of the way",
                                          style: TextStyle(
                                              fontSize: screenHeight * 0.019,
                                              color: Colors.white,
                                              fontWeight : FontWeight.w700// This color will be overridden by the gradient                fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4, // 6 out of 10 for the text section
                              child: Container(),
                            ),
                          ],
                        ),
                          Positioned(
                            left : 0,
                            bottom : 20,
                            child: Center(
                              child: Container(

                                padding: EdgeInsets.only(
                                  top : screenHeight * 0.005,
                                  bottom : screenHeight * 0.005,
                                  left : screenHeight * 0.01,
                                  right : screenHeight * 0.04,
                                ),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFB793B6),
                                          Color(0x00737373)
                                        ]
                                    )
                                ),
                                child: Text(
                                  "Ad",
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.01,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFFFFFFF)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                    // Red Card
                    Container(
                      margin: EdgeInsets.only(
                        right: screenHeight * 0.02,
                        top: screenHeight * 0.0,
                        bottom: screenHeight * 0.0,
                        left: screenHeight * 0.02,
                      ),// Responsive margin
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.14,
                      decoration: BoxDecoration(
                        color: Color(
                            0xFFC80000), // Fallback color if image fails to load
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/B2_ls.png'), // Path to your banner image
                          fit: BoxFit.fill,

                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.0),
                            offset: Offset(0, 4),
                            blurRadius: 9,
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 4, // 6 out of 10 for the text section
                            child: Container(),
                          ),
                          Flexible(
                            flex: 6, // 6 out of 10 for the text section
                            child: Padding(
                              padding: EdgeInsets.only(
                                top : screenHeight * 0.02,
                                left : screenHeight * 0.02,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.01,
                                      bottom: screenHeight * 0.00,
                                      left: screenHeight * 0.00,
                                      right: screenHeight * 0.00,
                                    ),
                                    child: Text(
                                      "Patient Mobile App",
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: screenHeight * 0.014,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.00,
                                      bottom: screenHeight * 0.00,
                                      left: screenHeight * 0.00,
                                      right: screenHeight * 0.00,
                                    ),
                                    child: Text(
                                      "Caring for you, every step of the way",
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.018,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(

                                      padding: EdgeInsets.only(
                                        right : screenHeight * 0.015,
                                        bottom : screenHeight * 0.005,
                                      ),
                                      child : Text(
                                        "Offer Validity: 12/12/2020 - 12/12/2025",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.008,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      alignment: Alignment.bottomRight,
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ...items.map((item){


                  return Dismissible(
                    key : UniqueKey(),
                    direction: DismissDirection.endToStart, // Allow swipe from right to left
                    background: Container(
                      color: Colors.white,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    onDismissed: (direction) {

                      print('id : ${item['id']}');

                      Future.delayed(Duration(milliseconds: 300), () {
                        // if (index < dataList.length) {
                        //   setState(() {
                        //     dataList.removeAt(index);
                        //   });
                        // }

                        if(index < dataList.length){
                          setState(() {
                            dataList.removeWhere((itemList) => itemList['id'] == item['id']);
                          });
                        }

                      });







                    },

                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin:
                                Alignment.centerLeft,
                                end:
                                Alignment.centerRight,
                                stops: [
                                  0.5,
                                  0.9
                                ],
                                colors: [
                                  Color(
                                      0xFFE8F0F3)
                                      .withOpacity(
                                      0.5),
                                  Color(
                                      0xFFE8F0F3)
                                      .withOpacity(
                                      0.5),
                                ],)),
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.01,
                              right: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.01,
                              bottom: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.0,
                              top: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.00),
                          child: Container(



                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.00,
                                right: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.00,
                                bottom: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.00,
                                top: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.00),
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.005,
                                right: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.005,
                                bottom: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.005,
                                top: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.005),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left:
                                    MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    right:
                                    MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.015,
                                    top:
                                    MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    bottom:
                                    MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.005,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Container(
                                        height : MediaQuery.of(context).size.height * 0.05,
                                        width :  MediaQuery.of(context).size.height * 0.05,


                                        padding:
                                        EdgeInsets.only(
                                          left: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.00,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              130.0),
                                          child:
                                          Image.asset(
                                              item["image"],
                                              fit:
                                              BoxFit.fill,
                                              width: 40, height: 40
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .height *
                                              0.015),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Container(
                                              margin : EdgeInsets.only(
                                                top : MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.01,
                                              ),
                                              padding:
                                              EdgeInsets
                                                  .only(
                                                left: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                                right: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                                top: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.0,
                                                bottom: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                              ),
                                              child: Text(
                                                item["title"],
                                                style:
                                                TextStyle(
                                                  color: Color(0xFF126086),
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.012,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(

                                                  margin : EdgeInsets.only(
                                                    top : MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.005,
                                                  ),
                                                  padding:
                                                  EdgeInsets
                                                      .only(
                                                    left: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    right: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                    top: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.0,
                                                    bottom: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.00,
                                                  ),
                                                  child: Text(
                                                    "Duration: 6 Days : Intensity: Severe, Onset/Time course: Acute : ",
                                                    style:
                                                    TextStyle(
                                                      color: Color(0xFF126086).withOpacity(0.7),
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,

                                                      fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.009,
                                                      fontWeight : FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                if(item['markAllRead'])
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                              EdgeInsets
                                                  .only(
                                                left: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                                right: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                                top: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                                bottom: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .height *
                                                    0.00,
                                              ),
                                              child: Text(
                                                "Radiation of Pain: Chest Associated Symptoms:",
                                                style:
                                                TextStyle(
                                                  color: Color(0xFF126086).withOpacity(0.7),
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,

                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.009,
                                                  fontWeight : FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context).size.height * 0.00,
                                                right: MediaQuery.of(context).size.height * 0.00,
                                                top: MediaQuery.of(context).size.height * 0.00,
                                                bottom: MediaQuery.of(context).size.height * 0.00,
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional.centerEnd, // Align text to the end
                                                child: Text(
                                                  item["time"],
                                                  style : TextStyle(
                                                    color: Color(0xFF126086),
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,

                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.009,
                                                    fontWeight : FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      // Adding the side arrow at the end




                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            );

          },

        ),
      ),
    ],
  ),
),



                            Container(
  height: double
      .infinity,
  // Ensures it occupies full height
  width: double
      .infinity,
  // Ensures it occupies full width
  color: Colors
      .white,
  // You can change the background color
  child: MediaQuery(
  data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),),
    child: ListView(
        padding: EdgeInsets.zero,
      shrinkWrap:
      true,

      children: [


        Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: screenHeight * 0.005,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container (

                margin : EdgeInsets.only(
                  left : screenHeight * 0.015,
                ),
                child: Text(
                  "Today Jan 20",
                  style: TextStyle(color : Color(0xFF1F1F1F),
                      fontSize: screenHeight * 0.014, fontWeight: FontWeight.w500),
                ),
              ),

                TextButton(
                  onPressed: () {
                    setState(() {
                      for(var id in idList){

                        dataList[id]['markAllRead'] = false;

                      }
                    });

                  },
                  child: Text(
                      "Mark all Read",
                      style : TextStyle(
                        color : Color(0xFF126086),
                        fontSize: screenHeight * 0.012,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ),
            ],
          ),
        ),


        Container(
          margin: EdgeInsets.only(
            right: screenHeight * 0.02,
            top: screenHeight * 0.01,
            bottom: screenHeight * 0.01,
            left: screenHeight * 0.02,
          ), // Re

          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(

                topLeft: Radius.circular(15),
                topRight : Radius.circular(15),
                bottomLeft: Radius.circular(15), // Set the curve radius
                bottomRight: Radius.circular(15),
              ),

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    right: screenHeight * 0.0,
                    top: screenHeight * 0.0,
                    bottom: screenHeight * 0.0,
                    left: screenHeight * 0.0,
                  ), // Responsive margin
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.14,
                  decoration: BoxDecoration(
                    /*color: Color(
                        0xFFC80000), */// Fallback color if image fails to load
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/B1_ls.png'), // Path to your banner image
                      fit: BoxFit.fill, // Adjust to cover the entire container
                    ),


                  ),
                  child: Row(
                    children: <Widget>[

                      Flexible(
                        flex: 7, // 6 out of 10 for the text section
                        child: Container(

                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.0,
                              top: MediaQuery.of(context).size.height * 0.01),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.0,
                                  bottom: screenHeight * 0.00,
                                  left: screenHeight * 0.02,
                                  right: screenHeight * 0.00,
                                ),
                                child: Text(
                                  "Do not ignore your symptoms!",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.015,
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.0,
                                  bottom: screenHeight * 0.0,
                                  left: screenHeight * 0.02,
                                  right: screenHeight * 0.00,
                                ),
                                child: Text(
                                  "Find out what could be causing them ",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: screenHeight * 0.011,
                                    color: Colors.white,
                                    fontWeight : FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  left : screenHeight * 0.02,
                                ),

                                child: Row(
                                  children: [
                                    Container(
                                      padding : EdgeInsets.symmetric(
                                        vertical : screenHeight * 0.005,
                                        horizontal : screenHeight * 0.005,
                                      ),
                                      decoration: BoxDecoration(
                                          color : Color(0x40FFFFFF),
                                          borderRadius: BorderRadius.only(
                                            topLeft : Radius.circular(2),
                                            bottomLeft : Radius.circular(8),
                                            topRight : Radius.circular(8),
                                            bottomRight : Radius.circular(2),
                                          )
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              "START ASSESSMENT",
                                              style : TextStyle(
                                                fontSize: screenHeight * 0.0085,
                                                color : Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.w600,
                                              )
                                          ),
                                          SizedBox(width :MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.008,  ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01, // Dynamic icon size
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width : screenHeight * 0.005),
                                    Text(
                                        "Offer Vali: 12/12/2020 - 12/12/2025",
                                        style : TextStyle(
                                          fontSize: screenHeight * 0.0085,
                                          color : Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w600,
                                        )
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2, // 6 out of 10 for the text section
                        child: Container(),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(
                          15), // Apply curved corners here
                      bottomLeft: Radius.circular(15),
                    ),
                    border: Border(
                      left: BorderSide(color: Color(0x1A000000), width: 0.5),
                      right: BorderSide(color: Color(0x1A000000), width: 0.5),
                      bottom: BorderSide(color: Color(0x1A000000), width: 0.5),
                    ),

                  ),
                  child:GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(

                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                  padding:
                                  EdgeInsets.only(
                                    left: MediaQuery.of(
                                        context)
                                        .size
                                        .height *
                                        0.00,
                                  ),
                                  child:   Container(
                                    margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.01,
                                      right: MediaQuery.of(context).size.height * 0.008,
                                      top: MediaQuery.of(context).size.height * 0.0,
                                      bottom: MediaQuery.of(context).size.height * 0.0,
                                    ),
                                    height: MediaQuery.of(context).size.height * 0.017,
                                    width: MediaQuery.of(context).size.height * 0.02,
                                    child:
                                    Image.asset(
                                      'assets/notificaiocn.png',
                                      fit:
                                      BoxFit.fill,
                                    ),
                                  ),

                                ),


                                SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.010),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          right: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.0,
                                          bottom: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.00,
                                        ),
                                        child: Text(
                                          "Reported Symptoms",
                                          style: TextStyle(
                                            color: Color(0xFF6A6E83),
                                            overflow:
                                            TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                            MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.011,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Adding the side arrow at the end

                                Container(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.00,
                                    right: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01,
                                    top: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.0,
                                    bottom: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.0,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: MediaQuery.of(context)
                                        .size
                                        .height *
                                        0.01, // Dynamic icon size
                                    color: Color(0xFF6A6E83),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ),








              ],
            ),
          ),
        ),


        // violet
        Container(
        margin: EdgeInsets.only(
          right: screenHeight * 0.02,
          top: screenHeight * 0.0,
          bottom: screenHeight * 0.01,
          left: screenHeight * 0.02,
        ), // Responsive margin
        height:  MediaQuery
            .of(context)
            .size
            .height * 0.14,
        decoration: BoxDecoration(
          color: Color(
              0xFFC80000), // Fallback color if image fails to load
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: AssetImage(
                'assets/B3_ls.png'), // Path to your banner image
            fit: BoxFit.fill,
            // Adjust to cover the entire container
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.0),
              offset: Offset(0, 4),
              blurRadius: 9,
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
            children: <Widget>[
              // Flexible(
              //   flex: 6, // 6 out of 10 for the text section
              //   child: Padding(
              //     padding: EdgeInsets.all(MediaQuery
              //         .of(context)
              //         .size
              //         .height * 0.005),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //
              //         Container(
              //           padding: EdgeInsets.only(
              //             top: screenHeight * 0.01,
              //             bottom: screenHeight * 0.00,
              //             left: screenHeight * 0.01,
              //             right: screenHeight * 0.02,
              //           ),
              //           child: ShaderMask(
              //             shaderCallback: (Rect bounds) {
              //               return LinearGradient(
              //                 begin: Alignment.centerLeft,
              //                 end: Alignment.centerRight,
              //                 colors: [Color(0xFFFFB300), Color(0xFFF9F3E5)],
              //                 tileMode: TileMode.clamp,
              //               ).createShader(bounds);
              //             },
              //             child: Text(
              //               "Caring for you, every step of the way",
              //               style: TextStyle(
              //                 fontSize: screenHeight * 0.018,
              //                 color: Colors.white, // This color will be overridden by the gradient
              //                 fontWeight: FontWeight.bold,
              //               ),
              //               textAlign: TextAlign.left,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Flexible(
                flex: 6, // 6 out of 10 for the text section
                child: Padding(
                  padding: EdgeInsets.all( screenHeight * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          bottom: screenHeight * 0.00,
                          left: screenHeight * 0.00,
                          right: screenHeight * 0.00,
                        ),
                        child:
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFFFFB300), Color(0xFFF9F3E5)],
                              tileMode: TileMode.clamp,
                            ).createShader(bounds);
                          },
                          child: Text(
                            "Caring for you, every step of the way",
                            style: TextStyle(
                                fontSize: screenHeight * 0.019,
                                color: Colors.white,
                                fontWeight : FontWeight.w700// This color will be overridden by the gradient                fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 4, // 6 out of 10 for the text section
                child: Container(),
              ),
            ],
          ),
            Positioned(
              left : 0,
              bottom : 20,
              child: Center(
                child: Container(

                  padding: EdgeInsets.only(
                    top : screenHeight * 0.005,
                    bottom : screenHeight * 0.005,
                    left : screenHeight * 0.01,
                    right : screenHeight * 0.04,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFB793B6),
                        Color(0x00737373)
                      ]
                    )
                  ),
                  child: Text(
                    "Ad",
                    style: TextStyle(
                        fontSize: screenHeight * 0.01,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF)
                    ),
                  ),
                ),
              ),
            ),
          ]
        ),
                  ),
        // Red Card
        Container(
          margin: EdgeInsets.only(
            right: screenHeight * 0.02,
            top: screenHeight * 0.0,
            bottom: screenHeight * 0.0,
            left: screenHeight * 0.02,
          ),// Responsive margin
          height: MediaQuery
              .of(context)
              .size
              .height * 0.14,
          decoration: BoxDecoration(
            color: Color(
                0xFFC80000), // Fallback color if image fails to load
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: AssetImage(
                  'assets/B2_ls.png'), // Path to your banner image
              fit: BoxFit.fill,

            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.0),
                offset: Offset(0, 4),
                blurRadius: 9,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 4, // 6 out of 10 for the text section
                child: Container(),
              ),
              Flexible(
                flex: 6, // 6 out of 10 for the text section
                child: Padding(
                  padding: EdgeInsets.only(
                    top : screenHeight * 0.02,
                    left : screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          bottom: screenHeight * 0.00,
                          left: screenHeight * 0.00,
                          right: screenHeight * 0.00,
                        ),
                        child: Text(
                          "Patient Mobile App",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: screenHeight * 0.014,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.00,
                          bottom: screenHeight * 0.00,
                          left: screenHeight * 0.00,
                          right: screenHeight * 0.00,
                        ),
                        child: Text(
                          "Caring for you, every step of the way",
                          style: TextStyle(
                            fontSize: screenHeight * 0.018,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Container(

                          padding: EdgeInsets.only(
                            right : screenHeight * 0.015,
                            bottom : screenHeight * 0.005,
                          ),
                          child : Text(
                            "Offer Validity: 12/12/2020 - 12/12/2025",
                            style: TextStyle(
                              fontSize: screenHeight * 0.008,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          alignment: Alignment.bottomRight,
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
        ),


      ],
    ),
  ),
),
                            Container(
                              height: double
                                  .infinity,

                              width: double
                                  .infinity,

                              color: Colors
                                  .white,
                              child: Column(
                                children: [
                                  // 🔘 Toggle buttons
                                  Container(

                                    child: Padding(
                                      padding:  EdgeInsets.only(
                                          left:screenHeight * 0.015,
                                        right:screenHeight * 0.015,
                                        top :   screenHeight * 0.01,

                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                              "Filter By",
                                            style: TextStyle(
                                              color : Color(0xFF126086),
                                              fontSize: screenHeight * 0.014
                                            ),
                                          ),
                                          Row(

                                            children: [
                                              _notificationBuildTypeButton("Appointments"),
                                              SizedBox(width: 10),
                                              _notificationBuildTypeButton("Reports"),
                                            ],
                                          ),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: notificationUniqueDates.length,
                                      itemBuilder: (context,index){


                                        String dateKey = notificationUniqueDates[index];
                                        List<Map<String, dynamic>> items = notificationGroupedData[dateKey]!;

                                        List<int> idsToMark = items.map((e) => e["id"] as int).toList();

                                        idList.addAll(idsToMark);

                                        bool isToday = dateKey ==
                                            DateFormat('yyyy-MM-dd').format(today);
                                        String formattedDate = isToday
                                            ? "Today, ${DateFormat('MMM d').format(today)}"
                                            : DateFormat('MMM d, yyyy')
                                            .format(DateTime.parse(dateKey));




                                         return Column(
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Container
                                                   (
                                                   margin : EdgeInsets.only(
                                                     left : screenHeight * 0.015,
                                                 ),
                                                   child: Text(
                                                     formattedDate,
                                                     style: TextStyle(color : Color(0xFF1F1F1F),
                                                         fontSize: screenHeight * 0.014, fontWeight: FontWeight.w500),
                                                   ),
                                                 ),
                                                 if (index == 0)
                                                   TextButton(
                                                     onPressed: () {
                                                      setState(() {
                                                        for(var id in idList){

                                                          dataList[id]['markAllRead'] = false;

                                                        }
                                                      });

                                                     },
                                                     child: Text(
                                                         "Mark all Read",
                                                       style : TextStyle(
                                                         color : Color(0xFF126086),
                                                         fontSize: screenHeight * 0.012,
                                                         fontWeight: FontWeight.w600,
                                                       )
                                                     ),
                                                   ),
                                               ],
                                             ),
                                             ...items.map((item){


                                               return Dismissible(
                                                 key : UniqueKey(),
                                                 direction: DismissDirection.endToStart, // Allow swipe from right to left
                                                 background: Container(
                                                   color: Colors.white,
                                                   alignment: Alignment.centerRight,
                                                   padding: EdgeInsets.symmetric(horizontal: 20),
                                                   child: Icon(
                                                     Icons.delete,
                                                     color: Colors.red,
                                                   ),
                                                 ),
                                                 onDismissed: (direction) {

                                                   print('id : ${item['id']}');

                                                   Future.delayed(Duration(milliseconds: 300), () {
                                                     // if (index < dataList.length) {
                                                     //   setState(() {
                                                     //     dataList.removeAt(index);
                                                     //   });
                                                     // }
                                                     if(index < dataList.length){
                                                       setState(() {
                                                         dataList.removeWhere((itemList) => itemList['id'] == item['id']);
                                                       });
                                                     }


                                                   });







                                                 },
                                                 child: GestureDetector(
                                                   onTap: () {},
                                                   child: Card(
                                                     elevation: 0.0,
                                                     color: Colors.white,
                                                     child: Container(
                                                       decoration: BoxDecoration(
                                                           borderRadius:
                                                           BorderRadius.circular(10),
                                                           gradient: LinearGradient(
                                                             begin:
                                                             Alignment.centerLeft,
                                                             end:
                                                             Alignment.centerRight,
                                                             stops: [
                                                               0.5,
                                                               0.9
                                                             ],
                                                             colors: [
                                                               Color(
                                                                   0xFFE8F0F3)
                                                                   .withOpacity(
                                                                   0.5),
                                                               Color(
                                                                   0xFFE8F0F3)
                                                                   .withOpacity(
                                                                   0.5),
                                                             ],)),
                                                       margin: EdgeInsets.only(
                                                           left: MediaQuery.of(context)
                                                               .size
                                                               .height *
                                                               0.01,
                                                           right: MediaQuery.of(context)
                                                               .size
                                                               .height *
                                                               0.01,
                                                           bottom: MediaQuery.of(context)
                                                               .size
                                                               .height *
                                                               0.0,
                                                           top: MediaQuery.of(context)
                                                               .size
                                                               .height *
                                                               0.00),
                                                       child: Container(
                                                 
                                                 
                                                 
                                                         margin: EdgeInsets.only(
                                                             left: MediaQuery.of(context)
                                                                 .size
                                                                 .height *
                                                                 0.00,
                                                             right: MediaQuery.of(context)
                                                                 .size
                                                                 .height *
                                                                 0.00,
                                                             bottom: MediaQuery.of(context)
                                                                 .size
                                                                 .height *
                                                                 0.00,
                                                             top: MediaQuery.of(context)
                                                                 .size
                                                                 .height *
                                                                 0.00),
                                                         padding: EdgeInsets.only(
                                                             left: MediaQuery.of(context)
                                                                 .size
                                                                 .height *
                                                                 0.005,
                                                             right: MediaQuery.of(context)
                                                                 .size
                                                                 .height *
                                                                 0.005,
                                                             bottom: MediaQuery.of(context)
                                                                 .size
                                                                 .height *
                                                                 0.005,
                                                             top: MediaQuery.of(context)
                                                                 .size
                                                                 .height *
                                                                 0.005),
                                                         child: Column(
                                                           crossAxisAlignment:
                                                           CrossAxisAlignment.start,
                                                           children: <Widget>[
                                                             Container(
                                                               padding: EdgeInsets.only(
                                                                 left:
                                                                 MediaQuery.of(context)
                                                                     .size
                                                                     .height *
                                                                     0.01,
                                                                 right:
                                                                 MediaQuery.of(context)
                                                                     .size
                                                                     .height *
                                                                     0.015,
                                                                 top:
                                                                 MediaQuery.of(context)
                                                                     .size
                                                                     .height *
                                                                     0.00,
                                                                 bottom:
                                                                 MediaQuery.of(context)
                                                                     .size
                                                                     .height *
                                                                     0.005,
                                                               ),
                                                               child: Row(
                                                                 crossAxisAlignment:
                                                                 CrossAxisAlignment
                                                                     .center,
                                                                 mainAxisAlignment:
                                                                 MainAxisAlignment
                                                                     .start,
                                                                 children: <Widget>[
                                                                   Container(
                                                                     height : MediaQuery.of(context).size.height * 0.05,
                                                                     width :  MediaQuery.of(context).size.height * 0.05,
                                                 
                                                 
                                                                     padding:
                                                                     EdgeInsets.only(
                                                                       left: MediaQuery.of(
                                                                           context)
                                                                           .size
                                                                           .height *
                                                                           0.00,
                                                                     ),
                                                                     child: ClipRRect(
                                                                       borderRadius:
                                                                       BorderRadius
                                                                           .circular(
                                                                           130.0),
                                                                       child:
                                                                       Image.asset(
                                                                         item["image"],
                                                                         fit:
                                                                         BoxFit.fill,
                                                                           width: 40, height: 40
                                                                       ),
                                                                     ),
                                                                   ),
                                                                   SizedBox(
                                                                       width: MediaQuery.of(
                                                                           context)
                                                                           .size
                                                                           .height *
                                                                           0.015),
                                                                   Expanded(
                                                                     flex: 6,
                                                                     child: Column(
                                                                       crossAxisAlignment:
                                                                       CrossAxisAlignment
                                                                           .start,
                                                                       mainAxisAlignment:
                                                                       MainAxisAlignment
                                                                           .center,
                                                                       children: <Widget>[
                                                                         Container(
                                                                           margin : EdgeInsets.only(
                                                                             top : MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.01,
                                                                           ),
                                                                           padding:
                                                                           EdgeInsets
                                                                               .only(
                                                                             left: MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.00,
                                                                             right: MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.00,
                                                                             top: MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.0,
                                                                             bottom: MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.00,
                                                                           ),
                                                                           child: Text(
                                                                               item["title"],
                                                                             style:
                                                                             TextStyle(
                                                                               color: Color(0xFF126086),
                                                                               overflow:
                                                                               TextOverflow
                                                                                   .ellipsis,
                                                                               fontWeight:
                                                                               FontWeight
                                                                                   .w500,
                                                                               fontSize: MediaQuery.of(context)
                                                                                   .size
                                                                                   .height *
                                                                                   0.012,
                                                                             ),
                                                                           ),
                                                                         ),
                                                                         Row(
                                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                           children: [
                                                                             Container(
                                                 
                                                                               margin : EdgeInsets.only(
                                                                                 top : MediaQuery.of(
                                                                                     context)
                                                                                     .size
                                                                                     .height *
                                                                                     0.005,
                                                                               ),
                                                                               padding:
                                                                               EdgeInsets
                                                                                   .only(
                                                                                 left: MediaQuery.of(
                                                                                     context)
                                                                                     .size
                                                                                     .height *
                                                                                     0.00,
                                                                                 right: MediaQuery.of(
                                                                                     context)
                                                                                     .size
                                                                                     .height *
                                                                                     0.00,
                                                                                 top: MediaQuery.of(
                                                                                     context)
                                                                                     .size
                                                                                     .height *
                                                                                     0.0,
                                                                                 bottom: MediaQuery.of(
                                                                                     context)
                                                                                     .size
                                                                                     .height *
                                                                                     0.00,
                                                                               ),
                                                                               child: Text(
                                                                                 "Duration: 6 Days : Intensity: Severe, Onset/Time course: Acute : ",
                                                                                 style:
                                                                                 TextStyle(
                                                                                   color: Color(0xFF126086).withOpacity(0.7),
                                                                                   overflow:
                                                                                   TextOverflow
                                                                                       .ellipsis,
                                                 
                                                                                   fontSize: MediaQuery.of(context)
                                                                                       .size
                                                                                       .height *
                                                                                       0.009,
                                                                                   fontWeight : FontWeight.w400,
                                                                                 ),
                                                                               ),
                                                                             ),
                                                                             if(item['markAllRead'])
                                                                             Container(
                                                                               width: 10,
                                                                               height: 10,
                                                                               decoration: BoxDecoration(
                                                                                 color: Colors.red,
                                                                                 shape: BoxShape.circle,
                                                                               ),
                                                                             ),
                                                                           ],
                                                                         ),
                                                                         Container(
                                                                           padding:
                                                                           EdgeInsets
                                                                               .only(
                                                                             left: MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.00,
                                                                             right: MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.00,
                                                                             top: MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.00,
                                                                             bottom: MediaQuery.of(
                                                                                 context)
                                                                                 .size
                                                                                 .height *
                                                                                 0.00,
                                                                           ),
                                                                           child: Text(
                                                                             "Radiation of Pain: Chest Associated Symptoms:",
                                                                             style:
                                                                             TextStyle(
                                                                               color: Color(0xFF126086).withOpacity(0.7),
                                                                               overflow:
                                                                               TextOverflow
                                                                                   .ellipsis,
                                                 
                                                                               fontSize: MediaQuery.of(context)
                                                                                   .size
                                                                                   .height *
                                                                                   0.009,
                                                                               fontWeight : FontWeight.w400,
                                                                             ),
                                                                           ),
                                                                         ),
                                                                         Container(
                                                                           padding: EdgeInsets.only(
                                                                             left: MediaQuery.of(context).size.height * 0.00,
                                                                             right: MediaQuery.of(context).size.height * 0.00,
                                                                             top: MediaQuery.of(context).size.height * 0.00,
                                                                             bottom: MediaQuery.of(context).size.height * 0.00,
                                                                           ),
                                                                           child: Align(
                                                                             alignment: AlignmentDirectional.centerEnd, // Align text to the end
                                                                             child: Text(
                                                                                 item["time"],
                                                                               style : TextStyle(
                                                                                 color: Color(0xFF126086),
                                                                                 overflow:
                                                                                 TextOverflow
                                                                                     .ellipsis,
                                                 
                                                                                 fontSize: MediaQuery.of(context)
                                                                                     .size
                                                                                     .height *
                                                                                     0.009,
                                                                                 fontWeight : FontWeight.w500,
                                                                               ),
                                                                             ),
                                                                           ),
                                                                         ),
                                                 
                                                                       ],
                                                                     ),
                                                                   ),
                                                                   // Adding the side arrow at the end
                                                 
                                                 
                                                 
                                                 
                                                                 ],
                                                               ),
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                               );
                                             }).toList(),
                                           ],
                                         );

                                      },

                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),





                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: screenHeight * 0.07,  // Outer circle height (adjust as needed)
            width: screenHeight * 0.07, // Outer circle width (adjust as needed)
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Padding color (background ring)
            ),
            child: Padding(
              padding: EdgeInsets.all(
                  screenHeight * 0.008), // Padding inside the outer circle
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Color(0xFF126086),
                // Button color
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UploadPrescriptionMain();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(screenHeight * 0.008),
                  width: screenHeight * 0.03, // Adjust image width
                  height: screenHeight * 0.03, // Adjust image height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/Upload.png'), // Replace with your asset path
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                elevation: 0.0,
                shape: CircleBorder(), // Ensures the button remains circular
              ),
            ),
          ),
          bottomNavigationBar: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      blurRadius: 20, // Spread of the shadow
                      offset: Offset(
                          0, -4), // Position the shadow above the BottomAppBar
                    ),
                  ],
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent, // Remove splash color
                    highlightColor: Colors.transparent, // Remove highlight color
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType
                        .fixed,
                    // Set fixed type for equal spacing
                    currentIndex: _selectedIndex,
                    // Track the selected tab
                    // Track the selected tab
                    onTap: _onItemTapped,

                    backgroundColor: Colors.white,
                    selectedItemColor:
                    Color(0xFF126086),
                    // Color for the selected item
                    unselectedItemColor:
                    Color(0xFF484C52),
                    // Color for unselected items
                    selectedFontSize: MediaQuery
                        .of(context)
                        .size
                        .height *
                        0.014,
                    // Hide the label font for selected items
                    unselectedFontSize: MediaQuery
                        .of(context)
                        .size
                        .height *
                        0.012,
                    // Hide the label font for unselected items
                    elevation: 0,
                    // Disable elevation
                    items: [
                      BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                          ), // Add padding
                          child: Image.asset(
                            'assets/Homeactive.png',
                            width: MediaQuery
                                .of(context)
                                .size
                                .height * 0.027,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.027,
                          ),
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                          ), // Add padding
                          child: Image.asset(
                            'assets/MyReports.png',
                            width: MediaQuery
                                .of(context)
                                .size
                                .height * 0.027,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.027,
                          ),
                        ),
                        label: 'My Reports',
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.025,
                          ), // Add padding
                          child: Image.asset(
                            'assets/Appoinments.png',
                            width: 0,
                            height: 0,
                          ),
                        ),
                        label: 'Upload',
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                          ), // Add padding
                          child: Image.asset(
                            'assets/Appoinments.png',
                            width: MediaQuery
                                .of(context)
                                .size
                                .height * 0.027,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.027,
                          ),
                        ),
                        label: 'Appointments',
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                          ), // Add padding
                          child: Image.asset(
                            'assets/MyHealth.png',
                            width: MediaQuery
                                .of(context)
                                .size
                                .height * 0.027,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.027,
                          ),
                        ),
                        label: 'My Health',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    ),
      );
  }

  Widget _notificationBuildTypeButton(String label) {
    bool isSelected = notificationSelectedFilter == label;
    // return ElevatedButton(
    //   onPressed: () => onFilterButtonClick(label),
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
    //     foregroundColor: isSelected ? Colors.white : Colors.black,
    //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //   ),
    //   child: Text(label),
    // );

    return GestureDetector(
        onTap:   () => onNotificationFilterButtonClick(label),
      child: Container(
        padding : EdgeInsetsDirectional.symmetric(
          vertical: 10,
          horizontal: 12,
        ),

          child: Text(label,
            style : TextStyle(
              color :isSelected ? Color(0xFFFFFFFF): Color(0xFF126086),
              fontSize : MediaQuery.of(context).size.height * 0.01,
              fontWeight: FontWeight.w500,

            )
          ),
        decoration: BoxDecoration(
          color : isSelected ? Color(0xFF126086) : Color(0x1A126086),
          borderRadius: BorderRadius.circular(8),

        ),
      ),
    );
  }
  Widget _allBuildTypeButton(String label) {
    bool isSelected = allSelectedFilter == label;
    // return ElevatedButton(
    //   onPressed: () => onFilterButtonClick(label),
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
    //     foregroundColor: isSelected ? Colors.white : Colors.black,
    //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //   ),
    //   child: Text(label),
    // );

    return GestureDetector(
      onTap:   () => onAllFilterButtonClick(label),
      child: Container(
        padding : EdgeInsetsDirectional.symmetric(
          vertical: 10,
          horizontal: 12,
        ),

        child: Text(label,
            style : TextStyle(
              color :isSelected ? Color(0xFFFFFFFF): Color(0xFF126086),
              fontSize : MediaQuery.of(context).size.height * 0.01,
              fontWeight: FontWeight.w500,

            )
        ),
        decoration: BoxDecoration(
          color : isSelected ? Color(0xFF126086) : Color(0x1A126086),
          borderRadius: BorderRadius.circular(8),

        ),
      ),
    );
  }


  void onNotificationFilterButtonClick(String buttonType) {
    setState(() {
      if (notificationSelectedFilter == buttonType) {
        // Button clicked again → toggle back to All
        notificationSelectedFilter = "All";
      } else {
        // Otherwise select this button
        notificationSelectedFilter = buttonType;
      }
    });
  }
  void onAllFilterButtonClick(String buttonType) {
    setState(() {
      if (allSelectedFilter == buttonType) {
        // Button clicked again → toggle back to All
        allSelectedFilter = "All";
      } else {
        // Otherwise select this button
        allSelectedFilter = buttonType;
      }
    });
  }



  Map<String, List<Map<String, dynamic>>> getNotificationFilteredGroupedData() {
    List<Map<String, dynamic>> filteredList;
    if (notificationSelectedFilter == "All") {
      filteredList = List.from(dataList); // All data
    } else {
      filteredList = dataList
          .where((item) => item["buttonSelected"] == notificationSelectedFilter)
          .toList();
    }


      notificationCount = filteredList.length;
      Map<String, List<Map<String, dynamic>>> grouped = {};
      for (var item in filteredList) {
        grouped.putIfAbsent(item["date"], () => []);
        grouped[item["date"]]!.add(item);
      }
      return grouped;

  }
  Map<String, List<Map<String, dynamic>>> getAllFilteredGroupedData() {
    List<Map<String, dynamic>> filteredList;
    if (allSelectedFilter == "All") {
      filteredList = List.from(dataList); // All data
    } else {
      filteredList = dataList
          .where((item) => item["buttonSelected"] == allSelectedFilter)
          .toList();
    }

      allCount=3;
      allCount += filteredList.length;
      Map<String, List<Map<String, dynamic>>> grouped = {};
      for (var item in filteredList) {
        grouped.putIfAbsent(item["date"], () => []);
        grouped[item["date"]]!.add(item);
      }
      return grouped;


  }

  void _onItemTapped(int index) {
    setState(() {
      int selected = index;

      if (selected == 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePageMain()),
                (Route<dynamic> route) => false);
      } else if (selected == 1) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyReportsMain();
            },
          ),
        );
      } else if (selected == 2) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return UploadPrescriptionMain();
            },
          ),
        );
      } else if (selected == 3) {
        showBottomSheet();
      }
      else if (selected == 4) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyHealthMain();
            },
          ),
        );
      }



      // Fluttertoast.showToast(msg: "test", toastLength: Toast.LENGTH_LONG);
      print(selected);
    });
  }

  void showBottomSheet() =>
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: false,
          backgroundColor: Colors.transparent, // Make modal background transparent
          barrierColor: Colors.transparent,
          transitionAnimationController: AnimationController(
            duration: const Duration(milliseconds: 200),
            vsync: Navigator.of(context),
          ),// No default barrier color
          builder: (BuildContext context) {
            return Stack(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, -2), // Shadow appears above the sheet
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ), // Keep your content background
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter setState) =>
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.025,
                                          right: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.0,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.015),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.01,
                                            bottom: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.0,
                                            left: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00,
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00,
                                          ),
                                          padding: EdgeInsets.only(
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.0,
                                            bottom: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.0,
                                            left: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00,
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              // Container(
                                              //   padding: EdgeInsets.only(
                                              //     top: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.0,
                                              //     bottom: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.03,
                                              //     left: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.18,
                                              //     right: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.18,
                                              //   ),
                                              //   child: Divider(
                                              //     height: 0,
                                              //     indent: 0,
                                              //     thickness: MediaQuery
                                              //         .of(context)
                                              //         .size
                                              //         .height * 0.008,
                                              //     color: Color(0xFF95C8D6).withOpacity(0.3),
                                              //   ),
                                              // ),

                                              // Select the Type of Appointment

                                              GestureDetector(


                                                child: Center(
                                                  child: Container(

                                                    padding: EdgeInsets.only(
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.03,
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.18,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.18,
                                                    ),


                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.23,
                                                    // Same thickness as Divider
                                                    height: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.006,
                                                    // Same thickness as Divider
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFD9D9D9),
                                                      // Divider color
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          10), // Rounded edges
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.02),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.0,
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.02,
                                                    bottom: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height * 0.00),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            right: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            top: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00),
                                                        child: Text(
                                                          "Select the Type of Appointment",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF2F3335),
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            fontSize:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.016,
                                                          ),
                                                        ),
                                                      ),

                                                    ]),
                                              ),


                                              //  Appointments
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) {
                                                        return AppointmentsFootMain();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.025,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.015),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFA8B1CE)
                                                        .withOpacity(
                                                        0.1),

                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        8), // Optional: Rounded corners
                                                  ),

                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00),
                                                  // color: Colors.white,
                                                  child: Container(
                                                    // color: Colors.white,

                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        gradient: LinearGradient(
                                                            begin:
                                                            Alignment
                                                                .centerLeft,
                                                            end:
                                                            Alignment
                                                                .centerRight,
                                                            stops: [
                                                              0.5,
                                                              0.9
                                                            ],
                                                            colors: [
                                                              Color(0x0A056390),
                                                              Color(0x0A056390),
                                                            ])),

                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        right: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                            left:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            right:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            top:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                    left: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.00,
                                                                  ),
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                      left: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      right: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      top: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                    ),
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    child:
                                                                    Image.asset(
                                                                      'assets/Appointments_ls.png',
                                                                      fit:
                                                                      BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.010),
                                                              Expanded(
                                                                flex: 8,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        top: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        bottom: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                      ),
                                                                      child: Text(
                                                                        "Appointments",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xFF126086),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontSize: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.014,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                              // Adding the side arrow at the end
                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                                // Dynamic icon size
                                                                color:
                                                                Color(
                                                                    0xFF126086),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //  Test And Services
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (
                                                          BuildContext context) {
                                                        return TestAndServicesMain();
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.025,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.005,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.015),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFA8B1CE)
                                                        .withOpacity(
                                                        0.1),

                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        8), // Optional: Rounded corners
                                                  ),

                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.0,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.00),
                                                  // color: Colors.white,
                                                  child: Container(
                                                    // color: Colors.white,

                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        gradient: LinearGradient(
                                                            begin:
                                                            Alignment
                                                                .centerLeft,
                                                            end:
                                                            Alignment
                                                                .centerRight,
                                                            stops: [
                                                              0.5,
                                                              0.9
                                                            ],
                                                            colors: [
                                                              Color(0x0A056390),
                                                              Color(0x0A056390),
                                                            ])),

                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        right: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.005,
                                                        bottom: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00,
                                                        top: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                            left:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            right:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.005,
                                                            top:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                            bottom:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                    left: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.00,
                                                                  ),
                                                                  child: Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                      left: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      right: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      top: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                      bottom: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height *
                                                                          0.01,
                                                                    ),
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.025,
                                                                    child:
                                                                    Image.asset(
                                                                      'assets/TestServicesBs.png',
                                                                      fit:
                                                                      BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),

                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.010),
                                                              Expanded(
                                                                flex: 8,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                        left: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        right: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                        top: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.0,
                                                                        bottom: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height *
                                                                            0.00,
                                                                      ),
                                                                      child: Text(
                                                                        "Test & Services",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xFF126086),
                                                                          overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontSize: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height *
                                                                              0.014,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                              // Adding the side arrow at the end
                                                              Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height *
                                                                    0.014,
                                                                // Dynamic icon size
                                                                color:
                                                                Color(
                                                                    0xFF126086),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ]
            );
          }
      );


}
