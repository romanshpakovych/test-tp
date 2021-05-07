import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pose_detection_app/app/entity/LandmarkEntity.dart';
import 'package:pose_detection_app/app/entity/PoseEntity.dart';

class JoinPair {
  final Landmark a;
  final Landmark b;

  const JoinPair(this.a, this.b);
}

const joins = {
  const JoinPair(Landmark.RIGHT_SHOULDER, Landmark.RIGHT_ELBOW),
  const JoinPair(Landmark.LEFT_SHOULDER, Landmark.LEFT_ELBOW),
  const JoinPair(Landmark.RIGHT_ELBOW, Landmark.RIGHT_WRIST),
  const JoinPair(Landmark.LEFT_ELBOW, Landmark.LEFT_WRIST),
  const JoinPair(Landmark.RIGHT_WRIST, Landmark.RIGHT_THUMB),
  const JoinPair(Landmark.LEFT_WRIST, Landmark.LEFT_THUMB),
  const JoinPair(Landmark.RIGHT_WRIST, Landmark.RIGHT_PINKY),
  const JoinPair(Landmark.LEFT_WRIST, Landmark.LEFT_PINKY),
  const JoinPair(Landmark.RIGHT_WRIST, Landmark.RIGHT_INDEX),
  const JoinPair(Landmark.LEFT_WRIST, Landmark.LEFT_INDEX),
  const JoinPair(Landmark.RIGHT_PINKY, Landmark.RIGHT_INDEX),
  const JoinPair(Landmark.LEFT_PINKY, Landmark.LEFT_INDEX),
  const JoinPair(Landmark.RIGHT_SHOULDER, Landmark.LEFT_SHOULDER),
  const JoinPair(Landmark.RIGHT_SHOULDER, Landmark.RIGHT_HIP),
  const JoinPair(Landmark.LEFT_SHOULDER, Landmark.LEFT_HIP),
  const JoinPair(Landmark.RIGHT_HIP, Landmark.LEFT_HIP),
  const JoinPair(Landmark.RIGHT_HIP, Landmark.RIGHT_KNEE),
  const JoinPair(Landmark.LEFT_HIP, Landmark.LEFT_KNEE),
  const JoinPair(Landmark.RIGHT_KNEE, Landmark.RIGHT_ANKLE),
  const JoinPair(Landmark.LEFT_KNEE, Landmark.LEFT_ANKLE),
  const JoinPair(Landmark.RIGHT_ANKLE, Landmark.RIGHT_FOOT_INDEX),
  const JoinPair(Landmark.LEFT_ANKLE, Landmark.LEFT_FOOT_INDEX),
  const JoinPair(Landmark.RIGHT_ANKLE, Landmark.RIGHT_HEEL),
  const JoinPair(Landmark.LEFT_ANKLE, Landmark.LEFT_HEEL),
  const JoinPair(Landmark.RIGHT_FOOT_INDEX, Landmark.RIGHT_HEEL),
  const JoinPair(Landmark.LEFT_FOOT_INDEX, Landmark.LEFT_HEEL),
};

class PosePainter extends CustomPainter {
  static var pointPaint = Paint()
    ..color = Colors.amber
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2
    ..strokeWidth = 4;

  static var linePaint = Paint()
    ..color = Colors.white
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2;
  
  PoseEntity _poseEntity;

  PosePainter(this._poseEntity);

  @override
  void paint(Canvas canvas, Size size) {
    if (_poseEntity == null) return;

    double xFraction = size.width / _poseEntity.height;
    double yFraction = size.height / _poseEntity.width;

    joins.forEach((element) {
      var from = _poseEntity.landmarks[element.a.name].coordinates;
      var to = _poseEntity.landmarks[element.b.name].coordinates;
      canvas.drawLine(Offset(from.x * xFraction, from.y * yFraction),
          Offset(to.x * xFraction, to.y * yFraction), linePaint);
    });

    canvas.drawPoints(
        PointMode.points,
        _poseEntity.landmarks.values
            .map((e) => Offset(
                e.coordinates.x * xFraction, e.coordinates.y * yFraction))
            .toList(),
        pointPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
