//
//  Constants.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/16.
//

import Foundation

enum Constants {
    public static let lineWidth = CGFloat(1 / UIScreen.main.scale)
    
    public static let fontKey: String = "NSAttributeFontKey"
    public static let foregroundColorKey: String = "NSForegroundColorKey"
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
