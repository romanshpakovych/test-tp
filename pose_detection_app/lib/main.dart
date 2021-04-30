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

  runApp(PoseDetectionApp());
}
