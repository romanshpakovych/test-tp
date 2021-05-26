Add plugin to a project by simply adding it as separate module and set the path

dependencies:
  pose_detection_plugin:
    path: ../pose_detection_plugin

Call PoseDetectionPlugin.processFrame() from your project's '/lib'
or add any needed method in the same way as this one

PoseDetectionPlugin.processFrame()
    takes Map<String, dynamic> with next pairs:
        {     "width": int,
              "height": int,
              "planes": List<Uint8List>,
              "bytes_per_row": int  ,
              "isAccurate": bool        }

    returns JSON representation of poses:
        [
            {
            "landmarks": [
                  {
                    "likelihood": 0.9740808606147766,
                    "type": "Nose",
                    "coordinates": {
                      "x": 394.9513244628906,
                      "y": 656.96728515625,
                      "z": 4.204323768615723
                    }
                  },
                  ...etc
            }
        ]

  "isAccurate" value switch pose detector between 'GoogleMLKit/PoseDetection' and 'GoogleMLKit/PoseDetectionAccurate' libs