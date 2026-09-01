import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Medications/medicationselecttime.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/utils/cart_provider.dart';
import 'package:provider/provider.dart';

// 1. Global Function jisko aap kahin se bhi call kar sakte hain
void showPaymentBottomSheet(BuildContext context,) => showModalBottomSheet(
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
            child:   BottomSheetForPaymentForLabTest( ),
          ),
        ),
      ],
    );
  },
);

// 2. Stateful Widget for the UI (Handles Radio Button State)
class BottomSheetForPaymentForLabTest extends StatefulWidget {

  @override
  BottomSheetForPaymentForLabTestState createState() => BottomSheetForPaymentForLabTestState();
}

class BottomSheetForPaymentForLabTestState extends State<BottomSheetForPaymentForLabTest> {
  final FocusNode _focusNode = FocusNode();

  DraggableScrollableController  _scrollController = DraggableScrollableController();



  @override
  void dispose() {


    _scrollController.dispose();
    super.dispose();
  }


  int? _selectedValue;
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {

    bool isPaymentSelected = _selectedValue != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.02),
          topRight: Radius.circular(MediaQuery.of(context).size.height * 0.02),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Takes only required height
            children: <Widget>[
              // Top Handle (Visual only, no drag functionality now)
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.0,
                  ),
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: MediaQuery.of(context).size.height * 0.006,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.0),

              // Title
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.020,
                    right: MediaQuery.of(context).size.height * 0.020,
                    top: MediaQuery.of(context).size.height * 0.030,
                    bottom: MediaQuery.of(context).size.height * 0.00),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Payment Methods",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.018),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                            ),
                            child: Text(
                              "Please Select a payment method",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.014,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Payment mode 1
              Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.height * 0.015,
                  right: MediaQuery.of(context).size.height * 0.015,
                ),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Color(0x24D9D9D9),
                  border: Border.all(
                    color: Color(0x0F000000),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.05,
                      height: MediaQuery.of(context).size.height * 0.05,
                      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: AssetImage('assets/visapay.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '**** **** 3434',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height * 0.016,
                              color: Color(0xB2000000),
                            ),
                          ),
                          Text(
                            'Visa',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.014,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<int>(
                      value: 1,
                      groupValue: _selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Payment mode 2
              Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.height * 0.015,
                  right: MediaQuery.of(context).size.height * 0.015,
                ),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Color(0x24D9D9D9),
                  border: Border.all(
                    color: Color(0x0F000000),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.05,
                      height: MediaQuery.of(context).size.height * 0.05,
                      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: AssetImage('assets/paypalpay.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '**** **** 3434',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height * 0.016,
                              color: Color(0xB2000000),
                            ),
                          ),
                          Text(
                            'Paypal',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.014,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<int>(
                      value: 2,
                      groupValue: _selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Payment mode 3
              Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.height * 0.015,
                  right: MediaQuery.of(context).size.height * 0.015,
                ),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Color(0x24D9D9D9),
                  border: Border.all(
                    color: Color(0x0F000000),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.05,
                      height: MediaQuery.of(context).size.height * 0.05,
                      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: AssetImage('assets/applepay.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Priya Krishamurty',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height * 0.016,
                              color: Color(0xB2000000),
                            ),
                          ),
                          Text(
                            'Apple Pay',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.014,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<int>(
                      value: 3,
                      groupValue: _selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Payment mode 4
              Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.height * 0.015,
                  right: MediaQuery.of(context).size.height * 0.015,
                ),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Color(0x24D9D9D9),
                  border: Border.all(
                    color: Color(0x0F000000),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.05,
                      height: MediaQuery.of(context).size.height * 0.05,
                      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: AssetImage('assets/googlepay.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Priya Krishamurty',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height * 0.016,
                              color: Color(0xB2000000),
                            ),
                          ),
                          Text(
                            'Google Pay',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.014,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Radio<int>(
                      value: 4,
                      groupValue: _selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Continue Button
              GestureDetector(
                // Sirf tabhi tap hoga jab koi payment method selected ho
                onTap: isPaymentSelected
                    ? () async {
                  Navigator.pop(context);
                  Future.delayed(Duration(milliseconds: 200), () {
                    showsucessalertBottomSheet();
                  });
                }
                    : () {
                  showTopNotification(
                      context,
                      title: 'Payment Methods',
                      message: 'Please select a payment method',
                      type: NotificationType.error);
                }, // Warna click disable ho jayega
                child: Container(
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.03,
                    left: MediaQuery.of(context).size.height * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height * 0.012),
                            // Payment select hone ke hisab se color change karein
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.center,
                              colors: isPaymentSelected
                                  ? [Color(0xFF126086), Color(0xFF126086)] // Active state
                                  : [Colors.grey.shade400, Colors.grey.shade400], // Disabled state
                            ),
                          ),
                          alignment: Alignment.center,
                          child: TextButton(
                            // Yaha bhi click logic add kiya hai
                            onPressed: isPaymentSelected
                                ? () async {
                              Navigator.pop(context);
                              Future.delayed(Duration(milliseconds: 200), () {
                                showsucessalertBottomSheet( );
                              });
                            }
                                : () {
                              showTopNotification(
                                  context,
                                  title: 'Payment Methods',
                                  message: 'Please select a payment method',
                                  type: NotificationType.error);
                            },
                            child: Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.02,
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
      ),
    );
  }


  void showsucessalertBottomSheet( ) => showModalBottomSheet(
    enableDrag: false,
    isScrollControlled: true,
    isDismissible: true,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    barrierColor: Colors.grey.withOpacity(0.8),
    context: context,
    backgroundColor: Colors.white
    ,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) =>
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(

                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.020,
                      right: MediaQuery.of(context).size.height * 0.020,
                      top: MediaQuery.of(context).size.height * 0.030,
                      bottom: MediaQuery.of(context).size.height * 0.00),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/paymentsucess.png',
                              height: MediaQuery.of(context).size.height * 0.30,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              "Thank you!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                MediaQuery.of(context).size.height * 0.02,
                                left: MediaQuery.of(context).size.height * 0.00,
                                right:
                                MediaQuery.of(context).size.height * 0.00,
                              ),
                              child: Text(
                                "Payment Done Successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize:
                                  MediaQuery.of(context).size.height *
                                      0.014,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(width: MediaQuery.of(context).size.height * 0.040),
                    ],
                  ),
                ),



                // Back to Home
                GestureDetector(
                  onTap: () async {
                    showTopNotification(
                        context,
                        title: 'Package',
                        message: 'Package added successfully.', type: NotificationType.success);

                    await Provider.of<CartProvider>(context, listen: false).clearCart();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomePageMain(),
                        ),
                            (Route route) => false,
                      );


                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.00,
                          right: MediaQuery.of(context).size.height * 0.00),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.height * 0.03,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.03),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.012),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.center,
                                        stops: [
                                          0.5,
                                          0.9
                                        ],
                                        colors: [
                                          Color(0xFF126086),
                                          Color(0xFF126086),
                                        ])),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 0.0),
                                child: TextButton(
                                  onPressed: () async {
                                    showTopNotification(
                                        context,
                                        title: 'Package',
                                        message: 'Package added successfully.', type: NotificationType.success);

                                    await Provider.of<CartProvider>(context, listen: false).clearCart();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => HomePageMain(),
                                      ),
                                          (Route route) => false,
                                    );


                                  },
                                  child: Text("Back to Home",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.016,
                                          fontWeight: FontWeight.w600

                                      )),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // ← Adjust this
                                    minimumSize: Size(0, 0), // Removes minimum button constraints
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap padding
                                  ),
                                ),
                              ),
                            ),
                          ])),
                ),


                const SizedBox(height: 16,),
              ],
            ),
          ),
    ),
  );



}