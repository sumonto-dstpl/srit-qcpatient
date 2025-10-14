import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMemberBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Controllers
        final firstNameController = TextEditingController();
        final lastNameController = TextEditingController();
        final uhidController = TextEditingController();
        final mobileController = TextEditingController();
        final emailController = TextEditingController();

        // State variables
        String? relationshipSelected;
        String? genderSelected;
        bool isGenderValid = true;

        List<Map<String, String>> genderOptions = [
          {"key": "M", "label": "Male"},
          {"key": "F", "label": "Female"},
          {"key": "O", "label": "Other"},
        ];

        List<String> relationshipOptions = [
          "Mother",
          "Father",
          "Brother",
          "Sister",
          "Other"
        ];

        return StatefulBuilder(builder: (context, setState) {
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
              Stack(
                children:[
                  Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Container(
                      height: screenHeight * 0.75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: Offset(0, -1),
                          ),
                        ],
                      ),
                      child: Stack(
                         clipBehavior: Clip.none,
                        children: [
                          Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.02,
                            vertical: screenHeight * 0.07,
                          ),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: screenHeight * 0.015),
                                // Header
                                // Center(
                                //   child: Container(
                                //     width: 40,
                                //     height: 4,
                                //     margin: EdgeInsets.only(bottom: 10),
                                //     decoration: BoxDecoration(
                                //       color: Colors.grey[400],
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //   ),
                                // ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Add New Family Member",
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.015),

                                // Label + Field template
                                _buildLabelWithAsterisk(context, 'First Name', required: true),
                                _buildField(context, firstNameController, "Enter First Name"),

                                _buildLabelWithAsterisk(context, 'Last Name', required: true),
                                _buildField(context, lastNameController, "Enter Last Name"),

                                _buildLabelWithAsterisk(context, 'UHID', required: true),
                                _buildField(context, uhidController, "Enter UHID"),

                                _buildLabelWithAsterisk(context, 'Mobile Number', required: true),
                                _buildField(context, mobileController, "Enter Mobile Number",
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [LengthLimitingTextInputFormatter(10)]),

                                _buildLabelWithAsterisk(context, 'Email'),
                                _buildField(context, emailController, "Enter Email Address",
                                    keyboardType: TextInputType.emailAddress),

                                _buildLabelWithAsterisk(context, 'Relationship', required: true),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color(0xFFF1F1F1)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: relationshipSelected,
                                      hint: Text(
                                        "Select Relationship",
                                        style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: screenHeight * 0.014,
                                        ),
                                      ),
                                      isExpanded: true,
                                      dropdownColor: Colors.white,
                                      items: relationshipOptions
                                          .map((value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          relationshipSelected = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),

                                _buildLabelWithAsterisk(context, 'Gender', required: true),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // left align the whole row
                                  children: genderOptions.map((gender) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          genderSelected = gender["key"]!;
                                          isGenderValid = true;
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min, // take only as much space as needed
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Radio<String>(
                                            value: gender["key"]!,
                                            groupValue: genderSelected,
                                            activeColor: const Color(0xFF00C7BE),
                                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            onChanged: (value) {
                                              setState(() {
                                                genderSelected = value!;
                                                isGenderValid = true;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 2), // small gap between radio and text
                                          Text(
                                            gender["label"]!,
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.014,
                                            ),
                                          ),
                                          SizedBox(width: 10), // optional: gap between different options
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),


                                if (!isGenderValid)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.005, left: 8),
                                    child: Text(
                                      "Please select a gender",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: screenHeight * 0.013,
                                      ),
                                    ),
                                  ),

                                SizedBox(height: screenHeight * 0.02),

                                // Buttons Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end, // Align row contents to right
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.5, // 50% of total width
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                right: screenHeight * 0.01,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Color(0xFF126086), width: 1),
                                                borderRadius:
                                                BorderRadius.circular(screenHeight * 0.012),
                                              ),
                                              child: TextButton(
                                                onPressed: () => Navigator.of(context).pop(),
                                                child: Text(
                                                  "Close",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF126086),
                                                    fontSize: screenHeight * 0.016,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Inter",
                                                  ),
                                                ),
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 11.0, horizontal: 12.0),
                                                  minimumSize: Size(0, 0),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF126086),
                                                borderRadius:
                                                BorderRadius.circular(screenHeight * 0.012),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  if (genderSelected == null) {
                                                    setState(() => isGenderValid = false);
                                                  } else {
                                                    Navigator.of(context).pop();
                                                    // Implement save logic here
                                                  }
                                                },
                                                child: Text(
                                                  "Save",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: screenHeight * 0.017,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Inter",
                                                  ),
                                                ),
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(vertical: 11.0),
                                                  minimumSize: Size(0, 0),
                                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: screenHeight * 0.015),
                              ],
                            ),
                          ),
                        ),

                          Positioned(
                            top: -50, // move image above the top border
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 3),
                                  image: DecorationImage(
                                    image: AssetImage('assets/NutanBhatt.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),

                    ]
                  ),
                ), ]
              ),


            ],
          );
        });
      },
    );
  }

  static Widget _buildLabelWithAsterisk(BuildContext context, String label, {bool required = false}) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
        left: MediaQuery.of(context).size.height * 0.005,
        bottom: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: label, // The label text
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.012,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w400,
              fontFamily: "Inter",
            ),
            children: required
                ? [
              TextSpan(
                text: ' *', // Red asterisk
                style: TextStyle(
                  color: Colors.red,
                  fontSize: MediaQuery.of(context).size.height * 0.012,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                ),
              ),
            ]
                : [],
          ),
        ),
      ),
    );
  }

  static Widget _buildField(BuildContext context, TextEditingController controller, String hint,
      {TextInputType keyboardType = TextInputType.text,
        List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * 0.005,
        right: MediaQuery.of(context).size.height * 0.005,
        bottom: MediaQuery.of(context).size.height * 0.008,
      ),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.black45,
          fontSize: MediaQuery.of(context).size.height * 0.016,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.02,
            vertical: MediaQuery.of(context).size.height * 0.013,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(
            color: Color(0x4D111111),
            fontSize: MediaQuery.of(context).size.height * 0.012,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Color(0xFFF1F1F1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Color(0xFFF1F1F1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Color(0xFF00C7BE)),
          ),
        ),
      ),
    );
  }


}
