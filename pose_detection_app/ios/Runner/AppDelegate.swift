import UIKit
import Flutter
import MLKitVision

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller = window?.rootViewController as! FlutterViewController
        let platformChannel = FlutterMethodChannel(name: "pose_detection_app/platform_plugin", binaryMessenger: controller.binaryMessenger)
        
        platformChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, flutterResult: @escaping FlutterResult) -> Void in
            guard call.method == "processFrame" else {
                flutterResult(FlutterMethodNotImplemented)
                return
            }
            
            self?.processFrame(arguments: call.arguments) { result in
                DispatchQueue.main.async {
                    flutterResult(result)
                }
            }
            
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
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
