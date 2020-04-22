//
//  ChartExtension.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/20.
//

import Foundation

extension UIColor {
    
    static var riseColor: UIColor {
        get {
            return UIColor.init(0xFF3F00)
        }
    }
    
    static var fallColor: UIColor {
        get {
            return UIColor.init(0x21BC41)
        }
    }
    
    convenience init(_ hex:UInt32) {
        let r = (hex & 0xFF0000) >> 16
        let g = (hex & 0x00FF00) >> 8
        let b = hex & 0x0000FF
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension CGMutablePath {
    
    func addLine(_ line: Line) -> () {
        move(to: line.start)
        addLine(to: line.end)
    }
    
    func addKShape(_ shape: KShape) -> () {
        move(to: shape.top)
        addLine(to: CGPoint.init(x: shape.top.x, y: shape.rect.minY))
        addRect(shape.rect)
        move(to: CGPoint.init(x: shape.end.x, y: shape.rect.maxY))
        addLine(to: shape.end)
    }
    
    func addGrid(_ grid: Grid) -> () {
        let x = grid.rect.minX
        let y = grid.rect.minY
        
        let hCount: Int = grid.y_dis == 0 ? 0 : Int(grid.rect.height / grid.y_dis) + 1 /// 横线个数
        let vCount: Int = grid.x_dis == 0 ? 0 : Int(grid.rect.width / grid.x_dis) + 1   /// 纵线个数
        
        for i in 0..<hCount {
            move(to: CGPoint.init(x: x, y: grid.y_dis * CGFloat(i)))
            addLine(to: CGPoint.init(x: grid.rect.maxX, y: y + grid.y_dis * CGFloat(i)))
        }
        
        for i in 0..<vCount {
            move(to: CGPoint.init(x: x + grid.x_dis * CGFloat(i), y: y))
            addLine(to: CGPoint.init(x: x + grid.x_dis * CGFloat(i), y: grid.rect.maxY))
        }
        
        addRect(grid.rect)
    }
}
