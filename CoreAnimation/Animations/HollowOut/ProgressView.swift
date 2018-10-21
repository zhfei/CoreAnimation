//
//  ProgressView.swift
//  CoreAnimation
//
//  Created by 周飞 on 2018/10/21.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    var _progressValue: CGFloat = 1
    
    var progressValue: CGFloat {
        get {
            return _progressValue
        }
        set {
            _progressValue = newValue
            self.setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        let startArc = 0
        var endArc: CGFloat = 0
        let center = CGPoint(x:rect.size.width*0.5, y: rect.size.height*0.5)

        endArc = _progressValue*CGFloat(M_PI*2)
        
        let bez = UIBezierPath(arcCenter: center, radius: rect.size.height*0.5, startAngle: CGFloat(startArc), endAngle: endArc, clockwise: true)
        bez.lineWidth = 2
        
        UIColor.red.setStroke()
        bez.stroke()
    }

}
