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
        context.setLineWidth(width)
        context.setStrokeColor(color.cgColor)

        if let dash = dashPattern {
            context.setLineDash(phase: 0, lengths: dash)
        }

        context.move(to: start)
        context.addLine(to: end)
        context.strokePath()
    }
}

extension Circle: RenderProtocol {
    public func darwInContext(_ context: CGContext) {
        context.setLineWidth(borderWidth)
        context.setStrokeColor(borderColor.cgColor)
        context.addEllipse(in: CGRect.init(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        if let gradentC = gradentColors {
            let clearCir = CGColorSpaceCreateDeviceRGB()
            var colorArr = [CGColor]()
            for color in gradentC {
                colorArr.append(color.cgColor)
            }
            
            let gradientRef = CGGradient.init(colorsSpace: clearCir, colors: colorArr as CFArray, locations: [0.25, 0.75])!
            context.drawRadialGradient(gradientRef, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: .drawsBeforeStartLocation)
            
        } else {
            context.setFillColor(fillColor.cgColor)
            context.fillEllipse(in: CGRect.init(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        }
        context.strokePath()
    }
}



public struct RectRender : RenderProtocol {
    let rect: CGRect
    var width: CGFloat = Constants.lineWidth
    var borderColor: UIColor = UIColor.white
    var fillColor: UIColor?
    
    public func darwInContext(_ context: CGContext) {
        context.setLineWidth(width)
        context.setStrokeColor(borderColor.cgColor)
        context.addRect(rect)
        
        if let fillC = fillColor {
            context.setFillColor(fillC.cgColor)
            context.fill(rect)
        }
        context.strokePath()
    }
}
