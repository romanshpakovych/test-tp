

import 'package:flutter/material.dart';

class PosePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.amber;
    paint.strokeWidth = 2;

    canvas.drawLine(
      Offset(0, size.height / 3),
      Offset(size.width, size.height / 3),
      paint,
    );

    canvas.drawLine(
      Offset(0, (size.height / 3) * 2),
      Offset(size.width, (size.height / 3) * 2),
      paint,
    );

    canvas.drawLine(
      Offset(size.width / 3, 0),
      Offset(size.width / 3, size.height),
      paint,
    );

    canvas.drawLine(
      Offset((size.width / 3) * 2, 0),
      Offset((size.width / 3) * 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}