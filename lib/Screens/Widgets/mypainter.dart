import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final double startX = size.width / 2;
    final double startY = 0;
    final double endY = size.height;

    final Path path = Path();
    path.moveTo(startX, startY);
    path.lineTo(startX, endY);

    final List<Offset> dashPoints = List.generate(
        (endY / 10).floor(), (index) => Offset(startX, startY + index * 20.0));

    canvas.drawPath(
      dashPoints.fold<Path>(Path(), (prev, point) {
        return prev..addOval(Rect.fromCircle(center: point, radius: 2));
      }),
      paint
        ..strokeWidth = 1.0
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
