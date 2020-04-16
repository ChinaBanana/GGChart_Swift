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
            var colorArr = [CGColor]()
            for color in gradentC {
                colorArr.append(color.cgColor)
            }
            
            let gradientRef = CGGradient.init(colorsSpace: clearCir, colors: colorArr as CFArray, locations: [0.25, 0.75])!
            context.drawRadialGradient(gradientRef, startCenter: self.center, startRadius: 0, endCenter: self.center, endRadius: self.radius, options: .drawsBeforeStartLocation)
            
        } else {
            context.setFillColor(self.fillColor.cgColor)
            context.fillEllipse(in: CGRect.init(x: self.center.x - self.radius, y: self.center.y - self.radius, width: self.radius * 2, height: self.radius * 2))
        }
        context.strokePath()
    }
}

extension Axis : RenderProtocol {
    
    private func ratioConvert(_ ratio: CGPoint) -> CGPoint {
        return CGPoint.init(x: (-1 + self.pureDecimal(ratio.x))/2, y: (-1 + self.pureDecimal(ratio.y)) / 2)
    }
    
    private func pureDecimal(_ x: CGFloat) -> CGFloat {
        return x > 1 ? 1 : (x < -1 ? -1 : x)
    }
    
    public func darwInContext(_ context: CGContext) {
        context.setLineWidth(self.width)
        context.setStrokeColor(self.color.cgColor)
//        let ratioP = self.ratioConvert(self.offSetRatio)
        
        if self.showLine {
            context.move(to: self.line.start)
            context.addLine(to: self.line.end)
        }
        
        let count = Int(self.sep == 0 ? 0 : abs(self.line.length / self.sep + 0.1) + 1)
        var fromArr = [CGPoint]()
        var endArr = [CGPoint]()
        for i in 0..<count {
            let axisP = self.line.moveFromEnd(self.sep * CGFloat(i))
            fromArr.append(axisP)
            endArr.append(self.line.perpendicular(axisP, radius: self.over))
        }
        
        if self.showSep {
            for i in 0..<count {
                context.move(to:fromArr[i])
                context.addLine(to: endArr[i])
            }
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
        context.setLineWidth(self.width)
        context.setStrokeColor(self.borderColor.cgColor)
        context.addRect(self.rect)
        
        if let fillC = fillColor {
            context.setFillColor(fillC.cgColor)
            context.fill(self.rect)
        }
        context.strokePath()
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
