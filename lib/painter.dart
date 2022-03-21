import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class FilledPathPainter extends CustomPainter {
  const FilledPathPainter({
    required this.path,
    required this.color,
    required this.currentIndex,
    required this.startDrawing,
    required this.points,
  });

  final String path;
  final Color color;
  final int currentIndex;
  final bool startDrawing;
  final List<dynamic> points;

  @override
  bool shouldRepaint(FilledPathPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      parseSvgPathData(path),
      Paint()
        ..strokeWidth = 2
        ..color = color
        ..style = PaintingStyle.stroke,
    );

    var squarePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var point in points) {
      canvas.drawRect(
          Offset(point['x'], point['y']) & const Size(8, 8), squarePaint);
    }
  }
}
