//
//  Shapes.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/15.
//

import Foundation

/// 直线
public struct Line {
    let start: CGPoint
    let end: CGPoint
    
    public var width: CGFloat = Constants.lineWidth
    public var color: UIColor = UIColor.white
    public var dashPattern: Array<CGFloat>?
    
    /// 当前线点长度
    var length: CGFloat {
        get {
            let w = self.start.x - self.end.x
            let h = self.end.x - self.end.y
            return sqrt(w * w + h * h)
        }
    }
    
    /// 起始点到终点的x距离
    var xLenght: CGFloat {
        get {
            return CGFloat(self.end.x - self.start.x)
        }
    }
    
    /// 起始点到终点的y距离
    var yLentgh: CGFloat {
        get {
            return CGFloat(self.end.y - self.start.y)
        }
    }
    
    /// 直线与X轴的弧度 范围 -pi/2 ~ pi/2
    func xCircular() -> CGFloat {
        return atan2(self.end.y - self.start.y, self.end.x - self.start.x)
    }
    
    /// 直线与Y轴的弧度 范围 -pi/2 ~ pi/2
    func yCircular() -> CGFloat {
        return atan2(self.end.x - self.start.x, self.end.y - self.start.y)
    }
    
    /// 直线与X轴的弧度 范围：0～pi   0～3.141592653...
    func xArc() -> CGFloat {
        return self.xCircular() < 0 ? CGFloat.pi * 2 + self.xCircular() : self.xCircular()
    }
    
    /// 直线偏移线
    /// - Parameter move: 偏移量
    func endPointArcMoveX(_ move: CGFloat) -> CGPoint {
        let base: CGFloat = self.yCircular() > 0 ? 1: -1;
        return CGPoint.init(x: CGFloat.init(move * base) + self.end.x, y: self.end.y)
    }
    
    /// 获取基于point垂直与直线的点
    /// - Parameters:
    ///   - point: 任意点
    ///   - radius:点到基准线到距离
    func perpendicular(_ point: CGPoint, radius: CGFloat) -> CGPoint {
        let m_h = radius * cos(self.xCircular())
        let m_w = radius * sin(self.xCircular())
        return CGPoint.init(x: point.x - CGFloat(m_w), y: point.y + CGFloat(m_h))
    }
    
    /// 从起始点沿直线方向移动一段距离，返回移动后的点
    /// - Parameter move: 移动距离
    func moveFromStart(_ move: CGFloat) -> CGPoint {
        return CGPoint.init(x: self.start.x + CGFloat(move * cos(self.xCircular())), y: self.start.y + CGFloat(move * sin(self.xCircular())))
    }
    
    /// 从终点沿直线方向移动一段距离后，返回移动后的点
    /// - Parameter move: 移动距离
    func moveFromEnd(_ move: CGFloat) -> CGPoint {
        return CGPoint.init(x: self.end.x + CGFloat(move * cos(self.xCircular())), y: self.end.y + CGFloat(move * sin(self.xCircular())))
    }
    
    /// 偏移x，返回偏移后的点
    /// - Parameter move: 移动距离
    func endPointArcMove(_ move: CGFloat) -> CGPoint {
        let base: CGFloat = self.yCircular() > 0 ? 1 : -1;
        return CGPoint.init(x: CGFloat(base * move) + self.end.x, y: self.end.y)
    }
    
    /// 移动起始点
    /// - Parameter move: 移动距离
    func moveStart(_ move: CGFloat) -> Line {
        return Line.init(start: self.moveFromStart(move), end: self.end)
    }
    
    /// 移动终点
    /// - Parameter move: 移动距离
    func moveEnd(_ move: CGFloat) -> Line {
        return Line.init(start: self.start, end: self.moveFromEnd(move))
    }
}

/// factory methods
extension Line {
    
    /// 取角度射线
    /// - Parameters:
    ///   - arcLine: 结构体
    ///   - clockWise: 是否顺时针
    static func lineWithArc(_ arcLine: ArcLine, clockWise: Bool) -> Line {
        let base: CGFloat = clockWise ? -1 : 1;
        let end_x = CGFloat.init(arcLine.center.x) + cos(arcLine.arc) * arcLine.leg * base
        let end_y = CGFloat.init(arcLine.center.y) + sin(arcLine.arc) * arcLine.leg * base
        return Line.init(start: arcLine.center, end: CGPoint.init(x: CGFloat.init(end_x), y: CGFloat.init(end_y)))
    }
    
    /// 从rect中构造line，上，左，右，下
    /// - Parameter rect: rect
    static func topLineOfRect(_ rect: CGRect) -> Line {
        return Line.init(start: rect.origin, end: rect.rightTopPoint)
    }
    
    static func leftLineOfRect(_ rect: CGRect) -> Line {
        return Line.init(start: rect.origin, end: rect.leftBottomPoint)
    }
    
    static func rightLineOfRect(_ rect: CGRect) -> Line {
        return Line.init(start: rect.rightTopPoint, end: rect.rightBottomPoint)
    }
    
    static func bottomLineOfRect(_ rect: CGRect) -> Line {
        return Line.init(start: rect.leftBottomPoint, end: rect.rightBottomPoint)
    }
    
