//
//  LabelProgressBar.swift
//  CoreAnimation
//
//  Created by 周飞 on 2018/12/17.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class LabelProgressBar: UIView {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var progressWidth: CGFloat = 0.0
    
    private var bottomLayer: CALayer?
    var progressValue_: CGFloat = 0.7
    var progressValue: CGFloat {
        get {
            return progressValue_
        }
        set {
            progressValue_ = newValue
            progressWidth = progressValue_ * width
            maskLayer()
        }
    }
    
    lazy var contextLabel: UILabel = {
        let label = UILabel()
        label.text = "3.96 KB/ 5.57 KB"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    func setText(text: String) {
        contextLabel.text = text
    }
    
    func maskLayer() {
        let temp = CGPoint(x: 0, y: 0)
        let bez = UIBezierPath()
        bez.move(to: temp)
        bez.addLine(to: CGPoint(x: progressWidth, y: 0))
        bez.addArc(withCenter: CGPoint(x: progressWidth, y: height*0.5), radius: height*0.5, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI_2), clockwise: true)
        bez.addLine(to: CGPoint(x: 0, y: height))
        bez.close()
        
        msLayer.path = bez.cgPath
        bottomLayer!.mask = msLayer
    }
    
    lazy var msLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.blue.cgColor
        layer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
        layer.position = CGPoint(x: width*0.5, y: height*0.5)
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let _ = bottomLayer else {
            width = self.frame.size.width
            height = self.frame.size.height
            progressWidth = progressValue_ * width
            
            //初始化gradientLayer并设置相关属性
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor(hex: "7963e6").cgColor, UIColor(hex: "b972d7").cgColor]
            //(I.e. [0,0] is the bottom-left corner of the layer, [1,1] is the top-right corner.)
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            gradientLayer.position = CGPoint(x: width*0.5, y: height*0.5)
            gradientLayer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
            self.layer.insertSublayer(gradientLayer, at: 0)
            bottomLayer = gradientLayer
            
            maskLayer()
            
            self.addSubview(contextLabel)
            contextLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
            self.layer.cornerRadius = height*0.5
            self.layer.masksToBounds = true
            return
        }
    }
}
