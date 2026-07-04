import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newfolder/Core/Dialog/camera_image.dart';
import 'dart:io';

import 'package:newfolder/Core/Dropdown/inner_dropdown.dart';
import 'package:newfolder/Core/Dropdown/smart_dropdown.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';

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

      if (editDetail['image'] != null &&
          editDetail['image'].toString().isNotEmpty) {
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


        // ✅ 1. Keyboard ki height ko capture karo
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return StatefulBuilder(builder: (context, setState) {
          // Image Preview Logic
          ImageProvider? imageProvider;
          if (myProfileImagePath != null && myProfileImagePath!.isNotEmpty) {
            if (myProfileImagePath!.startsWith("assets/")) {
              imageProvider = AssetImage(myProfileImagePath!);
            } else {
              imageProvider = FileImage(File(myProfileImagePath!));
            }
          }

          return Stack(
            children: [
              // 1. FULL SCREEN BLUR BACKDROP
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

              // 2. CONTROLLED BOTTOM SHEET UI
              Padding(
                padding: EdgeInsets.only(
                  // ✅ FIX 1: Sheet hamesha top se kam se kam 12% door rahegi (Sabse upar nahi jayegi)
                  top: screenHeight * 0.05,
                  // ✅ FIX 2: Keyboard aane par bottom se shift hogi
                  bottom: keyboardHeight,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // ✅ FIX 3: Normal state me sheet 75% height legi.
                    // Keyboard aane par ye khud choti ho jayegi aur Scroll start ho jayega.
                    constraints: BoxConstraints(
                      maxHeight: screenHeight * 0.85,
                    ),
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // --- WHITE FORM CONTAINER ---
                        Positioned(
                          top: 50, // Image ka adha hissa upar rakhne ke liye 50px space
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Stack(
                              children: [
                                // ✅ FIX 4: Form ko Positioned.fill me rakha h taaki flexible scrolling kaam kare
                                Positioned.fill(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: screenHeight * 0.02,
                                      right: screenHeight * 0.02,
                                      top: screenHeight * 0.07,
                                      bottom: 0, // Save/Close buttons ke liye safe space reserve kiya
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Header Text
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 16),
                                          child: Text(
                                            operation == "edit" ? "Edit Family Member" : "Add New Family Member",
                                            style: TextStyle(fontSize: screenHeight * 0.020, fontWeight: FontWeight.w600, color: Colors.black87),
                                          ),
                                        ),
                                        // Scrollable Form Area
                                        Expanded(
                                          child: SingleChildScrollView(
                                            physics: const BouncingScrollPhysics(),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // --- ALL YOUR TEXT FIELDS ---
                                                _buildLabelWithAsterisk(context, 'First Name', required: true, isFirst: true),
                                                _buildField(context, firstNameController, "Enter First Name", onChanged: (val) {
                                                  setState(() => firstNameValid = val.trim().isNotEmpty);
                                                }),
                                                if (!firstNameValid)
                                                  Padding(padding: EdgeInsets.only(left: 8, bottom: screenHeight * 0.005), child: Text("Please enter First Name", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013))),

                                                _buildLabelWithAsterisk(context, 'Last Name', required: true),
                                                _buildField(context, lastNameController, "Enter Last Name", onChanged: (val) {
                                                  setState(() => lastNameValid = val.trim().isNotEmpty);
                                                }),
                                                if (!lastNameValid)
                                                  Padding(padding: EdgeInsets.only(left: 8, bottom: screenHeight * 0.005), child: Text("Please enter Last Name", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013))),

                                                _buildLabelWithAsterisk(context, 'UHID'),
                                                _buildField(context, uhidController, "Enter UHID"),

                                                _buildLabelWithAsterisk(context, 'Mobile Number', required: true),
                                                _buildField(context, mobileController, "Enter Mobile Number", keyboardType: TextInputType.number,
                                                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                                                  onChanged: (val) => setState(() => mobileValid = val.length == 10),
                                                  suffixIcon: mobileController.text.length == 10 ? const Icon(Icons.check_circle, color: Colors.green, size: 22) : null,
                                                ),
                                                if (!mobileValid)
                                                  Padding(padding: EdgeInsets.only(left: 8, bottom: screenHeight * 0.005), child: Text("Please enter a valid 10-digit Mobile Number", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013))),

                                                _buildLabelWithAsterisk(context, 'Email', required: true),
                                                _buildField(context, emailController, "Enter Email Address", keyboardType: TextInputType.emailAddress,
                                                  onChanged: (val) => setState(() => emailValid = isValidEmail(val)),
                                                  suffixIcon: emailController.text.isNotEmpty && emailValid ? const Icon(Icons.check_circle, color: Colors.green, size: 22) : null,
                                                ),
                                                if (!emailValid)
                                                  Padding(padding: EdgeInsets.only(left: 8, bottom: screenHeight * 0.005), child: Text("Please enter Email Address", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013))),

                                                _buildLabelWithAsterisk(context, 'Relationship', required: true),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                  child: SmartAdaptiveDropdown(
                                                    initialValue: relationshipSelected,
                                                    hint: "Select Relationship",
                                                    items: const ["Mother", "Father", 'Brother', 'Sister', 'Other'],
                                                    onChanged: (String value) {
                                                      setState(() { relationshipSelected = value; relationshipValid = true; });
                                                    },
                                                  ),
                                                ),
                                                if (!relationshipValid)
                                                  Padding(padding: const EdgeInsets.only(left: 8, top: 4), child: Text("Please select Relationship", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013))),

                                                _buildLabelWithAsterisk(context, 'Gender', required: true),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: genderOptions.map((gender) {
                                                    return InkWell(
                                                      onTap: () => setState(() { genderSelected = gender["key"]!; isGenderValid = true; }),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Radio<String>(
                                                            value: gender["key"]!, groupValue: genderSelected, activeColor: const Color(0xFF00C7BE),
                                                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                            onChanged: (value) => setState(() { genderSelected = value!; isGenderValid = true; }),
                                                          ),
                                                          const SizedBox(width: 4),
                                                          Text(gender["label"]!, style: TextStyle(fontSize: screenHeight * 0.012)),
                                                          const SizedBox(width: 15),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                                if (!isGenderValid)
                                                  Padding(padding: const EdgeInsets.only(left: 8, top: 4), child: Text("Please select a gender", style: TextStyle(color: Colors.red, fontSize: screenHeight * 0.013))),
                                                const SizedBox(height: 80),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // --- SAVE AND CLOSE BUTTONS ---
                                Positioned(
                                  bottom: 0, left: 0, right: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    padding: EdgeInsets.only(bottom: screenHeight * 0.025, top: screenHeight * 0.01, right: screenHeight * 0.02, left: screenHeight * 0.02),
                                    decoration: const BoxDecoration(color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 100, alignment: Alignment.center,
                                          decoration: BoxDecoration(border: Border.all(color: const Color(0xFFA8B1CE), width: 1), borderRadius: BorderRadius.circular(screenHeight * 0.012)),
                                          child: TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            style: TextButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.symmetric(vertical: screenHeight * 0.007, horizontal: screenHeight * 0.03), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                            child: Text("Close", style: TextStyle(color: const Color(0xFF126086), fontSize: screenHeight * 0.017, fontWeight: FontWeight.w600, fontFamily: "Inter")),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Container(
                                          width: 100, alignment: Alignment.center,
                                          decoration: BoxDecoration(color: const Color(0xFF126086), borderRadius: BorderRadius.circular(screenHeight * 0.012)),
                                          child: TextButton(
                                            onPressed: () {
                                              // Add save logic here (Aapka pehle wala pura if-else condition)
                                              setState(() {
                                                firstNameValid = firstNameController.text.trim().isNotEmpty;
                                                lastNameValid = lastNameController.text.trim().isNotEmpty;
                                                mobileValid = mobileController.text.trim().length == 10;
                                                emailValid = isValidEmail(emailController.text);
                                                relationshipValid = relationshipSelected != null && relationshipSelected!.isNotEmpty;
                                                isGenderValid = genderSelected != null;
                                              });

                                              if (firstNameValid && lastNameValid && mobileValid && emailValid && relationshipValid && isGenderValid) {
                                                String gender = "";
                                                if (genderSelected == 'M') gender = 'Male';
                                                else if (genderSelected == 'F') gender = 'Female';
                                                else if (genderSelected == 'O') gender = 'Other';

                                                if (operation == 'add') {
                                                  showTopNotification(context, title: 'Family Member', message: 'Family Member is added sucessfully', type: NotificationType.success);
                                                } else {
                                                  showTopNotification(context, title: 'Family Member', message: 'Family Member is updated sucessfully', type: NotificationType.success);
                                                }
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
                                            style: TextButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008, horizontal: screenHeight * 0.03), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                            child: Text("Save", style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.017, fontWeight: FontWeight.w700, fontFamily: "Inter")),
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

                        // --- PROFILE IMAGE CAMERA WIDGET ---
                        // ✅ FIX 5: Image ke boundaries poori tarah parent Stack ke andar hain, ab full tappable hoga!
                        // PROFILE IMAGE CAMERA WIDGET
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                // Ek simple native-looking dialog box
                                // showDialog(
                                //   barrierColor: Colors.transparent,
                                //   context: context,
                                //   barrierDismissible: false,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       title: const Text("Select Image"),
                                //       content: Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           ListTile(
                                //             leading: const Icon(Icons.camera_alt),
                                //             title: const Text("Camera"),
                                //             onTap: () async {
                                //               Navigator.pop(context);
                                //               final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                                //               if (image != null) setState(() { myProfileImage = File(image.path); myProfileImagePath = image.path; });
                                //             },
                                //           ),
                                //           ListTile(
                                //             leading: const Icon(Icons.photo_library),
                                //             title: const Text("Gallery"),
                                //             onTap: () async {
                                //               Navigator.pop(context);
                                //               final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                //               if (image != null) setState(() { myProfileImage = File(image.path); myProfileImagePath = image.path; });
                                //             },
                                //           ),
                                //         ],
                                //       ),
                                //     );
                                //   },
                                // );


                                CustomImagePicker.show(context, onImagePicked: (File pickedFile) {
                                  setState(() {
                                    myProfileImage = pickedFile;
                                    myProfileImagePath = pickedFile.path;
                                  });
                                });

                              },
                              child: Container(
                                height: 100, width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 3),
                                  color: const Color(0xFF608597),
                                  image: imageProvider != null ? DecorationImage(image: imageProvider, fit: BoxFit.cover) : null,
                                ),
                                child: imageProvider == null ? const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 50) : null,
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
          );
        });
      },
    );
  }

  static Widget _buildLabelWithAsterisk(BuildContext context, String label,
      {bool required = false, bool isFirst = false}) {
    return Padding(
      padding: EdgeInsets.only(
        top: isFirst ? 0 : MediaQuery.of(context).size.height * 0.01,
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
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
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
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent, // Balloon gayab ho jayega
            // cursorColor: Colors.black, // Agar cursor ka color change karna ho to yahan kar sakte hain
            // selectionColor: Colors.blue.withOpacity(0.3), // Highlight color
          ),
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
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * 0.01),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF00C7BE), width: 1),
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * 0.01),
            ),
          ),
        ),
      ),
    );
  }

  static bool isValidEmail(String email) {
    // Regular expression for validating general email addresses
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
