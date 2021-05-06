import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pose_detection_app/app/PosePainter.dart';

import '../main.dart';

class CameraRoute extends StatefulWidget {
  @override
  _CameraRouteState createState() => _CameraRouteState();
}

class _CameraRouteState extends State<CameraRoute> {
  CameraController controller;
  bool _cameraInitialized = false;
  CameraImage _savedImage;
  bool inProcess = false;
  var message = "hello";
  var time = 0;
  var frames = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PoseDetectionApp"),
      ),
      body: Stack(
        children: [
          Expanded(
            child: (controller.value.isInitialized)
                ? CameraPreview(controller)
                : CircularProgressIndicator(),
          ),
          CustomPaint(
            painter: PosePainter(),
            child: Center(),
          )
        ],
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
      debugPrint(result);

      inProcess = false;
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
