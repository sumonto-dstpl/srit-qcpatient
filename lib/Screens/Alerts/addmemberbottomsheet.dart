import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddMemberBottomSheet {
  static Future<Map<String, dynamic>?> show(BuildContext context,
      {Map? editDetail, String? operation = "add"}) {
    print("operation : $operation");
    File? myProfileImage; // Camera se capture ki image
    String? myProfileImagePath; // Image ka path store karne ke liye (cache/storage)
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final uhidController = TextEditingController();
    final mobileController = TextEditingController();
    final emailController = TextEditingController();

    bool firstNameValid = true;
    bool lastNameValid = true;
    bool mobileValid = true;

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
    String image = "";
    if (editDetail != null) {
      print("editDetail : $editDetail");
      firstNameController.text = editDetail['firstName'] ?? "";
      lastNameController.text = editDetail['lastName'] ?? "";
      uhidController.text = editDetail['uhid'] ?? "";
      mobileController.text = editDetail['mobileNumber'] ?? "";
      emailController.text = editDetail['email'] ?? "";

      relationshipSelected = editDetail['relationship'] ?? "";
      final String? genderLabel = editDetail['gender']; // e.g. "Female"

      // ✅ Convert label ("Female") to key ("F")
      final match = genderOptions.firstWhere(
            (g) => g['label']?.toLowerCase() == genderLabel?.toLowerCase(),
        orElse: () => {},
      );

      genderSelected = match['key']; // will set "F" if found

      // ✅ Image: Check type and set accordingly
      if (editDetail['image'] != null &&
          editDetail['image'].toString().isNotEmpty) {
        final imagePath = editDetail['image'].toString().trim();
        myProfileImagePath = imagePath;
      }
    }

    return showModalBottomSheet<Map<String, dynamic>?>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        return StatefulBuilder(builder: (context, setState) {
          bool isImageNotAvailable = (myProfileImage == null) &&
              (editDetail == null ||
                  (editDetail['image']?.toString().isEmpty ?? true));

          Widget imageWidget;
          if (isImageNotAvailable) {
            imageWidget = Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  color: const Color(0xFF608597),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 50,
                ));
          } else {
            final imagePath = myProfileImagePath;
            if (imagePath != null && imagePath.startsWith("/")) {
              imageWidget = Container(
                height: 100,
                width: 100,
                child: ClipOval(
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            } else if (imagePath != null && imagePath.startsWith("assets/")) {
              imageWidget = Container(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/profileM2.png"));
            } else {
              imageWidget = Container(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/profileM4.png"));
            }
          }

          Future<void> pickImage() async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(source: ImageSource.camera);

            if (image != null) {
              File imageFile = File(image.path);
              setState(() {
                myProfileImage = imageFile;
                myProfileImagePath = imageFile.path;
              });
              debugPrint("Image captured: ${imageFile.path}");
            } else {
              debugPrint("No image selected");
            }
          }

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
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Container(
                          height: screenHeight * 0.75,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, -1),
                              ),
                            ],
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              /// ✅ Scrollable form fields
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.02,
                                  vertical: screenHeight * 0.07,
                                ),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: screenHeight * 0.015),
                                      // Align(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Text(
                                      //     "Add New Family Member",
                                      //     style: TextStyle(
                                      //       fontSize: screenHeight * 0.02,
                                      //       fontWeight: FontWeight.w600,
                                      //       color: Colors.black87,
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(height: screenHeight * 0.015),

                                      _buildLabelWithAsterisk(context, 'First Name', required: true),
                                      _buildField(context, firstNameController, "Enter First Name"),

                                      if (!firstNameValid)
                                        Padding(
                                          padding: EdgeInsets.only(top: screenHeight * 0.005, left: 8),
                                          child: Text(
                                            "Please enter First Name",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: screenHeight * 0.013,
                                            ),
                                          ),
                                        ),

                                      _buildLabelWithAsterisk(context, 'Last Name', required: true),
                                      _buildField(context, lastNameController, "Enter Last Name"),

                                      if (!lastNameValid)
                                        Padding(
                                          padding: EdgeInsets.only(top: screenHeight * 0.005, left: 8),
                                          child: Text(
                                            "Please enter Last Name",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: screenHeight * 0.013,
                                            ),
                                          ),
                                        ),

                                      _buildLabelWithAsterisk(context, 'UHID'),
                                      _buildField(context, uhidController, "Enter UHID"),

                                      _buildLabelWithAsterisk(context, 'Mobile Number', required: true),
                                      _buildField(context, mobileController, "Enter Mobile Number",
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [LengthLimitingTextInputFormatter(10)]),

                                      if (!mobileValid)
                                        Padding(
                                          padding: EdgeInsets.only(top: screenHeight * 0.005, left: 8),
                                          child: Text(
                                            "Please enter Mobile Number",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: screenHeight * 0.013,
                                            ),
                                          ),
                                        ),

                                      _buildLabelWithAsterisk(context, 'Email'),
                                      _buildField(context, emailController, "Enter Email Address",
                                          keyboardType: TextInputType.emailAddress),

                                      _buildLabelWithAsterisk(context, 'Relationship', required: true),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: const Color(0xFFF1F1F1)),
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
                                                  visualDensity:
                                                  const VisualDensity(horizontal: -4, vertical: -4),
                                                  materialTapTargetSize:
                                                  MaterialTapTargetSize.shrinkWrap,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      genderSelected = value!;
                                                      isGenderValid = true;
                                                    });
                                                  },
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  gender["label"]!,
                                                  style: TextStyle(
                                                    fontSize: screenHeight * 0.014,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),

                                      if (!isGenderValid)
                                        Padding(
                                          padding: EdgeInsets.only(top: screenHeight * 0.005, left: 8),
                                          child: Text(
                                            "Please select a gender",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: screenHeight * 0.013,
                                            ),
                                          ),
                                        ),

                                      SizedBox(height: screenHeight * 0.15),
                                    ],
                                  ),
                                ),
                              ),

                              Positioned(
                                top: screenHeight * 0.06,
                                left: screenHeight * 0.02,
                                child: Text(
                                  "Add New Family Member",
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.022,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              /// ✅ Fixed Buttons - Right Half of the Screen
                              Positioned(
                                bottom: 0,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Close Button
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(right: screenHeight * 0.015),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: const Color(0xFF126086), width: 1),
                                            borderRadius: BorderRadius.circular(screenHeight * 0.012),
                                          ),
                                          child: TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                vertical: screenHeight * 0.014,
                                                horizontal: screenHeight * 0.01,
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
                                      ),

                                      /// Save Button
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF126086),
                                            borderRadius: BorderRadius.circular(screenHeight * 0.012),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              if (firstNameController.text.isEmpty) {
                                                setState(() => firstNameValid = false);
                                              } else {
                                                setState(() => firstNameValid = true);
                                              }
                                              if (lastNameController.text.isEmpty) {
                                                setState(() => lastNameValid = false);
                                              } else {
                                                setState(() => lastNameValid = true);
                                              }
                                              if (mobileController.text.isEmpty) {
                                                setState(() => mobileValid = false);
                                              } else {
                                                setState(() => mobileValid = true);
                                              }
                                              if (genderSelected == null) {
                                                setState(() => isGenderValid = false);
                                              } else {
                                                setState(() => isGenderValid = true);
                                              }

                                              if (firstNameValid &&
                                                  lastNameValid &&
                                                  mobileValid &&
                                                  isGenderValid) {
                                                String gender = "";
                                                if (genderSelected == 'M') {
                                                  gender = 'Male';
                                                } else if (genderSelected == 'F') {
                                                  gender = 'Female';
                                                } else if (genderSelected == 'O') {
                                                  gender = 'Other';
                                                }

                                                Navigator.of(context).pop({
                                                  "firstName": firstNameController.text,
                                                  "lastName": lastNameController.text,
                                                  "uhid": uhidController.text,
                                                  "mobileNumber": mobileController.text,
                                                  "email": emailController.text,
                                                  "relationship": relationshipSelected,
                                                  "gender": gender,
                                                  "image": myProfileImagePath ?? "",
                                                });
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                vertical: screenHeight * 0.014,
                                                horizontal: screenHeight * 0.01,
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              /// ✅ Existing camera widget untouched
                              if (operation == "add")
                                Positioned(
                                  top: -50,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        final ImagePicker picker = ImagePicker();
                                        final XFile? image =
                                        await picker.pickImage(source: ImageSource.camera);

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
                                          image: myProfileImage != null
                                              ? DecorationImage(
                                            image: FileImage(myProfileImage!),
                                            fit: BoxFit.cover,
                                          )
                                              : null,
                                        ),
                                        child: myProfileImage == null
                                            ? const Icon(Icons.camera_alt_outlined,
                                            color: Colors.white, size: 50)
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );


        });
      },
    );
  }

  static Widget _buildLabelWithAsterisk(BuildContext context, String label,
      {bool required = false}) {
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
            text: label,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.012,
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w400,
              fontFamily: "Inter",
            ),
            children: required
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize:
                  MediaQuery.of(context).size.height * 0.012,
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

  static Widget _buildField(BuildContext context,
      TextEditingController controller, String hint,
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
            color: const Color(0x4D000000),
            fontSize: MediaQuery.of(context).size.height * 0.014,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: Color(0xFFF1F1F1), width: 1),
            borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: Color(0xFF00C7BE), width: 1),
            borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
          ),
        ),
      ),
    );
  }
}


// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// class AddMemberBottomSheet {
//     static Future<Map<String, dynamic>?> show(BuildContext context,{Map? editDetail,String? operation = "add"}) {
//       print("operation : $operation");
//       File? myProfileImage;    // Camera se capture ki image
//       String? myProfileImagePath; // Image ka path store karne ke liye (cache/storage)
//       final firstNameController = TextEditingController();
//       final lastNameController = TextEditingController();
//       final uhidController = TextEditingController();
//       final mobileController = TextEditingController();
//       final emailController = TextEditingController();
//
//       bool firstNameValid = true;
//       bool lastNameValid = true;
//       bool mobileValid = true;
//
//       // State variables
//       String? relationshipSelected;
//       String? genderSelected;
//       bool isGenderValid = true;
//
//       List<Map<String, String>> genderOptions = [
//         {"key": "M", "label": "Male"},
//         {"key": "F", "label": "Female"},
//         {"key": "O", "label": "Other"},
//       ];
//
//       List<String> relationshipOptions = [
//         "Mother",
//         "Father",
//         "Brother",
//         "Sister",
//         "Other"
//       ];
//       String image = "";
//       if(editDetail != null) {
//         print("editDetail : $editDetail");
//         firstNameController.text = editDetail['firstName'] ?? "";
//         lastNameController.text = editDetail['lastName'] ?? "";
//         uhidController.text = editDetail['uhid'] ?? "";
//         mobileController.text = editDetail['mobileNumber'] ?? "";
//         emailController.text = editDetail['email'] ?? "";
//
//         relationshipSelected = editDetail['relationship'] ?? "";
//         final String? genderLabel = editDetail['gender']; // e.g. "Female"
//
//         // ✅ Convert label ("Female") to key ("F")
//         final match = genderOptions.firstWhere(
//               (g) => g['label']?.toLowerCase() == genderLabel?.toLowerCase(),
//           orElse: () => {},
//         );
//
//         genderSelected = match['key']; // will set "F" if found
//
//         // ✅ Image: Check type and set accordingly
//         if (editDetail['image'] != null &&
//             editDetail['image'].toString().isNotEmpty) {
//           final imagePath = editDetail['image'].toString().trim();
//           myProfileImagePath = imagePath;
//
//
//         }
//
//
//
//       }
//       return showModalBottomSheet<Map<String, dynamic>?>(
//       context: context,
//       isScrollControlled: true,
//       isDismissible: true,
//       enableDrag: true,
//       backgroundColor: Colors.transparent,
//       barrierColor: Colors.transparent,
//       builder: (BuildContext context) {
//
//         final screenHeight = MediaQuery.of(context).size.height;
//         final screenWidth = MediaQuery.of(context).size.width;
//
//         // Controllers
//
//
//
//
//         return StatefulBuilder(builder: (context, setState) {
//           print("builder : ");
//           bool isImageNotAvailable =
//               (myProfileImage == null) &&
//                   (editDetail == null ||
//                       (editDetail['image']?.toString().isEmpty ?? true));
//
//           print("isImageNotAvailable : $isImageNotAvailable");
//           Widget imageWidget;
//           if (isImageNotAvailable) {
//             // No image → show first character
//             imageWidget =  Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 3),
//                   color: Color(0xFF608597),
//                   // color : Colors.red,
//
//                 ),
//                 child: Icon(
//                   Icons.camera_alt_outlined,
//                   color: Colors.white,
//                   size: 50,
//                 )
//             );
//           }
//
//           else {
//             final imagePath  =  myProfileImagePath;
//
//             if(imagePath!.startsWith("/")){
//               imageWidget =  Container(
//                 height: 100,
//                 width: 100,
//                 child: ClipOval(
//                   child: Image.file(
//                     File(imagePath),
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//               );
//             }
//
//             else if(imagePath!.startsWith("assets/")){
//               imageWidget =  Container(
//                   height: 100,
//                   width: 100,
//
//                   child: Image.asset("assets/profileM2.png")
//               );
//             }
//
//             else {
//               imageWidget =  Container(
//                   height: 100,
//                   width: 100,
//
//                   child: Image.asset("assets/profileM4.png")
//               );
//             }
//
//           }
//           return Stack(
//             children: [
//               GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//                   child: Container(
//                     color: Colors.transparent,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                 ),
//               ),
//               Stack(
//                 children:[
//                   Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Stack(
//                     children: [
//                       Container(
//                       height: screenHeight * 0.75,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 8,
//                             spreadRadius: 1,
//                             offset: Offset(0, -1),
//                           ),
//                         ],
//                       ),
//                       child: Stack(
//                          clipBehavior: Clip.none,
//                         children: [
//                           Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: screenHeight * 0.02,
//                             vertical: screenHeight * 0.07,
//                           ),
//                           child: SingleChildScrollView(
//                             physics: BouncingScrollPhysics(),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: screenHeight * 0.015),
//                                 // Header
//                                 // Center(
//                                 //   child: Container(
//                                 //     width: 40,
//                                 //     height: 4,
//                                 //     margin: EdgeInsets.only(bottom: 10),
//                                 //     decoration: BoxDecoration(
//                                 //       color: Colors.grey[400],
//                                 //       borderRadius: BorderRadius.circular(10),
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Add New Family Member",
//                                     style: TextStyle(
//                                       fontSize: screenHeight * 0.02,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ),
//
//                                 SizedBox(height: screenHeight * 0.015),
//
//                                 // Label + Field template
//                                 _buildLabelWithAsterisk(context, 'First Name', required: true),
//                                 _buildField(context, firstNameController, "Enter First Name"),
//
//                                 if (!firstNameValid)
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         top: screenHeight * 0.005, left: 8),
//                                     child: Text(
//                                       "Please enter First Name",
//                                       style: TextStyle(
//                                         color: Colors.red,
//                                         fontSize: screenHeight * 0.013,
//                                       ),
//                                     ),
//                                   ),
//
//                                 _buildLabelWithAsterisk(context, 'Last Name', required: true),
//                                 _buildField(context, lastNameController, "Enter Last Name"),
//
//                                 if (!lastNameValid)
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         top: screenHeight * 0.005, left: 8),
//                                     child: Text(
//                                       "Please enter Last Name",
//                                       style: TextStyle(
//                                         color: Colors.red,
//                                         fontSize: screenHeight * 0.013,
//                                       ),
//                                     ),
//                                   ),
//                                 _buildLabelWithAsterisk(context, 'UHID', required: false),
//                                 _buildField(context, uhidController, "Enter UHID"),
//
//                                 _buildLabelWithAsterisk(context, 'Mobile Number', required: true),
//                                 _buildField(context, mobileController, "Enter Mobile Number",
//                                     keyboardType: TextInputType.number,
//                                     inputFormatters: [LengthLimitingTextInputFormatter(10)]),
//
//                                 if (!mobileValid)
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         top: screenHeight * 0.005, left: 8),
//                                     child: Text(
//                                       "Please enter Mobile Number",
//                                       style: TextStyle(
//                                         color: Colors.red,
//                                         fontSize: screenHeight * 0.013,
//                                       ),
//                                     ),
//                                   ),
//                                 _buildLabelWithAsterisk(context, 'Email'),
//                                 _buildField(context, emailController, "Enter Email Address",
//                                     keyboardType: TextInputType.emailAddress),
//
//                                 _buildLabelWithAsterisk(context, 'Relationship', required: true),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(color: Color(0xFFF1F1F1)),
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButton<String>(
//                                       value: relationshipSelected,
//                                       hint: Text(
//                                         "Select Relationship",
//                                         style: TextStyle(
//                                           color: Colors.black38,
//                                           fontSize: screenHeight * 0.014,
//                                         ),
//                                       ),
//                                       isExpanded: true,
//                                       dropdownColor: Colors.white,
//                                       items: relationshipOptions
//                                           .map((value) => DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       ))
//                                           .toList(),
//                                       onChanged: (value) {
//                                         setState(() {
//                                           relationshipSelected = value!;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//
//                                 _buildLabelWithAsterisk(context, 'Gender', required: true),
//
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start, // left align the whole row
//                                   children: genderOptions.map((gender) {
//                                     return InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           genderSelected = gender["key"]!;
//                                           isGenderValid = true;
//                                         });
//                                       },
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min, // take only as much space as needed
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Radio<String>(
//                                             value: gender["key"]!,
//                                             groupValue: genderSelected,
//                                             activeColor: const Color(0xFF00C7BE),
//                                             visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//                                             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 genderSelected = value!;
//                                                 isGenderValid = true;
//                                               });
//                                             },
//                                           ),
//                                           SizedBox(width: 2), // small gap between radio and text
//                                           Text(
//                                             gender["label"]!,
//                                             style: TextStyle(
//                                               fontSize: screenHeight * 0.014,
//                                             ),
//                                           ),
//                                           SizedBox(width: 10), // optional: gap between different options
//                                         ],
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//
//
//                                 if (!isGenderValid)
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         top: screenHeight * 0.005, left: 8),
//                                     child: Text(
//                                       "Please select a gender",
//                                       style: TextStyle(
//                                         color: Colors.red,
//                                         fontSize: screenHeight * 0.013,
//                                       ),
//                                     ),
//                                   ),
//
//                                 SizedBox(height: screenHeight * 0.02),
//
//                                 // Buttons Row
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end, // Align row contents to right
//                                   children: [
//                                     Container(
//                                       width: MediaQuery.of(context).size.width * 0.5, // 50% of total width
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               alignment: Alignment.center,
//                                               margin: EdgeInsets.only(
//                                                 right: screenHeight * 0.01,
//                                               ),
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(color: Color(0xFF126086), width: 1),
//                                                 borderRadius:
//                                                 BorderRadius.circular(screenHeight * 0.012),
//                                               ),
//                                               child: TextButton(
//                                                 onPressed: () => Navigator.of(context).pop(),
//                                                 child: Text(
//                                                   "Close",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: Color(0xFF126086),
//                                                     fontSize: screenHeight * 0.016,
//                                                     fontWeight: FontWeight.w600,
//                                                     fontFamily: "Inter",
//                                                   ),
//                                                 ),
//                                                 style: TextButton.styleFrom(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 11.0, horizontal: 12.0),
//                                                   minimumSize: Size(0, 0),
//                                                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 color: Color(0xFF126086),
//                                                 borderRadius:
//                                                 BorderRadius.circular(screenHeight * 0.012),
//                                               ),
//                                               child: TextButton(
//                                                 onPressed: () {
//                                                   if(firstNameController == null || firstNameController.text.isEmpty){
//                                                      setState( (){
//                                                        setState(() => firstNameValid = false);
//                                                      });
//                                                   }
//                                                   else {
//                                                     setState(() => firstNameValid = true);
//                                                   }
//                                                   if(lastNameController == null || lastNameController.text.isEmpty){
//                                                     setState( (){
//                                                       setState(() => lastNameValid = false);
//                                                     });
//                                                   }
//                                                   else {
//                                                     setState(() => lastNameValid = true);
//                                                   }
//                                                   if(mobileController == null || mobileController.text.isEmpty){
//                                                     setState( (){
//                                                       setState(() => mobileValid = false);
//                                                     });
//                                                   }
//
//                                                   else {
//                                                     setState(() => mobileValid = true);
//                                                   }
//
//                                                    if (genderSelected == null) {
//                                                     setState(() => isGenderValid = false);
//                                                   }
//                                                    else {
//                                                      setState(() => isGenderValid = true);
//                                                    }
//
//                                                    if(firstNameValid && lastNameValid && mobileValid && isGenderValid ) {
//                                                     String gender = "";
//                                                     if (genderSelected == 'M') {
//                                                       gender = 'Male';
//                                                     } else if (genderSelected == 'F') {
//                                                       gender = 'Female';
//                                                     } else if (genderSelected == 'O') {
//                                                       gender = 'Other';
//                                                     }
//                                                      Navigator.of(context).pop({
//                                                        "firstName": firstNameController.text,
//                                                        "lastName": lastNameController.text,
//                                                        "uhid": uhidController.text,
//                                                        "mobileNumber": mobileController.text,
//                                                        "email": emailController.text,
//                                                        "relationship": relationshipSelected,
//                                                        "gender": gender,
//                                                        "image": myProfileImagePath ?? "", // captured image path
//                                                      });
//                                                     // Implement save logic here
//                                                   }
//                                                 },
//                                                 child: Text(
//                                                   "Save",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: screenHeight * 0.017,
//                                                     fontWeight: FontWeight.w700,
//                                                     fontFamily: "Inter",
//                                                   ),
//                                                 ),
//                                                 style: TextButton.styleFrom(
//                                                   padding: EdgeInsets.symmetric(vertical: 11.0),
//                                                   minimumSize: Size(0, 0),
//                                                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: screenHeight * 0.5),
//                               ],
//                             ),
//                           ),
//                         ),
//                           if(operation == "add")
//                           Positioned(
//                             top: -50,
//                             left: 0,
//                             right: 0,
//                             child: GestureDetector(
//                               onTap: () async {
//                                 final ImagePicker picker = ImagePicker();
//
//                                 final XFile? image = await picker.pickImage(source: ImageSource.camera);
//
//                                 if (image != null) {
//                                   File imageFile = File(image.path);
//
//                                   setState(() {
//                                     myProfileImage = imageFile;          // UI me turant show
//                                     myProfileImagePath = imageFile.path; // path store for return
//                                   });
//
//                                   debugPrint("Image captured: ${imageFile.path}");
//                                 } else {
//                                   debugPrint("No image selected");
//                                 }
//                               },
//
//                               child: Center(
//                                 child: GestureDetector(
//
//                                   onTap: () async {
//                                     final ImagePicker picker = ImagePicker();
//
//                                     final XFile? image = await picker.pickImage(source: ImageSource.camera);
//
//                                     if (image != null) {
//                                       File imageFile = File(image.path);
//
//                                       setState(() {
//                                         myProfileImage = imageFile;          // UI me turant show
//                                         myProfileImagePath = imageFile.path; // path store for return
//                                       });
//
//                                       debugPrint("Image captured: ${imageFile.path}");
//                                     } else {
//                                       debugPrint("No image selected");
//                                     }
//                                   },
//                                   child: Container(
//                                     height: 100,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(color: Colors.white, width: 3),
//                                       color: Color(0xFF608597),
//                                       // color : Colors.red,
//                                       image: myProfileImage != null
//                                           ? DecorationImage(
//                                         image: FileImage(myProfileImage!),
//                                         fit: BoxFit.cover,
//                                       )
//                                           : null,
//                                     ),
//                                     child: myProfileImage == null
//                                         ? Icon(
//                                       Icons.camera_alt_outlined,
//                                       color: Colors.white,
//                                       size: 50,
//                                     )
//                                         : null,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           if(operation == "edit")
//                             Positioned(
//                               top: -50,
//                               left: 0,
//                               right: 0,
//                               child: Center(
//                                 child: GestureDetector(
//                                   onTap: () async {
//                                     final ImagePicker picker = ImagePicker();
//                                     final XFile? picked = await picker.pickImage(source: ImageSource.camera);
//
//                                     if (picked != null) {
//                                       File imageFile = File(picked.path);
//                                       setState(() {
//                                         myProfileImage = imageFile;
//                                         myProfileImagePath = imageFile.path;
//
//                                       });
//                                       debugPrint("📸 New image selected: ${imageFile.path}");
//                                     } else {
//                                       debugPrint("No image selected");
//                                     }
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//
//                                       color: Color(0xFF608597),
//                                     ),
//                                       child: imageWidget
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                         ]
//                       ),
//                     ),
//
//                     ]
//                   ),
//                 ), ]
//               ),
//
//
//             ],
//           );
//         });
//       },
//     );
//   }
//
//   static Widget _buildLabelWithAsterisk(BuildContext context, String label, {bool required = false}) {
//     return Padding(
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).size.height * 0.01,
//         left: MediaQuery.of(context).size.height * 0.005,
//         bottom: MediaQuery.of(context).size.height * 0.01,
//       ),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: RichText(
//           textAlign: TextAlign.start,
//           text: TextSpan(
//             text: label, // The label text
//             style: TextStyle(
//               fontSize: MediaQuery.of(context).size.height * 0.012,
//               color: Color(0xFF333333),
//               fontWeight: FontWeight.w400,
//               fontFamily: "Inter",
//             ),
//             children: required
//                 ? [
//               TextSpan(
//                 text: ' *', // Red asterisk
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: MediaQuery.of(context).size.height * 0.012,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: "Inter",
//                 ),
//               ),
//             ]
//                 : [],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Widget _buildField(BuildContext context, TextEditingController controller, String hint,
//       {TextInputType keyboardType = TextInputType.text,
//         List<TextInputFormatter>? inputFormatters}) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: MediaQuery.of(context).size.height * 0.005,
//         right: MediaQuery.of(context).size.height * 0.005,
//         bottom: MediaQuery.of(context).size.height * 0.008,
//       ),
//       child: TextFormField(
//         controller: controller,
//         inputFormatters: inputFormatters,
//         keyboardType: keyboardType,
//         style: TextStyle(
//           color: Colors.black45,
//           fontSize: MediaQuery.of(context).size.height * 0.016,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           isDense: true,
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.height * 0.02,
//             vertical: MediaQuery.of(context).size.height * 0.013,
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           hintText: hint,
//           hintStyle: TextStyle(
//             color: Color(0x4D111111),
//             fontSize: MediaQuery.of(context).size.height * 0.012,
//             fontWeight: FontWeight.w400,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.0),
//             borderSide: BorderSide(color: Color(0xFFF1F1F1)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.0),
//             borderSide: BorderSide(color: Color(0xFFF1F1F1)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5.0),
//             borderSide: BorderSide(color: Color(0xFF00C7BE)),
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
//
// // 👇 Builds correct DecorationImage based on input
// DecorationImage? _buildProfileImage(String? image, File? myProfileImage) {
//
//   if (myProfileImage != null) {
//     // ✅ Camera/Gallery se li gayi image
//     return DecorationImage(image: FileImage(myProfileImage), fit: BoxFit.cover);
//   } else if (image != null && image.isNotEmpty) {
//     if (image.startsWith('assets/')) {
//       // ✅ Local asset image
//       return DecorationImage(image: AssetImage(image), fit: BoxFit.fill);
//     } else if (image.startsWith('/') || image.startsWith('storage/')) {
//       // ✅ Local file from storage
//       return DecorationImage(image: FileImage(File(image)), fit: BoxFit.cover);
//     }
//   }
//   return null; // No image → camera icon visible
// }
//
// // 👇 Shows camera icon only if no image exists
// Widget? _buildCameraIcon(String? image, File? myProfileImage) {
//
//   if (myProfileImage == null && (image == null || image.isEmpty)) {
//     return const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 50);
//   }
//   return null;
// }
//
