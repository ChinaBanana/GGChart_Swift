//
//  Axis.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/17.
//

import Foundation

/// 轴线
public struct Axis {
    let line: Line  // 基准线
    let over: CGFloat // 轴分割线长度
    let sep: CGFloat  // 轴分割距离
    
    init(_ line: Line, over: CGFloat, sep: CGFloat) {
        self.line = line
        self.over = over
        self.sep = sep
    }
    
    var showLine: Bool = true
    var showSep: Bool = true
    var showText: Bool = true
    var drawContextCenter: Bool = false
    var isStringFirstLastindent: Bool = false
    
    var width: CGFloat = Constants.lineWidth
    var color: UIColor = UIColor.white
    var textOffSet: CGSize = CGSize.zero
    var aryStrings: Array<String>?
    var colorArr: Array<UIColor>?
    
    var strColor = UIColor.white
    var strFont = UIFont.systemFontSize
    var offSetRatio:CGPoint = TextRatio.bottomRight
    var hiddenPattern: Array<Int>?
    
    private var stringArr = [String]()
    private var stringPoints = [CGPoint]()
    private var textParam = [String : Any]()
}
