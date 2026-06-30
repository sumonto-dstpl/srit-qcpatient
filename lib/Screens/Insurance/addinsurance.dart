import 'dart:convert';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Data/APIServices/connectivity_service.dart';
import 'package:newfolder/Screens/AddToCart/addtocart.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointmentsfoot/appointmentsfootmain.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/MyHealth/myhealthmain.dart';
import 'package:newfolder/Screens/MyReports/myreportsmain.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Profile/profilemain.dart';
import 'package:newfolder/Screens/TestAndServices/testandservicesmain.dart';
import 'package:newfolder/Screens/UploadPrescrip/uploadprescrip.dart';
import 'package:newfolder/Screens/Widgets/UploadBox.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:newfolder/Screens/Widgets/custom_type_calender.dart';
import 'package:newfolder/Core/Header/header.dart';
import 'package:newfolder/Core/Image%20Action/floating_action_button.dart';
import 'package:newfolder/Core/bottom_navigation_bar.dart';
class AddInsuranceMain extends StatefulWidget {
  int selectedIndex = 0;

  Map? item;
  AddInsuranceMain({
    super.key,
    this.item,
  });

  @override
  State<AddInsuranceMain> createState() => AddInsuranceMainstate();
}

class AddInsuranceMainstate extends State<AddInsuranceMain> {
  String usernameValue = "Add New Insurance";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";
  int _selectedIndex = 0;

  String? selectedCity;

  String? selectedCountryId;






  TextEditingController InsurnceProviderTextController =TextEditingController();

  TextEditingController NationalIDTextController = TextEditingController();
  TextEditingController PolicyNameEditTextController = TextEditingController();
  TextEditingController StartDateController = TextEditingController();
  TextEditingController ExpiryDateTextController = TextEditingController();
  TextEditingController PrimaryinsuredNameTextController = TextEditingController();

