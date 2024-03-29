//
//  LEExtension.swift
//  LEBottomSheetView
//
//  Created by DongLunYou on 2019/6/10.
//

import Foundation
import UIKit

extension UIView {
    
    public func roundCorner(radious : CGFloat,rectCorners : UIRectCorner){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rectCorners, cornerRadii: CGSize(width: radious, height: radious))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }

    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }

    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    public func setShadow(size:CGSize , opacity : Float ,radius: CGFloat , cgColor : CGColor){
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = cgColor
    }
}
extension UIImage {
    
    public func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context!.clip(to: drawRect, mask: cgImage!)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
   public class func bundledImage(named: String) -> UIImage? {
        var image : UIImage?
        let path = Bundle(for: BottomSheetView.self).resourcePath! + "/LEBottomSheetView.bundle"
        image = UIImage(named: "barLine", in: Bundle.init(url: URL.init(fileURLWithPath: path)),compatibleWith: nil)
        return image
    }
    
    
}

extension UIColor {
    public static let shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
}
