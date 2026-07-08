import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  // 🌟 NAYA: Sirf ek callback jo picked image wapas dega
  static void show(BuildContext context, {required Function(File) onImagePicked}) {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.transparent,
      barrierColor: Colors.black45, // Background transparent rakha taki margin kaam kare
      isScrollControlled: true, // Bottom sheet ko uske content ke hisaab se size lene deta hai
      builder: (BuildContext context) {



        final height = MediaQuery.of(context).size.height ;
        return Container(


          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),

          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Jinta content h utni hi height lega
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: height * 0.006,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9), // Divider color
                    borderRadius: BorderRadius.circular(10),
                    // Rounded edges
                  ),
                ),
              ),
              const SizedBox( height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,),

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ❌ Left aligned Close Icon
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close action
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 26, // Image me icon thoda prominent hai
                        ),
                      ),
                    ),

                    // 📝 Centered Text
                    const Text(
                      "Open With",
                      style: TextStyle(
                        fontSize: 18, // Exact text size
                        fontWeight: FontWeight.w400, // Normal font weight (bold nahi hai image me)
                        color: Colors.black,
                        letterSpacing: 0.2, // Thoda clean look ke liye
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox( height: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Left align karne ke liye
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 📷 Camera Option
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context); // Bottom sheet close
                      final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                      if (image != null) {
                        onImagePicked(File(image.path)); // 🌟 Data bahar bhejna
                      }
                    },
                    child: Padding(
                      // Padding for touch area and spacing
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.photo_camera_outlined, // Outlined camera icon as per image
                            color: Colors.black, // Slight greyish white
                            size: 28,
                          ),
                          const SizedBox(width: 20), // Icon aur text ke beech ka space
                          const Text(
                            "Camera",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 🖼️ Gallery Option
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context); // Bottom sheet close
                      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        onImagePicked(File(image.path)); // 🌟 Data bahar bhejna
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.image_outlined, // Outlined gallery icon as per image
                            color: Colors.black,
                            size: 28,
                          ),
                          const SizedBox(width: 20), // Icon aur text ke beech ka space
                          const Text(
                            "Gallery",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox( height: 16,),

            ],
          ),
        );
      },
    );
  }
}