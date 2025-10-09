// profile_avatar.dart
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double radius;
  final Color backgroundColor;
  final Color textColor;

  const ProfileAvatar({
    Key? key,
    required this.name,
    this.imageUrl,
    this.radius = 30,
    this.backgroundColor = const Color(0xFF00C7BE),
    this.textColor = Colors.white,
  }) : super(key: key);

  // Helper to generate initials
  String getInitials(String name) {
    List<String> parts = name.trim().split(' ');
    if (parts.isEmpty) return "";
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
          ? NetworkImage(imageUrl!)
          : null,
      child: imageUrl == null || imageUrl!.isEmpty
          ? Text(
        // getInitials(name),
        "GS",
        style: TextStyle(
          color: textColor,
          fontSize: radius * 0.3,
          fontWeight: FontWeight.bold,
        ),
      )
          : null,
    );
  }
}
