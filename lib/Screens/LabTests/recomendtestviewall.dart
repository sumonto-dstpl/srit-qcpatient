import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newfolder/Screens/AddToCart/addtocarPackageDetails.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/LabTests/bottomsheet.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/appointmentsfindspecialities.dart';
import 'package:newfolder/Screens/Appointments/finddoctorslist.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithdata.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithoutdata.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/HomeCare/diagnosticmain.dart';
import 'package:newfolder/Screens/HomeCare/doctorhcmain.dart';
import 'package:newfolder/Screens/HomeCare/medicalequipmentshcmain.dart';
import 'package:newfolder/Screens/HomeCare/nursehcmain.dart';
import 'package:newfolder/Screens/HomeCare/physiohcmain.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:universal_html/js_util.dart';

class RecommendedViewAll extends StatefulWidget {
  String usernameValue ;
  int selectedIndex = 0;
  RecommendedViewAll({
    super.key,
    required this.usernameValue,
  });
  @override
  State<RecommendedViewAll> createState() => RecommendedViewAllstate();
}

class RecommendedViewAllstate extends State<RecommendedViewAll> {

  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;
  final mybrowsebyhealthcond = [
    ["assets/Diagnostic.png", "Harmone"],
    ["assets/Doctor.png", "Diabetes"],
    ["assets/Nurse.png", "Joint Pain"],
    ["assets/Physio.png", "Thyroid"],
    ["assets/MedicalEquipment.png", "Heart"],
    ["assets/Diagnostic.png", "Bone"],
    ["assets/Doctor.png", "Blood Sugar"],
    ["assets/Nurse.png", "Vitamin"],
    ["assets/Physio.png", "Hair Fall"],
    ["assets/MedicalEquipment.png", "Liver"],
    ["assets/Physio.png", "Kidney"],
    ["assets/MedicalEquipment.png", "Fever"],
  ];

  final myhealthpackages = [
    ["assets/Diagnostic.png", "Full Body Checkup"],
    ["assets/Doctor.png", "Men’s Wellness"],
    ["assets/Nurse.png", "Women’s Health"],
    ["assets/Physio.png", "Thyroid Package"],
    ["assets/MedicalEquipment.png", "Heart Package"],
    ["assets/Diagnostic.png", "Diabetes package"],
    ["assets/Doctor.png", "Blood Studies Package"],
    ["assets/Nurse.png", "Vitamin package"],
    ["assets/Physio.png", "Hairfall package"],
    ["assets/MedicalEquipment.png", "Liver Package"],
    ["assets/Physio.png", "Kidney Package"],
    ["assets/MedicalEquipment.png", "Fever Package"],
  ];

  EmergencyHomeCall emergencycallalert = new EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = new AppointmentCancel();
  TextEditingController SearchfilterEditTextController = TextEditingController();


  // List of filter categories
  final List<String> categories = [
    'Must have tests',
    'Category',
  ];

  // Tracks the selected category
  int selectedCategoryIndex = 0;


  final List<String> musthavetests = [
    "Complete Blood Count (CBC)",
    "Glucose, Post Prandial (PP), 2 Hours",
    "Complete Urine Examination",
    "Thyroid Profile (Total T3, Total T4)",
    "Lipid Profile",
    "Liver Function Test (I-FT)",
    "C - Reactive Protein (Quantitative)",
  ];

  final List<String> categorieslast = [
    "Pregnancy",
    "X - ray MRI CT Ultrasound",
    "Blood Studies",
    "Allergy",
    "Tax Saver",
    "Bone",
    "Men’s Health",
  ];

  List<Map<String,dynamic>> cartList = [
    {"id" : 101,"plan" : "QCT Prime Health Plan" , "test" : "89", "qr" : "QR 1999"},
    {"id" : 102,"plan" : "QCT Superoir Health Plan" , "test" : "100" , "qr" : "QR 1999"},
    {"id" : 103,"plan" : "QCT Full Body Checkup Female" , "test" : "100" , "qr" : "QR 1999"},

    {"id" : 104,"plan" : "QCT Prime Health Plan" , "test" : "89", "qr" : "QR 1999"},
    {"id" : 105,"plan" : "QCT Superoir Health Plan" , "test" : "100" , "qr" : "QR 1999"},
    {"id" : 106,"plan" : "QCT Full Body Checkup Female" , "test" : "100" , "qr" : "QR 1999"},

    {"id" : 107,"plan" : "QCT Prime Health Plan" , "test" : "89", "qr" : "QR 1999"},
    {"id" : 108,"plan" : "QCT Superoir Health Plan" , "test" : "100" , "qr" : "QR 1999"},
    {"id" : 109,"plan" : "QCT Full Body Checkup Female" , "test" : "100" , "qr" : "QR 1999"},

    {"id" : 110,"plan" : "QCT Prime Health Plan" , "test" : "89", "qr" : "QR 1999"},
    {"id" : 111,"plan" : "QCT Superoir Health Plan" , "test" : "100" , "qr" : "QR 1999"},
    {"id" : 112,"plan" : "QCT Full Body Checkup Female" , "test" : "100" , "qr" : "QR 1999"},
  ];

  List<dynamic> addedList=[];

  @override
  void initState(){
    // getSharedPrefs();
    setState(() {});
    _loadData();
    super.initState();
  }

