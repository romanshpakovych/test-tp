//
//  PoseDetectionHelper.swift
//  Runner
//
//  Created by Vladimir on 06.05.2021.
//

import Foundation
import MLKitPoseDetectionAccurate
import MLKitVision

class PoseDetectionHelper {
    static let instance = PoseDetectionHelper()
    
    let poseDetector: PoseDetector
    
    private init(){
        let options = AccuratePoseDetectorOptions()
        options.detectorMode = .stream
        poseDetector = PoseDetector.poseDetector(options: options)
    }
    
    func processVisionImage(uiimage: UIImage) -> String? {
        let visionImage = VisionImage(image: uiimage)
        visionImage.orientation = uiimage.imageOrientation
        
        var results: [Pose]
        do {
            results = try poseDetector.results(in: visionImage)
        } catch let error {
            print("Failed to detect pose with error: \(error.localizedDescription).")
            return nil
        }
        
        guard !results.isEmpty else {
            print("Pose detector returned no results.")
            return nil
        }
        
        
//        results[0].landmarks[0].position
//        results[0].landmarks[0].inFrameLikelihood
//        results[0].landmarks[0].type.rawValue
        
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
