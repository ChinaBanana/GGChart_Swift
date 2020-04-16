//
//  Renderer.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/15.
//

import Foundation

public protocol RenderProtocol {
    func darwInContext(_ context: CGContext) -> ()
}

extension Line: RenderProtocol {
    public func darwInContext(_ context: CGContext) {
        context.setLineWidth(self.width)
        context.setStrokeColor(self.color.cgColor)

        if let dash = self.dashPattern {
            context.setLineDash(phase: 0, lengths: dash)
        }

        context.move(to: self.start)
        context.addLine(to: self.end)
        context.strokePath()
    }
}

extension Circle: RenderProtocol {
    public func darwInContext(_ context: CGContext) {
        context.setLineWidth(self.borderWidth)
        context.setStrokeColor(self.borderColor.cgColor)
        context.addEllipse(in: CGRect.init(x: self.center.x - self.radius, y: self.center.y - self.radius, width: self.radius * 2, height: self.radius * 2))
        if let gradentC = self.gradentColors {
            let clearCir = CGColorSpaceCreateDeviceRGB()
            
            let gradientRef = CGGradient.init(colorsSpace: clearCir, colors: gradentC as CFArray, locations: [0.25, 0.75])
            
            context.drawRadialGradient((gradientRef ?? nil), startCenter: self.center, startRadius: 0, endCenter: self.center, endRadius: self.radius, options: .drawsBeforeStartLocation)
        } else {
            
        }
    }
}

//extension CGContext {
//    func drawLine(_ line: Line) -> () {
//        self.setLineWidth(line.width)
//        self.setStrokeColor(line.color.cgColor)
//
//        if let dash = line.dashPattern {
//            self.setLineDash(phase: 0, lengths: dash)
//        }
//
//        self.move(to: line.start)
//        self.addLine(to: line.end)
//        self.strokePath()
//    }
//}
