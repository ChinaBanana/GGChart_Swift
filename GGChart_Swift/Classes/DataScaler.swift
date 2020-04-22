//
//  DataScaler.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 4/16/20.
//

import Foundation

public protocol ScalarProtocol {
    var rect: CGRect { set get }
    var shapeWidth: CGFloat { set get }
    var shapeInterval: CGFloat { set get }
    var interval: CGFloat { get }
}

public class KLineScaler: NSObject, ScalarProtocol {
    public var rect: CGRect = CGRect.zero
    public var shapeWidth: CGFloat = 5
    public var shapeInterval: CGFloat = 3
    public var plainRatio: CGFloat = 0.05  //  留白百分比
    
    public var max: CGFloat = 1
    public var min: CGFloat = 0
    public var xMaxCount: Int = 1
    public var kShapes = [KShape]()
    public var interval: CGFloat {
        get {
            return shapeInterval + shapeWidth / 2
        }
    }
    
    private var objs: Array<KShapeDataProtocol>?
    
    /// 计算价格对应的纵坐标y
    private func _kFig(value: CGFloat) -> CGFloat {
        return rect.maxY - (value - min) * (rect.height / (max - min))
    }
    
    public var klineObjs: Array<KShapeDataProtocol>? {
        set (newValue) {
            objs = newValue
            updateScaler()
        }
        get {
            return objs
        }
    }
    
    var contentSize: CGSize {
        get {
            return CGSize.init(width: (shapeInterval + shapeWidth) * CGFloat(xMaxCount), height: rect.height)
        }
    }
    
    public override init() {
        super.init()
    }
    
    private func updateScaler() -> () {
        if let arr = objs {
            configBaseData()
            kShapes.removeAll();
            for (i, obj) in arr.enumerated() {
                let x:CGFloat = (CGFloat(i) + 0.5) * shapeInterval + (CGFloat(i) + 0.5) * shapeWidth
                let openPoint = CGPoint.init(x: x, y: _kFig(value: obj.open))
                let closePoint = CGPoint.init(x: x, y: _kFig(value: obj.close))
                let lowPoint = CGPoint.init(x: x, y: _kFig(value: obj.low))
                let highPoint = CGPoint.init(x: x, y: _kFig(value: obj.high))
                
                let kRect = CGRect.lineDownRectWith(openPoint, end: closePoint, width: shapeWidth)
                let kshape = KShape.init(top: highPoint, rect: kRect, end: lowPoint)
                kShapes.append(kshape)
            }
        }
    }
    
    public func updateScalerIn(_ range:NSRange) -> () {
        if let arr = objs {
            for i in range.location..<(range.location + range.length) {
                let obj = arr[i]
                let x:CGFloat = (CGFloat(i) + 0.5) * shapeInterval + (CGFloat(i) + 0.5) * shapeWidth
                let openPoint = CGPoint.init(x: x, y: _kFig(value: obj.open))
                let closePoint = CGPoint.init(x: x, y: _kFig(value: obj.close))
                let lowPoint = CGPoint.init(x: x, y: _kFig(value: obj.low))
                let highPoint = CGPoint.init(x: x, y: _kFig(value: obj.high))
                let kRect = CGRect.lineDownRectWith(openPoint, end: closePoint, width: shapeWidth)
                kShapes[i] = KShape.init(top: highPoint, rect: kRect, end: lowPoint)
            }
        }
    }
    
    private func configBaseData() {
        guard max == 1 && min == 0 else {
            return
        }
        
        if let arr = objs {
            if let firstObj = arr.first {
                max = firstObj.high
                    min = firstObj.low
                } else {
                    return
                }
                
                xMaxCount = arr.count
                for obj in arr {
                    if max < obj.high {
                        max = obj.high
                    }
                    if min > obj.low {
                        min = obj.low
                    }
                }
                
                /// 通过最大值最小值留白上下各 10% 的空间
//                let abs = max - min
//                max = max + abs * plainRatio
//                min = min - abs * plainRatio
//
//                rect.size = contentSize
        }
    }
}
