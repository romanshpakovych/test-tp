import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class CameraRoute extends StatefulWidget {
  @override
  _CameraRouteState createState() => _CameraRouteState();
}

class _CameraRouteState extends State<CameraRoute> {
  CameraController controller;
  bool _cameraInitialized = false;
  CameraImage _savedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() {
    controller = CameraController(cameras[0], ResolutionPreset.max);

    controller.initialize().then((_) async {
      await controller.startImageStream((image) => _processImage(image));
      setState(() {});
    });
  }

  void _processImage(CameraImage image) async {
    debugPrint(image.toString());
    setState(() {
      _savedImage = image;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PoseDetectionApp"),
      ),
      body: Column(
        children: [
          Expanded(
            child: (controller.value.isInitialized)
                ? CameraPreview(controller)
                : CircularProgressIndicator(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Center(
              child: Text("detected data: none"),
            ),
          )
        ],
      ),
    );
  }
}
