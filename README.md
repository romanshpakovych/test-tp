Add plugin to any project simply added its as separate module and set the path like this
or put it anywhere you prefer and set the path relatively

dependencies:
  pose_detection_plugin:
    path: ../pose_detection_plugin

Then call from your projects's '/lib' PoseDetectionPlugin.processFrame()
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
   Project has both for purpose of testing best performance and choosing the best

   You can remove unused lib from pose_detection_plugin/pose_detection_plugin.podspec
   Don't forget to remove imports and deleted classes out of pose_detection_plugin/Classes/Helper/PoseDetectionHelper.swift

