//
//  DataScaler.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 4/16/20.
//

import Foundation

typealias LineScaler = (CGFloat, CGFloat, CGRect) -> (CGFloat)

protocol ScalarProtocol {
    var rect: CGRect {set get}
    var shapeWidth: CGFloat {set get}
    var shapeInterval: CGFloat {set get}
    var interval: CGFloat {get}
}

class KLineScaler: ScalarProtocol {
    var rect: CGRect = CGRect.zero
    var shapeWidth: CGFloat = 2
    var shapeInterval: CGFloat = 0
    
    var max: CGFloat = 0
    var min: CGFloat = 0
    var xMaxCount: Int = 0
    
    var interval: CGFloat {
        get {
            return self.shapeInterval + self.shapeWidth / 2
        }
    }
    
    private var objs: Array<KShapeDataProtocol>?
    
    var kShapes = [KShape]()
    var klineObjs: Array<KShapeDataProtocol>? {
        set (newValue) {
            self.objs = newValue
            self .updateKShapes()
        }
        get {
            return self.objs
        }
    }
    
    var contentSize: CGSize {
        get {
            return CGSize.init(width: (self.shapeInterval + self.shapeWidth) * CGFloat(self.xMaxCount), height: self.rect.height)
        }
    }
    
    private func updateKShapes() -> () {
        if let arr = self.objs {
            for i in 0..<arr.count {
                let x:CGFloat = (CGFloat(i) + 0.5) * self.shapeInterval + (CGFloat(i) + 0.5) * self.shapeWidth
                
            }
        }
    }
    
    func updateScalerIn(_ range:NSRange) -> () {
        
    }
}
