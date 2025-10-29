import 'dart:convert';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Alerts/appointmentcancel.dart';
import 'package:newfolder/Screens/Alerts/emergencycallhome.dart';
import 'package:newfolder/Screens/Appointments/quicksearchwithdata.dart';
import 'package:newfolder/Screens/ForgotPassword/forgotpassword.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Notifications/notifications.dart';
import 'package:newfolder/Screens/Registeration/registeration.dart';
import 'package:newfolder/Screens/Utils/SizeConfigGlobal.dart';
import 'package:newfolder/Screens/Widgets/HomeSliderWidget.dart';
import 'package:newfolder/Screens/Widgets/appointmentbadge.dart';
import 'package:newfolder/Screens/Widgets/badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class QuickSearchWithoutData extends StatefulWidget {
  const QuickSearchWithoutData({super.key});

  @override
  State<QuickSearchWithoutData> createState() => QuickSearchWithoutDatastate();
}

class QuickSearchWithoutDatastate extends State<QuickSearchWithoutData> {
  String usernameValue = "Find Specialties";
  String useraddressValue = "QuadraCyte, Qatar 500006";
  String usernameValuewithoutp = "P";
  String userprofilepValue = "NA";

  EmergencyHomeCall emergencycallalert = EmergencyHomeCall();
  AppointmentCancel appointmentcancelalert = AppointmentCancel();

  final TextEditingController SearchEditTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final List<String> hints = ["Doctor", "Speciality", "Symptoms"];



  bool _showDetails = false;
  bool _showHint = false;

  List specialiatiesList = [
    {"specaility" : "Hemotology"},
    {"specaility" : "Oncology"},
    {"specaility" : "Organ Tranplant"},
    {"specaility" : "Support Specialites"},
  ];

  List<Map<String, dynamic>> doctorList = [
    {
      "id": 1,
      "doctorName": "Dr. Arjun Mehta",
      "expertise": "Blood disorders and anemia management",
      "speciality": "Hematology"
    },
    {
      "id": 2,
      "doctorName": "Dr. Priya Nair",
      "expertise": "Cancer diagnosis and chemotherapy",
      "speciality": "Oncology"
    },
    {
      "id": 3,
      "doctorName": "Dr. Rohan Kapoor",
      "expertise": "Bone marrow transplantation",
      "speciality": "Organ Transplant"
    },
    {
      "id": 4,
      "doctorName": "Dr. Meera Iyer",
      "expertise": "Pain and palliative care",
      "speciality": "Support Specialties"
    },
    {
      "id": 5,
      "doctorName": "Dr. Neelesh Rao",
      "expertise": "Leukemia and lymphoma specialist",
      "speciality": "Hematology"
    },
    {
      "id": 6,
      "doctorName": "Dr. Sneha Chatterjee",
      "expertise": "Breast and ovarian cancer management",
      "speciality": "Oncology"
    },
    {
      "id": 7,
      "doctorName": "Dr. Vikram Shah",
      "expertise": "Liver and kidney transplantation",
      "speciality": "Organ Transplant"
    },
    {
      "id": 8,
      "doctorName": "Dr. Kavita Pillai",
      "expertise": "Nutrition and patient support care",
      "speciality": "Support Specialties"
    },
    {
      "id": 9,
      "doctorName": "Dr. Aman Verma",
      "expertise": "Platelet and coagulation disorder expert",
      "speciality": "Hematology"
    },
    {
      "id": 10,
      "doctorName": "Dr. Nisha Reddy",
      "expertise": "Radiation and immuno-oncology specialist",
      "speciality": "Oncology"
    },
    {
      "id": 11,
      "doctorName": "Dr. Harshad Patel",
      "expertise": "Heart and lung transplantation",
      "speciality": "Organ Transplant"
    },
    {
      "id": 12,
      "doctorName": "Dr. Ritu Joshi",
      "expertise": "Rehabilitation and counseling",
      "speciality": "Support Specialties"
    },
    {
      "id": 13,
      "doctorName": "Dr. Aditya Khanna",
      "expertise": "Sickle cell and hemophilia care",
      "speciality": "Hematology"
    },
    {
      "id": 14,
      "doctorName": "Dr. Sanjana Bhatia",
      "expertise": "Pediatric oncology specialist",
      "speciality": "Oncology"
    },
    {
      "id": 15,
      "doctorName": "Dr. Rajeev Sinha",
      "expertise": "Pancreas and kidney transplant surgeon",
      "speciality": "Organ Transplant"
    },
    {
      "id": 16,
      "doctorName": "Dr. Alka Deshmukh",
      "expertise": "Psychological and social support care",
      "speciality": "Support Specialties"
    },
    {
      "id": 17,
      "doctorName": "Dr. Nitin Agarwal",
      "expertise": "Bone marrow disorder specialist",
      "speciality": "Hematology"
    },
    {
      "id": 18,
      "doctorName": "Dr. Shreya Das",
      "expertise": "Immunotherapy and targeted cancer treatment",
      "speciality": "Oncology"
    },
    {
      "id": 19,
      "doctorName": "Dr. Mohan Menon",
      "expertise": "Multi-organ transplant coordinator",
      "speciality": "Organ Transplant"
    },
    {
      "id": 20,
      "doctorName": "Dr. Anjali Gupta",
      "expertise": "Pain management and patient well-being",
      "speciality": "Support Specialties"
    },
  ];
  List<Map<String, dynamic>> filteredList = [];

