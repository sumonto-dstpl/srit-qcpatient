import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:newfolder/Core/Dropdown/inner_dropdown.dart';

class AddMemberBottomSheet {
  static Future<Map<String, dynamic>?> show(BuildContext context,
      {Map? editDetail, String? operation = "add"}) {

    File? myProfileImage;
    String? myProfileImagePath;

    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final uhidController = TextEditingController();
    final mobileController = TextEditingController();
    final emailController = TextEditingController();

    // Validation Flags
    bool firstNameValid = true;
    bool lastNameValid = true;
    bool mobileValid = true;
    bool emailValid = true;
    bool relationshipValid = true;
    bool isGenderValid = true;

    String? relationshipSelected;
    String? genderSelected;



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

    if (editDetail != null) {
      firstNameController.text = editDetail['firstName'] ?? "";
      lastNameController.text = editDetail['lastName'] ?? "";
      uhidController.text = editDetail['uhid'] ?? "";
      mobileController.text = editDetail['mobileNumber'] ?? "";
      emailController.text = editDetail['email'] ?? "";
      relationshipSelected = editDetail['relationship'] ?? "";

      final String? genderLabel = editDetail['gender'];
      final match = genderOptions.firstWhere(
            (g) => g['label']?.toLowerCase() == genderLabel?.toLowerCase(),
        orElse: () => {},
      );
      genderSelected = match['key'];

      if (editDetail['image'] != null && editDetail['image'].toString().isNotEmpty) {
        myProfileImagePath = editDetail['image'].toString().trim();
        if (myProfileImagePath.startsWith("/")) {
          myProfileImage = File(myProfileImagePath);
        }
      }
    }

    return showModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black45,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // ✅ 1. Keyboard ki height ko capture karo
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return StatefulBuilder(builder: (context, setState) {

          // Image Preview Logic for both Add & Edit Mode
          ImageProvider? imageProvider;
          if (myProfileImagePath != null && myProfileImagePath!.isNotEmpty) {
            if (myProfileImagePath!.startsWith("assets/")) {
              imageProvider = AssetImage(myProfileImagePath!);
            } else {
              imageProvider = FileImage(File(myProfileImagePath!));
            }
          }

          return Padding(
            // Padding se sheet keyboard ke upar shift hogi
            padding: EdgeInsets.only(bottom: keyboardHeight),
            child: Stack(
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

                    // ✅ 2. FIX HERE: Jab keyboard khule, toh Container ki height thodi kam kar do
                    // Isse sheet pura upar nahi bhagegi, aur thodi niche hi rahegi.
                    height: (screenHeight * 0.75) - (keyboardHeight > 0 ? (keyboardHeight * 0.5) : 0),

                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // ... Yahan se tumhara baaki ka form code same rahega ...
                        /// Form Content
                        Padding(
                          key: const ValueKey('form_padding'),
                          padding: EdgeInsets.only(

                            left: screenHeight * 0.02,
                            right: screenHeight * 0.02,
                            top: screenHeight * 0.07,
                            bottom: screenHeight * 0.09, // space for fixed buttons
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.005,),
                                  color: Colors.white,
                                  child: Text(
                                    operation == "edit" ? "Edit Family Member" : "Add New Family Member",
                                    style: TextStyle(fontSize: screenHeight * 0.022, fontWeight: FontWeight.w600, color: Colors.black87),
                                  ),
                                ),

                                _buildLabelWithAsterisk(context, 'First Name', required: true),
                                _buildField(
                                  context,
                                  firstNameController,
                                  "Enter First Name",
                                  onChanged: (val) {
                                    // ✅ Fix Issue 2: Real-time validation clearance
                                    if (val.isNotEmpty && !firstNameValid) {
                                      setState(() => firstNameValid = true);
                                    }
                                  },
                                ),
                                if (!firstNameValid)
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, bottom: screenHeight * 0.005),
                                    child: Text("Please enter First Name", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013)),
                                  ),

                                _buildLabelWithAsterisk(context, 'Last Name', required: true),
                                _buildField(
                                  context,
                                  lastNameController,
                                  "Enter Last Name",
                                  onChanged: (val) {
                                    if (val.isNotEmpty && !lastNameValid) {
                                      setState(() => lastNameValid = true);
                                    }
                                  },
                                ),
                                if (!lastNameValid)
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, bottom: screenHeight * 0.005),
                                    child: Text("Please enter Last Name", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013)),
                                  ),

                                _buildLabelWithAsterisk(context, 'UHID'),
                                _buildField(context, uhidController, "Enter UHID"),

                                _buildLabelWithAsterisk(context, 'Mobile Number', required: true),
                                _buildField(
                                  context,
                                  mobileController,
                                  "Enter Mobile Number",
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                                  onChanged: (val) {
                                    setState(() {
                                      mobileValid = val.length == 10;
                                    });
                                  },
                                  // ✅ Fix Issue 1: Green Validation Tick Icon appears when 10 digits are filled
                                  suffixIcon: mobileController.text.length == 10
                                      ? const Icon(Icons.check_circle, color: Colors.green, size: 22)
                                      : null,
                                ),
                                if (!mobileValid)
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, bottom: screenHeight * 0.005),
                                    child: Text("Please enter a valid 10-digit Mobile Number", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013)),
                                  ),

                                // ✅ Fix Issue 7: Email field made mandatory with Asterisk mark
                                _buildLabelWithAsterisk(context, 'Email', required: true),
                                _buildField(
                                  context,
                                  emailController,
                                  "Enter Email Address",
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (val) {
                                    if (val.isNotEmpty && !emailValid) {
                                      setState(() => emailValid = true);
                                    }
                                  },
                                ),
                                if (!emailValid)
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, bottom: screenHeight * 0.005),
                                    child: Text("Please enter Email Address", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013)),
                                  ),

                                _buildLabelWithAsterisk(context, 'Relationship', required: true),


                                InnnerDropdown(
                                  value: relationshipSelected,
                                  hint: 'Select Relationship',
                                  items: [ "Mother", "Father",'Brother','Sister','Other'],
                                  onChanged: (newValue) {
                                    setState(() {
                                      relationshipSelected = newValue;
                                      relationshipValid = true ;
                                    });
                                  },
                                ),
                                if (!relationshipValid)
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, top: 4),
                                    child: Text("Please select Relationship", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013)),
                                  ),

                                _buildLabelWithAsterisk(context, 'Gender', required: true),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: genderOptions.map((gender) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          genderSelected = gender["key"]!;
                                          isGenderValid = true;
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
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
                                          const SizedBox(width: 4),
                                          Text(gender["label"]!, style: TextStyle(fontSize: screenHeight * 0.016)),
                                          const SizedBox(width: 15),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                                if (!isGenderValid)
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, top: 4),
                                    child: Text("Please select a gender", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013)),
                                  ),
                              ],
                            ),
                          ),
                        ),




                        /// ✅ Fix Issue 8: Re-proportioned Full width equal-sized compact buttons
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65, // right half only
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                              horizontal: screenHeight * 0.02, // more padding for spacious layout
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: screenHeight * 0.015,
                                  bottom: 10,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFA8B1CE), width: 1),
                                    borderRadius: BorderRadius.circular(screenHeight * 0.012),
                                  ),
                                  child: TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero, // 🔥 Ye limit hatayega
                                      padding: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.008,   // 🔥 Vertical size yahan se adjust karo
                                        horizontal: screenHeight * 0.03,  // 🔥 Horizontal width 0.04 se kam kardi
                                      ),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      "Close",
                                      style: TextStyle(
                                        color: const Color(0xFF126086),
                                        fontSize: screenHeight * 0.017,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF126086),
                                    borderRadius: BorderRadius.circular(screenHeight * 0.012),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      // ✅ Fix Issue 4: Full Validation Check before triggering Pop/Save
                                      setState(() {
                                        firstNameValid = firstNameController.text.trim().isNotEmpty;
                                        lastNameValid = lastNameController.text.trim().isNotEmpty;
                                        mobileValid = mobileController.text.trim().length == 10;
                                        emailValid = emailController.text.trim().isNotEmpty;
                                        relationshipValid = relationshipSelected != null && relationshipSelected!.isNotEmpty;
                                        isGenderValid = genderSelected != null;
                                      });

                                      if (firstNameValid && lastNameValid && mobileValid && emailValid && relationshipValid && isGenderValid) {
                                        String gender = "";
                                        if (genderSelected == 'M') gender = 'Male';
                                        else if (genderSelected == 'F') gender = 'Female';
                                        else if (genderSelected == 'O') gender = 'Other';

                                        Navigator.of(context).pop({
                                          "firstName": firstNameController.text.trim(),
                                          "lastName": lastNameController.text.trim(),
                                          "uhid": uhidController.text.trim(),
                                          "mobileNumber": mobileController.text.trim(),
                                          "email": emailController.text.trim(),
                                          "relationship": relationshipSelected,
                                          "gender": gender,
                                          "image": myProfileImagePath ?? "",
                                        });
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero, // 🔥 Ye limit hatayega
                                      padding: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.008,   // 🔥 Vertical size yahan se adjust karo
                                        horizontal: screenHeight * 0.03,  // 🔥 Horizontal width 0.04 se kam kardi
                                      ),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenHeight * 0.017,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                        /// ✅ Fix Issue 5: Condition removed so Camera Profile widget appears in both Add & Edit modes
                        Positioned(
                          top: -50,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(source: ImageSource.camera);

                                if (image != null) {
                                  File imageFile = File(image.path);
                                  setState(() {
                                    myProfileImage = imageFile;
                                    myProfileImagePath = imageFile.path;
                                  });
                                }
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 3),
                                  color: const Color(0xFF608597),
                                  image: imageProvider != null
                                      ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
                                      : null,
                                ),
                                child: imageProvider == null
                                    ? const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 50)
                                    : null,
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
        bottom: MediaQuery.of(context).size.height * 0.006,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.014,
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
            children: required
                ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ]
                : [],
          ),
        ),
      ),
    );
  }

  static Widget _buildField(
      BuildContext context,
      TextEditingController controller,
      String hint, {
        TextInputType keyboardType = TextInputType.text,
        List<TextInputFormatter>? inputFormatters,
        ValueChanged<String>? onChanged,
        Widget? suffixIcon,
      }) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * 0.005,
        right: MediaQuery.of(context).size.height * 0.005,
        bottom: MediaQuery.of(context).size.height * 0.006,
      ),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: TextStyle(
          color: Colors.black87,
          fontSize: MediaQuery.of(context).size.height * 0.016,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.018,
            vertical: MediaQuery.of(context).size.height * 0.013,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(
            color: const Color(0x4D000000),
            fontSize: MediaQuery.of(context).size.height * 0.014,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFF1F1F1), width: 1),
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00C7BE), width: 1),
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
          ),
        ),
      ),
    );
  }
}