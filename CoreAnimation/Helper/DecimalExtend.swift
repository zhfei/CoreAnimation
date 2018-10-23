//
//  DecimalExtend.swift
//  CoreAnimation
//
//  Created by zhoufei on 2018/10/23.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import Foundation

import UIKit

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
