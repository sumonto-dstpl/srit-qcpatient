import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  // 🌟 NAYA: Sirf ek callback jo picked image wapas dega
  static void show(BuildContext context, {required Function(File) onImagePicked}) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          elevation: 0,
          alignment: Alignment.bottomCenter,
          insetPadding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Open with",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // 📷 Camera Option
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context); // Dialog close
                        final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
                        if (image != null) {
                          onImagePicked(File(image.path)); // 🌟 Sirf ye line data bahar bhejegi
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.camera_alt, color: Colors.blueAccent, size: 50),
                          ),
                          const SizedBox(height: 8),
                          const Text("Camera", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFFAFAFA))),
                        ],
                      ),
                    ),

                    // 🖼️ Gallery Option
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context); // Dialog close
                        final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          onImagePicked(File(image.path)); // 🌟 Sirf ye line data bahar bhejegi
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.photo_library, color: Colors.blueAccent, size: 50),
                          ),
                          const SizedBox(height: 8),
                          const Text("Gallery", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFFAFAFA))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // ❌ Cancel Button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}