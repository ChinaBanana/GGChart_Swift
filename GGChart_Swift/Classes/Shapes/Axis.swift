//
//  Axis.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/17.
//

import Foundation

/// 轴线
public struct Axis {
    var line: Line  // 基准线
    var length: CGFloat // 轴分割线长度
    var sep: CGFloat  // 轴分割距离
    
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
    var offSetRatio:CGPoint = TextRatio.bottomRight
    
    var hiddenPattern: Array<Bool>?
    
    private var stringArr = [String]()
    private var stringPoints = [CGPoint]()
    private var textParam = [NSAttributedString.Key : Any]()
    
    init(_ line: Line, len: CGFloat, sep: CGFloat) {
        self.line = line
        self.length = len
        self.sep = sep
    }
    
    init() {
        self.init(Line.init(start: CGPoint.zero, end: CGPoint.zero), len: 0, sep: 0)
    }
    
    var strColor: UIColor {
        set {
            textParam[NSAttributedString.Key.foregroundColor] = newValue
        }
        get {
            return textParam[NSAttributedString.Key.foregroundColor] as? UIColor ?? UIColor.white
        }
    }
    var strFont: UIFont {
        set {
            textParam[NSAttributedString.Key.font] = newValue
        }
        get {
            return textParam[NSAttributedString.Key.font] as? UIFont ?? UIFont.systemFont(ofSize: 10)
        }
    }
}

extension Axis : RenderProtocol {
    
    /// 根据hiddenPattern 确定某个位置是否绘制文本，默认true
    private func drawAtIndex(_ i: Int) -> Bool {
        if let arr = hiddenPattern {
            guard i < arr.count else {
                return true
            }
            return arr[i]
        }
        return true
    }
    
    private func ratioConvert(_ ratio: CGPoint) -> CGPoint {
        return CGPoint.init(x: (-1 + pureDecimal(ratio.x))/2, y: (-1 + pureDecimal(ratio.y)) / 2)
    }
    
    private func pureDecimal(_ x: CGFloat) -> CGFloat {
        return x > 1 ? 1 : (x < -1 ? -1 : x)
    }
    
    public func darwInContext(_ context: CGContext) {
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)
        let ratioP = ratioConvert(offSetRatio)
        
        if showLine {
            context.move(to: line.start)
            context.addLine(to: line.end)
        }
        
        let count = Int(sep == 0 ? 0 : abs(line.length / sep + 0.1) + 1)
        var fromArr = [CGPoint]()
        var endArr = [CGPoint]()
        for i in 0..<count {
            let axisP = line.moveFromStart(sep * CGFloat(i))
            fromArr.append(axisP)
            endArr.append(line.perpendicular(axisP, radius: length))
        }
        
        if showSep {
            for i in 0..<count {
                context.move(to:fromArr[i])
                context.addLine(to: endArr[i])
            }
        }
        context.strokePath()
        
        /// 绘制文字内容
        if showText {
            UIGraphicsPushContext(context)
            if let texts = aryStrings {
                
                let l_cir = line.xCircular()
                let cir = l_cir > (CGFloat.pi / 2) ? l_cir - (CGFloat.pi / 2) : l_cir
                
                for (i, text) in texts.enumerated() {
                    let nsStr = text as NSString
                    
                    guard i < endArr.count else {
                        return
                    }
                    
                    var point = endArr[i]
                    let size = nsStr.size(withAttributes: textParam)
                    
                    point = CGPoint.init(x: point.x + textOffSet.width, y: point.y + textOffSet.height)
                    
                    if drawContextCenter {
                        point = cir > CGFloat.pi / 8 ? CGPoint.init(x: point.x, y: sep / 2 + point.y) : CGPoint.init(x: point.x + sep / 2, y: point.y)
                    }
                    
                    point = CGPoint.init(x: point.x + size.width * ratioP.x, y: point.y + size.height * ratioP.y)
                    
                    if drawAtIndex(i) {
                        nsStr.draw(at: point, withAttributes: textParam)
                    }
                }
            }
            UIGraphicsPopContext()
        }
    }
}
