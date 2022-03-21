import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  const CirclePainter({
    required this.offset,
    required this.color,
  });

  final Color color;
  final Offset offset;

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      offset,
      10,
      Paint()
        ..strokeWidth = 1
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }
}