    /// rect内部垂直于Y轴的线
    /// - Parameters:
    ///   - rect: rect
    ///   - x: PointX
    static func xLineOfRect(_ rect: CGRect, x: CGFloat) -> Line {
        var pX = x > rect.rightTopPoint.x ? rect.rightTopPoint.x : x
        pX = x < rect.origin.x ? rect.origin.x : x
        return Line.init(start: CGPoint.init(x: pX, y: rect.origin.y), end: CGPoint.init(x: pX, y: rect.leftBottomPoint.y))
    }
    
    /// rect内部垂直于X轴的线
    /// - Parameters:
    ///   - rect: rect
    ///   - y: PointY
    static func yLineOfRect(_ rect: CGRect, y: CGFloat) -> Line {
        var pY = y > rect.rightBottomPoint.y ? rect.rightBottomPoint.y : y
        pY = y < rect.origin.y ? rect.origin.y : y
        return Line.init(start: CGPoint.init(x: rect.origin.x, y: pY), end: CGPoint.init(x: rect.rightTopPoint.x, y: pY))
    }
}

/// 角度线段
public struct ArcLine {
    let center:CGPoint // 中心点
    let arc: CGFloat     // 弧度
    let leg: CGFloat     // 长度
}

/// 箭头
public struct Arrow {
    let line: Line
    let side: CGFloat
}

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

/// 圆
public struct Circle {
    let center: CGPoint // 圆心
    let radius: CGFloat   // 半径
    public var borderWidth: CGFloat = Constants.lineWidth
    public var fillColor: UIColor = UIColor.white
    public var borderColor: UIColor = UIColor.white
    public var gradentColors: Array<UIColor>?
}

/// 网格
public struct Grid {
    let rect: CGRect
    let y_dis: CGFloat   // y轴分割距离
    let x_dis: CGFloat   // x轴分割距离
}

/// k线
public struct KShape {
    let top: CGPoint
    let rect: CGRect
    let end: CGPoint
}

public struct RadiusRange {
    let inRadius: CGFloat
    let outRadius: CGFloat
    
    // 获取间距
    var range: CGFloat {
        get {
            return abs(self.inRadius - self.outRadius)
        }
    }
    
    var isZero: Bool {
        get {
            return self.inRadius == 0 && self.outRadius == 0
        }
    }
    
    func containLength(_ length: CGFloat) -> Bool {
        return length >= self.inRadius && length <= self.outRadius;
    }
}

public struct Pie {
    let center: CGPoint
    let radiusRange: RadiusRange
    let arc: CGFloat
    let transform: CGFloat
    
    var isEmpty: Bool {
        get {
            return self.arc == 0 && self.transform == 0 && self.center == CGPoint.zero && self.radiusRange.isZero
        }
    }
    
    var minArc: CGFloat {
        get {
            return self.getLessFloat(self.transform + self.arc, v2: CGFloat.pi)
        }
    }
    
    var maxArc: CGFloat {
        get {
            return self.getLessFloat(self.arc, v2: CGFloat.pi)
        }
    }
    
    var yCircular: CGFloat {
        get {
            let arcLine = ArcLine.init(center: self.center, arc: self.transform + self.arc / 2, leg: self.radiusRange.outRadius)
            return Line.lineWithArc(arcLine, clockWise: false).yCircular()
        }
    }
    
    private func getLessFloat(_ v1: CGFloat, v2: CGFloat) -> CGFloat {
        var v = v1
        while v > v2 {
            v -= v2
        }
        return v
    }
    
    private func convertArc(_ arc: CGFloat) -> CGFloat {
        var changeArc = arc
        while changeArc > CGFloat.pi * 2 {
            changeArc -= (CGFloat.pi * 2)
        }
        return changeArc
    }
    
    
    
    func containArc(_ arc: CGFloat) -> Bool {
        var pAcr = arc
        var trans = self.convertArc(self.transform)
        var maxArc = self.convertArc(self.transform + self.arc)
        if trans > maxArc {
            trans = trans > CGFloat.pi ? -(CGFloat.pi * 2 - trans) : trans
            maxArc = maxArc > CGFloat.pi ? -(CGFloat.pi * 2 - maxArc) : maxArc
            pAcr = arc > CGFloat.pi ? -(CGFloat.pi * 2 - arc) : arc
        }
        return pAcr >= trans && arc <= maxArc
    }
    
    func containPoint(_ point: CGPoint) -> Bool {
        let line = Line.init(start: self.center, end: point)
        return self.radiusRange.containLength(line.length) && self.containArc(line.xArc())
    }
    
    func toAnotherPie(_ toPie: Pie, withProgress: CGFloat) -> Pie {
        let f_transform = toPie.transform - self.transform
        let f_arc = toPie.arc - self.arc
        let f_in = toPie.radiusRange.inRadius - self.radiusRange.inRadius
        let f_out = toPie.radiusRange.outRadius - self.radiusRange.outRadius
        
        let n_arc = self.arc + f_arc * withProgress
        let n_trans = self.transform + f_transform * withProgress
        
        return Pie.init(center: self.center, radiusRange: RadiusRange.init(inRadius: self.radiusRange.inRadius + f_in * withProgress, outRadius: self.radiusRange.outRadius + f_out * withProgress), arc: n_arc, transform: n_trans)
    }
}

public struct Polygon {
    let radius: CGFloat
    let center: CGPoint
    let side: Int
    let radian: CGFloat
}

public struct SizeRange : Equatable {
    let max: CGFloat
    let min: CGFloat
    
    public static func == (lhs: SizeRange, rhs: SizeRange) -> Bool {
        return lhs.max == rhs.max && lhs.min == rhs.min
    }
}
