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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenHeight * 0.02,
                      vertical: screenHeight * 0.015,
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Add Family Member",
                              style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),

                          // Label + Field template
                          _buildLabel(context, 'First Name *'),
                          _buildField(context, firstNameController, "Enter First Name"),

                          _buildLabel(context, 'Last Name *'),
                          _buildField(context, lastNameController, "Enter Last Name"),

                          _buildLabel(context, 'UHID *'),
                          _buildField(context, uhidController, "Enter UHID"),

                          _buildLabel(context, 'Mobile Number *'),
                          _buildField(context, mobileController, "Enter Mobile Number",
                              keyboardType: TextInputType.number,
                              inputFormatters: [LengthLimitingTextInputFormatter(10)]),

                          _buildLabel(context, 'Email'),
                          _buildField(context, emailController, "Enter Email Address",
                              keyboardType: TextInputType.emailAddress),

                          _buildLabel(context, 'Relationship *'),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.015,
                            ),
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

                          SizedBox(height: screenHeight * 0.01),
                          _buildLabel(context, 'Gender *'),

                          Row(
                            children: genderOptions.map((gender) {
                              return Expanded(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Color(0xFFD0D5DD),
                                  ),
                                  child: RadioListTile<String>(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      gender["label"]!,
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.014,
                                      ),
                                    ),
                                    value: gender["key"]!,
                                    groupValue: genderSelected,
                                    activeColor: const Color(0xFF00C7BE),
                                    onChanged: (value) {
                                      setState(() {
                                        genderSelected = value!;
                                        isGenderValid = true;
                                      });
                                    },
                                  ),
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
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                    right: screenHeight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xFF126086), width: 1),
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * 0.012),
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
                                      tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF126086),
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * 0.012),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      // TODO: Validation + Save
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
                                      padding:
                                      EdgeInsets.symmetric(vertical: 11.0),
                                      minimumSize: Size(0, 0),
                                      tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  static Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
        left: MediaQuery.of(context).size.height * 0.005,
        bottom: MediaQuery.of(context).size.height * 0.006,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.012,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w400,
              fontFamily: "Inter",
            ),
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