  List<Map<String, dynamic>> suggestionList = [];
  @override
  void initState() {
    super.initState();

    // 👇 Rebuild UI when focus changes


    // 👇 Force uppercase conversion listener
    SearchEditTextController.addListener(() {

      final text = SearchEditTextController.text;

      if (text != text.toUpperCase()) {
        final selection = SearchEditTextController.selection;
        SearchEditTextController.value = SearchEditTextController.value.copyWith(
          text: text.toUpperCase(),
          selection: selection,
          composing: TextRange.empty,
        );
      }
      setState(() {
        _showDetails = false;
        if(text.length < 3){
          _showHint = false;

        }
        else{
          _showHint = true;
        }
      });

    });

  }

  void showDetails(String query){
    final text = query;
    setState(() {
      if(text.length < 3){
        _showDetails = false;
        filteredList.clear();
      }
      else {
        _showDetails = true;
        filteredList = doctorList.where((doctor) {
          final query = text.toLowerCase().trim(); // clean input once

          final name = doctor["doctorName"].toString().toLowerCase();
          final exp = doctor["expertise"].toString().toLowerCase();
          final spec = doctor["speciality"].toString().toLowerCase();

          // 🔍 partial match: "hema" will match "hematology"
          return name.contains(query) || exp.contains(query) || spec.contains(query);
        }).toList();

        // 🔹 Save unique search to suggestionList
        bool alreadyExists = suggestionList.any((item) =>
        item["suggestion"].toString().toLowerCase() == text.toLowerCase()
        );

        print("alreadyExists : $alreadyExists");
        print("Before Suggestion : $suggestionList");
        if (!alreadyExists && filteredList.isNotEmpty ) {
          suggestionList.add({
            "id": suggestionList.length + 1,
            "suggestion": text,
          });
        }

        print("After Suggestion : $suggestionList");


      }
    });
  }
  @override
  void dispose() {
    SearchEditTextController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  bottom: screenWidth * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ),

