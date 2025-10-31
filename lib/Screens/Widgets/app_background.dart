import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool hasFooter; // 👈 add this flag for screens with bottom nav

  const AppBackground({
    super.key,
    required this.child,
    this.isLoading = false,
    this.hasFooter = false,
  });

  @override
  Widget build(BuildContext context) {
    final double footerHeight = MediaQuery.of(context).size.height * 0.09;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height-footerHeight, 
      decoration: isLoading
          ? const BoxDecoration(color: Colors.white)
          : const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Background Pattern.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter, // keeps it visually consistent
              ),
            ),
      child: child,
    );
  }
}
