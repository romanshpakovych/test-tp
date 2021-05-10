//
//  PoseDetectionHelper.swift
//  Runner
//
//  Created by Vladimir on 06.05.2021.
//

import Foundation
import MLKitPoseDetectionAccurate
import MLKitPoseDetection
import MLKitVision

class PoseDetectionHelper {
    static let instance = PoseDetectionHelper()
    
    var poseDetector: PoseDetector? = nil
    
    var isAccurate = false
    
    private init(){
        self.setup(accurate: false)
    }
    
    func setup(accurate: Bool) {
        var options: CommonPoseDetectorOptions
        if (accurate) {
            options = AccuratePoseDetectorOptions()
        } else {
            options = PoseDetectorOptions()
        }
        isAccurate = accurate
        
        options.detectorMode = .stream
        poseDetector = PoseDetector.poseDetector(options: options)
    }
    
    func processVisionImage(uiimage: UIImage) -> String? {
        let visionImage = VisionImage(image: uiimage)
        visionImage.orientation = uiimage.imageOrientation
        
        var results: [Pose]
        do {
            results = try poseDetector!.results(in: visionImage)
        } catch let error {
            print("Failed to detect pose with error: \(error.localizedDescription).")
            return nil
        }
        
        guard !results.isEmpty else {
            print("Pose detector returned no results.")
            return nil
        }
        
        let result: Array<PoseEntity> = results.map{(pose: Pose) -> PoseEntity in
            
            return PoseEntity(landmarks: pose.landmarks.map{ (poseLandmark: PoseLandmark) -> LandmarkEntity in
                let position = poseLandmark.position
                
                return LandmarkEntity(likelihood: poseLandmark.inFrameLikelihood,
                                      type: poseLandmark.type.rawValue,
                                      coordinates: CoordinatesEntity(x: position.x, y: position.y, z: position.z))
            })
            
        }
        let json: Data
        do {
            json = try JSONEncoder().encode(result)
        } catch {
            return nil
        }
        
        let jsonString = String(data: json, encoding: .utf8)
        
        return jsonString
    }
}
