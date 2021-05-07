import 'package:pose_detection_app/app/entity/LandmarkEntity.dart';

class PoseEntity {
  Map<String, LandmarksEntity> landmarks;
  int width;
  int height;

  PoseEntity({this.landmarks});

  PoseEntity.fromJson(Map<String, dynamic> json) {
    if (json['landmarks'] != null) {
      landmarks = new Map<String, LandmarksEntity>();
      json['landmarks'].forEach((v) {
        var landmark = new LandmarksEntity.fromJson(v);
        landmarks.putIfAbsent(landmark.type, () => landmark);
      });
    }
  }
}