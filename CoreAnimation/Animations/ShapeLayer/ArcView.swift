//
//  ArcView.swift
//  CoreAnimation
//
//  Created by zhoufei on 2018/10/17.
//  Copyright © 2018年 ChenDao. All rights reserved.
//
// 在使用图层mask时，若要做出镂空的效果，需要在要镂空的区域时偶数层描绘。
// 比如：0层时，在一个矩形中，上部分和下部分都被一个封闭的路径包裹着，则中间没有被描绘覆盖的间隙就时镂空的图形
// 比如：2层时，在一个矩形中，先对整个举行描绘，描绘的一个封闭的矩形。然后再在矩形中描绘一个封闭的圆，那么这个圆就是镂空图形

import UIKit

class ArcView: UIView {
    
    lazy var arcState:Bool = {
        self.drawCircularArc()
        return true
    }()

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //像CG一样绘图
        
//        UIColor.red.setStroke()
//        UIColor.brown.setFill()
//        let cgRect = CGRect(x: 10, y: 10, width: 300, height: 200)
//        let bezier = UIBezierPath()
//        bezier.lineWidth = 5
//        bezier.lineCapStyle = .round
//        bezier.lineJoinStyle = .round
//
//        bezier.move(to: cgRect.origin)
//        bezier.addLine(to: CGPoint(x: 100, y: 100))
//        bezier.addLine(to: CGPoint(x: 50, y: 100))
//        bezier.close()
//        bezier.fill()
//        bezier.stroke()
        
//        //1.拿到上下文
//        let context = UIGraphicsGetCurrentContext()
//        //2.绘制路径
//        let bez = UIBezierPath()
//        bez.move(to: CGPoint(x: 10, y: 10))
//        bez.addLine(to: CGPoint(x: 100, y: 100))
//        //3.把路径添加到上下文
//        context?.addPath(bez.cgPath)
//        //4.绘制上下文中的路径
//        context?.strokePath()
        
//        //1.拿到上下文
//        let context = UIGraphicsGetCurrentContext()
//        UIColor.red.setStroke()
//        //2.绘制路径
//        let bez = UIBezierPath()
//        bez.lineWidth = 2
//        bez.move(to: CGPoint(x: 10, y: 10))
//        bez.addLine(to: CGPoint(x: 100, y: 100))
//        bez.addLine(to: CGPoint(x: 50, y: 100))
//        bez.close()
//        //3.把路径添加到上下文
//        context?.addPath(bez.cgPath)
//        //4.绘制上下文中的路径
//        context?.strokePath()
        
//        //1.拿到上下文
//        let context = UIGraphicsGetCurrentContext()
//        UIColor.red.setFill()
//        //2.绘制路径
//        let bez = UIBezierPath(ovalIn: CGRect(x: 20, y: 20, width: 100, height: 200))
//        //3.把路径添加到上下文
//        context?.addPath(bez.cgPath)
//        //4.绘制上下文中的路径
//        context?.fillPath()
        
        //1.拿到上下文
        let context = UIGraphicsGetCurrentContext()
        UIColor.blue.setFill()
        //2.绘制路径
        let bez = UIBezierPath(arcCenter: CGPoint(x: 60, y: 60), radius: 50, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: false)
        //3.把路径添加到上下文
        context?.addPath(bez.cgPath)
        //4.绘制上下文中的路径
        context?.fillPath()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _ = arcState
    }
    
    func drawCircularArc() {
        //镂空效果
        //第一种方式，0层路径描绘
        let path =  UIBezierPath()//UIBezierPath(rect: self.bounds)
        path.lineCapStyle = .round
        path.move(to: CGPoint(x: 0, y: self.bounds.size.height))
        path.addArc(withCenter: CGPoint(x: self.bounds.size.width*0.5, y: self.bounds.size.height), radius: self.bounds.size.width*0.5, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: self.bounds.size.width, y: 0))
        path.addLine(to: CGPoint(x:0, y: 0))
        path.close()
        
        let path0 =  UIBezierPath()
        path0.lineCapStyle = .round
        path0.move(to: CGPoint(x: self.bounds.size.width - 5, y: self.bounds.size.height))
        path0.addArc(withCenter: CGPoint(x: self.bounds.size.width*0.5, y: self.bounds.size.height), radius: self.bounds.size.width*0.5 - 5, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: false)
        path0.close()
        
        let path1 = UIBezierPath() //UIBezierPath(rect: self.bounds)
        path1.append(path0)
        path1.append(path)
        
        
        //第二种方式，2层路径描绘
        let bigArc:CGFloat = self.bounds.size.width*0.5
        let smallArc:CGFloat = 2.5
        let arcCenter = CGPoint(x: self.bounds.size.width*0.5, y: self.bounds.size.height-smallArc)
        
        let bez2 = UIBezierPath(rect: self.bounds)
        let bez = UIBezierPath(arcCenter: arcCenter, radius: bigArc, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: false)
        bez.addArc(withCenter: CGPoint(x: smallArc, y: self.bounds.size.height-smallArc), radius: smallArc, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: false)
        bez.addArc(withCenter: arcCenter, radius: self.bounds.size.width*0.5 - 5, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        bez.addArc(withCenter: CGPoint(x: self.bounds.size.width - smallArc, y: self.bounds.size.height-smallArc), radius: smallArc, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI*2), clockwise: false)
        
        bez2.append(bez)
        
        let shape = CAShapeLayer()
        shape.path = bez2.cgPath
        shape.frame = self.bounds
        
        self.layer.mask = shape
        
    }

}
