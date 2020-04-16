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
            return self.frame.origin.x
        }
    }
    
    var right: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: newValue - self.width, y: self.top, width: self.width, height: self.height)
        }
        
        get {
            return self.left + self.width
        }
    }
    
    var bottom: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: newValue - self.top, y: self.top, width: self.width, height: self.height)
        }
        get {
            return self.top + self.height
        }
    }
    
    var top: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: self.left, y: newValue, width: self.width, height: newValue)
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var height: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: self.left, y: self.top, width: self.width, height: newValue)
        }
        get {
            return self.frame.size.height
        }
    }
    
    var width: CGFloat {
        set (newValue) {
            self.frame = CGRect.init(x: self.left, y: self.top, width: newValue, height: self.height)
        }
        get {
            return self.frame.size.width
        }
    }
}

extension CGRect {
    var width: CGFloat {
        get {
            return self.size.width
        }
    }
    
    var height: CGFloat {
        get {
            return self.size.height
        }
    }
    
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
