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
    
    var width: CGFloat = Constants.lineWidth
    var color: UIColor = UIColor.white
    var dash: CGSize = CGSize.zero
    var needRect: Bool = false
    
    private var aryLines = [Line]()
}

extension Grid : RenderProtocol {
    
    public mutating func add(_ line: Line) {
        self.aryLines.append(line)
    }
    
    public mutating func removeAllLine() {
        self.aryLines.removeAll()
    }
    
    public func darwInContext(_ context: CGContext) {
        let x = self.rect.origin.x
        let y = self.rect.origin.y
        
        let h_count = Int(self.y_dis == 0 ? 0 : self.rect.height / self.y_dis + 1) /// 横线个数
        let v_count = Int(self.x_dis == 0 ? 0 : self.rect.width / self.x_dis + 1)  /// 纵线个数
        
        context.setLineWidth(self.width)
        context.setStrokeColor(self.color.cgColor)
        if self.dash != CGSize.zero {
            context.setLineDash(phase: 0, lengths: [dash.width, dash.height])
        }
        
        for i in 0..<h_count {
            context.move(to: CGPoint.init(x: x, y: y + self.y_dis * CGFloat(i)))
            context.addLine(to: CGPoint.init(x: self.rect.maxX, y: y + self.y_dis * CGFloat(i)))
        }
        
        for i in 0..<v_count {
            context.move(to: CGPoint.init(x: x + self.x_dis * CGFloat(i), y: y))
            context.addLine(to: CGPoint.init(x: x + self.x_dis * CGFloat(i), y: self.rect.maxY))
        }
        
        if needRect {
            let innder = self.width / 2
            let rectInnder = UIEdgeInsets.init(top: innder, left: innder, bottom: innder, right: innder)
            context.addRect(self.rect.inset(by: rectInnder))
        }
        
        for line in self.aryLines {
            context.move(to: line.start)
            context.addLine(to: line.end)
        }
        context.strokePath()
    }
}
