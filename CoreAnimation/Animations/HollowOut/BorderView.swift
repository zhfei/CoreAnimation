//
//  BorderView.swift
//  CoreAnimation
//
//  Created by 周飞 on 2018/10/22.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class BorderView: UIView {

    var _targetRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var targetRect: CGRect {
        get {
            return _targetRect
        }
        set {
            _targetRect = newValue
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.addRect(_targetRect)
        context?.setLineWidth(2)
        UIColor.lightGray.setStroke()
        
        context?.strokePath()
    }

}
