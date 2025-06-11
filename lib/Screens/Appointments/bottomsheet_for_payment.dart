import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Appointments/selecttimeslot.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';


class BottomSheetForPayment extends StatefulWidget {
  @override
  BottomSheetForPaymentState createState() => BottomSheetForPaymentState();
}

class BottomSheetForPaymentState extends State<BottomSheetForPayment> {
  final FocusNode _focusNode = FocusNode();

  DraggableScrollableController  _scrollController = DraggableScrollableController();



  @override
  void dispose() {


    _scrollController.dispose();
    super.dispose();
  }


  int? _selectedValue;
  int selectedCategoryIndex = 0;


  double _currentChildSize = 0.55;
  bool _isDismissed = false;
  double _lastExtent = 0.55;
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {


    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: _currentChildSize, // Start at 50% of screen height
      minChildSize: 0.3, // Minimum height (30% of screen)
      maxChildSize: 0.9, // Max height (90% of screen)
      expand: false,
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification){
            final currentExtent = notification.extent;

            // ✅ Hide keyboard when dragging down
            if (currentExtent < _lastExtent - 0.01) {
              print("Dragging down - Hiding keyboard");
              FocusScope.of(context).unfocus();
            }

            // ✅ Dismiss the sheet if dragged below threshold
            if (!_isDismissed &&
                currentExtent < _currentChildSize - 0.05) {
              _isDismissed = true;
              Navigator.of(context).pop(); // Dismiss sheet
            }

            _lastExtent = currentExtent;
            return true;

          },
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragUpdate: (details) {
              final newSize = (_sheetController.size ?? _currentChildSize) -
                  details.primaryDelta! / MediaQuery.of(context).size.height;

              _sheetController.jumpTo(
                newSize.clamp(0.3, 0.95),
              );
            },
            child: Container(
              decoration: BoxDecoration(
              color: Colors.white,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.02),
                    topRight: Radius.circular(MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Container(

                          padding: EdgeInsets.only(
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
                                .height * 0.18,
                            right: MediaQuery
                                .of(context)
                                .size
                                .height * 0.18,
                          ),
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
                            color: Color(0xFFD9D9D9), // Divider color
                            // color : Colors.red,
                            borderRadius: BorderRadius.circular(
                                10), // Rounded edges
                          ),
                        ),
                      ),
                      SizedBox(height : MediaQuery.of(context).size.height * 0.0),

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
                                        fontSize: MediaQuery.of(context).size.height *
                                            0.018
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.00,
                                      bottom:
                                      MediaQuery.of(context).size.height * 0.02,
                                      left: MediaQuery.of(context).size.height * 0.00,
                                      right:
                                      MediaQuery.of(context).size.height * 0.00,
                                    ),
                                    child: Text(
                                      "Please Select a payment metho",
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

                      // Payment mode
                      // 1
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.015,
                          right: MediaQuery.of(context).size.height * 0.015,
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.00,
                        ),
                        decoration: BoxDecoration(
                          color : Color(0x24D9D9D9),
                          border: Border.all(
                            color: Color(0x0F000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image from assets
                            Container(
                              width: MediaQuery.of(context).size.height * 0.05,
                              height: MediaQuery.of(context).size.height * 0.05,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.01,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/visapay.png'), // Replace with your asset path
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Column with two Text widgets
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '**** **** 3434',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.016,
                                      color: Color(0xB2000000),
                                    ),
                                  ),
                                  Text(
                                    'Visa',
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.014,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Circular Radio Button
                            Radio<int>(
                              value: 1, // The value for this radio button
                              groupValue: _selectedValue, // The currently selected value
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                                print('Selected Value: $value');
                              },
                            ),
                          ],
                        ),
                      ),

                      // 2
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.015,
                          right: MediaQuery.of(context).size.height * 0.015,
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.00,
                        ),
                        decoration: BoxDecoration(
                          color : Color(0x24D9D9D9),
                          border: Border.all(
                            color: Color(0x0F000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image from assets
                            Container(
                              width: MediaQuery.of(context).size.height * 0.05,
                              height: MediaQuery.of(context).size.height * 0.05,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.01,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/paypalpay.png'), // Replace with your asset path
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Column with two Text widgets
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '**** **** 3434',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.016,
                                      color: Color(0xB2000000),
                                    ),
                                  ),
                                  Text(
                                    'Paypal',
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.014,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Circular Radio Button
                            Radio<int>(
                              value: 2, // The value for this radio button
                              groupValue: _selectedValue, // The currently selected value
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                                print('Selected Value: $value');
                              },
                            ),
                          ],
                        ),
                      ),

                      // 3
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.height * 0.015,
                          right: MediaQuery.of(context).size.height * 0.015,
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.00,
                        ),
                        decoration: BoxDecoration(
                          color : Color(0x24D9D9D9),
                          border: Border.all(
                            color: Color(0x0F000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image from assets
                            Container(
                              width: MediaQuery.of(context).size.height * 0.05,
                              height: MediaQuery.of(context).size.height * 0.05,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.01,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/applepay.png'), // Replace with your asset path
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Column with two Text widgets
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Priya Krishamurty',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.016,
                                      color: Color(0xB2000000),
                                    ),
                                  ),
                                  Text(
                                    'Apple Pay',
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.014,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Circular Radio Button
                            Radio<int>(
                              value: 3, // The value for this radio button
                              groupValue: _selectedValue, // The currently selected value
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                                print('Selected Value: $value');
                              },
                            ),
                          ],
                        ),
                      ),

                      // 4
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.015,
                          right: MediaQuery.of(context).size.height * 0.015,
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.00,
                          left: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.height * 0.00,
                        ),
                        decoration: BoxDecoration(
                          color : Color(0x24D9D9D9),
                          border: Border.all(
                            color: Color(0x0F000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image from assets
                            Container(
                              width: MediaQuery.of(context).size.height * 0.05,
                              height: MediaQuery.of(context).size.height * 0.05,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.01,
                                right: MediaQuery.of(context).size.height * 0.01,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/googlepay.png'), // Replace with your asset path
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Column with two Text widgets
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Priya Krishamurty',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.016,
                                      color: Color(0xB2000000),
                                    ),
                                  ),
                                  Text(
                                    'Google Pay',
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height * 0.014,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Circular Radio Button
                            Radio<int>(
                              value: 4, // The value for this radio button
                              groupValue: _selectedValue, // The currently selected value
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                                print('Selected Value: $value');
                              },
                            ),
                          ],
                        ),
                      ),

                      // Continue
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          Future.delayed(Duration(milliseconds: 200), () {
                            showsucessalertBottomSheet();
                          });

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
                                          Navigator.pop(context);
                                          Future.delayed(Duration(milliseconds: 200), () {
                                            showsucessalertBottomSheet();
                                          });
                                        },
                                        child: Text("Continue",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.02)),

                                      ),
                                    ),
                                  ),
                                ])),
                      ),








                    ],
                  ),
                ),
              ),
            ),
          ),
        ) ; },
    );
  }


  void showsucessalertBottomSheet() => showModalBottomSheet(
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

                // Reschedule
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) {
                          return SelectTimeSlot("responselist![index].id");
                        },
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0,
                      bottom: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.height * 0.00,
                      right: MediaQuery.of(context).size.height * 0.00,
                    ),
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.03,
                      top: MediaQuery.of(context).size.height * 0.00,
                      bottom: MediaQuery.of(context).size.height * 0.0,
                      left: MediaQuery.of(context).size.height * 0.03,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF126086), // Border color
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.012),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 0.0),
                            child: TextButton(
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (BuildContext context) {
                                      return SelectTimeSlot("responselist![index].id!");
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Reschedule",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF126086),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.016,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // ← Adjust this
                                minimumSize: Size(0, 0), // Removes minimum button constraints
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap padding
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Back to Home
                GestureDetector(
                  onTap: () async {
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
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePageMain(),
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
              ],
            ),
          ),
    ),
  );



}