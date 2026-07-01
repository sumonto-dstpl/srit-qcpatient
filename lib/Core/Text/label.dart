import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class LabelWithAsterisk extends StatelessWidget {
  final String label;
  final bool isRequired;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const LabelWithAsterisk({
    super.key,
    required this.label,
    this.isRequired = false,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    // Agar custom values pass ki gayi hain toh wo use hongi,
    // nahi toh purani default values apply ho jayengi.
    final double finalFontSize = fontSize ?? (MediaQuery.of(context).size.height * 0.016);
    final Color finalTextColor = textColor ?? const Color(0xFF333333);
    final FontWeight finalFontWeight = fontWeight ?? FontWeight.w500;

    return Padding(
      padding: EdgeInsets.only(

      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: finalFontSize,
              color: finalTextColor,
              fontWeight: finalFontWeight,
            ),
            children: isRequired
                ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
                : [],
          ),
        ),
      ),
    );
  }
}