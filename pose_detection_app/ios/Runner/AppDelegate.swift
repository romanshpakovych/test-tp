import UIKit
import Flutter
import MLKitPoseDetectionAccurate
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
        guard call.method == "hello" else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        self?.hello(result: result, arguments: call.arguments)
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func hello(result: @escaping FlutterResult, arguments: Any?){
        if (arguments == nil) {
            result("Are you there?")
        } else {
            let args = arguments as! Dictionary<String, Any>
            
            DispatchQueue.global(qos: .userInitiated).async {
                guard let uiimage = ImageHelper.getImage(args: args)
                else {
                    DispatchQueue.main.async { result(nil) }
                    return
                }
                
                guard let positions = PoseDetectionHelper.instance.processVisionImage(uiimage: uiimage) else {
                    DispatchQueue.main.async { result(nil) }
                    return
                }
                
        
                DispatchQueue.main.async {
                    result(positions)
                }
            }
        }
    }
    
}
