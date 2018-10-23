//
//  PartArcView.swift
//  CoreAnimation
//
//  Created by zhoufei on 2018/10/23.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class PartArcView: UIView {

    var _progressValue: CGFloat = 0.6
    var progressValue: CGFloat {
        get {
            return _progressValue
        }
        set {
            _progressValue = newValue
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        //        let image = UIImage(named: "TokenMarkeDetailBG")
        //        image?.draw(in: rect)
        let width = rect.size.width
        let height = rect.size.height
        
        let borderWidth: CGFloat = 6.0
        let bigOuterRadius = height-borderWidth
        let bigInnerRadius = bigOuterRadius - borderWidth
        let smailRadius:CGFloat = borderWidth*0.5
        let arcCenter = CGPoint(x: width*0.5, y: height-borderWidth)
        
        let context = UIGraphicsGetCurrentContext()
        //渐变色
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0,1]
        let startC = UIColor(hex: "f46b45")
        let endC = UIColor(hex: "eea849")
        let colors = [startC.cgColor,endC.cgColor]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: rect.size.width, y: 0), options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        //渐变色弧
        context?.saveGState()
        context?.addRect(rect)
        context?.move(to: CGPoint(x: width-borderWidth, y: bigOuterRadius))
        context?.addArc(center: arcCenter, radius: bigOuterRadius, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: true)
        context?.addArc(center: CGPoint(x: smailRadius+borderWidth, y: arcCenter.y), radius: smailRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: true)
        context?.addArc(center: arcCenter, radius: bigInnerRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: false)
        context?.addArc(center: CGPoint(x: width-smailRadius-borderWidth, y: arcCenter.y), radius: smailRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: true)
        context?.setFillColor(UIColor.white.cgColor)
        context?.fillPath()
        
        
        //灰色弧
        context?.restoreGState()
        let context1 = UIGraphicsGetCurrentContext()
        var endAng =  CGFloat(M_PI*2) - (_progressValue * CGFloat(M_PI))
        context1?.move(to: CGPoint(x: width-borderWidth, y: bigOuterRadius))
        context1?.addArc(center: arcCenter, radius: bigOuterRadius, startAngle: 0, endAngle: endAng, clockwise: true)
        
        let midSmallX: CGFloat = arcCenter.x + cos(endAng)*(bigOuterRadius-smailRadius)
        let midSmallY: CGFloat = arcCenter.y + sin(endAng)*(bigOuterRadius-smailRadius)
        
        context1?.addArc(center: CGPoint(x: midSmallX, y: midSmallY), radius: smailRadius, startAngle: endAng, endAngle: endAng-CGFloat(M_PI), clockwise: false)
        context1?.addArc(center: arcCenter, radius: bigInnerRadius, startAngle: endAng, endAngle: CGFloat(M_PI*2), clockwise: false)
        context1?.addArc(center: CGPoint(x: width-smailRadius-borderWidth, y: arcCenter.y), radius: smailRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: true)
        context1?.setFillColor(UIColor(hex: "e7e3e3").cgColor)
        context1?.fillPath()
    }
}
