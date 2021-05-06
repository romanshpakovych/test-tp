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
                guard let uiimage = self.getImage(args: args)
                else {
                    DispatchQueue.main.async { result("uiimage is nil") }
                    return
                }
                
                guard let positions = PoseDetectionHelper.instance.processVisionImage(uiimage: uiimage) else {
                    DispatchQueue.main.async { result("positions is nil") }
                    return
                }
                
        
                DispatchQueue.main.async {
                    result(positions)
                }
            }
        }
    }
    
    public struct PixelData {
        var a: UInt8
        var r: UInt8
        var g: UInt8
        var b: UInt8
    }
    
    func getImage(args: Dictionary<String, Any>) -> UIImage? {
        let width = args["width"] as! Int
        let height = args["height"] as! Int
        let planes = args["planes"] as! Array<FlutterStandardTypedData>
        let bytesPerRaw = args["bytes_per_row"] as! Int
        
        let bgraUint8 = [UInt8](planes[0].data)
       
        let image = imageFromARGB32Bitmap(pixels: bgraUint8, width: width, height: height, bytesPerRow: bytesPerRaw)
    
        return image
    }
    
    func imageFromARGB32Bitmap(pixels: [UInt8], width: Int, height: Int, bytesPerRow: Int = 0) -> UIImage? {
        guard width > 0 && height > 0 else { return nil }
  //      guard pixels.count == width * height else { return nil }

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        
        var data = pixels
        /* guard let providerRef = CGDataProvider(data: NSData(bytes: &data,
                                length: data.count * MemoryLayout<PixelData>.size)
            )
            else { return nil } */
        
        guard let providerRef = CGDataProvider(data: NSData(bytes: &data,
                               length: data.count)
           )
           else { return nil }

        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
           // bytesPerRow: width * MemoryLayout<PixelData>.size,
            bytesPerRow: bytesPerRow,
            space: rgbColorSpace,
            bitmapInfo: bitmapInfo,
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
            )
            else { return nil }

        return UIImage(cgImage: cgim)
    }
    
}
