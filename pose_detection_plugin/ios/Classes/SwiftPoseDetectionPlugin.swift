import Flutter
import UIKit

public class SwiftPoseDetectionPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "pose_detection_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftPoseDetectionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard call.method == "processFrame" else {
            result(FlutterMethodNotImplemented)
            return
        }
    
        processFrame(arguments: call.arguments) { response in
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
    
    func processFrame(arguments: Any?, result: @escaping (String?) -> Void){
        DispatchQueue.global(qos: .background).async {
            guard let args = arguments as? Dictionary<String, Any> else {
                result(nil)
                return
            }
            let isAccurate = args["isAccurate"] as! Bool
            
            if (PoseDetectionHelper.instance.isAccurate != isAccurate) {
                PoseDetectionHelper.instance.setup(accurate: isAccurate)
            }
            
            guard let uiimage = ImageHelper.getImage(args: args)
            else {
                result(nil)
                return
            }
            
            let positions = PoseDetectionHelper.instance.processVisionImage(uiimage: uiimage)
            
            result(positions)
        }
    }
}
