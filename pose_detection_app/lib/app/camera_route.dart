import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
    debugPrint("build with: $pose");
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
      await controller.startImageStream((image) => _processImage(image));
      setState(() {});
    });
  }

  void _processImage(CameraImage image) async {
    _savedImage = image;
    if (!inProcess) {
      inProcess = true;
      String result =
          await platform.invokeMethod("hello", _convertImage(_savedImage));
      debugPrint(
          "frame processed ${DateTime.now().minute}:${DateTime.now().second}:${DateTime.now().millisecond}");

      inProcess = false;

      if (result != null) debugPrint("json: ${jsonDecode(result)[0]}");

      pose = PoseEntity.fromJson(jsonDecode(result)[0]);
      pose.height = image.height;
      pose.width = image.width;
      debugPrint("pose is: $pose");
      if(pose != null) setState(() {});
    }
  }

  Map<String, dynamic> _convertImage(CameraImage image) {
    debugPrint("image format: ${image.format.group}");
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
