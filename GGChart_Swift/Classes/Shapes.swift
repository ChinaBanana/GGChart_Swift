//
//  Shapes.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/15.
//

import Foundation

/// 直线
struct Line {
    let start: CGPoint
    let end: CGPoint
    
    var width: CGFloat = 0
    var color: UIColor = UIColor.white
    var dashPattern: Array<CGFloat>?
    
    /// 当前线点长度
    var length: Float {
        get {
            let w = self.start.x - self.end.x
            let h = self.end.x - self.end.y
            return sqrtf(Float(w * w + h * h))
        }
    }
    
    /// 起始点到终点的x距离
    var xLenght: Float {
        get {
            return Float(self.end.x - self.start.x)
        }
    }
    
    /// 起始点到终点的y距离
    var yLentgh: Float {
        get {
            return Float(self.end.y - self.start.y)
        }
    }
    
    /// 直线与X轴的弧度 范围 -pi/2 ~ pi/2
    func xCircular() -> Float {
        return atan2f(Float.init(self.end.y - self.start.y), Float.init(self.end.x - self.start.x))
    }
    
    /// 直线与Y轴的弧度 范围 -pi/2 ~ pi/2
    func yCircular() -> Float {
        return atan2f(Float.init(self.end.x - self.start.x), Float.init(self.end.y - self.start.y))
    }
    
    /// 直线与X轴的弧度 范围：0～pi   0～3.141592653...
    func xArc() -> Float {
        return self.xCircular() < 0 ? Float.pi * 2 + self.xCircular() : self.xCircular()
    }
    
    /// 直线偏移线
    /// - Parameter move: 偏移量
    func endPointArcMoveX(_ move: Float) -> CGPoint {
        let base: Float = self.yCircular() > 0 ? 1: -1;
        return CGPoint.init(x: CGFloat.init(move * base) + self.end.x, y: self.end.y)
    }
    
    /// 获取基于point垂直与直线的点
    /// - Parameters:
    ///   - point: 任意点
    ///   - radius:点到基准线到距离
    func perpendicular(_ point: CGPoint, radius: Float) -> CGPoint {
        let m_h = radius * cos(self.xCircular())
        let m_w = radius * sin(self.xCircular())
        return CGPoint.init(x: point.x - CGFloat(m_w), y: point.y + CGFloat(m_h))
    }
    
    /// 从起始点沿直线方向移动一段距离，返回移动后的点
    /// - Parameter move: 移动距离
    func moveFromStart(_ move: Float) -> CGPoint {
        return CGPoint.init(x: self.start.x + CGFloat(move * cos(self.xCircular())), y: self.start.y + CGFloat(move * sin(self.xCircular())))
    }
    
    /// 从终点沿直线方向移动一段距离后，返回移动后的点
    /// - Parameter move: 移动距离
    func moveFromEnd(_ move: Float) -> CGPoint {
        return CGPoint.init(x: self.end.x + CGFloat(move * cos(self.xCircular())), y: self.end.y + CGFloat(move * sin(self.xCircular())))
    }
    
    /// 偏移x，返回偏移后的点
    /// - Parameter move: 移动距离
    func endPointArcMove(_ move: Float) -> CGPoint {
        let base: Float = self.yCircular() > 0 ? 1 : -1;
        return CGPoint.init(x: CGFloat(base * move) + self.end.x, y: self.end.y)
    }
    
    /// 移动起始点
    /// - Parameter move: 移动距离
    func moveStart(_ move: Float) -> Line {
        return Line.init(start: self.moveFromStart(move), end: self.end)
    }
    
