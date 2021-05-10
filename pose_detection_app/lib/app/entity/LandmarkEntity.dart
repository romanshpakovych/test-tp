import 'package:pose_detection_app/app/entity/CoordinatesEntity.dart';

class Landmark {
  final String name;
  final int id;
  /*1 - left
   0 - right
   -1 - middle*/
  final int side;

  const Landmark._internal(this.name, this.id, this.side);

  static const NOSE = const Landmark._internal("Nose", 0, -1);
  static const LEFT_EYE_INNER = const Landmark._internal("LeftEyeInner", 1, 1);
  static const LEFT_EYE = const Landmark._internal("LeftEye", 2, 1);
  static const LEFT_EYE_OUTER = const Landmark._internal("LeftEyeOuter", 3, 1);
  static const RIGHT_EYE_INNER = const Landmark._internal("RightEyeInner", 4, 0);
  static const RIGHT_EYE = const Landmark._internal("RightEye", 5, 0);
  static const RIGHT_EYE_OUTER = const Landmark._internal("RightEyeOuter", 6, 0);
  static const LEFT_EAR = const Landmark._internal("LeftEar", 7, 1);
  static const RIGHT_EAR = const Landmark._internal("RightEar", 8, 0);
  static const LEFT_MOUTH = const Landmark._internal("MouthLeft", 9, 1);
  static const RIGHT_MOUTH = const Landmark._internal("MouthRight", 10, 0);
  static const LEFT_SHOULDER = const Landmark._internal("LeftShoulder", 11, 1);
  static const RIGHT_SHOULDER = const Landmark._internal("RightShoulder", 12, 0);
  static const LEFT_ELBOW = const Landmark._internal("LeftElbow", 13, 1);
  static const RIGHT_ELBOW = const Landmark._internal("RightElbow", 14, 0);
  static const LEFT_WRIST = const Landmark._internal("LeftWrist", 15, 1);
  static const RIGHT_WRIST = const Landmark._internal("RightWrist", 16, 0);
  static const LEFT_PINKY = const Landmark._internal("LeftPinkyFinger", 17, 1);
  static const RIGHT_PINKY = const Landmark._internal("RightPinkyFinger", 18, 0);
  static const LEFT_INDEX = const Landmark._internal("LeftIndexFinger", 19, 1);
  static const RIGHT_INDEX = const Landmark._internal("RightIndexFinger", 20, 0);
  static const LEFT_THUMB = const Landmark._internal("LeftThumb", 21, 1);
  static const RIGHT_THUMB = const Landmark._internal("RightThumb", 22, 0);
  static const LEFT_HIP = const Landmark._internal("LeftHip", 23, 1);
  static const RIGHT_HIP = const Landmark._internal("RightHip", 24, 0);
  static const LEFT_KNEE = const Landmark._internal("LeftKnee", 25, 1);
  static const RIGHT_KNEE = const Landmark._internal("RightKnee", 26, 0);
  static const LEFT_ANKLE = const Landmark._internal("LeftAnkle", 27, 1);
  static const RIGHT_ANKLE = const Landmark._internal("RightAnkle", 28, 0);
  static const LEFT_HEEL = const Landmark._internal("LeftHeel", 29, 1);
  static const RIGHT_HEEL = const Landmark._internal("RightHeel", 30, 0);
  static const LEFT_FOOT_INDEX = const Landmark._internal("LeftToe", 31, 1);
  static const RIGHT_FOOT_INDEX = const Landmark._internal("RightToe", 32, 0);

  static Landmark fromString(String value) {
    return [
      NOSE,
      LEFT_EYE_INNER,
      LEFT_EYE,
      LEFT_EYE_OUTER,
      RIGHT_EYE_INNER,
      RIGHT_EYE,
      RIGHT_EYE_OUTER,
      LEFT_EAR,
      RIGHT_EAR,
      LEFT_MOUTH,
      RIGHT_MOUTH,
      LEFT_SHOULDER,
      RIGHT_SHOULDER,
      LEFT_ELBOW,
      RIGHT_ELBOW,
      LEFT_WRIST,
      RIGHT_WRIST,
      LEFT_PINKY,
      RIGHT_PINKY,
      LEFT_INDEX,
      RIGHT_INDEX,
      LEFT_THUMB,
      RIGHT_THUMB,
      LEFT_HIP,
      RIGHT_HIP,
      LEFT_KNEE,
      RIGHT_KNEE,
      LEFT_ANKLE,
      RIGHT_ANKLE,
      LEFT_HEEL,
      RIGHT_HEEL,
      LEFT_FOOT_INDEX,
      RIGHT_FOOT_INDEX
    ].firstWhere((element) => element.name == value);
  }
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
