import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:pose_detection_app/app/pose_detection_app.dart';

List<CameraDescription> cameras;

var platform = MethodChannel('pose_detection_app/platform_plugin');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  var message = "hello";
  Map<int, String> messages = {1: message + "1", 2: message + "2", 3: message + "3"};
  debugPrint("Send: $messages");
  Map<int, String> result = await platform.invokeMapMethod("hello", messages);
  for (String response in result.values) {
    debugPrint("Get: $response");
  }
  runApp(PoseDetectionApp());
}
