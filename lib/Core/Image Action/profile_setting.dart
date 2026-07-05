import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newfolder/Core/Data/dummy_data.dart';
import 'package:newfolder/Core/Data/notifier.dart';
import 'package:newfolder/Core/Dialog/camera_image.dart';
import 'package:newfolder/Screens/Utils/profile_avatar.dart';

// 🌟 Apne paths ke hisaab se inko import kar lijiye
// import 'package:newfolder/Screens/Utils/global_state.dart';
// import 'package:newfolder/Screens/Widgets/profile_avatar.dart'; // Jisme ProfileAvatar hai

class ProfileImagePicker extends StatelessWidget {
  final bool isGuestUser; // Screen batayegi ki user guest hai ya nahi

  const ProfileImagePicker({Key? key, required this.isGuestUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isGuestUser) return; // disable picking for guest users
        CustomImagePicker.show(context, onImagePicked: (File pickedFile) {
          NotifierData.profileImageNotifier.value = pickedFile;
        });
      },
      child: Center(
        child: Stack(
          children: [
            isGuestUser
                ? ProfileAvatar(
              name: "Guest User",
              radius: MediaQuery.of(context).size.height * 0.06,
              backgroundColor: Color(0x66D9D9D9),
              textColor: Colors.white,
            )
                : ValueListenableBuilder<File?>(
              valueListenable: NotifierData.profileImageNotifier,
              builder: (context, globalImage, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(130.0),
                  child: globalImage != null
                      ? Image.file(
                    globalImage,
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.height * 0.12,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    'assets/drsujeet.png', // Apni default image lagayein
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.height * 0.12,
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
            if (!isGuestUser)
              Positioned(
                bottom: 6,
                right: 4,
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.018,
                  height: MediaQuery.of(context).size.height * 0.018,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(
                      width: MediaQuery.of(context).size.height * 0.002,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}