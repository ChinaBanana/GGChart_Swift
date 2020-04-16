//
//  Canvas.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/16.
//

import Foundation

public class Canvas: CALayer {
    
    public var renders: Array<RenderProtocol> = []
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(in ctx: CGContext) {
        ctx.saveGState()
        super.draw(in: ctx)
        
        for obj in renders {
            obj.darwInContext(ctx)
        }
        
        ctx.restoreGState()
    }
}
