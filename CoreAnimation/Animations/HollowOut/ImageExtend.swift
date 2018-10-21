//
//  ImageExtend.swift
//  CoreAnimation
//
//  Created by 周飞 on 2018/10/21.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    
    static func zhf_drawImageWithImageNamed(_ name: String) -> UIImage {
        let image = UIImage(named: name)
        UIGraphicsBeginImageContext((image?.size)!)
        image?.draw(in: CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage!
    }
    
    static func zhf_waterImage(_ name: String, waterText:NSString, rect: CGRect) -> UIImage {
        let image = UIImage(named: name)
//        let rect = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 1)
        image?.draw(in: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        
        let att = [NSFontAttributeName:UIFont(name: "PingFang SC", size: 15),
                  NSForegroundColorAttributeName:UIColor.red]
        waterText.draw(at: CGPoint(x: rect.size.width*0.1, y: rect.size.height*0.1), withAttributes: att)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    static func zhf_waterImage(_ name: String, rect: CGRect, waterImageName:String, waterRect:CGRect) -> UIImage {
        let image = UIImage(named: name)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 1)
        image?.draw(in: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        let waterImage = UIImage(named: waterImageName)
        waterImage?.draw(in: waterRect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    static func zhf_clipCircleImage(_ name: String, rect: CGRect, circleRect:CGRect) -> UIImage {
        let image = UIImage(named: name)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 1)
        
        let bez = UIBezierPath(ovalIn: circleRect)
        bez.addClip()
        
        image?.draw(in: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    static func zhf_clipCircleImage(_ name: String, rect: CGRect, circleRect:CGRect, borderWidth:CGFloat, borderColor:UIColor) -> UIImage {
        let image = UIImage(named: name)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 1)
        
        let bez = UIBezierPath(ovalIn: circleRect)
        borderColor.setFill()
        bez.fill()
        
        let bez1 = UIBezierPath(ovalIn: CGRect(x: circleRect.origin.x+borderWidth, y: circleRect.origin.y+borderWidth, width: (circleRect.size.width-borderWidth*2), height: (circleRect.size.height-borderWidth*2)))
        bez1.addClip()
        
        image?.draw(in: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}