              // Main Content Section
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.01,
                    vertical: screenHeight * 0.03,

                  ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: screenHeight * 0.01,
                        ),
                        margin: EdgeInsets.zero,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: screenHeight * 0.045,
                                width: screenHeight * 0.045,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100]!.withOpacity(0.9),
                                  // color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: const Color(0xFF126086),
                                  size: screenHeight * 0.02,
                                ),
                              ),
                            ),
                            SizedBox(width: screenHeight * 0.005),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Container(

                                    alignment: Alignment.centerRight,

                                    child: TextFormField(
                                      controller: SearchEditTextController,
                                      focusNode: searchFocusNode,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(15),
                                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                                      ],
                                      textCapitalization: TextCapitalization.characters,

                                      style: const TextStyle(color: Colors.black45),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) => input!.length < 3
                                          ? "Search should be more than 3 characters"
                                          : null,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.fromLTRB(
                                          screenHeight * 0.02,
                                          screenHeight * 0.012,
                                          screenHeight * 0.012,
                                          screenHeight * 0.012,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF7F5F6),
                                        // hintText: "Search By Doctor",
                                        hintText: null,
                                        hintStyle: TextStyle(
                                          color: Colors.black26,
                                          fontSize: screenHeight * 0.016,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(color: Colors.white),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: Colors.black45,
                                            size: screenHeight * 0.024,
                                          ),
                                          onPressed: () {

                                            showDetails(SearchEditTextController.text);
                                          },
                                        ),

                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        // label: Row(
                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                        //   crossAxisAlignment: CrossAxisAlignment.center,
                                        //   mainAxisSize: MainAxisSize.min,
                                        //   children: [
                                        //     Text(
                                        //       "Search by ",
                                        //       style: TextStyle(
                                        //         color: Color(0xFF999999),
                                        //         fontSize: screenHeight * 0.016,
                                        //         fontWeight: FontWeight.w400,
                                        //       ),
                                        //     ),
                                        //     DefaultTextStyle(
                                        //       style: TextStyle(
                                        //         color: Color(0xFF126086),
                                        //         fontWeight: FontWeight.bold,
                                        //         fontSize: screenHeight * 0.016,
                                        //       ),
                                        //       child: AnimatedTextKit(
                                        //         repeatForever: true,
                                        //         pause: Duration(milliseconds: 700),
                                        //         animatedTexts: hints
                                        //             .map((e) => RotateAnimatedText(
                                        //           e,
                                        //           textStyle: TextStyle(
                                        //             color: Color(0xFF126086),
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: screenHeight * 0.016,
                                        //           ),
                                        //         ))
                                        //             .toList(),
                                        //         onTap: () {
                                        //           // Optional — navigate to search page
                                        //           Navigator.of(context).push(
                                        //             MaterialPageRoute(
                                        //               builder: (context) => QuickSearchWithoutData(),
                                        //             ),
                                        //           );
                                        //         },
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ),
                                    ),


                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(!_showHint)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenHeight * 0.01,
                          vertical: screenHeight * 0.005,
                        ),
                        margin: EdgeInsets.zero,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: screenHeight * 0.02,
                                width: screenHeight * 0.045,

                              ),
                            ),
                            SizedBox(width: screenHeight * 0.005),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [


                                  Container(

                                    child: Text(
                                      "Please Enter a Search term with at least 3 characters to search",
                                      style: TextStyle(
                                        color: Color(0xFF1F1F1F),
                                        fontWeight: FontWeight.w500,
                                        fontSize: screenHeight * 0.012,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(_showHint && _showDetails)
                      Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              if(suggestionList.isNotEmpty)
                              SizedBox(
                                height: screenHeight * 0.06,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,

                                    itemCount: suggestionList.length,
                                    itemBuilder: (context,index){
                                     final item = suggestionList[index];
                                      return Align(
                                        alignment: Alignment.centerLeft, // ya centerRight / center
                                        child: GestureDetector(
                                          onTap: (){
                                            showDetails(item['suggestion']);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.002,
                                              horizontal: screenHeight * 0.01,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.005,
                                              horizontal: screenHeight * 0.01,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0x99F7F5F6),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min, // 👈 important
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: Color(0xE5000000),
                                                  size: screenHeight * 0.016,
                                                ),
                                                SizedBox(width: screenHeight * 0.01),
                                                Text(
                                                   item['suggestion'],
                                                  style: TextStyle(
                                                    fontSize: screenHeight * 0.012,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(0xCC000000),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                              if(suggestionList.isEmpty)
                                SizedBox(height: screenHeight * 0.02,),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.01,
                                ),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      // Upcoming Appoinments
                                      Flexible(
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
                                                  .height * 0.005,
                                              bottom: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.005),
                                          child:
                                          Text(
                                            "Specialties",
                                            style: TextStyle(
                                                color: Color(0xFF1F1F1F),
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: (MediaQuery.of(context).size.height * 0.014),
                                                fontFamily: "Inter"

                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),



                                    ]

                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01,),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true, // ✅ Important - tells ListView to take only required space
                                physics: NeverScrollableScrollPhysics(), // ✅ Disable inner scrolling
                                itemCount: specialiatiesList.length,
                                itemBuilder: (context,index) {
                                  final item = specialiatiesList[index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.002,
                                      horizontal: screenHeight * 0.01,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01,
                                      horizontal: screenHeight * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xB2F7F5F6),
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Row(
                                      children: [
                                        Container(

                                          child: Image.asset(
                                            "assets/Hematology.png",
                                            fit: BoxFit.fill,
                                          ),
                                          height : screenHeight * 0.02,
                                          width : screenHeight * 0.02,
                                        ),
                                        SizedBox(width: screenHeight * 0.02,),
                                        Text(
                                          "${item['specaility']}",
                                          style: TextStyle(
                                              fontSize: screenHeight * 0.012,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF136891)
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: screenHeight * 0.01,),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.01,
                                ),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      // Upcoming Appoinments
                                      Flexible(
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
                                                  .height * 0.005,
                                              bottom: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.005),
                                          child:
                                          Text(
                                            "Doctors",
                                            style: TextStyle(
                                                color: Color(0xFF1F1F1F),
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: (MediaQuery.of(context).size.height * 0.014),
                                                fontFamily: "Inter"

                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),



                                    ]

                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01,),
                              (filteredList.length > 0 ) ?
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filteredList.length,
                                itemBuilder: (context,index) {
                                  final item = filteredList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(32),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x0D000000),

                                          blurRadius: 5, // Spread of the shadow

                                          offset: Offset(0,0), // Offset in x and y direction

                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      elevation: 0.0,
                                      color: Colors.white,
                                      child:  Container(
                                        width:MediaQuery.of(context).size.height * 0.450,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(32),

                                        ),

                                        child:
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[


                                              // Image & Dr profile & Icon
                                              Container(
                                                // color: Colors.red,
                                                // height: MediaQuery.of(context).size.height * 0.12,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: screenHeight * 0.02,
                                                  horizontal: screenHeight * 0.01,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,

                                                  children: <Widget>[
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.01),
                                                    Container(
                                                      height : MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.055,

                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            130.0),
                                                        child: Image.asset(
                                                          'assets/NutanBhatt.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.height *
                                                            0.015),

                                                    Expanded(

                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,

                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[


                                                          Container(

                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(

                                                                    child:
                                                                    Text(
                                                                     item['doctorName'] ?? "Dr. Nutan Bhatt",

                                                                      style: TextStyle(
                                                                          color: Color(0xFF1F1F1F),

                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                          MediaQuery.of(context).size.height * 0.016),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                      vertical: screenHeight * 0.002,
                                                                      horizontal: screenHeight * 0.005,
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                      color:Color(0xFFF3F5F9),
                                                                      borderRadius: BorderRadius.circular(8),
                                                                    ),

                                                                    child:
                                                                    Row(
                                                                      children: <Widget>[

                                                                        Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                          Colors.amber,
                                                                          size: MediaQuery.of(context).size.height *
                                                                              0.015,
                                                                        ),
                                                                        SizedBox(width: MediaQuery.of(context).size.height * 0.005 ,),
                                                                        Text(
                                                                          "4.2",
                                                                          style: TextStyle(
                                                                              color: Colors.black87,
                                                                              fontWeight: FontWeight.w600,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.012),
                                                                        )
                                                                      ],
                                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                                    ),
                                                                  ),
                                                                ]
                                                            ),
                                                            margin: EdgeInsets.only(
                                                              left: screenHeight * 0.005,
                                                              right: screenHeight * 0.01,
                                                            ),

                                                          ),


                                                          SizedBox(height: screenHeight * 0.005,),


                                                          Container(

                                                            margin: EdgeInsets.only(
                                                              left: screenHeight * 0.005,

                                                            ),
                                                            child:
                                                            Text(
                                                            item['expertise'] ?? "General Medicine /Internal Medicine",

                                                              style: TextStyle(
                                                                  color: Color(0x80000000),

                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  fontSize: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.014),
                                                            ),
                                                          ),




                                                        ],
                                                      ),
                                                    ),



                                                  ],
                                                ),
                                              ),






                                            ]),

                                      ),
                                    ),
                                  );
                                },
                              )
                              : Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.height * 0.02,
                                    vertical: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [0.5, 0.9],
                                      colors: [
                                        Color(0xB2F7F5F6),
                                        Color(0xB2F7F5F6),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.height * 0.02,
                                        height: MediaQuery.of(context).size.height * 0.020,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/nodatasearchicon.png"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                                      Expanded(
                                        child: Text(
                                          "No result found for the searched keyword - ${SearchEditTextController.text}",
                                          style: TextStyle(
                                            color: Color(0xFF13658C),
                                            fontWeight: FontWeight.w500,
                                            fontSize: screenHeight * 0.012, // Use fixed size for stability
                                          ),
                                          maxLines: 2, // Avoid overflow by limiting lines
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2),
                                          // Optional: limit font scaling
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              SizedBox(height: screenHeight * 0.02,),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.01,
                                ),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      // Upcoming Appoinments
                                      Flexible(
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
                                                  .height * 0.005,
                                              bottom: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.005),
                                          child:
                                          Text(
                                            "Preventive Health Checkup",
                                            style: TextStyle(
                                                color: Color(0xFF1F1F1F),
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: (MediaQuery.of(context).size.height * 0.014),
                                                fontFamily: "Inter"

                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),



                                    ]

                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01,),
                              Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.height * 0.02,
                                    vertical: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [0.5, 0.9],
                                      colors: [
                                        Color(0xB2F7F5F6),
                                        Color(0xB2F7F5F6),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.height * 0.02,
                                        height: MediaQuery.of(context).size.height * 0.020,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/nodatasearchicon.png"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                                      Expanded(
                                        child: Text(
                                          "No result found for the searched keyword - ${SearchEditTextController.text}",
                                          style: TextStyle(
                                            color: Color(0xFF13658C),
                                            fontWeight: FontWeight.w500,
                                            fontSize: screenHeight * 0.012, // Use fixed size for stability
                                          ),
                                          maxLines: 2, // Avoid overflow by limiting lines
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2),
                                          // Optional: limit font scaling
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.01,
                                ),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      // Upcoming Appoinments
                                      Flexible(
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
                                                  .height * 0.005,
                                              bottom: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.005),
                                          child:
                                          Text(
                                            "Services",
                                            style: TextStyle(
                                                color: Color(0xFF1F1F1F),
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: (MediaQuery.of(context).size.height * 0.014),
                                                fontFamily: "Inter"

                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),



                                    ]

                                ),
                              ),

                              Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.of(context).size.height * 0.02,
                                    vertical: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [0.5, 0.9],
                                      colors: [
                                        Color(0xB2F7F5F6),
                                        Color(0xB2F7F5F6),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.height * 0.02,
                                        height: MediaQuery.of(context).size.height * 0.020,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/nodatasearchicon.png"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                                      Expanded(
                                        child: Text(
                                          "No result found for the searched keyword - ${SearchEditTextController.text}",
                                          style: TextStyle(
                                            color: Color(0xFF13658C),
                                            fontWeight: FontWeight.w500,
                                            fontSize: screenHeight * 0.012, // Use fixed size for stability
                                          ),
                                          maxLines: 2, // Avoid overflow by limiting lines
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.2),
                                          // Optional: limit font scaling
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      )

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
