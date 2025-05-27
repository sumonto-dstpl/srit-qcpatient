import 'package:flutter/material.dart';

class CustomDividerWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Custom Divider with increasing thickness
        CustomPaint(
          size: Size(double.infinity, 1), // Divider height (thickness)
          painter: _CustomDividerPainter(),
        ),
        // Container with the text
        Container(
          color: Colors.white, // Background color to cover the divider
          padding:
              EdgeInsets.symmetric(horizontal: 10), // Padding around the text
          child: Text(
            "or",
            style: TextStyle(
              color: Color(0xFF1F1F1F),
              fontSize: MediaQuery.of(context).size.height * 0.014, // Adjust font size as needed
              fontWeight: FontWeight.w400,
              fontFamily:  "Inter"// Optional: to make the text bold
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double maxWidth = size.width;
    double centerX = maxWidth / 2;
    final Shader shader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        const Color(0xFFFFFFFF), // Start color
        const Color(0xFF999999).withOpacity(0.1), // Center (fade out)
        const Color(0xFFFFFFFF), // End color
      ],
       // stops: [0.0, 0.5, 1.0], // Mid-point fade
    ).createShader(Rect.fromLTWH(0, 0, maxWidth, size.height));
    final Paint paint = Paint()
      // ..color = Colors.black12 // Color of the divider
       ..shader = shader
      ..strokeCap = StrokeCap.round;


    double thickness = 1.0; // Initial thickness at the start

    // Draw the divider path
    for (double i = 0; i <= maxWidth; i++) {
      // Gradually increase thickness as we approach the center
      if (i < centerX) {
        thickness =
            1 + (i / centerX) * 2; // Increase thickness towards the center
      } else {
        thickness = 1 +
            ((maxWidth - i) / centerX) *
                2; // Decrease thickness after the center
      }

      paint.strokeWidth = thickness;
      canvas.drawLine(
          Offset(i, size.height / 2), Offset(i + 1, size.height / 2), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


