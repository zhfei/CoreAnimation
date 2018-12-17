//
//  LabelProgressBar.swift
//  CoreAnimation
//
//  Created by 周飞 on 2018/12/17.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class LabelProgressBar: UILabel {

    private var bottomLayer: CALayer?
    var progressColor:UIColor = UIColor.lightGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubLayer()
        self.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubLayer() {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.red.cgColor
        layer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: self.frame.size.width*0.5, height: self.frame.size.height))
        layer.position = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5)
        self.layer.addSublayer(layer)
    }

}
