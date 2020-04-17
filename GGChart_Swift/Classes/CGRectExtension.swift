//
//  CGRectExtension.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/15.
//

import Foundation

public extension UIView {
    var left: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: newValue, y: self.top, width: self.width, height: self.frame.size.height)
        }
        get {
            return self.frame.minX
        }
    }
    
    var right: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: newValue - self.width, y: self.top, width: self.width, height: self.height)
        }
        
        get {
            return self.frame.maxX
        }
    }
    
    var bottom: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: newValue - self.top, y: self.top, width: self.width, height: self.height)
        }
        get {
            return self.frame.maxY
        }
    }
    
    var top: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: self.left, y: newValue, width: self.width, height: newValue)
        }
        get {
            return self.frame.minY
        }
    }
    
    var height: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: self.left, y: self.top, width: self.width, height: newValue)
        }
        get {
            return self.frame.height
        }
    }
    
    var width: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: self.left, y: self.top, width: newValue, height: self.height)
        }
        get {
            return self.frame.width
        }
    }
}

extension CGRect {
    var rightTopPoint: CGPoint {
        get {
            return CGPoint.init(x: self.origin.x + self.width, y: self.origin.y)
        }
    }
    
    var leftBottomPoint: CGPoint {
        get {
            return CGPoint.init(x: self.origin.x, y: self.origin.y + self.height)
        }
    }
    
    var rightBottomPoint: CGPoint {
        get {
            return CGPoint.init(x: self.origin.x + self.width, y: self.origin.y + self.height)
        }
    }
}

extension UIColor {
    
    static func riseColor() -> UIColor {
        return UIColor.init(0xFF3F00)
    }
    
    static func fallColor() -> UIColor {
        return UIColor.init(0x21BC41)
    }
    
    convenience init(_ hex:UInt32) {
        let r = (hex & 0xFF0000) >> 16
        let g = (hex & 0x00FF00) >> 8
        let b = hex & 0x0000FF
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
