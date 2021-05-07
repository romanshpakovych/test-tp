import 'package:pose_detection_app/app/entity/CoordinatesEntity.dart';

class Landmark  {
  final String name;
  final int id;
  const Landmark._internal(this.name, this.id);
  
  static const NOSE = const Landmark._internal("Nose", 0);
  static const LEFT_EYE_INNER = const Landmark._internal("LeftEyeInner", 1);
  static const LEFT_EYE = const Landmark._internal("LeftEye", 2);
  static const LEFT_EYE_OUTER = const Landmark._internal("LeftEyeOuter", 3);
  static const RIGHT_EYE_INNER = const Landmark._internal("RightEyeInner", 4);
  static const RIGHT_EYE = const Landmark._internal("RightEye", 5);
  static const RIGHT_EYE_OUTER = const Landmark._internal("RightEyeOuter", 6);
  static const LEFT_EAR = const Landmark._internal("LeftEar", 7);
  static const RIGHT_EAR = const Landmark._internal("RightEar", 8);
  static const LEFT_MOUTH = const Landmark._internal("MouthLeft", 9);
  static const RIGHT_MOUTH = const Landmark._internal("MouthRight", 10);
  static const LEFT_SHOULDER = const Landmark._internal("LeftShoulder", 11);
  static const RIGHT_SHOULDER = const Landmark._internal("RightShoulder", 12);
  static const LEFT_ELBOW = const Landmark._internal("LeftElbow", 13);
  static const RIGHT_ELBOW = const Landmark._internal("RightElbow", 14);
  static const LEFT_WRIST = const Landmark._internal("LeftWrist", 15);
  static const RIGHT_WRIST = const Landmark._internal("RightWrist", 16);
  static const LEFT_PINKY = const Landmark._internal("LeftPinkyFinger", 17);
  static const RIGHT_PINKY = const Landmark._internal("RightPinkyFinger", 18);
  static const LEFT_INDEX = const Landmark._internal("LeftIndexFinger", 19);
  static const RIGHT_INDEX = const Landmark._internal("RightIndexFinger", 20);
  static const LEFT_THUMB = const Landmark._internal("LeftThumb", 21);
  static const RIGHT_THUMB = const Landmark._internal("RightThumb", 22);
  static const LEFT_HIP = const Landmark._internal("LeftHip", 23);
  static const RIGHT_HIP = const Landmark._internal("RightHip", 24);
  static const LEFT_KNEE = const Landmark._internal("LeftKnee", 25);
  static const RIGHT_KNEE = const Landmark._internal("RightKnee", 26);
  static const LEFT_ANKLE = const Landmark._internal("LeftAnkle", 27);
  static const RIGHT_ANKLE = const Landmark._internal("RightAnkle", 28);
  static const LEFT_HEEL = const Landmark._internal("LeftHeel", 29);
  static const RIGHT_HEEL = const Landmark._internal("RightHeel", 30);
  static const LEFT_FOOT_INDEX = const Landmark._internal("LeftToe", 31);
  static const RIGHT_FOOT_INDEX = const Landmark._internal("RightToe", 32);

}


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