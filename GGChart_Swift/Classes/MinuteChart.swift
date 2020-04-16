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
        
        var line = Line.init(start: CGPoint.init(x: 0, y: 20), end: CGPoint.init(x: 100, y: 20))
        line.color = UIColor.red
        var l2 = Line.init(start: line.end, end: CGPoint.init(x: 100, y: 80))
        l2.color = UIColor.red
        
        backCanvas.frame = self.bounds
        backCanvas.renders.append(line)
        backCanvas.renders.append(l2) 
        
        self.layer.addSublayer(backCanvas)
        backCanvas.setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
