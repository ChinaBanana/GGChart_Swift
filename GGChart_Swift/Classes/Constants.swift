//
//  Constants.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/16.
//

import Foundation

/// k 线数据协议
public protocol KShapeDataProtocol {
    var low: CGFloat {get}
    var high: CGFloat {get}
    var open: CGFloat {get}
    var close: CGFloat {get}
}

enum Constants {
    public static let lineWidth = CGFloat(0.25)
}

enum TextRatio {
    public static let topLeft = CGPoint.init(x: -1, y: -1)
    public static let topCenter = CGPoint.init(x: 0, y: -1)
    public static let topRight = CGPoint.init(x: 1, y: -1)
    
    public static let center = CGPoint.init(x: 0, y: 0)
    public static let centerleft = CGPoint.init(x: -1, y: 0)
    public static let centerRight = CGPoint.init(x: 1, y: 0)
    
    public static let bottomLeft = CGPoint.init(x: -1, y: 1)
    public static let bottomCenter = CGPoint.init(x: 0, y: 1)
    public static let bottomRight = CGPoint.init(x: 1, y: 1)
}
