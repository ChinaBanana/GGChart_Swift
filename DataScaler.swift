//
//  DataScaler.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 4/16/20.
//

import Foundation

class BaseScalar: NSObject {
    var rect:CGRect
    init(_ rect: CGRect) {
        self.rect = rect
    }
}

class BaseShapeScalar: BaseScalar {
    var shapeWidth: CGFloat = 0
    var shapeIntervar: CGFloat = 0
    
    
    var interval: CGFloat {
        get {
            return self.shapeIntervar + self.shapeWidth / 2
        }
    }
}
