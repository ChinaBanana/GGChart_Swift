//
//  Grid.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/17.
//

import Foundation

/// 网格
public struct Grid {
    let rect: CGRect
    let y_dis: CGFloat   // y轴分割距离
    let x_dis: CGFloat   // x轴分割距离
    
    init(_ rect: CGRect, yDis: CGFloat, xDis: CGFloat) {
        self.rect = rect
        self.y_dis = yDis
        self.x_dis = xDis
    }
    
    var width: CGFloat = Constants.lineWidth
    var color: UIColor = UIColor.white
    var dash: CGSize = CGSize.zero
    var needRect: Bool = false
    
    private var aryLines = [Line]()
}

extension Grid : RenderProtocol {
    
    public mutating func add(_ line: Line) {
        aryLines.append(line)
    }
    
    public mutating func removeAllLine() {
        aryLines.removeAll()
    }
    
    public func darwInContext(_ context: CGContext) {
        let x = rect.origin.x
        let y = rect.origin.y
        
        let h_count = Int(y_dis == 0 ? 0 : rect.height / y_dis + 1) /// 横线个数
        let v_count = Int(x_dis == 0 ? 0 : rect.width / x_dis + 1)  /// 纵线个数
        
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)
        if dash != CGSize.zero {
            context.setLineDash(phase: 0, lengths: [dash.width, dash.height])
        }
        
        for i in 0..<h_count {
            context.move(to: CGPoint.init(x: x, y: y + y_dis * CGFloat(i)))
            context.addLine(to: CGPoint.init(x: rect.maxX, y: y + y_dis * CGFloat(i)))
        }
        
        for i in 0..<v_count {
            context.move(to: CGPoint.init(x: x + x_dis * CGFloat(i), y: y))
            context.addLine(to: CGPoint.init(x: x + x_dis * CGFloat(i), y: rect.maxY))
        }
        
        if needRect {
            let innder = width / 2
            let rectInnder = UIEdgeInsets.init(top: innder, left: innder, bottom: innder, right: innder)
            context.addRect(rect.inset(by: rectInnder))
        }
        
        for line in aryLines {
            context.move(to: line.start)
            context.addLine(to: line.end)
        }
        context.strokePath()
    }
}
