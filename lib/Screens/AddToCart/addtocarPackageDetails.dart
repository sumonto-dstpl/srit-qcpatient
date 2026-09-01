import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newfolder/Core/Dialog/bottom_payment_method.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:provider/provider.dart';
import '../../utils/cart_provider.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';


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
  List<dynamic> addedList=[];
  bool isInCart =false;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // _loadData();

  }
  @override
  void dispose() {
    _scrollController.dispose(); // Yeh add karein
    super.dispose();
  }

  void _loadData() async {
    var guestUser = await UserSecureStorage.getIfGuestLogged();
    // print("guestUser: $guestUser");
    final isGuestUser=guestUser == "YES";

    if(!isGuestUser) {
      String? username = await UserSecureStorage.getUsernameid();

      List<dynamic> _loadedCart2  = await UserSecureStorage.getAddToCart("addToCart2",username ?? '');

      // if(_loadedCart2.isNotEmpty){
      //   print("_loadedCart2.length:${_loadedCart2.length}");
      //   bool status =_loadedCart2.any((addedItem) => addedItem['id'] == widget.id);
      //   setState(() {
      //     isInCart =status;
      //   });
      // }

    }
  }
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height ;
    final screenWidth = MediaQuery.of(context).size.width ;

    final cart = Provider.of<CartProvider>(context);
    bool isInCart = cart.isAdded(widget.id);

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

                                         left: screenHeight * 0.02,

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
                           left: screenWidth * 0.05,
                           right: screenWidth * 0.01,
                         ),
                         child: Container(
                           padding: EdgeInsets.only(
                             left: screenWidth * 0.01,
                           ),

                           // ✅ YAHAN CUSTOM DRAGGABLE SCROLLBAR LAGAYA HAI
                           child: DraggableScrollbar(
                             controller: _scrollController,
                             alwaysVisibleScrollThumb: true, // Hamesha dikhega
                             backgroundColor: Color(0xFF126086),
                             heightScrollThumb: 40.0, // Slider ki Lambaai

                             // ✅ APNA CUSTOM DESIGN: Bina shadow ke aur patla
                             scrollThumbBuilder: (
                                 Color backgroundColor,
                                 Animation<double> thumbAnimation,
                                 Animation<double> labelAnimation,
                                 double height, {
                                   Text? labelText,
                                   BoxConstraints? labelConstraints,
                                 }) {
                               return Container(
                                 height: height,
                                 width: 6.0, // ✅ YAHAN SE PATLA HOGA (Aap isko 4.0 ya 5.0 bhi kar sakte hain)
                                 margin: EdgeInsets.only(right: 2.0),
                                 decoration: BoxDecoration(
                                   color: backgroundColor, // Blue color
                                   borderRadius: BorderRadius.circular(10.0), // Kinare gol
                                   // ❌ Yahan humne koi BoxShadow nahi dala hai, toh shadow nahi aayegi
                                 ),
                               );
                             },

                             child: ListView.builder(
                               controller: _scrollController,
                               padding: EdgeInsets.zero,
                               itemCount: testList.length,
                               itemBuilder: (context, index) {
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
                     ),






                   ],
                 ),
               ),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: widget.buttonName != "no" ? SizedBox.shrink() : CustomFloatingActionButton(),
      bottomNavigationBar:   widget.buttonName == "no"  ? CustomBottomNavigationBar(selectedIndex: _selectedIndex):
      !isInCart
          ?
      Container(
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
                          await cart.addItem({
                            "id": widget.id,
                            "plan": widget.plan,
                            "test": widget.test,
                            "qr": widget.qr,
                          });
                          // Navigator.pop(context);
                        }
                        else {
                          showPaymentBottomSheet(context) ;
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

                              await cart.addItem({
                                "id": widget.id,
                                "plan": widget.plan,
                                "test": widget.test,
                                "qr": widget.qr,
                              });
                              // Navigator.pop(context);
                            }
                            else {
                              showPaymentBottomSheet(context);
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
      ) : SizedBox.shrink()

    );
  }



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
      isInCart =true;
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
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      settings: const RouteSettings(
                                                        name: 'appointments',
                                                      ),
                                                      builder: (_) => AppointmentsFootMain(

                                                      ),
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