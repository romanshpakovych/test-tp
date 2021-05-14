import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pose_detection_app/app/PosePainter.dart';
import 'package:pose_detection_app/app/entity/PoseEntity.dart';
import 'package:pose_detection_app/app/widgets/RoundButton.dart';
import 'package:pose_detection_plugin/pose_detection_plugin.dart';

import '../main.dart';

const resolutions = {
  "480p": ResolutionPreset.medium,
  "720p": ResolutionPreset.high,
  "1080p": ResolutionPreset.veryHigh
};

class CameraRoute extends StatefulWidget {
  @override
  _CameraRouteState createState() => _CameraRouteState();
}

class _CameraRouteState extends State<CameraRoute> {
  CameraController controller;
  CameraImage _savedImage;
  PoseEntity pose;
  var currentResolution = "480p";
  var processedFps = "";
  var inProcess = false;
  var isAccurate = false;
  var time = 0;
  var frames = 0;
  var camera = 0;
  var processedFramesCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PoseDetectionApp"),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Center(
                child: CustomPaint(
                  foregroundPainter: PosePainter(pose),
                  child: (controller.value.isInitialized)
                      ? Stack(
                          children: [
                            CameraPreview(controller),
                            Text(
                              "processed-fps: $processedFps",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        )
                      : CircularProgressIndicator(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Is accurate",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black38,
                        ),
                      ),
                      Switch(
                          value: isAccurate,
                          onChanged: (bool) {
                            isAccurate = bool;
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Resolution",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black38,
                        ),
                      ),
                      DropdownButton(
                          value: currentResolution,
                          items: resolutions.keys
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text(value)))
                              .toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              currentResolution = newValue;
                              _initializeCamera();
                            });
                          })
                    ],
                  ),
                  Center(
                    child:
                        RoundIconButton("assets/image/ic_swap_camera.png", () {
                      setState(() {
                        if (camera == 0) {
                          camera = 1;
                        } else {
                          camera = 0;
                        }
                        _initializeCamera();
                      });
                    }),
                  )
                ],
              ),
            ),
          ],
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
    controller?.stopImageStream();
    controller =
        CameraController(cameras[camera], resolutions[currentResolution]);

    controller.initialize().then((_) async {
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      await controller.startImageStream((image) => _processImage(image));
      setState(() {});
    });
  }

  void _processImage(CameraImage image) async {
    _savedImage = image;
    if (!inProcess) {
      inProcess = true;

      //Calculate processed frames per second
      ++processedFramesCounter;
      if (time == 0) time = DateTime.now().millisecondsSinceEpoch;
      if (DateTime.now().millisecondsSinceEpoch - time >= 1000) {
        processedFps = processedFramesCounter.toString();
        processedFramesCounter = 0;
        time = 0;
      }

      //Invoke native method through platform channel
      //Result is JSON representation of poses
      String result = await PoseDetectionPlugin.processFrame(
          _convertImage(_savedImage)
            //Add any variables you needs get on IOS side here
            ..putIfAbsent("isAccurate", () => isAccurate));
      debugPrint(result);
      //Parse result
      try {
        if (result != null) {
          pose = PoseEntity.fromJson(jsonDecode(result)[0])
            ..height = image.height
            ..width = image.width;
        } else {
          pose = null;
        }
        setState(() {
          ++frames;
          inProcess = false;
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  //Convert image data to map of primitive.
  //dynamic type is equals to Any on IOS.
  //Image is extracted in bgra8888 format.
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
