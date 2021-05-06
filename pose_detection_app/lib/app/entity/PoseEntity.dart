import 'package:pose_detection_app/app/entity/LandmarkEntity.dart';

class PoseEntity {
  List<LandmarksEntity> landmarks;
  int width;
  int height;

  PoseEntity({this.landmarks});

  PoseEntity.fromJson(Map<String, dynamic> json) {
    if (json['landmarks'] != null) {
      landmarks = new List<LandmarksEntity>();
      json['landmarks'].forEach((v) {
        landmarks.add(new LandmarksEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.landmarks != null) {
      data['landmarks'] = this.landmarks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}