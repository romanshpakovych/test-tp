import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pose_detection_app/app/model/LandmarkModel.dart';
import 'package:pose_detection_app/app/entity/PoseEntity.dart';

/*
Simple painter to represent detected landmarks over camera view
 */

//Pair of related landmarks
class JoinPair {
  final LandmarkModel a;
  final LandmarkModel b;

  const JoinPair(this.a, this.b);
}

//Pairs to paint lines between two landmarks
const joins = {
  const JoinPair(LandmarkModel.RIGHT_SHOULDER, LandmarkModel.RIGHT_ELBOW),
  const JoinPair(LandmarkModel.LEFT_SHOULDER, LandmarkModel.LEFT_ELBOW),
  const JoinPair(LandmarkModel.RIGHT_ELBOW, LandmarkModel.RIGHT_WRIST),
  const JoinPair(LandmarkModel.LEFT_ELBOW, LandmarkModel.LEFT_WRIST),
  const JoinPair(LandmarkModel.RIGHT_WRIST, LandmarkModel.RIGHT_THUMB),
  const JoinPair(LandmarkModel.LEFT_WRIST, LandmarkModel.LEFT_THUMB),
  const JoinPair(LandmarkModel.RIGHT_WRIST, LandmarkModel.RIGHT_PINKY),
  const JoinPair(LandmarkModel.LEFT_WRIST, LandmarkModel.LEFT_PINKY),
  const JoinPair(LandmarkModel.RIGHT_WRIST, LandmarkModel.RIGHT_INDEX),
  const JoinPair(LandmarkModel.LEFT_WRIST, LandmarkModel.LEFT_INDEX),
  const JoinPair(LandmarkModel.RIGHT_PINKY, LandmarkModel.RIGHT_INDEX),
  const JoinPair(LandmarkModel.LEFT_PINKY, LandmarkModel.LEFT_INDEX),
  const JoinPair(LandmarkModel.RIGHT_SHOULDER, LandmarkModel.LEFT_SHOULDER),
  const JoinPair(LandmarkModel.RIGHT_SHOULDER, LandmarkModel.RIGHT_HIP),
  const JoinPair(LandmarkModel.LEFT_SHOULDER, LandmarkModel.LEFT_HIP),
  const JoinPair(LandmarkModel.RIGHT_HIP, LandmarkModel.LEFT_HIP),
  const JoinPair(LandmarkModel.RIGHT_HIP, LandmarkModel.RIGHT_KNEE),
  const JoinPair(LandmarkModel.LEFT_HIP, LandmarkModel.LEFT_KNEE),
  const JoinPair(LandmarkModel.RIGHT_KNEE, LandmarkModel.RIGHT_ANKLE),
  const JoinPair(LandmarkModel.LEFT_KNEE, LandmarkModel.LEFT_ANKLE),
  const JoinPair(LandmarkModel.RIGHT_ANKLE, LandmarkModel.RIGHT_FOOT_INDEX),
  const JoinPair(LandmarkModel.LEFT_ANKLE, LandmarkModel.LEFT_FOOT_INDEX),
  const JoinPair(LandmarkModel.RIGHT_ANKLE, LandmarkModel.RIGHT_HEEL),
  const JoinPair(LandmarkModel.LEFT_ANKLE, LandmarkModel.LEFT_HEEL),
  const JoinPair(LandmarkModel.RIGHT_FOOT_INDEX, LandmarkModel.RIGHT_HEEL),
  const JoinPair(LandmarkModel.LEFT_FOOT_INDEX, LandmarkModel.LEFT_HEEL),
};

class PosePainter extends CustomPainter {
  static var pointPaint = Paint()
    ..color = Colors.amber
    ..strokeCap = StrokeCap.round
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

    //Fractions to calculate correct landmarks position relatively to canvas
    double xFraction = size.width / _poseEntity.height;
    double yFraction = size.height / _poseEntity.width;

    //Draw all join pairs
    joins.forEach((element) {
      var from = _poseEntity.landmarks[element.a.name].coordinates;
      var to = _poseEntity.landmarks[element.b.name].coordinates;
      canvas.drawLine(
          Offset((from.x * xFraction).validate(size.width),
              (from.y * yFraction).validate(size.height)),
          Offset((to.x * xFraction).validate(size.width),
              (to.y * yFraction).validate(size.height)),
          linePaint);
    });

    //Separates points just to paint sides (left, middle, right) in different colors
    var leftPoints = _poseEntity.landmarks.values
        .where((element) => LandmarkModel.fromString(element.type).side == LandmarkSide.left);
    var rightPoints = _poseEntity.landmarks.values
        .where((element) => LandmarkModel.fromString(element.type).side == LandmarkSide.right);
    var middlePoints = _poseEntity.landmarks.values
        .where((element) => LandmarkModel.fromString(element.type).side == LandmarkSide.middle);

    //Draw points function
    Function drawPoints = (Iterable points, Color color) {
      canvas.drawPoints(
          PointMode.points,
          points
              .map((e) => Offset(
                  ((e.coordinates.x * xFraction) as double)
                      .validate(size.width),
                  ((e.coordinates.y * yFraction) as double)
                      .validate(size.height)))
              .toList(),
          pointPaint..color = color);
    };

    drawPoints(leftPoints, Colors.lightBlue);
    drawPoints(rightPoints, Colors.orange);
    drawPoints(middlePoints, Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

extension Adduction on double {
  double validate(double maximum) => max(min(this, maximum), 0);
}
