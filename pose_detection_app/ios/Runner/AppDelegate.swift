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
            let args = arguments as! Dictionary<String, Any>
            
            let uiimage = getImage(args: args)
            
            result("uiimage is nil " + String(uiimage == nil))
          //  result("a")
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
        let bytesPerRow = args["bytes_per_row"] as! Int
        
    
        let rgbaUint8 = [UInt8](planes[0].data)
        let data = NSData(bytes: rgbaUint8, length: rgbaUint8.count)

        let image = imageFromARGB32Bitmap(pixels: data, width: width, height: height, bytesPerRow: bytesPerRow)
    
        return image
    }
    
    func imageFromARGB32Bitmap(pixels: NSData, width: Int, height: Int, bytesPerRow: Int) -> UIImage? {
        guard width > 0 && height > 0 else { return nil }
     //   guard pixels.count == width * height else { return nil }

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        /*
        var data = pixels // Copy to mutable []
         guard let providerRef = CGDataProvider(data: NSData(bytes: &data,
                                length: data.count * MemoryLayout<NSData>.size)
            )
            else { return nil } */
        
        guard let providerRef = CGDataProvider(data: pixels)
        else { return nil }

        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
        
            //bytesPerRow: width * MemoryLayout<NSData>.size,
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
