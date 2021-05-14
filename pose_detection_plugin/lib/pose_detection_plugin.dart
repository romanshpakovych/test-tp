import 'dart:async';

import 'package:flutter/services.dart';

class PoseDetectionPlugin {
  static const MethodChannel _channel =
      const MethodChannel('pose_detection_plugin');

  static Future<String> processFrame(Map<String, dynamic> data) async {
      return await _channel.invokeMethod("processFrame", data);
  }

}
