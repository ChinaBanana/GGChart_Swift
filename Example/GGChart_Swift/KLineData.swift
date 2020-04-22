//
//  KLineData.swift
//  GGChart_Swift_Example
//
//  Created by 赵海伟 on 2020/4/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import GGChart_Swift

struct KLineData: Codable, KShapeDataProtocol {
    let high_price: CGFloat
    let turnover: CGFloat
    let turnover_rate: CGFloat
    let volume: Int
    let price_change: CGFloat
    let close_price: CGFloat
    let low_price: CGFloat
    let open_price: CGFloat
    let date: String
    let amplitude: CGFloat
    let price_change_rate: CGFloat
    
    var low: CGFloat {
        get {
            return low_price
        }
    }
    
    var high: CGFloat {
        get {
            return high_price
        }
    }
    
    var open: CGFloat {
        get {
            return open_price
        }
    }
    
    var close: CGFloat {
        get {
            return close_price
        }
    }
}
