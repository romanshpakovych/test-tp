import 'package:pose_detection_app/app/entity/CoordinatesEntity.dart';

class LandmarksEntity {
  double likelihood;
  String type;
  CoordinatesEntity coordinates;

  LandmarksEntity({this.likelihood, this.type, this.coordinates});

  LandmarksEntity.fromJson(Map<String, dynamic> json) {
    likelihood = (json['likelihood'] as num).toDouble();
    type = json['type'];
    coordinates = json['coordinates'] != null
        ? new CoordinatesEntity.fromJson(json['coordinates'])
        : null;
  }
}
