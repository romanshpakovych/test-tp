//
//  ImageHelper.swift
//  Runner
//
//  Created by Vladimir on 07.05.2021.
//

import Foundation

extension UIImage {
    
    public func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
        rotatedViewBox.transform = t
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat.pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

public struct PixelData {
    var a: UInt8
    var r: UInt8
    var g: UInt8
    var b: UInt8
}

class ImageHelper {
    
    static func getImage(args: Dictionary<String, Any>) -> UIImage? {
        let width = args["width"] as! Int
        let height = args["height"] as! Int
        let planes = args["planes"] as! Array<FlutterStandardTypedData>
        let bytesPerRaw = args["bytes_per_row"] as! Int
        
        let bgraUint8 = [UInt8](planes[0].data)
       
        let image = imageFromARGB32Bitmap(pixels: bgraUint8, width: width, height: height, bytesPerRow: bytesPerRaw)
    
        return image?.imageRotatedByDegrees(degrees: 90)
    }
    
    private static func imageFromARGB32Bitmap(pixels: [UInt8], width: Int, height: Int, bytesPerRow: Int = 0) -> UIImage? {
        guard width > 0 && height > 0 else { return nil }

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        
        var data = pixels
        
        guard let providerRef = CGDataProvider(data: NSData(bytes: &data,
                               length: data.count)
           )
           else { return nil }

        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
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
