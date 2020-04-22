//
//  DayLineChart.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/20.
//

import UIKit

public class DayLineChart: UIView, UIScrollViewDelegate {
    
    public var riseColor = UIColor.riseColor
    public var fallColor = UIColor.fallColor
    public var gridColor = UIColor(0xF0f0f0)
    
    public var verticalSplitCount: Int = 7    /// 竖直分割线条数
    public var horizontalSplitCount: Int = 3  /// 水平分割条数

    private let redLineLayer = CAShapeLayer.init()
    private let greenLineLayer = CAShapeLayer.init()
    private let gridLayer = CAShapeLayer.init()
    
    private var horizontalAxisRender: Axis = Axis()
    private var verticalAxisRender: Axis = Axis()
    
    private let contentView = UIScrollView()
    private let stringLayer = Canvas()
    
    let kLineScaler = KLineScaler()
    
    private var contentRect: CGRect {
        get {
            return bounds.inset(by: UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
    
    private var contentBounds: CGRect {
        get {
            return CGRect.init(origin: CGPoint.zero, size: contentRect.size)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(0xe0e0e0)
        
        stringLayer.frame = bounds
        layer.addSublayer(stringLayer)
        
        gridLayer.frame = contentRect
        gridLayer.strokeColor = gridColor.cgColor
        gridLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(gridLayer)
        
        redLineLayer.strokeColor = riseColor.cgColor
        redLineLayer.fillColor = UIColor.clear.cgColor
        
        greenLineLayer.strokeColor = fallColor.cgColor
        greenLineLayer.fillColor = fallColor.cgColor
        
        contentView.frame = contentRect
        contentView.layer.addSublayer(redLineLayer)
        contentView.layer.addSublayer(greenLineLayer)
        contentView.delegate = self
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        addSubview(contentView)
        
        kLineScaler.shapeWidth = 10
        kLineScaler.shapeInterval = 3
        kLineScaler.rect = contentBounds
        
        verticalAxisRender = Axis.init(Line.leftLineOfRect(contentRect), len: 0, sep: height / CGFloat(verticalSplitCount))
        verticalAxisRender.strColor = UIColor.red
        verticalAxisRender.width = 0.25
        verticalAxisRender.offSetRatio = TextRatio.topRight
        verticalAxisRender.showText = true
        
        horizontalAxisRender = Axis.init(Line.bottomLineOfRect(contentRect), len: 0, sep: width / CGFloat(horizontalSplitCount))
        horizontalAxisRender.strColor = UIColor.red
        horizontalAxisRender.width = 0.25
        horizontalAxisRender.offSetRatio = TextRatio.topRight 
        horizontalAxisRender.showText = true
        
        stringLayer.renders.append(verticalAxisRender)
        stringLayer.renders.append(horizontalAxisRender)
        
        updateBaseContents()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    private func updateBaseContents() {
        let gridRef = CGMutablePath()
        let v_spe = contentRect.height / CGFloat(verticalSplitCount)
        let h_spe = contentRect.width / CGFloat(horizontalSplitCount)
        
        let grid = Grid.init(contentBounds, yDis: v_spe, xDis: h_spe)
        gridRef.addGrid(grid)
        gridLayer.path = gridRef
        gridLayer.setNeedsDisplay()
    }
    
    public func updateContentsWith(_ data: Array<KShapeDataProtocol>) -> () {
        kLineScaler.klineObjs = data
        contentView.contentSize = kLineScaler.contentSize
        
        redLineLayer.frame.size = contentView.contentSize
        greenLineLayer.frame.size = contentView.contentSize
        
        var verticalStrs = [String]()
        let gap = (kLineScaler.max - kLineScaler.min) / CGFloat(verticalSplitCount)
        
        for i in 0...verticalSplitCount {
            verticalStrs.append(String.init(format: "%.2f", (kLineScaler.max - CGFloat(i) * gap)))
        }
        
        verticalAxisRender.aryStrings = verticalStrs
        verticalAxisRender.sep = height / CGFloat(verticalSplitCount + 1)
        
        let redRef = CGMutablePath()
        let greenRef = CGMutablePath()
        
        for (i, shape) in kLineScaler.kShapes.enumerated() {
            let obj = data[i]
            if obj.close > obj.open {
                redRef.addKShape(shape)
            } else {
                greenRef.addKShape(shape)
            }
        }
        
        redLineLayer.path = redRef
        greenLineLayer.path = greenRef
        
        stringLayer.renders.removeAll()
        stringLayer.renders.append(verticalAxisRender)
        stringLayer.renders.append(horizontalAxisRender)
        
        redLineLayer.setNeedsDisplay()
        greenLineLayer.setNeedsDisplay()
        stringLayer.setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
