//
//  UIImageExtension.swift
//  Constructo
//
//  Created by Jan Rajtr on 15.08.17.
//  Copyright © 2017 Jan Rajtr. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

extension UIImage {
    
    
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
    
    func inverse() -> UIImage {
        
        
        //CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
        let coreImage:CIImage = CIImage(cgImage: self.cgImage!)
        //CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
        let filter:CIFilter = CIFilter(name: "CIColorInvert")!
        //[filter setValue:coreImage forKey:kCIInputImageKey];
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        //CIImage *result = [filter valueForKey:kCIOutputImageKey];
        let result:CIImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
        //return [UIImage imageWithCIImage:result];
        return UIImage(ciImage: result)
        
    }
    

    
    func thumbnail(width:CGFloat) -> UIImage {
        
        let originalImage:UIImage = self
        
        let ratio = originalImage.size.width/width
        let newHeight:CGFloat = originalImage.size.height/ratio
        let size:CGSize = CGSize(width: width, height: newHeight)
        
        UIGraphicsBeginImageContext(size)
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: width, height: newHeight)
        originalImage.draw(in: rect)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    class func imageWithLabel(label: UILabel) -> UIImage {
        let size = label.bounds.size
        let newSize = CGSize(width: size.width*2, height: size.height*2)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    
    func thumbnail(height:CGFloat) -> UIImage {
        
        let originalImage:UIImage = self
        
        let ratio = originalImage.size.height/height
        let newWidth:CGFloat = originalImage.size.width/ratio
        let size:CGSize = CGSize(width: newWidth, height: newWidth)
        
        UIGraphicsBeginImageContext(size)
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: newWidth, height: height)
        originalImage.draw(in: rect)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    func cropToSquare() -> UIImage {
        let refWidth = CGFloat((self.cgImage?.width)!) //CGFloat(CGImageGetWidth(self.cgImage!))
        let refHeight = CGFloat((self.cgImage?.height)!)
        let cropSize = refWidth > refHeight ? refHeight : refWidth
        
        let x = (refWidth - cropSize) / 2.0
        let y = (refHeight - cropSize) / 2.0
        
        let cropRect = CGRect(x: x, y: y, width: cropSize, height: cropSize) //(x, y, cropSize, cropSize)
        let imageRef = self.cgImage?.cropping(to: cropRect) //CGImageCreateWithImageInRect(self.cgImage!, cropRect)
        let cropped = UIImage(cgImage: imageRef!, scale: 0.0, orientation: self.imageOrientation) //(CGImage: imageRef, scale: 0.0, orientation: self.imageOrientation)!
        
        return cropped
    }
    
    func compress(maxWitdh:CGFloat) -> UIImage {
        
        let width:CGFloat = maxWitdh
        let ratio = self.size.width/width
        let height:CGFloat = self.size.height/ratio
        let size:CGSize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContext(size)
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        self.draw(in: rect)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func compress(maxHeight:CGFloat) -> UIImage {
        
        let height:CGFloat = maxHeight
        let ratio = self.size.height/height
        let width:CGFloat = self.size.width/ratio
        let size:CGSize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContext(size)
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        self.draw(in: rect)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func compress() -> UIImage {
        
        let width:CGFloat = 2048
        let ratio = self.size.width/width
        let height:CGFloat = self.size.height/ratio
        let size:CGSize = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContext(size)
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        self.draw(in: rect)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
    
    
    
    
    @available(iOS 10.0, *)
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        
        return image
    }
    
    func overlayImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        
        color.setFill()
        
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        context!.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.draw(self.cgImage!, in: rect)
        
        context!.setBlendMode(CGBlendMode.sourceIn)
        context!.addRect(rect)
        context!.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImage ?? UIImage()
    }
    
    
    
}
extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var squared: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
