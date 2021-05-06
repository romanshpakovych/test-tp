import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pose_detection_app/app/entity/PoseEntity.dart';

class PosePainter extends CustomPainter {
  PoseEntity _poseEntity;

  PosePainter(this._poseEntity);

  @override
  void paint(Canvas canvas, Size size) {
    if (_poseEntity == null) return;

    var paint = Paint();
    paint.color = Colors.amber;
    paint.strokeWidth = 6;

    double xFraction = size.width / _poseEntity.height;
    double yFraction = size.height / _poseEntity.width;

    canvas.drawPoints(
        PointMode.points,
        _poseEntity.landmarks
            .map((e) => Offset(e.coordinates.y*xFraction, e.coordinates.x*yFraction))
            .toList()
              ..add(Offset(size.width / 2, size.height / 2)),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
