//
//  CGRectExtension.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/15.
//

import Foundation

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
