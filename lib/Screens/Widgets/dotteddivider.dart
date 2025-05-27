import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double height;

  DottedDivider({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.gap = 3.0,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinePainter(color, strokeWidth, gap),
      size: Size.fromHeight(height),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DottedLinePainter(this.color, this.strokeWidth, this.gap);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + gap, 0), paint);
      startX += gap * 2;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) => false;
}
