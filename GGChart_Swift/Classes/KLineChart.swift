//
//  DayLineChart.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/20.
//

import UIKit

public class KLineChart: UIView, UIScrollViewDelegate {
    
    public var datas = [KShapeDataProtocol]()
    
    public var riseColor = UIColor.riseColor
    public var fallColor = UIColor.fallColor
    public var gridColor = UIColor(0xe0e0e0)
    public var axisColor = UIColor(0x101e19)
    
    public var verticalSplitCount: Int = 7    /// 竖直分割线条数
    public var horizontalSplitCount: Int = 3  /// 水平分割条数
    
    private var visiableKlineCount = 60
    private var visiableKlineMaxCount = 120
    private var visiableKlineMinCount = 20
    private var kInterval:CGFloat = 3

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
            return bounds.inset(by: UIEdgeInsets.init(top: 20, left: 5, bottom: 20, right: 5))
        }
    }
    
    private var contentBounds: CGRect {
        get {
            return CGRect.init(origin: CGPoint.zero, size: contentRect.size)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        gridLayer.frame = contentRect
        gridLayer.strokeColor = gridColor.cgColor
        gridLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(gridLayer)
        
        stringLayer.frame = bounds
        layer.addSublayer(stringLayer)
        
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
        
        kLineScaler.shapeWidth = contentBounds.width /  CGFloat(visiableKlineCount) - kInterval
        kLineScaler.shapeInterval = kInterval
        kLineScaler.rect = contentBounds
        
        verticalAxisRender = Axis.init(Line.leftLineOfRect(contentRect), len: 0, sep: height / CGFloat(verticalSplitCount))
        verticalAxisRender.strColor = axisColor
        verticalAxisRender.strFont = UIFont.systemFont(ofSize: 10)
        verticalAxisRender.width = 0.25
        verticalAxisRender.offSetRatio = TextRatio.topRight
        verticalAxisRender.showText = true
        verticalAxisRender.showLine = false
        
        horizontalAxisRender = Axis.init(Line.bottomLineOfRect(contentRect), len: 0, sep: width / CGFloat(horizontalSplitCount))
        horizontalAxisRender.strColor = axisColor
        horizontalAxisRender.width = 0.25
        horizontalAxisRender.offSetRatio = TextRatio.topRight 
        horizontalAxisRender.showText = true
        horizontalAxisRender.showLine = false
        
        updateBaseContents()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateSubLayer()
    }
    
    private func updateSubLayer() {
        var index = Int(round((contentView.contentOffset.x - kLineScaler.rect.origin.x) / (kLineScaler.shapeInterval + kLineScaler.shapeWidth)))
        var length = visiableKlineCount
        
        if index < 0 {
            index = 0
        }
        if index > datas.count {
            index = datas.count
        }
        if index + visiableKlineCount > datas.count {
            length = datas.count - index
        }
        updateRange(NSRange.init(location: index, length: length))
    }
    
    private func updateRange(_ range: NSRange) {
        let (max, min) = datas.getMaxAndMinValueIn(range)
        let abs = max - min
        
        kLineScaler.max = max + abs * 0.05
        kLineScaler.min = min - abs * 0.05
        updateKlineWithRange(range)
        updateAxis(range)
    }
    
    private func updateAxis(_ range: NSRange) {
        var verticalStrs = [String]()
        let gap = (kLineScaler.max - kLineScaler.min) / CGFloat(verticalSplitCount)
        
        for i in 0...verticalSplitCount {
            verticalStrs.append(String.init(format: "%.2f", (kLineScaler.max - CGFloat(i) * gap)))
        }
        
        verticalAxisRender.aryStrings = verticalStrs
        verticalAxisRender.sep = height / CGFloat(verticalSplitCount + 1)
        
        stringLayer.renders.removeAll()
        stringLayer.renders.append(verticalAxisRender)
        
        stringLayer.setNeedsDisplay()
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
        datas.removeAll()
        datas.append(contentsOf: data)
        
        kLineScaler.klineObjs = data
        contentView.contentSize = kLineScaler.contentSize
        redLineLayer.frame.size = contentView.contentSize
        greenLineLayer.frame.size = contentView.contentSize
        
        updateSubLayer()
    }
    
    private func updateKlineWithRange(_ range: NSRange) {
        kLineScaler.updateScalerIn(range)
        
        let redRef = CGMutablePath()
        let greenRef = CGMutablePath()
        
        for i in range.location..<(range.location + range.length) {
            let obj = datas[i]
            if isRed(obj) {
                redRef.addKShape(kLineScaler.kShapes[i])
            } else {
                greenRef.addKShape(kLineScaler.kShapes[i])
            }
        }
        redLineLayer.path = redRef
        greenLineLayer.path = greenRef
        redLineLayer.setNeedsDisplay()
        greenLineLayer.setNeedsDisplay()
    }
    
    private func isRed(_ obj: KShapeDataProtocol) -> Bool {
        return obj.open >= obj.close
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
