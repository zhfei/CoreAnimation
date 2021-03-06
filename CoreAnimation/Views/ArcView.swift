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
        
//        //1.拿到上下文
//        let context = UIGraphicsGetCurrentContext()
//        UIColor.blue.setFill()
//        //2.绘制路径
//        let bez = UIBezierPath(arcCenter: CGPoint(x: 60, y: 60), radius: 50, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: false)
//        //3.把路径添加到上下文
//        context?.addPath(bez.cgPath)
//        //4.绘制上下文中的路径
//        context?.fillPath()
        
//        //1.拿到上下文
//        let context = UIGraphicsGetCurrentContext()
//        UIColor.blue.setFill()
//        //2.绘制路径
//        let bez = UIBezierPath(ovalIn: CGRect(x: 20, y: 20, width: 200, height: 100))
//        //3.把路径添加到上下文
//        context?.addPath(bez.cgPath)
//        //4.绘制上下文中的路径
//        context?.fillPath()
        
//        //1.拿到上下文
//        let context = UIGraphicsGetCurrentContext()
//        //2.绘制路径
//        let text: NSString = "描述路径"
////        UIColor.blue.setFill()
//        let attr = [
//            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 14.0)!,
//            NSForegroundColorAttributeName:UIColor.red,
//        ]
//        let rect = CGRect(x: 20, y: 20, width: 200, height: 100)
//        text.draw(in: rect, withAttributes: attr)
//        //4.绘制上下文中的路径
//        context?.fillPath()
        
//        //文字绘制可以不获取当前上下文，但是必须要做子view的draw方法内
//        let text: NSString = "描述路径"
//        //        UIColor.blue.setFill()
//        let attr = [
//            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 14.0)!,
//            NSForegroundColorAttributeName:UIColor.red,
//            ]
//        let rect = CGRect(x: 20, y: 20, width: 200, height: 100)
//        text.draw(in: rect, withAttributes: attr)

//        //文字绘制可以不获取当前上下文，但是必须要做子view的draw方法内
//        let text: NSString = "描述路径"
//        //        UIColor.blue.setFill()
//
//        let shadow = NSShadow()
//        shadow.shadowOffset = CGSize(width: 5, height: 5)
//        shadow.shadowColor = UIColor.black
//        shadow.shadowBlurRadius = 5
//        let attr = [
//            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 14.0)!,
//            NSForegroundColorAttributeName:UIColor.red,
//            NSBackgroundColorAttributeName:UIColor.blue,
//            NSShadowAttributeName:shadow
//            ]
//        let rect = CGRect(x: 20, y: 20, width: 200, height: 100)
//        text.draw(in: rect, withAttributes: attr)
        
        
//        //文字绘制可以不获取当前上下文，但是必须要做子view的draw方法内
//        let image = UIImage(named: "timg")
//
//        let rect = CGRect(x: 20, y: 20, width: 200, height: 100)
//        image?.draw(in: rect, blendMode: CGBlendMode.normal, alpha: 1)
        
        //在draw中的上下文里面，设置不同的的属性后划线，最终画出来的结果是一样的，因为上下文中对属性多次赋值，最终属性保存的是最后的赋值。
        //貌似对不同的线段设置不同颜色，实际到最后是最后的颜色值
//        let context = UIGraphicsGetCurrentContext()
//
//        let bez = UIBezierPath()
//        bez.lineWidth = 5
//        bez.move(to: CGPoint(x: 50, y: 20))
//        bez.addLine(to: CGPoint(x: 50, y: 100))
//        UIColor.purple.setStroke()
//        bez.stroke()
//
//        bez.lineWidth = 5
//        bez.move(to: CGPoint(x: 100, y: 20))
//        bez.addLine(to: CGPoint(x: 100, y: 100))
//        UIColor.brown.setStroke()
//        bez.stroke()
//
//        bez.lineWidth = 5
//        bez.move(to: CGPoint(x: 150, y: 20))
//        bez.addLine(to: CGPoint(x: 150, y: 100))
//        UIColor.red.setStroke()
//        bez.stroke()
        
//        //在上下文中有个状态栈概念，可以通过在设置不同上下文属性时，将不同状态的上下文入栈，可以保存起来。当用到对应的栈状态时，从状态栈弹出就可以了。
//        let context = UIGraphicsGetCurrentContext()
//        UIColor.purple.setStroke()
//        context?.saveGState()
//
//        let context1 = UIGraphicsGetCurrentContext()
//        UIColor.brown.setStroke()
//        context1?.saveGState()
//
//        let context2 = UIGraphicsGetCurrentContext()
//        UIColor.red.setStroke()
//        context2?.saveGState()
//

