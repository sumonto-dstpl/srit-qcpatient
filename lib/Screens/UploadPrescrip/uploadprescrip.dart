import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dotted_border/dotted_border.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:newfolder/Data/APIServices/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UploadPrescriptionMain extends StatefulWidget {
  int selectedIndex = 0;

  UploadPrescriptionMain({
    super.key,
  });

  @override
  State<UploadPrescriptionMain> createState() => UploadPrescriptionMainstate();
}

class UploadPrescriptionMainstate extends State<UploadPrescriptionMain> {
  String usernameValue = "Upload Prescription";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";

  final picker = ImagePicker();
  final storage = FlutterSecureStorage();
  APIService apiService = new APIService();


  Future<void> capturePhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await saveImageAndUpload(pickedFile);
    }
  }

  Future<void> selectFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await saveImageAndUpload(pickedFile);
    }
  }
  Future<void> saveImageAndUpload(XFile pickedFile) async {
    final tempFile = File(pickedFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(tempFile.path);
    final savedImage = await tempFile.copy('${appDir.path}/$fileName');

    // // Save to secure storage
    // await storage.write(key: 'saved_image', value: savedImage.path);
    // await storage.write(key: 'saved_image_name', value: fileName);

    // Upload to API
    final bytes = await savedImage.readAsBytes();
    String base64Data = base64Encode(bytes);
    apiService.uploadPrescription(fileName,base64Data);


  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height ;
    final screenWidth =  MediaQuery.of(context).size.height ;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  top: screenHeight * 0.055,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  bottom: screenWidth * 0.02,
                ),
                margin: EdgeInsets.only(
                  right: screenHeight * 0.0,
                  top: screenHeight * 0.01,
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

                    Padding(
                      padding: EdgeInsets.only(left : MediaQuery.of(context).size.height * 0.00),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top:
                              MediaQuery.of(context).size.height * 0.00,
                              bottom:
                              MediaQuery.of(context).size.height * 0.00,
                              left:
                              MediaQuery.of(context).size.height * 0.00,
                              right:
                              MediaQuery.of(context).size.height * 0.00,
                            ),
                            child: Text(
                              usernameValue,
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height *
                                    0.02,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // Align items to the start
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.00,
                                    horizontal: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.00,
                                  ),
                                  child: Text(
                                    useraddressValue,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.012,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),

                                Icon(
                                  Icons.keyboard_arrow_down,
                                  // Downward pointing arrow
                                  color: Colors.white,
                                  size: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02, // Responsive size
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                                0.04,
                            width: MediaQuery
                                .of(context)
                                .size
                                .height *
                                0.04,
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

              // Main Content Section
              Expanded(
                child: Container(
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
                          .height * 0.0),
                 
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 0.03),
                      topRight: Radius.circular(screenHeight * 0.03),
                    ),
                  ),
                  child: ListView(
                    children: [
                      // Top Dotted
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.015,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.150,
                        child: DottedBorder(
                          color: Color(0xFF343434).withOpacity(0.3),
                          strokeWidth: 1,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8),
                          child: Center(
                            // Ensures the content is centered within the border
                            child: Container(
                              width: double.infinity,
                              color: Color(0x33D9D9D9),
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.04,
                              ), // Optional padding for inner content
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Aligns content vertically
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // Aligns content horizontally
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.0,
                                        right:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.00,
                                        top:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.015,
                                            // 0.015,
                                        bottom:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.015),
                                            // 0.015),
                                    child: Text(
                                      "What is a valid Prescription?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1F1F1F),
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height *
                                              0.015),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  // Column
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Background color
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2),
                                          // Shadow color
                                          offset: Offset(0,
                                              5),
                                          // Shadow direction (downwards)
                                          blurRadius:
                                          10, // Spread of the shadow
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.only(
                                        left:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.02,
                                        right:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.02,
                                        top:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.02,
                                        bottom:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.02),
                                    margin: EdgeInsets.only(
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.0,
                                      top: MediaQuery
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
                                      right:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center, // Aligns content vertically
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, // Aligns content horizontally
                                      children: <Widget>[
                                        // SAMPLE PRESCRIPTION Text
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.035,
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.00,
                                            bottom: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.0,
                                            right: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.0,
                                          ),
                                          child: Text(
                                            "SAMPLE PRESCRIPTION",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF126086),
                                                fontSize: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.012),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                        // 1st Row
                                        Row(                                          
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            // Column with 3 texts and a border

                                            Container(
                                              // width: MediaQuery
                                              //     .of(context)
                                              //     .size
                                              //     .height * 0.170,
                                              // color: Colors.blue,
                                              padding: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                              ),
                                              margin: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.02,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height *
                                                    0.0,
                                              ),
                                              child: DottedBorder(
                                                  color: Colors
                                                      .black38,
                                                  // Border color
                                                  strokeWidth:
                                                  1,
                                                  // Border thickness
                                                  dashPattern: [
                                                    3,
                                                    3
                                                  ],
                                                  // Dotted line pattern (6px line, 3px space)
                                                  borderType: BorderType
                                                      .RRect,
                                                  // Rounded corners
                                                  radius: Radius.circular(
                                                      10),
                                                  // Corner radius
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                    ),
                                                    child: Column(
                                                      
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                              left:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
                                                              right:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
                                                              top:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.0,
                                                              bottom:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00),
                                                          child: Text(
                                                            "Dr. Nutan Bhatt",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .w800,
                                                                color: Color(
                                                                    0xFF1F1F1F),
                                                                fontSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.014),
                                                            // overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                              left:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
                                                              right:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
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
                                                                  0.00),
                                                          child: Text(
                                                            "Name of the Hospital/Clinic",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Color(
                                                                    0xFF000000)
                                                                    .withOpacity(
                                                                    0.5),
                                                                fontSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.011),
                                                            // overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                              left:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
                                                              right:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
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
                                                                  0.00),
                                                          child: Text(
                                                            "Address of Hospital/Clinic",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Color(
                                                                    0xFF000000)
                                                                    .withOpacity(
                                                                    0.5),
                                                                fontSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.011),
                                                            // overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .only(
                                                              left:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
                                                              right:
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.00,
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
                                                                  0.0),
                                                          child: Text(
                                                            "Reg.no : 13432442",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Color(
                                                                    0xFF000000)
                                                                    .withOpacity(
                                                                    0.5),
                                                                fontSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height *
                                                                    0.011),
                                                            // overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  )),
                                            ),

                                            // Divider

                                            Expanded(
                                              // flex: 2,
                                              child: Row(
                                                children: List.generate(
                                                    200 ~/ 10, (index) =>
                                                    Expanded(
                                                      child: Container(
                                                        color: index % 2 == 0
                                                            ? Colors.transparent
                                                            : Colors.grey,
                                                        height: 1,
                                                      ),
                                                    )),
                                              ),
                                            )
                                            ,

                                            // Row containing 2 texts
                                            Container(
                                              // color: Colors.blue,
                                              // width: MediaQuery
                                              //     .of(context)
                                              //     .size
                                              //     .height * 0.170,
                                              // Adjust size as needed
                                              // height: MediaQuery.of(context).size.height * 0.038,
                                            
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF126086)
                                                          .withOpacity(0.2),
                                                      // Background color
                                                      shape: BoxShape
                                                          .circle, // Makes the container circular
                                                    ),
                                                    child: Text(
                                                      "1",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Color(
                                                            0xFF126086),
                                                        fontSize: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.016,
                                                      ),
                                                    ),
                                                  )
                                                  ,
                                                  Container(
                                                    padding: EdgeInsets.only(
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
                                                            0.00,
                                                        top:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.01,
                                                        bottom:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Text(
                                                      "Doctor’s Details",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          color: Color(
                                                              0xFF126086),
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height *
                                                              0.01),
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        // 2nd Row
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            // Column with 3 texts and a border

                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              margin: EdgeInsets.only(
                                                left: MediaQuery
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
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              child: DottedBorder(
                                                color: Colors.black38,
                                                strokeWidth: 1,
                                                dashPattern: [3, 3],
                                                borderType: BorderType.RRect,
                                                radius: Radius.circular(5),
                                                child: Container(
                                                   padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                    ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                          right: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                          bottom: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                        ),
                                                        child: Image.asset(
                                                          'assets/medicationdate.png',
                                                          // Replace with your image path
                                                          width: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.150,
                                                          // Adjust size as needed
                                                          height: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.038,
                                                          fit: BoxFit
                                                              .fill, // Adjust the fit based on your design
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),


                                            // Divider

                                            Expanded(
                                              // flex: 3,
                                              child: Row(
                                                children: List.generate(
                                                    200 ~/ 8, (index) =>
                                                    Expanded(
                                                      child: Container(
                                                        color: index % 2 == 0
                                                            ? Colors.transparent
                                                            : Colors.grey,
                                                        height: 1,
                                                      ),
                                                    )),
                                              ),
                                            )
                                            ,

                                            // Row containing 2 texts
                                            Container(
                                              // width: MediaQuery
                                              //     .of(context)
                                              //     .size
                                              //     .height * 0.170,
                                              // Adjust size as needed
                                              // height: MediaQuery.of(context).size.height * 0.038,
                                              margin: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              child:
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Wrap(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          right: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                          bottom: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.01,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF126086)
                                                              .withOpacity(0.2),
                                                          // Background color
                                                          shape: BoxShape
                                                              .circle, // Makes the container circular
                                                        ),
                                                        child: Text(
                                                          "2",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Color(
                                                                0xFF126086),
                                                            fontSize: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.016,
                                                          ),
                                                        ),
                                                      )
                                                      ,
                                                      Container(
                                                        padding: EdgeInsets.only(
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
                                                                0.00,
                                                            top:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.01,
                                                            bottom:
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height *
                                                                0.00),
                                                        child: Text(
                                                          "Date of Prescriptions",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              color: Color(
                                                                  0xFF126086),
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height *
                                                                  0.01),
                                                          // overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),

                                        // 3rd Row
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            // Column with 3 texts and a border

                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              margin: EdgeInsets.only(
                                                left: MediaQuery
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
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              child: DottedBorder(
                                                color: Colors.black38,
                                                strokeWidth: 1,
                                                dashPattern: [3, 3],
                                                borderType: BorderType.RRect,
                                                radius: Radius.circular(5),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                    ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                          right: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                          bottom: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.00,
                                                        ),
                                                        child: Image.asset(
                                                          'assets/medicationpatientdetails.png',
                                                          // Replace with your image path
                                                          width: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.170,
                                                          // Adjust size as needed
                                                          height: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.038,
                                                          fit: BoxFit
                                                              .fill, // Adjust the fit based on your design
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),


                                            // Divider

                                            Expanded(
                                              // flex: 3,
                                              child: Row(
                                                children: List.generate(
                                                    200 ~/ 10, (index) =>
                                                    Expanded(
                                                      child: Container(
                                                        color: index % 2 == 0
                                                            ? Colors.transparent
                                                            : Colors.grey,
                                                        height: 1,
                                                      ),
                                                    )),
                                              ),
                                            )
                                            ,

                                            // Row containing 2 texts
                                            Container(
                                              // width: MediaQuery
                                              //     .of(context)
                                              //     .size
                                              //     .height * 0.170,
                                              // Adjust size as needed
                                              // height: MediaQuery.of(context).size.height * 0.038,
                                              margin: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              child:
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF126086)
                                                          .withOpacity(0.2),
                                                      // Background color
                                                      shape: BoxShape
                                                          .circle, // Makes the container circular
                                                    ),
                                                    child: Text(
                                                      "3",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Color(
                                                            0xFF126086),
                                                        fontSize: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.016,
                                                      ),
                                                    ),
                                                  )
                                                  ,
                                                  Container(
                                                    padding: EdgeInsets.only(
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
                                                            0.00,
                                                        top:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.01,
                                                        bottom:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Text(
                                                      "Patient’s Details",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          color: Color(
                                                              0xFF126086),
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height *
                                                              0.01),
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),

                                        // 4th Row
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            // Column with 3 texts and a border

                                            Container(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              margin: EdgeInsets.only(
                                                left: MediaQuery
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
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              child: DottedBorder(
                                                color: Colors.black38,
                                                strokeWidth: 1,
                                                dashPattern: [3, 3],
                                                borderType: BorderType.RRect,
                                                radius: Radius.circular(5),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          0.01,
                                                    ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                          left: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.005,
                                                          top: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.005,
                                                          right: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.005,
                                                          bottom: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.005,
                                                        ),
                                                        child: Image.asset(
                                                          'assets/medicationmedicinedetails.png',
                                                          // Replace with your image path
                                                          width: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.150,
                                                          // Adjust size as needed
                                                          height: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height * 0.035,
                                                          fit: BoxFit
                                                              .fill, // Adjust the fit based on your design
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),


                                            // Divider

                                            Expanded(
                                              // flex: 3,
                                              child: Row(
                                                children: List.generate(
                                                    200 ~/ 17, (index) =>
                                                    Expanded(
                                                      child: Container(
                                                        color: index % 2 == 0
                                                            ? Colors.transparent
                                                            : Colors.grey,
                                                        height: 1,
                                                      ),
                                                    )),
                                              ),
                                            )
                                            ,

                                            // Row containing 2 texts
                                            Container(
                                              // width: MediaQuery
                                              //     .of(context)
                                              //     .size
                                              //     .height * 0.165,
                                              // Adjust size as needed
                                              // height: MediaQuery.of(context).size.height * 0.038,
                                              margin: EdgeInsets.only(
                                                left: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                                right: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.0,
                                              ),
                                              child:
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      right: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      top: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                      bottom: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height * 0.01,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF126086)
                                                          .withOpacity(0.2),
                                                      // Background color
                                                      shape: BoxShape
                                                          .circle, // Makes the container circular
                                                    ),
                                                    child: Text(
                                                      "4",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        color: Color(
                                                            0xFF126086),
                                                        fontSize: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height * 0.016,
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    padding: EdgeInsets.only(
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
                                                            0.00,
                                                        top:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.01,
                                                        bottom:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height *
                                                            0.00),
                                                    child: Text(
                                                      "Medicine Details",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          color: Color(
                                                              0xFF126086),
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .height *
                                                              0.01),
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.05,
                        ),
                        padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0,
                          right: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0,
                          bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.00,
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),

                            topRight: Radius.circular(20.0),

                            bottomLeft: Radius.circular(0.0),

                            bottomRight: Radius.circular(
                                0.0), // Remove bottom-right curve
                          ),
                          border: Border(
                            top: BorderSide(
                              color: Colors.black12,
                              // Specify your desired top border color here
                              width: 2.0, // Adjust border width as needed
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.012,
                                bottom: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.0,
                                left: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.0,
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.0,
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
                                    .height * 0.18,
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.18,
                              ),
                              child: Divider(
                                height: 0,
                                indent: 0,
                                thickness: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.008,
                                color: Color(0xFF95C8D6).withOpacity(0.3),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.01),
                              color: Colors.white,
                              child: Text(
                                "Upload Prescription From:",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.016,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),


                            // Gallery and camera


                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
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
                                      .height * 0.01,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.01),
                              child:

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () async {
                                       selectFromGallery();
                                    },
                                    child: Container(
                                      width: screenHeight * 0.19,
                                      height: screenHeight * 0.13,
                                      padding: new EdgeInsets.only(
                                          left: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.035,
                                          right: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.035,
                                          top: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.01,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.01),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF126086),
                                        borderRadius: BorderRadius.circular(5),
                                      ),


                                      margin: EdgeInsets.only(
                                        left: MediaQuery
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
                                            .height * 0.00,
                                        right: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.005,
                                      ),
                                      // color: Colors.grey[300],
                                      alignment: Alignment.center,
                                      // height:
                                      // MediaQuery.of(context).size.height * 0.070,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              selectFromGallery();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.01,
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.01,
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00,
                                                  top: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.01),
                                              width: screenHeight * 0.07,
                                              height: screenHeight * 0.07,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    screenHeight * 0.01),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/medicationgallery.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
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
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.00,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.005),
                                            // color: Colors.white,
                                            child: Text(
                                              "Gallery",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.014,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {

                                      capturePhoto();
                                    },
                                    child: Container(
                                      width: screenHeight * 0.19,
                                      height: screenHeight * 0.13,
                                      padding: new EdgeInsets.only(
                                          left: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.035,
                                          right: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.035,
                                          top: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.01,
                                          bottom: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.01),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF126086),
                                        borderRadius: BorderRadius.circular(5),
                                      ),


                                      margin: EdgeInsets.only(
                                        left: MediaQuery
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
                                            .height * 0.00,
                                        right: MediaQuery
                                            .of(context)
                                            .size
                                            .height * 0.005,
                                      ),
                                      // color: Colors.grey[300],
                                      alignment: Alignment.center,
                                      // height:
                                      // MediaQuery.of(context).size.height * 0.070,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              capturePhoto();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.01,
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.01,
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.00,
                                                  top: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.01),
                                              width: screenHeight * 0.07,
                                              height: screenHeight * 0.07,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    screenHeight * 0.01),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/medicationcamera.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
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
                                                bottom: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.00,
                                                top: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.005),
                                            // color: Colors.white,
                                            child: Text(
                                              "Camera",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.014,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ),


                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.01),
                              color: Colors.white,
                              child: Text(
                                "Don’t have a valid Prescription?",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.012,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.02,
                                  right: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.0,
                                  bottom: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.00,
                                  top: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.01),
                              color: Colors.white,
                              child: Text(
                                "Click Here for QuadraCyte Doctor Consultation",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.012,
                                    color: Color(0xFF126086),
                                    fontWeight: FontWeight.w500
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
            ],
          ),
        ]),
      ),


    );
  }


}
