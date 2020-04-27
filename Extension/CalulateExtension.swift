//
//  CalulateExtension.swift
//  GGChart_Swift
//
//  Created by 赵海伟 on 2020/4/23.
//

import Foundation

extension Array {
    public func getMaxAndMinValue() -> (CGFloat, CGFloat) {
        if let arr = self as? Array<KShapeDataProtocol> {
            var max, min: CGFloat
            if let first = arr.first {
                max = first.high
                min = first.low
                for obj in arr {
                    if max < obj.high {
                        max = obj.high
                    }
                    if min > obj.low {
                        min = obj.low
                    }
                }
                return (max, min)
            }
            return (1, 0)
        }
        return (1, 0)
    }
    
    public func getMaxAndMinValueIn(_ range: NSRange) -> (CGFloat, CGFloat) {
        guard self.count >= range.location + range.length else {
            return (1, 0)
        }
        if let arr = self as? Array<KShapeDataProtocol> {
            var max = arr[range.location].high
            var min = arr[range.length].low
            
            for i in range.location..<(range.location + range.length) {
                let obj = arr[i]
                if max < obj.high {
                    max = obj.high
                }
                if min > obj.low {
                    min = obj.low
                }
            }
            return (max, min)
        }
        return (1, 0)
    }
}