  TextEditingController InsuranceTypeTextController = TextEditingController();
  TextEditingController CoverageLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Agar item null nahi hai, matlab edit mode
    if (widget.item != null) {
      usernameValue = 'Edit Insurance' ;
      InsurnceProviderTextController.text = widget.item!['insuranceProvider'] ?? '';
      NationalIDTextController.text = widget.item!['nationalId'] ?? '';
      PolicyNameEditTextController.text = widget.item!['policyName'] ?? '';
      StartDateController.text = widget.item!['startDate'] ?? '';
      ExpiryDateTextController.text = widget.item!['expiryDate'] ?? '';
      PrimaryinsuredNameTextController.text = widget.item!['primaryInsuredName'] ?? '';
      InsuranceTypeTextController.text = widget.item!['insuranceType'] ?? '';
      CoverageLimitController.text = widget.item!['coverageLimit'] ?? '';

      checkSubmitButtonEnabled();
    }
  }


  ConnectivityService connectivityservice = ConnectivityService();

  String? errorMessage;
  bool isValid = false;
  bool hasStartedTyping = false;

  String? nationalIDerrorMessage;
  bool nationalIDisValid = false;
  bool nationalIDhasStartedTyping = false;

  String? policynameerrorMessage;
  bool policynameisValid = false;
  bool policynamehasStartedTyping = false;

  String? startDateerrorMessage;
  bool startDateisValid = false;
  bool startDatehasStartedTyping = false;

  String? expiryDateerrorMessage;
  bool expiryDateisValid = false;
  bool expiryDatehasStartedTyping = false;

  bool _isSubmitButtonEnabled = false;



  void checkSubmitButtonEnabled() {
    String input = InsurnceProviderTextController.text.trim();
    String input2 = NationalIDTextController.text.trim();
    String input3 = PolicyNameEditTextController.text.trim();
    String input4 = StartDateController.text.trim();
    String input5 = ExpiryDateTextController.text.trim();

    if (input.isNotEmpty &&
        input2.isNotEmpty &&
        input3.isNotEmpty &&
        input4.isNotEmpty &&
        input5.isNotEmpty) {
      setState(() {
        _isSubmitButtonEnabled = true;
      });
    } else {
      setState(() {
        _isSubmitButtonEnabled = false;
      });
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
              Header(userName: usernameValue),

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
                  child: ListView(
                    children: [
                      if(widget.item == null)
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.height * 0.01,
                            top: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.00),
                        child: Center(
                          child: Text(
                            "New Insurance Card",
                            style: TextStyle(
                                color: Color(0xFF126086),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018),
                          ),
                        ),
                      ),
                      if(widget.item == null)
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.height * 0.01,
                            top: MediaQuery.of(context).size.height * 0.005,
                            bottom: MediaQuery.of(context).size.height * 0.00),
                        child: Center(
                          child: Text(
                            "Please fill the Card Information Below",
                            style: TextStyle(
                                color: Color(0x80000000),
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.014),
                          ),
                        ),
                      ),
                      if(widget.item == null)
                      SizedBox(height:  MediaQuery.of(context).size.height * 0.02,),
                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.height * 0.02,

                        ),
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.00,
                            right: MediaQuery.of(context).size.height * 0.00,
                            top: MediaQuery.of(context).size.height * 0.01,
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        decoration: BoxDecoration(
                          color: Color(0x08000000),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: [
                          // Insurance Provider *
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02,
                              left: MediaQuery.of(context).size.height * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Insurance Provider ",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.014,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: TextFormField(
                              controller: InsurnceProviderTextController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                // FilteringTextInputFormatter.allow(
                                //     RegExp('[a-zA-Z ]'))
                              ],
                              /*textCapitalization:
                                          TextCapitalization.characters,*/
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                              ),
                              keyboardType: TextInputType.text,
                              validator: (input) => input!.length < 3
                                  ? "First Name should be more than 3 characters"
                                  : null,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.02,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                hintText: "Enter the Insurance Provider name",
                                hintStyle: TextStyle(
                                  color: Color(0x4D111111),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                              ),
                              onChanged: (value) {
                                checkSubmitButtonEnabled();
                              },
                            ),
                          ),
                          if (errorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  errorMessage ?? '',
                                  style: TextStyle(
                                    color: isValid ? Colors.green : Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                  ),
                                ),
                              ),
                            ),

                          //National ID or Iqama *
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "National ID or Iqama",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.014,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: new TextFormField(
                              controller: NationalIDTextController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                                // FilteringTextInputFormatter.allow(
                                //     RegExp('[0-9]'))
                              ],
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (input) => input!.length < 3
                                  ? "Mobile Number should be more than 3 characters"
                                  : null,
                              decoration: new InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.02,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                hintText: "Enter national id or Iqama",
                                hintStyle: TextStyle(
                                  color: Color(0x4D111111),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                              ),
                              onChanged: (value) {
                                checkSubmitButtonEnabled();
                              },
                            ),
                          ),
                          if (nationalIDerrorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  nationalIDerrorMessage ?? '',
                                  style: TextStyle(
                                    color: nationalIDisValid
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                  ),
                                ),
                              ),
                            ),

                          //Policy Name *
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Policy Name",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.014,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: TextFormField(
                              controller: PolicyNameEditTextController,
                              keyboardType: TextInputType.text,
                              inputFormatters: const [
                                // LengthLimitingTextInputFormatter(15),
                                // FilteringTextInputFormatter.allow(
                                //     RegExp('[0-9]'))
                              ],
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (input) => input!.length < 3
                                  ? "Mobile Number should be more than 3 characters"
                                  : null,
                              decoration: new InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.02,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                hintText: "Enter policy name",
                                hintStyle: TextStyle(
                                  color: Color(0x4D111111),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                              ),
                              onChanged: (value) {
                                checkSubmitButtonEnabled();
                              },
                            ),
                          ),
                          if (policynameerrorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  policynameerrorMessage ?? '',
                                  style: TextStyle(
                                    color: policynameisValid
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                  ),
                                ),
                              ),
                            ),

                          //Start Date *
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Start Date",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.014,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: SizedBox(
                              height: 32,
                              child: TextFormField(
                                controller: StartDateController,
                                readOnly: true,
                                onTap: () async {
                                  FocusScope.of(context).unfocus(); // Hide keyboard

                                  // Open Custom Calendar in Bottom Sheet
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                    ),
                                    builder: (_) {
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        height: 350, // Adjust as needed
                                        child: CustomTypeCalendar(
                                          onDateSelected: (selectedDate) {
                                            String formattedDate =
                                                "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}";

                                            StartDateController.text = formattedDate;
                                            checkSubmitButtonEnabled();

                                            Navigator.pop(context); // Close bottom sheet after selection
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                validator: (input) => input!.isEmpty ? "Please select a date" : null,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Select Date",
                                  hintStyle: TextStyle(
                                    color: Color(0x4D111111),
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today, size: 13, color: Color(0xFF126086)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                  ),
                                ),
                              ),
                            )
                            ,
                          )
                          ,
                          if (startDateerrorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  startDateerrorMessage ?? '',
                                  style: TextStyle(
                                    color: startDateisValid
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                  ),
                                ),
                              ),
                            ),

                          //Expiry Date *
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Expiry Date",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.012,
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "*",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.014,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: SizedBox(
                              height: 32, // 🔽 Same compact height
                              child: TextFormField(
                                controller: ExpiryDateTextController,
                                readOnly: true, // Disable manual input
                                onTap: () {
                                  FocusScope.of(context).unfocus(); // Hide keyboard

                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                    ),
                                    builder: (_) {
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        height: 350,
                                        child: CustomTypeCalendar(
                                          minDate: DateTime.now().add(Duration(days: 1)),
                                          onDateSelected: (selectedDate) {
                                            String formattedDate =
                                                "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year}";
                                            ExpiryDateTextController.text = formattedDate;
                                            checkSubmitButtonEnabled();
                                            Navigator.pop(context); // Close calendar
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: MediaQuery.of(context).size.height * 0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                validator: (input) => input!.isEmpty ? "Please select expiry date" : null,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  hintText: "Select Date",
                                  hintStyle: TextStyle(
                                    color: Color(0x4D111111),
                                    fontSize: MediaQuery.of(context).size.height * 0.012,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today, size: 13, color: Color(0xFF126086)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(color: Color(0xFFF1F1F1)),
                                  ),
                                ),
                              ),
                            )
                            ,
                          ),
                          if (expiryDateerrorMessage != null)
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  expiryDateerrorMessage ?? '',
                                  style: TextStyle(
                                    color: expiryDateisValid
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.012,
                                  ),
                                ),
                              ),
                            ),

                          //Primary Insured Name
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Primary Insured Name ",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: new TextFormField(
                              controller: PrimaryinsuredNameTextController,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                                // FilteringTextInputFormatter.allow(
                                //     RegExp('[0-9]'))
                              ],
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (input) => input!.length < 3
                                  ? "Mobile Number should be more than 3 characters"
                                  : null,
                              decoration: new InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.02,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                hintText: "Enter Primary Insured Name",
                                hintStyle: TextStyle(
                                  color: Color(0x4D111111),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                              ),
                            ),
                          ),

                          //Insurance Type
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Insurance Type",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: new TextFormField(
                              controller: InsuranceTypeTextController,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                                // FilteringTextInputFormatter.allow(
                                //     RegExp('[0-9]'))
                              ],
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (input) => input!.length < 3
                                  ? "Mobile Number should be more than 3 characters"
                                  : null,
                              decoration: new InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.02,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                hintText: "Enter Insurance Type",
                                hintStyle: TextStyle(
                                  color: Color(0x4D111111),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                              ),
                            ),
                          ),

                          // Coverage Limit
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Coverage Limit",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: TextFormField(
                              controller: CoverageLimitController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50),
                                // FilteringTextInputFormatter.allow(
                                //     RegExp('[a-zA-Z ]'))
                              ],
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                              ),
                              keyboardType: TextInputType.text,
                              validator: (input) => input!.length < 3
                                  ? "Last Name should be more than 3 characters"
                                  : null,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.02,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                hintText: "Enter Coverage Limit",
                                hintStyle: TextStyle(
                                  color: Color(0x4D111111),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.012,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFF1F1F1)),
                                ),
                              ),
                            ),
                          ),

                          // Upload File
                          UploadBox(),

                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.01,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                      top: MediaQuery.of(context).size.height *
                                          0.0),
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(130.0),
                                    child: Image.asset(
                                      'assets/phinfofill.png',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02, // Adjust height
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.02, // Adjust width
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.0),
                                    child: Text(
                                      "Please note your request will be reviewed. and we will notify you once it's verified.",
                                      style: TextStyle(
                                          color: Color(0x80000000),
                                          // overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.014),
                                    ),
                                  ),
                                ),
                              ]),

                          // Submit Button
                          GestureDetector(
                            onTap: () async {
                              if (_isSubmitButtonEnabled) {
                                saveInsurance();
                              }
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00,
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                    right: MediaQuery.of(context).size.height *
                                        0.00),
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.height *
                                        0.02,
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.05,
                                    left: MediaQuery.of(context).size.height *
                                        0.02),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerRight,
                                                  end: Alignment.center,
                                                  stops: [0.5, 0.9],
                                                  colors: _isSubmitButtonEnabled
                                                      ? [
                                                          Color(0xFF126086),
                                                          Color(0xFF126086),
                                                        ]
                                                      : [
                                                          Color(0x99909090),
                                                          Color(0x99909090),
                                                        ])),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(left: 0.0),
                                          child: TextButton(
                                            onPressed: () async {
                                              if (_isSubmitButtonEnabled) {
                                                saveInsurance();
                                              }
                                            },
                                            child: Text("Submit",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.018,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 9.5,
                                                  horizontal:
                                                      12.0), // ← Adjust this
                                              minimumSize: Size(0,
                                                  0), // Removes minimum button constraints
                                              tapTargetSize: MaterialTapTargetSize
                                                  .shrinkWrap, // Removes extra tap padding
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])),
                          )
                        ]),
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
      floatingActionButton: isKeyboardVisible
          ? null
          : CustomFloatingActionButton(),

      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }





  void saveInsurance() {
    print("saveInsurance");

    connectivityservice.checkconnectivity().then((intenet) async {
      if (intenet != null && intenet) {
        String input = InsurnceProviderTextController.text.trim();
        if (input.isEmpty) {
          setState(() {
            hasStartedTyping = true;
            errorMessage = "Please enter your Insurance Provider";
            isValid = false;
          });
        } else {
          setState(() {
            hasStartedTyping = false;
            errorMessage = null;
            isValid = true;
          });
        }

        String input2 = NationalIDTextController.text.trim();
        if (input2.isEmpty) {
          setState(() {
            nationalIDhasStartedTyping = true;
            nationalIDerrorMessage = "Please enter your National ID or Iqama";
            nationalIDisValid = false;
          });
        } else {
          setState(() {
            nationalIDhasStartedTyping = false;
            nationalIDerrorMessage = null;
            nationalIDisValid = true;
          });
        }

        String input3 = PolicyNameEditTextController.text.trim();
        if (input3.isEmpty) {
          setState(() {
            policynamehasStartedTyping = true;
            policynameerrorMessage = "Please enter your Policy Name";
            policynameisValid = false;
          });
        } else {
          setState(() {
            policynamehasStartedTyping = false;
            policynameerrorMessage = null;
            policynameisValid = true;
          });
        }

        String input4 = StartDateController.text.trim();
        if (input4.isEmpty) {
          setState(() {
            startDatehasStartedTyping = true;
            startDateerrorMessage = "Please enter your Start Date";
            startDateisValid = false;
          });
        } else {
          setState(() {
            startDatehasStartedTyping = false;
            startDateerrorMessage = null;
            startDateisValid = true;
          });
        }

        String input5 = ExpiryDateTextController.text.trim();
        if (input5.isEmpty) {
          setState(() {
            expiryDatehasStartedTyping = true;
            expiryDateerrorMessage = "Please enter your Expiry Date";
            expiryDateisValid = false;
          });
        } else {
          setState(() {
            expiryDatehasStartedTyping = false;
            expiryDateerrorMessage = null;
            expiryDateisValid = true;
          });
        }

        if(input.isNotEmpty && input2.isNotEmpty && input3.isNotEmpty && input4.isNotEmpty && input5.isNotEmpty){
          Map<String, dynamic> newPolicy = {
            "id": widget.item?['id'], // keep existing ID if edit
            "insuranceProvider": InsurnceProviderTextController.text,
            "nationalId": NationalIDTextController.text,
            "policyName": PolicyNameEditTextController.text,
            "startDate": StartDateController.text,
            "expiryDate": ExpiryDateTextController.text,
            "primaryInsuredName": PrimaryinsuredNameTextController.text,
            "insuranceType": InsuranceTypeTextController.text,
            "coverageLimit": CoverageLimitController.text,
          };

          Navigator.pop(context, newPolicy); // return the map
        }

      } else {
        final snackBar = SnackBar(
            content: Text("No Internet, Check Connectivity!"),
            backgroundColor: Colors.red[600]);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }


}
