import UIKit
import Flutter

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
    
    func hello(result: FlutterResult, arguments: Any?){
        if (arguments == nil) {
            result("Are you there?")
        } else {
            let args = (arguments as! Dictionary<NSNumber, String>)
            
            let mappedResult = Dictionary(uniqueKeysWithValues: args.map {k,v in (k, v + " there")})
            result(mappedResult)
        }
    
    }
}