    /// 移动终点
    /// - Parameter move: 移动距离
    func moveEnd(_ move: Float) -> Line {
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
        let base: Float = clockWise ? -1 : 1;
        let end_x = Float.init(arcLine.center.x) + cos(arcLine.arc) * arcLine.leg * base
        let end_y = Float.init(arcLine.center.y) + sin(arcLine.arc) * arcLine.leg * base
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
struct ArcLine {
    let center:CGPoint // 中心点
    let arc: Float     // 弧度
    let leg: Float     // 长度
}

/// 箭头
struct Arrow {
    let line: Line
    let side: Float
}

/// 轴线
struct Axis {
    let line: Line  // 基准线
    let over: Float // 轴分割线长度
    let sep: Float  // 轴分割距离
}

/// 圆
struct Circle {
    let center: CGPoint // 圆心
    let radius: Float   // 半径
}

/// 网格
struct Grid {
    let rect: CGRect
    let y_dis: Float   // y轴分割距离
    let x_dis: Float   // x轴分割距离
}

/// k线
struct KShape {
    let top: CGPoint
    let rect: CGRect
    let end: CGPoint
}

struct RadiusRange {
    let inRadius: Float
    let outRadius: Float
    
    // 获取间距
    var range: Float {
        get {
            return fabsf(Float(self.inRadius - self.outRadius))
        }
    }
    
    var isZero: Bool {
        get {
            return self.inRadius == 0 && self.outRadius == 0
        }
    }
    
    func containLength(_ length: Float) -> Bool {
        return length >= self.inRadius && length <= self.outRadius;
    }
}

struct Pie {
    let center: CGPoint
    let radiusRange: RadiusRange
    let arc: Float
    let transform: Float
    
    var isEmpty: Bool {
        get {
            return self.arc == 0 && self.transform == 0 && self.center == CGPoint.zero && self.radiusRange.isZero
        }
    }
    
    var minArc: Float {
        get {
            return self.getLessFloat(self.transform + self.arc, v2: Float.pi)
        }
    }
    
    var maxArc: Float {
        get {
            return self.getLessFloat(self.arc, v2: Float.pi)
        }
    }
    
    var yCircular: Float {
        get {
            let arcLine = ArcLine.init(center: self.center, arc: self.transform + self.arc / 2, leg: self.radiusRange.outRadius)
            return Line.lineWithArc(arcLine, clockWise: false).yCircular()
        }
    }
    
    private func getLessFloat(_ v1: Float, v2: Float) -> Float {
        var v = v1
        while v > v2 {
            v -= v2
        }
        return v
    }
    
    private func convertArc(_ arc: Float) -> Float {
        var changeArc = arc
        while changeArc > Float.pi * 2 {
            changeArc -= (Float.pi * 2)
        }
        return changeArc
    }
    
    
    
    func containArc(_ arc: Float) -> Bool {
        var pAcr = arc
        var trans = self.convertArc(self.transform)
        var maxArc = self.convertArc(self.transform + self.arc)
        if trans > maxArc {
            trans = trans > Float.pi ? -(Float.pi * 2 - trans) : trans
            maxArc = maxArc > Float.pi ? -(Float.pi * 2 - maxArc) : maxArc
            pAcr = arc > Float.pi ? -(Float.pi * 2 - arc) : arc
        }
        return pAcr >= trans && arc <= maxArc
    }
    
    func containPoint(_ point: CGPoint) -> Bool {
        let line = Line.init(start: self.center, end: point)
        return self.radiusRange.containLength(line.length) && self.containArc(line.xArc())
    }
    
    func toAnotherPie(_ toPie: Pie, withProgress: Float) -> Pie {
        let f_transform = toPie.transform - self.transform
        let f_arc = toPie.arc - self.arc
        let f_in = toPie.radiusRange.inRadius - self.radiusRange.inRadius
        let f_out = toPie.radiusRange.outRadius - self.radiusRange.outRadius
        
        let n_arc = self.arc + f_arc * withProgress
        let n_trans = self.transform + f_transform * withProgress
        
        return Pie.init(center: self.center, radiusRange: RadiusRange.init(inRadius: self.radiusRange.inRadius + f_in * withProgress, outRadius: self.radiusRange.outRadius + f_out * withProgress), arc: n_arc, transform: n_trans)
    }
}

struct Polygon {
    let radius: Float
    let center: CGPoint
    let side: Int
    let radian: Float
}

struct SizeRange : Equatable {
    let max: Float
    let min: Float
    
    public static func == (lhs: SizeRange, rhs: SizeRange) -> Bool {
        return lhs.max == rhs.max && lhs.min == rhs.min
    }
}