//        context2?.restoreGState()
//        context2?.setLineWidth(5)
//        context2?.move(to: CGPoint(x: 50, y: 20))
//        context2?.addLine(to: CGPoint(x: 50, y: 100))
//        UIColor.red.setStroke()
//        context2?.strokePath()
//
//
//        context1?.restoreGState()
//        context1?.setLineWidth(5)
//        context1?.move(to: CGPoint(x: 100, y: 20))
//        context1?.addLine(to: CGPoint(x: 100, y: 100))
//        UIColor.brown.setStroke()
//        context1?.strokePath()
//
//        context?.restoreGState()
//        context?.setLineWidth(5)
//        context?.move(to: CGPoint(x: 150, y: 20))
//        context?.addLine(to: CGPoint(x: 150, y: 100))
//        UIColor.purple.setStroke()
//        context?.strokePath()
        
        
//        //在上下文中有个状态栈概念，可以通过在设置不同上下文属性时，将不同状态的上下文入栈，可以保存起来。当用到对应的栈状态时，从状态栈弹出就可以了。
//        //而用贝塞尔曲线则无需考虑状态栈，只需要创建一个新的贝塞尔对象即可。
//        let bez = UIBezierPath()
//        bez.lineWidth = 5
//        bez.move(to: CGPoint(x: 50, y: 20))
//        bez.addLine(to: CGPoint(x: 50, y: 100))
//        UIColor.purple.setStroke()
//        bez.stroke()
//
//        let bez1 = UIBezierPath()
//        bez1.lineWidth = 5
//        bez1.move(to: CGPoint(x: 100, y: 20))
//        bez1.addLine(to: CGPoint(x: 100, y: 100))
//        UIColor.brown.setStroke()
//        bez1.stroke()
//
//        let bez2 = UIBezierPath()
//        bez2.lineWidth = 5
//        bez2.move(to: CGPoint(x: 150, y: 20))
//        bez2.addLine(to: CGPoint(x: 150, y: 100))
//        UIColor.red.setStroke()
//        bez2.stroke()
        
        
//        //利用上下文绘制渐变色（圆形）
//        let context = UIGraphicsGetCurrentContext()
//        //颜色空间
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let startColor = UIColor.black
//        let endColor = UIColor.red
//        //颜色数组
//        let colors = [startColor.cgColor,endColor.cgColor]
//        //颜色所处位置
//        let locations:[CGFloat] = [0,1]
//
//
//        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as! CFArray, locations: locations)
//        let center = CGPoint(x: rect.size.width*0.5, y: rect.size.height*0.5)
//        let radius = rect.size.height*0.3
//        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: radius*0.2, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
//        //利用上下文绘制渐变色（clip形）
//        let context = UIGraphicsGetCurrentContext()
//        //颜色空间
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let startColor = UIColor.black
//        let endColor = UIColor.red
//        //颜色数组
//        let colors = [startColor.cgColor,endColor.cgColor]
//        //颜色所处位置
//        let locations:[CGFloat] = [0,1]
//
//
//        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as! CFArray, locations: locations)
//        let start = CGPoint(x: 0, y: 0)
//        let end = CGPoint(x: rect.size.width, y: 0)
//
//        let heigh = rect.size.height/4
//        let width = rect.size.width/4
//
//        let rect1 = CGRect(x: width, y: heigh, width: width, height: width)
//        let rect2 = CGRect(x: width*3, y: heigh, width: width, height: width)
//        let rect3 = CGRect(x: width*0, y: heigh*3, width: width, height: width)
//        let rect4 = CGRect(x: width*2, y: heigh*3, width: width, height: width)
//
//        context?.clip(to: [rect1,rect2,rect3,rect4])
//        context?.drawLinearGradient(gradient!, start: start, end: end, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        
//        //图层渐变色
//        let gradient = CAGradientLayer()
//        gradient.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
//        gradient.startPoint = CGPoint(x: 0, y: 1)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//        gradient.colors = [UIColor.red.cgColor,UIColor.blue.cgColor,UIColor.yellow.cgColor]
//        gradient.locations = [0,0.5,1]
//        gradient.type = CAGradientLayerType(string: "axial") as String
////        gradient.type = CAGradientLayerType(string: "radial") as String
////        gradient.type = CAGradientLayerType(string: "conic") as String
//        self.layer.addSublayer(gradient)
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
