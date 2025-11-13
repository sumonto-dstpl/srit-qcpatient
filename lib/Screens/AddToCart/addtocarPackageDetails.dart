import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';

import 'package:newfolder/Screens/Medications/bottomsheet_for_payment.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';


class AddtocardPackageDetails extends StatefulWidget {

  String buttonName ;
  int id;
  String plan;
  String test;
  String qr;
  AddtocardPackageDetails(
      {
        super.key,
        this.buttonName = "Next",
        required this.id,
        required this.plan,
        required this.test,
        required this.qr
      }
      );

  @override
  State<AddtocardPackageDetails> createState() => _AddtocardPackageDetailsState();
}

class _AddtocardPackageDetailsState extends State<AddtocardPackageDetails> {
  List<String> testList = [

  "Calcium - Total",
  "CHEST PHYSIO + ROM EXERCISES",
  "CONSULTATION DENTAL - MEDICINE",
  "CONSULTATION GENERAL SURGERY",
  "CONSULTATION INTERNAL MEDICINE",
  "CONSULTATION O. B. G.",
  "CONSULTATION ORTHOPAEDICS",
  "Creatinine- Serum",
  "Differential Count( Automated Cell Counter )",
  "ECG",
  "ECHO-SCREENING",
  "ESR ( Automated )",
  "GGT (Gamma Glutamyl Transpeptidase)",
  "Glucose - Fasting",
  "Glucose - Post Prandial (Ppbs),"
  "Glycated Hemoglobin ( Hba1C )",
  "Haemoglobin ( Automated )",
  "HC Cardiology Consultation",
  "Lipid Profile",
  "MCV",
  "PAP Smear",
  "PCV (Packed Cell Volume) ( Automated )",
  "Peripheral Smear Examination(P.S)",
  "Platelet Count ( Automated )",
  "Protein Total",
  "RBC Count ( Automated )",
  "Serum Globulin",
  "SGOT ( )",
  "SGPT ( Alt )",
  "TC (Total Count)( Automated )",
  "TSH (Thyroid Stimulating Hormone)",
  "Ultrasound Abdomen",
  "Uric Acid - Serum",
  "Urine Complete Analysis",
  "xray chest PA",
  "Xray knee AP & lateral (L)",

  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height ;
    final screenWidth = MediaQuery.of(context).size.width ;
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.05,
              ),
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height * 0.01,
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.0,
                  left: MediaQuery.of(context).size.height * 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Arrow

                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.025,
                      width: MediaQuery.of(context).size.height * 0.025,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.00,
                        top: MediaQuery.of(context).size.height * 0.00,
                        right: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.00,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF126086).withOpacity(0.2),
                        // color : Colors.red,
                        shape: BoxShape.circle,
                        border:
                        Border.all(width: 0.0, color: Color(0xFF126086)),
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
// Login Text
                  Expanded(
                    child: Center(
                      child: Text(
                        "Package Details",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter",

                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
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
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,

                   children: [
                     Container(
                       margin: EdgeInsets.only(
                         right: screenHeight * 0.0,
                         top: screenHeight * 0.0,
                         bottom: screenHeight * 0.01,
                         left: screenHeight * 0.0,
                       ), // Responsive margin
                       height: MediaQuery.of(context).size.height * 0.22,
                       decoration: BoxDecoration(
                         // color: Color(0xFFC80000), // Fallback color if image fails to load
                         borderRadius: BorderRadius.circular(15),
                         image: DecorationImage(
                           image: AssetImage(
                               'assets/package_Bannar.png'), // Path to your banner image
                           fit: BoxFit.fill, // Adjust to cover the entire container
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
                         children: [
                           Expanded(
                               child: Container(

                                 padding: EdgeInsets.only(
                                     left: MediaQuery.of(context).size.height * 0.00,
                                     right: MediaQuery.of(context).size.height * 0.00,
                                     bottom: MediaQuery.of(context).size.height * 0.0,
                                     top: MediaQuery.of(context).size.height * 0.01),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Container(
                                       padding: EdgeInsets.only(
                                         top: screenHeight * 0.0,
                                         bottom: screenHeight * 0.00,
                                         left: screenHeight * 0.02,
                                         right: screenHeight * 0.00,
                                       ),
                                       child: Text(
                                         "${widget.plan}",
                                         style: TextStyle(
                                           fontSize: screenHeight * 0.018,
                                           color: Color(0xFF000000),
                                           fontWeight: FontWeight.w600,
                                         ),
                                         textAlign: TextAlign.left,
                                         maxLines: 1,
                                       ),
                                     ),
                                     Row( mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Container(
                                               padding: EdgeInsets.only(
                                                 top: screenHeight * 0.0,
                                                 bottom: screenHeight * 0.00,
                                                 left: screenHeight * 0.02,
                                                 right: screenHeight * 0.00,
                                               ),
                                               child: Text(
                                                 "For Individuals Between For All Ages",

                                                 style: TextStyle(
                                                   fontSize: screenHeight * 0.008,
                                                   color: Color(0x99000000),
                                                   fontWeight: FontWeight.w500,
                                                 ),
                                                 textAlign: TextAlign.left,
                                               ),
                                             ),
                                             Container(

                                               padding: EdgeInsets.only(
                                                 top: screenHeight * 0.0,
                                                 bottom: screenHeight * 0.00,
                                                 left: screenHeight * 0.02,
                                                 right: screenHeight * 0.00,
                                               ),
                                               child: Text(
                                                 "For All Ages",

                                                 style: TextStyle(
                                                   fontSize: screenHeight * 0.01,
                                                   color: Color(0x99000000),
                                                   fontWeight: FontWeight.w600,
                                                 ),
                                                 textAlign: TextAlign.left,
                                               ),
                                             ),

                                           ],
                                         )
                                       ],
                                     ),
                                     Row( mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Container(
                                                 padding: EdgeInsets.only(
                                                   top: screenHeight * 0.0,
                                                   bottom: screenHeight * 0.00,
                                                   left: screenHeight * 0.02,
                                                   right: screenHeight * 0.00,
                                                 ),
                                                 child: Image.asset(
                                                     "assets/gender.png",
                                                   fit: BoxFit.fill,
                                                   height: screenHeight * 0.025,
                                                   width: screenHeight * 0.025,
                                                 )
                                             ),
                                           ],
                                         ),
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Container(
                                               padding: EdgeInsets.only(
                                                 top: screenHeight * 0.0,
                                                 bottom: screenHeight * 0.00,
                                                 left: screenHeight * 0.01,
                                                 right: screenHeight * 0.00,
                                               ),
                                               child: Text(
                                                 "Gender",

                                                 style: TextStyle(
                                                   fontSize: screenHeight * 0.008,
                                                   color: Color(0x99000000),
                                                   fontWeight: FontWeight.w500,
                                                 ),
                                                 textAlign: TextAlign.left,
                                               ),
                                             ),
                                             Container(

                                               padding: EdgeInsets.only(
                                                 top: screenHeight * 0.0,
                                                 bottom: screenHeight * 0.00,
                                                 left: screenHeight * 0.01,
                                                 right: screenHeight * 0.00,
                                               ),
                                               child: Text(
                                                "Male & Female",

                                                 style: TextStyle(
                                                   fontSize: screenHeight * 0.01,
                                                   color: Color(0x99000000),
                                                   fontWeight: FontWeight.w600,
                                                 ),
                                                 textAlign: TextAlign.left,
                                               ),
                                             ),

                                           ],
                                         )
                                       ],
                                     ),
                                     Row( mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Container(
                                                 padding: EdgeInsets.only(
                                                   top: screenHeight * 0.0,
                                                   bottom: screenHeight * 0.00,
                                                   left: screenHeight * 0.02,
                                                   right: screenHeight * 0.00,
                                                 ),
                                                 child: Image.asset(
                                                   "assets/Location1.png",
                                                   fit: BoxFit.fill,
                                                   height: screenHeight * 0.025,
                                                   width: screenHeight * 0.025,
                                                 )
                                             ),
                                           ],
                                         ),
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Container(
                                               padding: EdgeInsets.only(
                                                 top: screenHeight * 0.0,
                                                 bottom: screenHeight * 0.00,
                                                 left: screenHeight * 0.01,
                                                 right: screenHeight * 0.00,
                                               ),
                                               child: Text(
                                                 "Location",

                                                 style: TextStyle(
                                                   fontSize: screenHeight * 0.008,
                                                   color: Color(0x99000000),
                                                   fontWeight: FontWeight.w500,
                                                 ),
                                                 textAlign: TextAlign.left,
                                               ),
                                             ),
                                             Container(

                                               padding: EdgeInsets.only(
                                                 top: screenHeight * 0.0,
                                                 bottom: screenHeight * 0.00,
                                                 left: screenHeight * 0.01,
                                                 right: screenHeight * 0.00,
                                               ),
                                               child: Text(
                                                 "QCT Hospital Doha, Qatar",

                                                 style: TextStyle(
                                                   fontSize: screenHeight * 0.01,
                                                   color: Color(0x99000000),
                                                   fontWeight: FontWeight.w600,
                                                 ),
                                                 textAlign: TextAlign.left,
                                               ),
                                             ),

                                           ],
                                         )
                                       ],
                                     ),
                                     Container(
                                       padding: EdgeInsets.only(
                                         top: screenHeight * 0.0,
                                         bottom: screenHeight * 0.00,
                                         left: screenHeight * 0.02,
                                         right: screenHeight * 0.00,
                                       ),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Container(

                                             decoration:BoxDecoration(
                                               color: Color(0xFF1E6285),
                                               borderRadius: BorderRadius.circular(screenHeight * 0.005),
                                             )
                                             ,
                                             child: Text(
                                               "${widget.qr}",
                                               style: TextStyle(
                                                 fontSize: screenHeight * 0.012,
                                                 fontWeight: FontWeight.w600,
                                                 color: Color(0xFFFFFFFF)
                                               ),
                                             ),
                                               padding : EdgeInsets.symmetric(
                                                 vertical: screenHeight * 0.005,
                                                 horizontal: screenWidth * 0.02
                                               )
                                           )
                                         ],
                                       ),
                                     )
                                   ],
                                 ),
                               )


                           )
                         ],
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.only(
                         left : screenWidth * 0.05,
                       ),
                       alignment: Alignment.centerLeft,
                       child: Text(
                           "41 Tests Included",
                         style: TextStyle(
                           color: Color(0xFF000000),
                           fontSize: screenHeight * 0.020,
                           fontWeight: FontWeight.w600,
                           fontFamily: "Inter",

                         ),
                         maxLines: 1,
                       ),
                     ),

                     Expanded(
                       child: Padding(
                         padding: EdgeInsets.only(
                           left : screenWidth * 0.05,
                         ),
                         child: Container(
                           padding: EdgeInsets.only(
                               left : screenWidth * 0.01,
                             ),
                           child: ListView.builder(
                             padding: EdgeInsets.zero,
                            itemCount: testList.length,
                            itemBuilder: (context,index) {
                              String test = testList[index];
                                     return Column(
                                       children: [
                                         Row(
                                           children: [
                                             Container(
                                               decoration: BoxDecoration(
                                                 color: Color(0x80000000),
                                                 shape: BoxShape.circle,
                                               ),
                                               height: screenHeight * 0.006,
                                               width: screenHeight * 0.006,
                                             ),
                                             SizedBox(width: screenWidth * 0.015,),
                                             Expanded(
                                               child: Container(
                                                 child: Text(
                                                   "$test",
                                                   style: TextStyle(
                                                     color: Color(0x80000000),
                                                     fontSize: screenHeight * 0.014,
                                                     fontWeight: FontWeight.w500,
                                                     fontFamily: "Inter",

                                                   ),
                                                   maxLines: 2,
                                                   overflow: TextOverflow.ellipsis,
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                         if (index == testList.length - 1)
                                           SizedBox(height: screenHeight * 0.06),
                                       ],
                                     );
                                     },
                                                      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: widget.buttonName != "no" ? SizedBox.shrink() : Container(
        height: screenHeight * 0.07,  // Outer circle height (adjust as needed)
        width: screenHeight * 0.07, // Outer circle width (adjust as needed)
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // Padding color (background ring)
        ),
        child: Padding(
          padding: EdgeInsets.all(
              screenHeight * 0.008), // Padding inside the outer circle
          child:

          FloatingActionButton(
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
            child:

            Container(
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
          )
              ,
        ),
      ),
      bottomNavigationBar:   widget.buttonName == "no"  ? Stack(
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
                    icon:

                    Container(
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
                        'assets/Home_ls.png',
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

                    label:   'Home'
                  ),
                  BottomNavigationBarItem(
                    icon:

                    Container(
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
                        'assets/MyReports_ls.png',
                        width: MediaQuery
                            .of(context)
                            .size
                            .height * 0.027,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.027,
                      ),
                    )
                          ,
                    label:  'My Reports'  ,
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
                    label:  'Upload'  ,
                  ),
                  BottomNavigationBarItem(
                    icon:

                    Container(
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
                    )
                         ,
                    label:  'Appointments'  ,
                  ),
                  BottomNavigationBarItem(
                    icon:

                    Container(
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
                        'assets/MyHealthls.png',
                        width: MediaQuery
                            .of(context)
                            .size
                            .height * 0.027,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.027,
                      ),
                    )
                         ,
                    label:   'My Health'  ,
                  ),
                ],
              ),
            ),
          ),
        ],
      ):  Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, -2), // Makes the shadow appear above
              blurRadius: 6,
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.12,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Book Appointment
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0,
                bottom: MediaQuery.of(context).size.height * 0.00,
                left: MediaQuery.of(context).size.height * 0.00,
                right: MediaQuery.of(context).size.height * 0.00,
              ),
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.height * 0.04,
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque, // ✅ makes the whole container tappable
                      onTap: () async {
                        if(widget.buttonName == "Add to Cart") {
                           addToCart(widget.id, widget.plan, widget.test, widget.qr);
                          Navigator.pop(context);
                        }
                        else {
                          showPaymentmethodsBottomSheet(context);
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * 0.012,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.center,
                            stops: [0.5, 0.9],
                            colors: [
                              Color(0xFF126086),
                              Color(0xFF126086),
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 0.0),
                        child: TextButton(
                          onPressed: () async {
                            if(widget.buttonName == "Add to Cart") {

                              addToCart(widget.id, widget.plan, widget.test, widget.qr);
                              Navigator.pop(context);
                            }
                            else {
                              showPaymentmethodsBottomSheet(context);
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 9.5,
                              horizontal: 12.0,
                            ),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "${widget.buttonName}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              MediaQuery.of(context).size.height * 0.018,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      )   ,
    );
  }

  void showPaymentmethodsBottomSheet(BuildContext context) => showModalBottomSheet(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent, // Transparent for blur
    barrierColor: Colors.transparent, // Disable dark overlay
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white, // White background for popup
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: BottomSheetForPaymentForMedication(),
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
    //             Container(
    //               padding: EdgeInsets.only(
    //                   left: MediaQuery.of(context).size.height * 0.020,
    //                   right: MediaQuery.of(context).size.height * 0.020,
    //                   top: MediaQuery.of(context).size.height * 0.030,
    //                   bottom: MediaQuery.of(context).size.height * 0.00),
    //               child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: <Widget>[
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Text(
    //                           "Payment Methods",
    //                           style: TextStyle(
    //                               color: Colors.black,
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: MediaQuery.of(context).size.height *
    //                                   0.024),
    //                         ),
    //                         Container(
    //                           padding: EdgeInsets.only(
    //                             top: MediaQuery.of(context).size.height * 0.00,
    //                             bottom:
    //                             MediaQuery.of(context).size.height * 0.02,
    //                             left: MediaQuery.of(context).size.height * 0.00,
    //                             right:
    //                             MediaQuery.of(context).size.height * 0.00,
    //                           ),
    //                           child: Text(
    //                             "Please Select a payment method",
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                                 color: Colors.black54,
    //                                 fontSize:
    //                                 MediaQuery.of(context).size.height *
    //                                     0.018),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //
    //                   // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
    //                 ],
    //               ),
    //             ),
    //
    //             // Payment mode
    //             // 1
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/visapay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           '**** **** 3434',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Visa',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 2
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/paypalpay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           '**** **** 3434',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Paypal',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 3
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.01,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/applepay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Priya Krishamurty',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Apple Pay',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // 4
    //             Container(
    //               margin: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.01,
    //               ),
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height * 0.00,
    //                 bottom: MediaQuery.of(context).size.height * 0.00,
    //                 left: MediaQuery.of(context).size.height * 0.01,
    //                 right: MediaQuery.of(context).size.height * 0.00,
    //               ),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: Colors.grey,
    //                   width: 1.0,
    //                 ),
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Image from assets
    //                   Container(
    //                     width: MediaQuery.of(context).size.height * 0.07,
    //                     height: MediaQuery.of(context).size.height * 0.07,
    //                     margin: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.01,
    //                       right: MediaQuery.of(context).size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(4.0),
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/googlepay.png'), // Replace with your asset path
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   // Column with two Text widgets
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           'Priya Krishamurty',
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.018,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                         Text(
    //                           'Google Pay',
    //                           style: TextStyle(
    //                             fontSize:
    //                             MediaQuery.of(context).size.height * 0.016,
    //                             color: Colors.black,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Circular Radio Button
    //                   Radio<int>(
    //                     value: 1, // The value for this radio button
    //                     groupValue: 0, // The currently selected value
    //                     onChanged: (int? value) {
    //                       // Handle radio button change
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //             // Continue
    //             GestureDetector(
    //               onTap: () async {
    //                 showsucessalertBottomSheet();
    //               },
    //               child: Container(
    //                   alignment: Alignment.centerRight,
    //                   padding: EdgeInsets.only(
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.00,
    //                       left: MediaQuery.of(context).size.height * 0.00,
    //                       right: MediaQuery.of(context).size.height * 0.00),
    //                   margin: EdgeInsets.only(
    //                       right: MediaQuery.of(context).size.height * 0.03,
    //                       top: MediaQuery.of(context).size.height * 0.01,
    //                       bottom: MediaQuery.of(context).size.height * 0.01,
    //                       left: MediaQuery.of(context).size.height * 0.03),
    //                   child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: <Widget>[
    //                         Expanded(
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(
    //                                     MediaQuery.of(context).size.height *
    //                                         0.012),
    //                                 gradient: LinearGradient(
    //                                     begin: Alignment.centerRight,
    //                                     end: Alignment.center,
    //                                     stops: [
    //                                       0.5,
    //                                       0.9
    //                                     ],
    //                                     colors: [
    //                                       Color(0xFF126086),
    //                                       Color(0xFF126086),
    //                                     ])),
    //                             alignment: Alignment.center,
    //                             padding: EdgeInsets.only(left: 0.0),
    //                             child: TextButton(
    //                               onPressed: () async {
    //                                 showsucessalertBottomSheet();
    //                               },
    //                               child: Text("Continue",
    //                                   textAlign: TextAlign.center,
    //                                   style: TextStyle(
    //                                       color: Colors.white,
    //                                       fontSize: MediaQuery.of(context)
    //                                           .size
    //                                           .height *
    //                                           0.02)),
    //                             ),
    //                           ),
    //                         ),
    //                       ])),
    //             ),
    //           ],
    //         ),
    //       ),
    // ),
  );

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

      /* widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;*/

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
            // vsync: Navigator.of(context),
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
                                                                      'assets/AppointmentBs.png',
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