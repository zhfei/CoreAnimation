//
//  BottomFlagLineButton.swift
//  CoreAnimation
//
//  Created by 周飞 on 2018/12/17.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class BottomFlagLineButton: UIButton {

    private var bottomLayer: CALayer?
    var selectColorHex: String = "3a7ff5"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let btmLayer = bottomLayer {
            btmLayer.isHidden = !self.isSelected
        } else {
            bottomLayer = bottomFlagLine(CGSize(width: 16, height: 3), color: UIColor(hex:selectColorHex))
            self.layer.insertSublayer(bottomLayer!, at: 0)
            bottomLayer?.isHidden = true
        }
//        self.setTitleColor((bottomLayer?.isHidden)! ? UIColor(hex: "9ea4af") : UIColor(hex: selectColorHex) , for: UIControlState.normal)
    }

}

extension UIButton {
    func bottomFlagLine(_ size: CGSize, color: UIColor) -> CALayer {
        let layer = CALayer.init()
        layer.name = "layerName"
        layer.backgroundColor = color.cgColor
        layer.bounds = CGRect.init(origin: CGPoint.zero, size: size)
        layer.position = CGPoint.init(x: self.bounds.width*0.5, y: self.bounds.height - size.height*0.5)
        return layer
    }
}
