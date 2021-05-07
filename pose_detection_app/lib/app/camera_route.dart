import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pose_detection_app/app/PosePainter.dart';
import 'package:pose_detection_app/app/entity/PoseEntity.dart';

import '../main.dart';

class CameraRoute extends StatefulWidget {
  @override
  _CameraRouteState createState() => _CameraRouteState();
}

class _CameraRouteState extends State<CameraRoute> {
  CameraController controller;
  bool _cameraInitialized = false;
  CameraImage _savedImage;
  PoseEntity pose;
  bool inProcess = false;
  var message = "hello";
  var time = 0;
  var frames = 0;

  @override
  Widget build(BuildContext context) {
    "build with: $pose".log();
    return Scaffold(
      appBar: AppBar(
        title: Text("PoseDetectionApp"),
      ),
      body: Center(
        child: CustomPaint(
          foregroundPainter: PosePainter(pose),
          child: (controller.value.isInitialized)
              ? CameraPreview(controller)
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() {
    controller = CameraController(cameras[0], ResolutionPreset.high);

    controller.initialize().then((_) async {
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      await controller.startImageStream((image) => _processImage(image));
      setState(() {});
    });
  }

  void _processImage(CameraImage image) async {
    _savedImage = image;
    if (!inProcess) {
      "start frame $frames".log();

      inProcess = true;
      String result =
          await platform.invokeMethod("hello", _convertImage(_savedImage));

      "processed frame $frames".log();
      try {
        if (result != null) {
          pose = PoseEntity.fromJson(jsonDecode(result)[0])
            ..height = image.height
            ..width = image.width;
        } else {
          pose = null;
        }
        "pose is $pose".log();
        setState(() {});
        ++frames;
        inProcess = false;
      } catch (e) {
        e.toString().log();
      }
    }
  }

  Map<String, dynamic> _convertImage(CameraImage image) {
    return {
      "width": image.width,
      "height": image.height,
      "planes": image.planes.map((plane) => plane.bytes).toList(),
      "bytes_per_row": image.planes[0].bytesPerRow
    };
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
