import 'package:pose_detection_app/app/entity/CoordinatesEntity.dart';

class LandmarksEntity {
  double likelihood;
  String type;
  CoordinatesEntity coordinates;

  LandmarksEntity({this.likelihood, this.type, this.coordinates});

  LandmarksEntity.fromJson(Map<String, dynamic> json) {
    likelihood = json['likelihood'];
    type = json['type'];
    coordinates = json['coordinates'] != null
        ? new CoordinatesEntity.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likelihood'] = this.likelihood;
    data['type'] = this.type;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    return data;
  }
}