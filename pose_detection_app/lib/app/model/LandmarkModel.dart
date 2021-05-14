
enum LandmarkSide {
  left, right, middle
}

class LandmarkModel {
  final String name;
  final int id;
  final LandmarkSide side;

  const LandmarkModel._internal(this.name, this.id, this.side);

  static const NOSE = const LandmarkModel._internal("Nose", 0, LandmarkSide.middle);
  static const LEFT_EYE_INNER = const LandmarkModel._internal("LeftEyeInner", 1, LandmarkSide.left);
  static const LEFT_EYE = const LandmarkModel._internal("LeftEye", 2, LandmarkSide.left);
  static const LEFT_EYE_OUTER = const LandmarkModel._internal("LeftEyeOuter", 3, LandmarkSide.left);
  static const RIGHT_EYE_INNER = const LandmarkModel._internal("RightEyeInner", 4, LandmarkSide.right);
  static const RIGHT_EYE = const LandmarkModel._internal("RightEye", 5, LandmarkSide.right);
  static const RIGHT_EYE_OUTER = const LandmarkModel._internal("RightEyeOuter", 6, LandmarkSide.right);
  static const LEFT_EAR = const LandmarkModel._internal("LeftEar", 7, LandmarkSide.left);
  static const RIGHT_EAR = const LandmarkModel._internal("RightEar", 8, LandmarkSide.right);
  static const LEFT_MOUTH = const LandmarkModel._internal("MouthLeft", 9, LandmarkSide.left);
  static const RIGHT_MOUTH = const LandmarkModel._internal("MouthRight", 10, LandmarkSide.right);
  static const LEFT_SHOULDER = const LandmarkModel._internal("LeftShoulder", 11, LandmarkSide.left);
  static const RIGHT_SHOULDER = const LandmarkModel._internal("RightShoulder", 12, LandmarkSide.right);
  static const LEFT_ELBOW = const LandmarkModel._internal("LeftElbow", 13, LandmarkSide.left);
  static const RIGHT_ELBOW = const LandmarkModel._internal("RightElbow", 14, LandmarkSide.right);
  static const LEFT_WRIST = const LandmarkModel._internal("LeftWrist", 15, LandmarkSide.left);
  static const RIGHT_WRIST = const LandmarkModel._internal("RightWrist", 16, LandmarkSide.right);
  static const LEFT_PINKY = const LandmarkModel._internal("LeftPinkyFinger", 17, LandmarkSide.left);
  static const RIGHT_PINKY = const LandmarkModel._internal("RightPinkyFinger", 18, LandmarkSide.right);
  static const LEFT_INDEX = const LandmarkModel._internal("LeftIndexFinger", 19, LandmarkSide.left);
  static const RIGHT_INDEX = const LandmarkModel._internal("RightIndexFinger", 20, LandmarkSide.right);
  static const LEFT_THUMB = const LandmarkModel._internal("LeftThumb", 21, LandmarkSide.left);
  static const RIGHT_THUMB = const LandmarkModel._internal("RightThumb", 22, LandmarkSide.right);
  static const LEFT_HIP = const LandmarkModel._internal("LeftHip", 23, LandmarkSide.left);
  static const RIGHT_HIP = const LandmarkModel._internal("RightHip", 24, LandmarkSide.right);
  static const LEFT_KNEE = const LandmarkModel._internal("LeftKnee", 25, LandmarkSide.left);
  static const RIGHT_KNEE = const LandmarkModel._internal("RightKnee", 26, LandmarkSide.right);
  static const LEFT_ANKLE = const LandmarkModel._internal("LeftAnkle", 27, LandmarkSide.left);
  static const RIGHT_ANKLE = const LandmarkModel._internal("RightAnkle", 28, LandmarkSide.right);
  static const LEFT_HEEL = const LandmarkModel._internal("LeftHeel", 29, LandmarkSide.left);
  static const RIGHT_HEEL = const LandmarkModel._internal("RightHeel", 30, LandmarkSide.right);
  static const LEFT_FOOT_INDEX = const LandmarkModel._internal("LeftToe", 31, LandmarkSide.left);
  static const RIGHT_FOOT_INDEX = const LandmarkModel._internal("RightToe", 32, LandmarkSide.right);

  static LandmarkModel fromString(String value) {
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