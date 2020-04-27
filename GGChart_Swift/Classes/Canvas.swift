//
//  Canvas.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/16.
//

import Foundation

protocol CavansProtocol {
    var renders: Array<RenderProtocol> { set get }
}

public class Canvas: CALayer, CavansProtocol {
    
    public var renders: Array<RenderProtocol> = []
    
    override init() {
        super.init()
        contentsScale = UIScreen.main.scale
        masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(in ctx: CGContext) {
        
        super.draw(in: ctx)
        ctx.saveGState()
        
        for obj in renders {
            obj.darwInContext(ctx)
        }
        
        ctx.restoreGState()
        ctx.flush()
    }
}
