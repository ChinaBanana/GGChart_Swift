//
//  MinuteChart.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/16.
//

import Foundation

public class MinuteChart: UIView {
    
    let backCanvas: Canvas = Canvas.init()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backCanvas.frame = self.bounds
        
        var rectRender = RectRender.init(rect: self.bounds)
        rectRender.borderColor = UIColor.orange
        rectRender.fillColor = UIColor.riseColor()
        backCanvas.renders.append(rectRender)
        
        var line = Line.init(start: CGPoint.init(x: 0, y: 20), end: CGPoint.init(x: 100, y: 20))
        line.color = UIColor.red
        backCanvas.renders.append(line)
        
        var circle = Circle.init(center: CGPoint.init(x: UIScreen.main.bounds.width / 2, y: 100), radius: 50)
        circle.gradentColors = [UIColor.red, UIColor.green, UIColor.yellow]
        circle.borderWidth = 2
        backCanvas.renders.append(circle)
        
        var axis = Axis.init(line, over: 150, sep: 20)
        axis.color = UIColor.black
        
        backCanvas.renders.append(axis)
        
        self.layer.addSublayer(backCanvas)
        backCanvas.setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