  void _loadData() async {
    var guestUser = await UserSecureStorage.getIfGuestLogged();
    print("guestUser: $guestUser");
    final isGuestUser=guestUser == "YES";
    setState(() {});
    if(!isGuestUser) {
      String? username = await UserSecureStorage.getUsernameid();
      print("username: $username");
      // Map<String, dynamic>? user = await UserSecureStorage.getUser(username!);
      // print("user : $user");
      List<dynamic> _loadedCart2  = await UserSecureStorage.getAddToCart("addToCart2",username ?? '');

      if(_loadedCart2.isNotEmpty){
        print("_loadedCart2.length:${_loadedCart2.length}");
        setState(() {

          addedList = _loadedCart2 ?? [];
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController SearchEditTextController = TextEditingController();

    return Scaffold(
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
                  top: screenHeight * 0.07,
                  left: screenWidth * 0.045,
                  right: screenWidth * 0.045,
                  bottom: screenWidth * 0.06,
                ),
                margin: EdgeInsets.only(
                  right: screenHeight * 0.0,
                  top: screenHeight * 0.0,
                  bottom: screenHeight * 0.01,
                  left: screenHeight * 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.035,
                        width: MediaQuery.of(context).size.height * 0.035,
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.00,
                          top: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                        ),
                        decoration: BoxDecoration(

                          color: Color(0xFF126086).withOpacity(0.2),

                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 0.0, color: Color(0xFF126086)),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.005,
                            left: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.00,
                          ),
                          child: Text(
                            "${widget.usernameValue}",
                            style: TextStyle(
                              fontSize:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.018,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),



                      ],
                    ),


                    // Action Bar 2nd half
                    Expanded(
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
                            AppointmentIconBadge(
                              appointmentcount: "",
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
                            IconBadge(
                              notificationcount: "",
                            ),
                          ),


                          // Profile Image
                          userprofilepValue != "NA"
                              ?

                          GestureDetector(
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ProfileMain();
                                    },
                                  ),
                                );
                              }, child:
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.050,
                            width: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.050,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Colors.white,
                              ),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: Image
                                    .memory(
                                    base64Decode(userprofilepValue))
                                    .image,
                              ),
                            ),
                          )
                          )
                              : GestureDetector(
                            onTap: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ProfileMain();
                                  },
                                ),
                              );
                            }, child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.045,
                            width: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.045,
                            padding: EdgeInsets.only(
                              left: MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.00,
                            ),
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
                  ],
                ),
              ),

      Expanded(

        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenHeight * 0.03),
                topRight: Radius.circular(screenHeight * 0.03),
                bottomLeft: Radius.circular(screenHeight * 0.0),
                bottomRight: Radius.circular(screenHeight * 0.00),
                // bottomCenter: 0,
              ),
            ),
            child : Column(
              children: [
      Container(
          padding: EdgeInsets.only(
              left: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0,
              right: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0,
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
              bottom: MediaQuery
                  .of(context)
                  .size
                  .height * 0.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenHeight * 0.03),
              topRight: Radius.circular(screenHeight * 0.03),
            ),
          ),
          child:
          Column(
            children: [
              // Search Input Field
              Container(

                padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.0,
                  right: screenWidth * 0.0,
                  bottom: screenWidth * 0.01,
                ),
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.01,
                    top: MediaQuery.of(context).size.height * 0.0,
                    bottom: MediaQuery.of(context).size.height * 0.0,
                    left: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                        width: screenHeight *
                            0.005), // Add spacing between widgets
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                bottom: screenHeight * 0.01),

                            child: TextFormField(
                              controller: SearchEditTextController,

                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) => input!.length < 3
                                  ? "Search should be more than 3 characters"
                                  : null,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  top :   screenHeight * 0.012,
                                  left :   screenHeight * 0.02,
                                  right :   screenHeight * 0.012,
                                  bottom :   screenHeight * 0.012,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF7F5F6),
                                hintText: "Search by tests & packages",
                                hintStyle: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: screenHeight * 0.014,
                                    fontWeight: FontWeight.w400
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                  borderSide:
                                  BorderSide(color: Color(0xFFF7F5F6)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide:
                                  BorderSide(color: Colors.white),
                                ),
                                suffixIcon: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min, // Ensures the Row only takes as much space as needed
                                    children: [
                                      // Search Icon
                                      Icon(
                                        Icons.search,
                                        color: Colors.black45,
                                        size: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.025,
                                      ),
                                      // Divider
                                      Container(
                                        width: 1, // Width of the divider
                                        height: 20, // Height of the divider
                                        color: Colors.grey, // Color of the divider
                                        margin: EdgeInsets.symmetric(horizontal: 8), // Spacing around the divider
                                      ),
                                      // Icon from Assets
                                      InkWell(
                                        onTap: () {

                                          showBottomSheet();


                                        },
                                        child: Image.asset(
                                          'assets/scansearch.png', // Replace with your actual asset path
                                          height: 15, // Height of the asset icon
                                          width: 15,  // Width of the asset icon
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ]
          ),
      ),

              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                      top: MediaQuery.of(context).size.height * 0.01,
                      bottom: MediaQuery.of(context).size.height * 0.00),

                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,

                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(screenHeight * 0.03),
                    //   topRight: Radius.circular(screenHeight * 0.03),
                    // ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Provide a width constraint using SizedBox or Expanded
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                MediaQuery.of(context).size.height * 0.010,
                                top: MediaQuery.of(context).size.height * 0.0),
                            // height: MediaQuery.of(context).size.height * 0.190,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: ScrollPhysics(), // Ensures scrolling
                              shrinkWrap:
                              true, // Prevents ListView from taking up extra space
                              scrollDirection: Axis
                                  .vertical, // Makes the ListView horizontal
                              itemCount: cartList.length, // You can adjust the item count
                              itemBuilder: (BuildContext context, int index) {
                                final item = cartList[index];
                                bool isInCart = addedList.any((addedItem) => addedItem['id'] == item['id']);
                                return GestureDetector(
                                  onTap: () {

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (BuildContext context) {
                                            return AddtocardPackageDetails(buttonName: "Add to Cart",id: item['id'],plan: item['plan'],qr: item['qr'],test: item['test'],);
                                          },
                                        ),
                                      );


                                  },
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    child:  Container(
                                      // width:MediaQuery.of(context).size.height * 0.410,
                                      padding:EdgeInsets.only(
                                          left: MediaQuery.of(context).size.height * 0.00,
                                          right: MediaQuery.of(context).size.height * 0.00,
                                          bottom: MediaQuery.of(context).size.height * 0.00,
                                          top: MediaQuery.of(context).size.height * 0.00),
                                      color: Colors.white,
                                      child:
                                      Container(
                                        // color: Colors.white,

                                        decoration: BoxDecoration(
                                          color: Colors
                                              .white, // Background color of the container
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(
                                                  0.1), // Shadow color
                                              blurRadius:
                                              5, // Spread of the shadow
                                              offset: Offset(0,
                                                  0), // Offset in x and y direction
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Colors.black12, // Border color
                                            width: 1.0, // Border width
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              8), // Optional: Rounded corners
                                        ),
                                        margin:EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.00,
                                            right: MediaQuery.of(context).size.height * 0.00,
                                            bottom: MediaQuery.of(context).size.height * 0.00,
                                            top: MediaQuery.of(context).size.height * 0.00),
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.height * 0.005,
                                            right: MediaQuery.of(context).size.height * 0.005,
                                            bottom: MediaQuery.of(context).size.height * 0.005,
                                            top: MediaQuery.of(context).size.height * 0.005),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[

                                              Container(

                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                    top: MediaQuery.of(context).size.height * 0.01,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),

                                                    /*  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),*/
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      height : MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.055,
                                                      margin: EdgeInsets.only(
                                                        left:
                                                        MediaQuery.of(context).size.height * 0.01,
                                                        top: MediaQuery.of(context).size.height * 0.005,
                                                      ),

                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(130.0),
                                                        child: Image.asset(
                                                          'assets/Harmonebackground.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.height *
                                                            0.015),

                                                    Expanded(
                                                      flex: 8,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[


                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.0,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                               "${item['plan']}",
                                                              style: TextStyle(
                                                                  color: Colors.black87,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.014),
                                                            ),
                                                          ),
                                                          SizedBox(height : screenHeight * 0.005)  ,
                                                          Container(

                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              // "100 Tests Included : Complete Blood Count",
                                                              "${item['test']}",
                                                              style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012),
                                                            ),
                                                          ),
                                                          SizedBox(height : screenHeight * 0.005)  ,
                                                          Container(

                                                            padding: EdgeInsets.only(
                                                                left: MediaQuery.of(context).size.height * 0.00,
                                                                right: MediaQuery.of(context).size.height * 0.00,
                                                                top: MediaQuery.of(context).size.height * 0.00,
                                                                bottom: MediaQuery.of(context).size.height * 0.00),
                                                            child:
                                                            Text(
                                                              "Reports With in 24 Hours",
                                                              style: TextStyle(
                                                                  color: Color(0xFF126086),
                                                                  fontWeight: FontWeight.w600,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                      0.012),
                                                            ),
                                                          ),


                                                        ],
                                                      ),
                                                    ),



                                                  ],
                                                ),
                                              ),


                                              // Bottom Row
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.height * 0.005,
                                                    right: MediaQuery.of(context).size.height * 0.005,
                                                    top: MediaQuery.of(context).size.height * 0.00,
                                                    bottom: MediaQuery.of(context).size.height * 0.00),
                                                width: double.infinity,
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(06),
                                                        ),
                                                        padding: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.height * 0.01,
                                                          right: MediaQuery.of(context).size.height * 0.01,
                                                          top: MediaQuery.of(context).size.height * 0.01,
                                                          bottom: MediaQuery.of(context).size.height * 0.01,),
                                                        child: Row(
                                                          // mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[

                                                                      // More Details
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          // color:Colors.white,
                                                                          borderRadius: BorderRadius.circular(15),
                                                                        ),
                                                                        // color:Colors.green[100],
                                                                        padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.0,
                                                                            right: MediaQuery.of(context).size.height * 0.0,
                                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:

                                                                        Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            children: <Widget>[



                                                                              Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: 2),
                                                                                height: MediaQuery.of(context).size.height * 0.004,
                                                                                width: MediaQuery.of(context).size.height * 0.004,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                              ),

                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                      padding: EdgeInsets.only(
                                                                                          left: MediaQuery.of(context).size.height * 0.005,
                                                                                          right: MediaQuery.of(context).size.height * 0.00,
                                                                                          top: MediaQuery.of(context).size.height * 0.00,
                                                                                          bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                      child:
                                                                                      Text(
                                                                                        'QR 2999',
                                                                                        style: TextStyle(
                                                                                          // color: Colors.blue[600],
                                                                                            color: Colors.black,
                                                                                            fontWeight: FontWeight.w500,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            decoration: TextDecoration.lineThrough,
                                                                                            decorationThickness: 2,
                                                                                            fontSize: MediaQuery.of(context)
                                                                                                .size
                                                                                                .height *
                                                                                                0.014),
                                                                                      )


                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.only(
                                                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                                                        right: MediaQuery.of(context).size.height * 0.00,
                                                                                        top: MediaQuery.of(context).size.height * 0.00,
                                                                                        bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                    child:
                                                                                    Text(
                                                                                      // "QR 1999",
                                                                                      "${item['qr']}",
                                                                                      style: TextStyle(
                                                                                        // color: Colors.blue[600],
                                                                                          color: Color(0xFF12B76A),
                                                                                          fontWeight: FontWeight.w500,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          fontSize: MediaQuery.of(context)
                                                                                              .size
                                                                                              .height *
                                                                                              0.014),
                                                                                    ),

                                                                                  ),

                                                                                  Container(
                                                                                    margin: EdgeInsets.only(
                                                                                        left: MediaQuery.of(context).size.height * 0.005,
                                                                                        right: MediaQuery.of(context).size.height * 0.00,
                                                                                        top: MediaQuery.of(context).size.height * 0.00,
                                                                                        bottom: MediaQuery.of(context).size.height * 0.00),
                                                                                    height: screenHeight * 0.015,
                                                                                    width: screenHeight * 0.015,
                                                                                    decoration: BoxDecoration(
                                                                                      // color: Colors.blue[100]!.withOpacity(0.9),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Center( // Ensures the image is centered
                                                                                      child: Image.asset(
                                                                                        'assets/Offersicon.png', // Replace with your actual asset path
                                                                                        // color: Color(0xFF126086), // Optional: Apply color tint
                                                                                        height: screenHeight * 0.01,
                                                                                        width: screenHeight * 0.01,
                                                                                      ),
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              )


                                                                            ]
                                                                        ),

                                                                      ),

                                                                      // Buttons
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          // color:Colors.white,
                                                                          borderRadius: BorderRadius.circular(15),
                                                                        ),
                                                                        // color:Colors.green[100],
                                                                        padding: EdgeInsets.only(
                                                                            left: MediaQuery.of(context).size.height * 0.0,
                                                                            right: MediaQuery.of(context).size.height * 0.0,
                                                                            top: MediaQuery.of(context).size.height * 0.00,
                                                                            bottom: MediaQuery.of(context).size.height * 0.00),
                                                                        child:

                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                          children: <Widget>[
                                                                            !isInCart ?
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                 addToCart(item['id'],item['plan'],item['test'],item['qr']);
                                                                                 showTopNotification(
                                                                                   context,
                                                                                   title: "Add Cart",
                                                                                   message: "Cart is added successfully",
                                                                                   type: NotificationType.success,
                                                                                 );
                                                                                 setState(() {

                                                                                 });
                                                                              },
                                                                              child: Container(
                                                                                padding: new EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.02,
                                                                                    right: MediaQuery.of(context).size.height * 0.02,
                                                                                    top: MediaQuery.of(context).size.height * 0.006,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.006),
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFF126086),
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),


                                                                                margin: EdgeInsets.only(
                                                                                  left: MediaQuery.of(context).size.height * 0.0,
                                                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                  right: MediaQuery.of(context).size.height * 0.005,
                                                                                ),
                                                                                // color: Colors.grey[300],
                                                                                alignment: Alignment.center,
                                                                                // height:
                                                                                // MediaQuery.of(context).size.height * 0.070,
                                                                                child: Text("Add",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize:  MediaQuery.of(context).size.height * 0.01)),
                                                                              ),
                                                                            ):
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                _deleteCart(item['id'],index);
                                                                                showTopNotification(
                                                                                  context,
                                                                                  title: "Cart Delete",
                                                                                  message: "Cart is deleted Successfully",
                                                                                  type: NotificationType.error,
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                padding: new EdgeInsets.only(
                                                                                    left: MediaQuery.of(context).size.height * 0.02,
                                                                                    right: MediaQuery.of(context).size.height * 0.02,
                                                                                    top: MediaQuery.of(context).size.height * 0.006,
                                                                                    bottom: MediaQuery.of(context).size.height * 0.006),
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                ),


                                                                                margin: EdgeInsets.only(
                                                                                  left: MediaQuery.of(context).size.height * 0.0,
                                                                                  top: MediaQuery.of(context).size.height * 0.00,
                                                                                  bottom: MediaQuery.of(context).size.height * 0.00,
                                                                                  right: MediaQuery.of(context).size.height * 0.005,
                                                                                ),
                                                                                // color: Colors.grey[300],
                                                                                alignment: Alignment.center,
                                                                                // height:
                                                                                // MediaQuery.of(context).size.height * 0.070,
                                                                                child: Icon(Icons.delete, color: Colors.red),
                                                                              ),
                                                                            ),


                                                                          ],
                                                                        ),

                                                                      ),


                                                                    ]
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ]),
                                              ),







                                            ]),
                                      ),




                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Additional widgets can be added here
                        ],
                      ),




                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.045,
                      ),
                    ],

                  ),
                ),
              ),
              ],
            ),
        ),
      )
            ],
          ),
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isKeyboardVisible ? null : Container(
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
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      int selected = index;

      if (selected == 0) {
        /* Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePageMain()),
            (Route<dynamic> route) => false);*/
      } else if (selected == 1) {
      } else if (selected == 2) {
      } else if (selected == 3) {}

      widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;

      // Fluttertoast.showToast(msg: "test", toastLength: Toast.LENGTH_LONG);
      print(selected);
    });
  }


  // void showBottomSheet() => showModalBottomSheet(
  //   enableDrag: false,
  //   isScrollControlled: true,
  //   isDismissible: true,
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(24),
  //       topRight: Radius.circular(24),
  //     ),
  //   ),
  //   barrierColor: Colors.grey.withOpacity(0.9),
  //   context: context,
  //   builder: (context) {
  //     return AddFilterForFullBodyCheckup();
  //   }

      void showBottomSheet() => showModalBottomSheet(
  enableDrag: false,
  isScrollControlled: true,
  isDismissible: true,
  backgroundColor: Colors.transparent, // Make modal background transparent
  barrierColor: Colors.transparent,    // Disable default barrier color
  context: context,
  builder: (context) {
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
  decoration: const BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        spreadRadius: 2,
        offset: Offset(0, -2), // Shadow appears above the sheet
      ),
    ],
  color: Colors.white, // White background for the bottom sheet
  borderRadius: BorderRadius.only(
  topLeft: Radius.circular(24),
  topRight: Radius.circular(24),
  ),
  ),
  child: AddFilterForFullBodyCheckup(),
  ),
  ),
  ],
  );
  },

    //     StatefulBuilder(
    //   builder: (BuildContext context,
    //       StateSetter setState /*You can rename this!*/) =>
    //       Padding(
    //         padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(context).viewInsets.bottom),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Padding(
    //               padding: EdgeInsets.only(
    //                   left: MediaQuery.of(context).size.height * 0.025,
    //                   right: MediaQuery.of(context).size.height * 0.0,
    //                   bottom: MediaQuery.of(context).size.height * 0.015),
    //               child: Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Container(
    //                   margin: EdgeInsets.only(
    //                     top: MediaQuery.of(context).size.height * 0.01,
    //                     bottom: MediaQuery.of(context).size.height * 0.0,
    //                     left: MediaQuery.of(context).size.height * 0.00,
    //                     right: MediaQuery.of(context).size.height * 0.00,
    //                   ),
    //                   padding: EdgeInsets.only(
    //                     top: MediaQuery.of(context).size.height * 0.0,
    //                     bottom: MediaQuery.of(context).size.height * 0.0,
    //                     left: MediaQuery.of(context).size.height * 0.00,
    //                     right: MediaQuery.of(context).size.height * 0.00,
    //                   ),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Container(
    //                         padding: EdgeInsets.only(
    //                           top: MediaQuery.of(context).size.height * 0.0,
    //                           bottom: MediaQuery.of(context).size.height * 0.04,
    //                           left: MediaQuery.of(context).size.height * 0.18,
    //                           right: MediaQuery.of(context).size.height * 0.18,
    //                         ),
    //                         child: Divider(
    //                           height: 0,
    //                           indent: 0,
    //                           thickness: MediaQuery.of(context).size.height * 0.008,
    //                           color:Color(0xFF95C8D6).withOpacity(0.3),
    //                         ),
    //                       ),
    //
    //                       // Add Filters (1)
    //                       Padding(
    //                         padding: EdgeInsets.only(
    //                             left: MediaQuery.of(context).size.height * 0.0,
    //                             right: MediaQuery.of(context).size.height * 0.02,
    //                             bottom: MediaQuery.of(context).size.height * 0.00),
    //                         child: Row(
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                             children: <Widget>[
    //                               Container(
    //                                 padding: EdgeInsets.only(
    //                                     left: MediaQuery.of(context).size.height *
    //                                         0.00,
    //                                     right: MediaQuery.of(context).size.height *
    //                                         0.00,
    //                                     top: MediaQuery.of(context).size.height *
    //                                         0.00,
    //                                     bottom: MediaQuery.of(context).size.height *
    //                                         0.00),
    //                                 child: Text(
    //                                   "Add Filters (1)",
    //                                   style: TextStyle(
    //                                     color: Colors.black,
    //                                     fontWeight: FontWeight.bold,
    //                                     overflow: TextOverflow.ellipsis,
    //                                     fontSize:
    //                                     MediaQuery.of(context).size.height *
    //                                         0.02,
    //                                   ),
    //                                 ),
    //                               ),
    //                               GestureDetector(
    //                                 onTap: () async {
    //
    //                                 },
    //                                 child: Container(
    //                                   padding: EdgeInsets.only(
    //                                       left: MediaQuery.of(context).size.height *
    //                                           0.00,
    //                                       right:
    //                                       MediaQuery.of(context).size.height *
    //                                           0.00,
    //                                       top: MediaQuery.of(context).size.height *
    //                                           0.00,
    //                                       bottom:
    //                                       MediaQuery.of(context).size.height *
    //                                           0.00),
    //                                   child: Text(
    //                                     "Clear all",
    //                                     style: TextStyle(
    //                                       color: Color(0xFF126086),
    //                                       fontWeight: FontWeight.bold,
    //                                       overflow: TextOverflow.ellipsis,
    //                                       fontSize:
    //                                       MediaQuery.of(context).size.height *
    //                                           0.018,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ]),
    //                       ),
    //
    //
    //
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //
    //
    //
    //             Row(
    //               children: [
    //
    //                 // Left Side: Categories List
    //                 Expanded(
    //                   flex : 2,
    //                   child:
    //                   Container(
    //                     decoration: BoxDecoration(
    //                       color: Color(0xFF95C8D6).withOpacity(0.2),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                     margin: EdgeInsets.only(
    //                         left: MediaQuery.of(context).size.height * 0.020,
    //                         right: MediaQuery.of(context).size.height * 0.0,
    //                         top: MediaQuery.of(context).size.height * 0.0,
    //                         bottom: MediaQuery.of(context).size.height * 0.02),
    //                     // width: MediaQuery.of(context).size.height * 0.2,
    //                     height: MediaQuery.of(context).size.height * 0.35,
    //                     child: ListView.builder(
    //                       itemCount: categories.length,
    //                       itemBuilder: (context, index) {
    //                         return GestureDetector(
    //                           onTap: () {
    //                             setState(() {
    //                               selectedCategoryIndex = index;
    //                             });
    //                           },
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               color: selectedCategoryIndex == index
    //                                   ? Colors.white
    //                                   : Colors.transparent,
    //                               borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(8),
    //                                 bottomLeft: Radius.circular(8),
    //                               ),
    //                             ),
    //                             child: Stack(
    //                               children: [
    //                                 if (selectedCategoryIndex ==
    //                                     index) // Show the side line only for the selected cell
    //                                   Positioned(
    //                                     top: 6, // Gap from the top
    //                                     left: 0,
    //                                     bottom: 6, // Gap from the bottom
    //                                     child: Container(
    //                                       width: 2.0, // Same as border width
    //                                       color:  Color(0xFF126086), // Border color
    //                                     ),
    //                                   ),
    //                                 Container(
    //                                   padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
    //                                   child: Text(
    //                                     categories[index],
    //                                     style: TextStyle(
    //                                       color: selectedCategoryIndex == index
    //                                           ? Color(0xFF126086) : Colors.black87,
    //                                       fontSize: MediaQuery.of(context).size.height * 0.018,
    //                                       fontWeight: selectedCategoryIndex == index
    //                                           ? FontWeight.bold
    //                                           : FontWeight.normal,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                   ),
    //                 ),
    //
    //                 // Right Side: Filter Options
    //                 Expanded(
    //                   flex : 3,
    //                   child:
    //                   Container(
    //                     // width: MediaQuery.of(context).size.height * 0.28,
    //                     height: MediaQuery.of(context).size.height * 0.35,
    //                     padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0),
    //                     child: _getFilterWidget(categories[selectedCategoryIndex], context),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //
    //
    //
    //             GestureDetector(
    //               onTap: () async {
    //
    //               },
    //               child: Container(
    //                   alignment: Alignment.centerRight,
    //                   padding: EdgeInsets.only(
    //                       top:
    //                       MediaQuery.of(context).size.height * 0.01,
    //                       bottom:
    //                       MediaQuery.of(context).size.height * 0.00,
    //                       left:
    //                       MediaQuery.of(context).size.height * 0.00,
    //                       right: MediaQuery.of(context).size.height *
    //                           0.00),
    //                   margin: EdgeInsets.only(
    //                       right:
    //                       MediaQuery.of(context).size.height * 0.02,
    //                       top:
    //                       MediaQuery.of(context).size.height * 0.01,
    //                       bottom:
    //                       MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height *
    //                           0.02),
    //                   child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Expanded(
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(
    //                                     MediaQuery.of(context)
    //                                         .size
    //                                         .height *
    //                                         0.012),
    //                                 gradient: LinearGradient(
    //                                     begin: Alignment.centerRight,
    //                                     end: Alignment.center,
    //                                     stops: [
    //                                       0.5,
    //                                       0.9
    //                                     ],
    //                                     colors: [
    //                                       Color(0xFFA8B1CE),
    //                                       Color(0xFFA8B1CE),
    //                                     ])),
    //                             alignment: Alignment.center,
    //                             padding: EdgeInsets.only(left: 0.0),
    //                             child: TextButton(
    //                               onPressed: () async {
    //
    //                               },
    //                               child: Text("Apply Filters",
    //                                   textAlign: TextAlign.center,
    //                                   style: TextStyle(
    //                                       color: Colors.white,
    //                                       fontSize:
    //                                       MediaQuery.of(context)
    //                                           .size
    //                                           .height *
    //                                           0.026)),
    //                             ),
    //                           ),
    //                         ),
    //                       ])),
    //             )
    //
    //
    //
    //           ],
    //         ),
    //       ),
    // ),
  );

  // Dynamically return the filter widget based on the selected category
  // Widget _getFilterWidget(String category, BuildContext context) {
  //   switch (category) {
  //     case 'Must have tests':
  //       return _MusthavetestsFilterWidget(context);
  //     case 'Category':
  //       return _CategoryFilterWidget(context);
  //     default:
  //       return Container();
  //   }
  // }
  //
  //
  // // Area of Expertise
  // Widget _MusthavetestsFilterWidget(BuildContext context) {
  //   return ListView(
  //     // crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // Search Input Field
  //       GestureDetector(
  //         onTap: () {
  //
  //         },
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.06,
  //           alignment: Alignment.centerRight,
  //           padding: EdgeInsets.only(
  //             top: MediaQuery.of(context).size.height * 0.0,
  //             bottom: MediaQuery.of(context).size.height * 0.00,
  //             left: MediaQuery.of(context).size.height * 0.00,
  //             right: MediaQuery.of(context).size.height * 0.00,
  //           ),
  //           margin: EdgeInsets.only(
  //             right: MediaQuery.of(context).size.height * 0.01,
  //             top: MediaQuery.of(context).size.height * 0.0,
  //             bottom: MediaQuery.of(context).size.height * 0.01,
  //             left: MediaQuery.of(context).size.height * 0.01,
  //           ),
  //           child: AbsorbPointer(
  //             // Prevents the field from gaining focus or triggering gestures
  //             child: TextFormField(
  //               readOnly: true,
  //               controller: SearchfilterEditTextController,
  //               inputFormatters: [
  //                 LengthLimitingTextInputFormatter(15),
  //                 FilteringTextInputFormatter.allow(
  //                     RegExp('[a-zA-Z0-9]')),
  //               ],
  //               textCapitalization: TextCapitalization.characters,
  //               style: TextStyle(color: Colors.black45),
  //               keyboardType: TextInputType.emailAddress,
  //               validator: (input) => input!.length < 3
  //                   ? "Search should be more than 3 characters"
  //                   : null,
  //               decoration: InputDecoration(
  //                 isDense: true,
  //                 contentPadding:
  //                 EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
  //                 filled: true,
  //                 fillColor: Colors.grey[200],
  //                 hintText:
  //                 "Search",
  //                 hintStyle: TextStyle(
  //                   color: Colors.black26,
  //                   fontSize: MediaQuery.of(context).size.height * 0.016,
  //                 ),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(5.0),
  //                   borderSide: BorderSide(color: Colors.grey),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                   borderRadius:
  //                   BorderRadius.all(Radius.circular(5.0)),
  //                   borderSide: BorderSide(color: Colors.grey.shade200),
  //                 ),
  //                 suffixIcon: IconButton(
  //                   icon: Icon(
  //                     Icons.search,
  //                     color: Colors.black45,
  //                     size: MediaQuery
  //                         .of(context)
  //                         .size
  //                         .height * 0.02,
  //                   ),
  //                   onPressed: () {
  //
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //       Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Container(
  //             margin: EdgeInsets.only(
  //               left: MediaQuery.of(context).size.height * 0.00,
  //               right: MediaQuery.of(context).size.height * 0.00,
  //               bottom: MediaQuery.of(context).size.height * 0.0,
  //               top: MediaQuery.of(context).size.height * 0.00,
  //             ),
  //             child: ListView.builder(
  //               physics: ScrollPhysics(), // Ensures scrolling
  //               shrinkWrap: true, // Prevents ListView from taking up extra space
  //               scrollDirection: Axis.vertical, // Keeps the ListView vertical
  //               itemCount: musthavetests.length, // Use the diseases list length
  //               itemBuilder: (BuildContext context, int index) {
  //                 return GestureDetector(
  //                   onTap: () {
  //                     // Add your onTap logic here
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.only(
  //                       top: MediaQuery.of(context).size.height * 0.00,
  //                       bottom: MediaQuery.of(context).size.height * 0.01,
  //                       left: MediaQuery.of(context).size.height * 0.01,
  //                       right: MediaQuery.of(context).size.height * 0.0,
  //                     ),
  //                     padding: EdgeInsets.only(
  //                       top: MediaQuery.of(context).size.height * 0.00,
  //                       bottom: MediaQuery.of(context).size.height * 0.00,
  //                       left: MediaQuery.of(context).size.height * 0.00,
  //                       right: MediaQuery.of(context).size.height * 0.00,
  //                     ),
  //                     child: Row(
  //                       mainAxisSize: MainAxisSize.max, // Full width
  //                       children: <Widget>[
  //                         Container(
  //                           padding: EdgeInsets.only(
  //                             left: MediaQuery.of(context).size.height * 0.005,
  //                             right: MediaQuery.of(context).size.height * 0.005,
  //                             top: MediaQuery.of(context).size.height * 0.005,
  //                             bottom: MediaQuery.of(context).size.height * 0.005,
  //                           ),
  //                           margin: EdgeInsets.only(
  //                             left: MediaQuery.of(context).size.height * 0.0,
  //                             right: MediaQuery.of(context).size.height * 0.0,
  //                             top: MediaQuery.of(context).size.height * 0.0,
  //                             bottom: MediaQuery.of(context).size.height * 0.0,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: Color(0xFFEEEEEE),
  //                             borderRadius: BorderRadius.circular(5),
  //                           ),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center, // Center content
  //                             children: <Widget>[
  //                               Text(
  //                                 musthavetests[index], // Display disease name
  //                                 textAlign: TextAlign.center,
  //                                 style: TextStyle(
  //                                   color: Colors.black87,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: MediaQuery.of(context).size.height * 0.016,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //           // Additional widgets can be added here
  //         ],
  //       ),
  //
  //     ],
  //   );
  // }
  //
  //
  // // Category Filter Widget
  // Widget _CategoryFilterWidget(BuildContext context) {
  //   return ListView(
  //     // crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // Search Input Field
  //       GestureDetector(
  //         onTap: () {
  //
  //         },
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.06,
  //           alignment: Alignment.centerRight,
  //           padding: EdgeInsets.only(
  //             top: MediaQuery.of(context).size.height * 0.0,
  //             bottom: MediaQuery.of(context).size.height * 0.00,
  //             left: MediaQuery.of(context).size.height * 0.00,
  //             right: MediaQuery.of(context).size.height * 0.00,
  //           ),
  //           margin: EdgeInsets.only(
  //             right: MediaQuery.of(context).size.height * 0.01,
  //             top: MediaQuery.of(context).size.height * 0.0,
  //             bottom: MediaQuery.of(context).size.height * 0.01,
  //             left: MediaQuery.of(context).size.height * 0.01,
  //           ),
  //           child: AbsorbPointer(
  //             // Prevents the field from gaining focus or triggering gestures
  //             child: TextFormField(
  //               readOnly: true,
  //               controller: SearchfilterEditTextController,
  //               inputFormatters: [
  //                 LengthLimitingTextInputFormatter(15),
  //                 FilteringTextInputFormatter.allow(
  //                     RegExp('[a-zA-Z0-9]')),
  //               ],
  //               textCapitalization: TextCapitalization.characters,
  //               style: TextStyle(color: Colors.black45),
  //               keyboardType: TextInputType.emailAddress,
  //               validator: (input) => input!.length < 3
  //                   ? "Search should be more than 3 characters"
  //                   : null,
  //               decoration: InputDecoration(
  //                 isDense: true,
  //                 contentPadding:
  //                 EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
  //                 filled: true,
  //                 fillColor: Colors.grey[200],
  //                 hintText:
  //                 "Search",
  //                 hintStyle: TextStyle(
  //                   color: Colors.black26,
  //                   fontSize: MediaQuery.of(context).size.height * 0.016,
  //                 ),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(5.0),
  //                   borderSide: BorderSide(color: Colors.grey),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                   borderRadius:
  //                   BorderRadius.all(Radius.circular(5.0)),
  //                   borderSide: BorderSide(color: Colors.grey.shade200),
  //                 ),
  //                 suffixIcon: IconButton(
  //                   icon: Icon(
  //                     Icons.search,
  //                     color: Colors.black45,
  //                     size: MediaQuery
  //                         .of(context)
  //                         .size
  //                         .height * 0.02,
  //                   ),
  //                   onPressed: () {
  //
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //       Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Container(
  //             margin: EdgeInsets.only(
  //               left: MediaQuery.of(context).size.height * 0.00,
  //               right: MediaQuery.of(context).size.height * 0.00,
  //               bottom: MediaQuery.of(context).size.height * 0.0,
  //               top: MediaQuery.of(context).size.height * 0.00,
  //             ),
  //             child: ListView.builder(
  //               physics: ScrollPhysics(), // Ensures scrolling
  //               shrinkWrap: true, // Prevents ListView from taking up extra space
  //               scrollDirection: Axis.vertical, // Keeps the ListView vertical
  //               itemCount: categorieslast.length, // Use the diseases list length
  //               itemBuilder: (BuildContext context, int index) {
  //                 return GestureDetector(
  //                   onTap: () {
  //                     // Add your onTap logic here
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.only(
  //                       top: MediaQuery.of(context).size.height * 0.00,
  //                       bottom: MediaQuery.of(context).size.height * 0.01,
  //                       left: MediaQuery.of(context).size.height * 0.01,
  //                       right: MediaQuery.of(context).size.height * 0.0,
  //                     ),
  //                     padding: EdgeInsets.only(
  //                       top: MediaQuery.of(context).size.height * 0.00,
  //                       bottom: MediaQuery.of(context).size.height * 0.00,
  //                       left: MediaQuery.of(context).size.height * 0.00,
  //                       right: MediaQuery.of(context).size.height * 0.00,
  //                     ),
  //                     child: Row(
  //                       mainAxisSize: MainAxisSize.max, // Full width
  //                       children: <Widget>[
  //                         Container(
  //                           padding: EdgeInsets.only(
  //                             left: MediaQuery.of(context).size.height * 0.005,
  //                             right: MediaQuery.of(context).size.height * 0.005,
  //                             top: MediaQuery.of(context).size.height * 0.005,
  //                             bottom: MediaQuery.of(context).size.height * 0.005,
  //                           ),
  //                           margin: EdgeInsets.only(
  //                             left: MediaQuery.of(context).size.height * 0.0,
  //                             right: MediaQuery.of(context).size.height * 0.0,
  //                             top: MediaQuery.of(context).size.height * 0.0,
  //                             bottom: MediaQuery.of(context).size.height * 0.0,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: Color(0xFFEEEEEE),
  //                             borderRadius: BorderRadius.circular(5),
  //                           ),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center, // Center content
  //                             children: <Widget>[
  //                               Text(
  //                                 categorieslast[index], // Display disease name
  //                                 textAlign: TextAlign.center,
  //                                 style: TextStyle(
  //                                   color: Colors.black87,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: MediaQuery.of(context).size.height * 0.016,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //           // Additional widgets can be added here
  //         ],
  //       ),
  //
  //     ],
  //   );
  // }

   void addToCart(int id,String plan,String test,String qr) async{
     Map<String,dynamic> addToCart = {
       "id": id,
       "plan" : plan,
       "test" : test,
       "qr" : qr
     };

     print("addToCart : $addToCart");

     bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
     print("isGuestUser : $isGuestUser");
     String? username =  await UserSecureStorage.getUsernameid();

     Map<String, dynamic>? user = await UserSecureStorage.getUser(username ?? '');

     print("user : $user");

     if(isGuestUser){
       String userId = "GUEST";
       UserSecureStorage.saveAddToCard(key: "addToCart2",userId: userId, newData: addToCart);
     }
     else {
       String userId = username ?? '';
       UserSecureStorage.saveAddToCard(key: "addToCart2",userId: userId, newData: addToCart);
     }


     setState(() {
       addedList.insert(0, addToCart);
     });

   }

  void _deleteCart(int id,int index,{String? key}) async {

    bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
    String? username =  await UserSecureStorage.getUsernameid();

    if(isGuestUser) {
      username = "GUEST";
    }

    if(key == null || key.isEmpty){

      List<dynamic> addToCart2 = await UserSecureStorage.getAddToCart("addToCart2",username ?? '');
      print("addToCart2: $addToCart2");
      bool _loadedCartCache = addToCart2.any((item) => item['id'] == id);
      print("_loadedCartCache: $_loadedCartCache");
      print("id: $id , index : $index");
      setState(() {
        addedList.removeWhere((addedItem) => addedItem['id'] == id);
      });

      if(_loadedCartCache){
        await UserSecureStorage.deleteFromAddToCart(
          key: "addToCart2", // tumhara constant key name
          userId: username ?? '',
          index: index,
        );
      }
    }
  }

}
