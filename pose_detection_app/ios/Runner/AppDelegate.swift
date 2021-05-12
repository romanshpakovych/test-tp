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
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "processFrame" else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        self?.processFrame(result: result, arguments: call.arguments)
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func processFrame(result: @escaping FlutterResult, arguments: Any?){
        if (arguments == nil) {
            result("Are you there?")
        } else {
            let poseDetectionHelper = PoseDetectionHelper.instance
            
            let args = arguments as! Dictionary<String, Any>
            let isAccurate = args["isAccurate"] as! Bool
            
            if (poseDetectionHelper.isAccurate != isAccurate) {
                poseDetectionHelper.setup(accurate: isAccurate)
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                guard let uiimage = ImageHelper.getImage(args: args)
                else {
                    DispatchQueue.main.async { result(nil) }
                    return
                }
                
                let positions = poseDetectionHelper.processVisionImage(uiimage: uiimage)
                
                DispatchQueue.main.async {
                    result(positions)
                }
            }
        }
    }
    
}
