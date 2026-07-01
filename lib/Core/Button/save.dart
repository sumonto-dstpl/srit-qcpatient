import 'package:flutter/material.dart';

class GlobalActionButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onTap;
  final String title;

  const GlobalActionButton({
    Key? key,
    required this.isEnabled,
    required this.onTap,
    this.title = "Save",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(
        left: height * 0.04,
        right: height * 0.04,
        bottom: height * 0.07,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.012),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.center,
          stops: const [0.5, 0.9],
          colors: isEnabled
              ? const [Color(0xFF13668E), Color(0xFF13668E)]
              : const [Color(0xFFBDBDBD), Color(0xFFBDBDBD)],
        ),
      ),
      // Material aur InkWell ka use kiya hai taaki tap karne par ripple effect aaye
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(height * 0.012),
          onTap: onTap, // Tap event yahan trigger hoga
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}