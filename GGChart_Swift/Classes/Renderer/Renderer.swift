//
//  Renderer.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/15.
//

import Foundation

protocol RenderProtocol {
    func darwInContext(_ context: CGContext) -> ()
}

extension Line: RenderProtocol {
    func darwInContext(_ context: CGContext) {
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

extension CGContext {
    func drawLine(_ line: Line) -> () {
        self.setLineWidth(line.width)
        self.setStrokeColor(line.color.cgColor)

        if let dash = line.dashPattern {
            self.setLineDash(phase: 0, lengths: dash)
        }

        self.move(to: line.start)
        self.addLine(to: line.end)
        self.strokePath()
    }
}
