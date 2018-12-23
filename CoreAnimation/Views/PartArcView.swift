//
//  PartArcView.swift
//  CoreAnimation
//
//  Created by zhoufei on 2018/10/23.
//  Copyright © 2018年 ZHF. All rights reserved.
//

import UIKit

class PartArcView: UIView {

    var _progressValue: CGFloat = 0.5
    var progressValue: CGFloat {
        get {
            return _progressValue
        }
        set {
            _progressValue = 1 - newValue
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        //        let image = UIImage(named: "TokenMarkeDetailBG")
        //        image?.draw(in: rect)
        let width = rect.size.width
        let height = rect.size.height
        //圆弧距离边界距离
        let edgeDistance: CGFloat = 6.0
        //大弧半径基值
        var baseRadius = width*0.5
        if baseRadius > height {
            baseRadius = height
        }
        //圆弧粗
        let borderWidth: CGFloat = 10.0
        //大弧外线半径
        let bigOuterRadius = baseRadius-edgeDistance
        //大弧内线半径
        let bigInnerRadius = bigOuterRadius - borderWidth
        //小弧半径
        let smailRadius:CGFloat = borderWidth*0.5
        //大弧圆心
        let arcCenter = CGPoint(x: width*0.5, y: height-edgeDistance)
        
        let context = UIGraphicsGetCurrentContext()
        //渐变色
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0,1]
        let startC = UIColor(hex: "EEA13A")
        let endC = UIColor(hex: "B1283C")
        let colors = [startC.cgColor,endC.cgColor]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: rect.size.width, y: 0), options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        //渐变色弧
        context?.saveGState()
        context?.addRect(rect)
        context?.move(to: CGPoint(x: width-edgeDistance, y: bigOuterRadius))
        context?.addArc(center: arcCenter, radius: bigOuterRadius, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: true)
        context?.addArc(center: CGPoint(x: smailRadius+edgeDistance, y: arcCenter.y), radius: smailRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: true)
        context?.addArc(center: arcCenter, radius: bigInnerRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: false)
        context?.addArc(center: CGPoint(x: width-smailRadius-edgeDistance, y: arcCenter.y), radius: smailRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: true)
        context?.setFillColor(UIColor.white.cgColor)
        context?.fillPath()
        
        
        //灰色弧
        context?.restoreGState()
        let context1 = UIGraphicsGetCurrentContext()
        var endAng =  CGFloat(M_PI*2) - (_progressValue * CGFloat(M_PI))
        context1?.move(to: CGPoint(x: width-edgeDistance, y: bigOuterRadius))
        context1?.addArc(center: arcCenter, radius: bigOuterRadius, startAngle: 0, endAngle: endAng, clockwise: true)
        
        let midSmallX: CGFloat = arcCenter.x + cos(endAng)*(bigOuterRadius-smailRadius)
        let midSmallY: CGFloat = arcCenter.y + sin(endAng)*(bigOuterRadius-smailRadius)
        
        context1?.addArc(center: CGPoint(x: midSmallX, y: midSmallY), radius: smailRadius, startAngle: endAng, endAngle: endAng-CGFloat(M_PI), clockwise: false)
        
        context1?.addArc(center: arcCenter, radius: bigInnerRadius, startAngle: endAng, endAngle: CGFloat(M_PI*2), clockwise: false)
        context1?.addArc(center: CGPoint(x: width-smailRadius-edgeDistance, y: arcCenter.y), radius: smailRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: true)
        context1?.setFillColor(UIColor(hex: "e7e3e3").cgColor)
        context1?.fillPath()
        
        drawProgressValueStr(rect)
    }
    
    func drawProgressValueStr(_ rect: CGRect) {
        let pv = NSString(format:  "当前进度：%.2f", (1-_progressValue)*100)
        let size = pv.size(withAttributes: nil)
        let x = (rect.size.width - size.width)*0.5
        let y = (rect.size.height - size.height)*0.5
        
        pv.appending(" %").draw(at: CGPoint(x: x, y: y+20), withAttributes: nil)
    }
}
