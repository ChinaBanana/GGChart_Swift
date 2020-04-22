//
//  CGRectExtension.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/15.
//

import Foundation

public extension UIView {
    var left: CGFloat {
        set {
            frame = CGRect.init(x: newValue, y: top, width:  width, height:  frame.size.height)
        }
        get {
            return frame.minX
        }
    }
    
    var right: CGFloat {
        set {
             frame = CGRect.init(x: newValue -  width, y: top, width:  width, height:  height)
        }
        
        get {
            return frame.maxX
        }
    }
    
    var bottom: CGFloat {
        set {
            frame = CGRect.init(x: newValue - top, y:  top, width:  width, height:  height)
        }
        get {
            return frame.maxY
        }
    }
    
    var top: CGFloat {
        set {
            frame = CGRect.init(x:  left, y: newValue, width:  width, height: newValue)
        }
        get {
            return frame.minY
        }
    }
    
    var height: CGFloat {
        set {
            frame = CGRect.init(x:  left, y: top, width:  width, height: newValue)
        }
        get {
            return frame.height
        }
    }
    
    var width: CGFloat {
        set {
            frame = CGRect.init(x:  left, y: top, width: newValue, height:  height)
        }
        get {
            return frame.width
        }
    }
}

extension CGRect {
    
    static func lineDownRectWith(_ start: CGPoint, end: CGPoint, width: CGFloat) -> CGRect {
        let ben = start.y > end.y ? end : start
        return CGRect.init(origin: CGPoint.init(x: ben.x - width / 2, y: ben.y), size: CGSize.init(width: width, height: abs(start.y - end.y)))
    }
    
    var rightTopPoint: CGPoint {
        get {
            return CGPoint.init(x: maxX, y: minY)
        }
    }
    
    var leftBottomPoint: CGPoint {
        get {
            return CGPoint.init(x: minX, y: maxY)
        }
    }
    
    var rightBottomPoint: CGPoint {
        get {
            return CGPoint.init(x: maxX, y: maxY)
        }
    }
}
