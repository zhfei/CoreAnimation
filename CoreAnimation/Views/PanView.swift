//
//  PanView.swift
//  CoreAnimation
//
//  Created by 周飞 on 2018/11/7.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class PanView: UIView {

    lazy var replicator: CAReplicatorLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        shapeLayer.position = CGPoint(x: self.bounds.size.width*0.5, y: self.bounds.size.height*0.5)
        shapeLayer.cornerRadius = 5
        shapeLayer.backgroundColor = UIColor.red.cgColor
        let anim1 = CABasicAnimation(keyPath: "transform")
        let trans1 = CATransform3DMakeScale(5, 5, 1)
        anim1.toValue = NSValue(caTransform3D: trans1)
        
        let anim2 = CABasicAnimation(keyPath: "opacity")
        anim2.toValue = 0
        
        let animGroup = CAAnimationGroup()
        animGroup.animations = [anim1,anim2]
        animGroup.repeatCount = MAXFLOAT
        animGroup.duration = 2
        animGroup.isRemovedOnCompletion = false
        shapeLayer.add(animGroup, forKey: nil)
        
        let replicator = CAReplicatorLayer()
        replicator.borderWidth = 1
        replicator.borderColor = UIColor.blue.cgColor
        replicator.bounds = self.bounds
        replicator.position = CGPoint(x: self.bounds.size.width*0.5, y: self.bounds.size.height*0.5)
        replicator.instanceCount = 2
        replicator.instanceDelay = 0.5
        replicator.addSublayer(shapeLayer)
        self.layer.addSublayer(replicator)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        self.gestureRecognizers = [tap,pan]
        
        self.lastLocation = self.center
        self.backgroundColor = UIColor.lightGray
        return replicator
    }()
    
    let text: NSString = "点击我"
    var lastLocation: CGPoint?
    let titles = ["选项一","选项一"]
    static var showed: Bool = false
    
    override func draw(_ rect: CGRect) {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.black,
                     NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)]
        
        text.draw(in: rect, withAttributes: attrs)
    }
    
    override func layoutSubviews() {
        _ = replicator
    }
    
    
    @objc func tapAction(_ recognizer: UITapGestureRecognizer) {
        print("点击了。。。")
        
        let alert = UIAlertController(title: "种类选择", message: "选择说明", preferredStyle: UIAlertController.Style.actionSheet);
        for title in titles {
            let alertAction = UIAlertAction(title: title, style: UIAlertAction.Style.default) { (action) in
                print("选中内容：\(action.title)")
            }
            alert.addAction(alertAction)
        }
        let root = UIApplication.shared.keyWindow?.rootViewController
        root?.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func panAction(_ recognizer:UIPanGestureRecognizer) {
        let trans = recognizer.translation(in: self.superview)
        switch recognizer.state {
        case .changed:
            self.center = CGPoint(x:(lastLocation?.x)!+trans.x, y: (lastLocation?.y)!+trans.y)
        case .ended:
            lastLocation = self.center
        default:
            print("recognizer.state: \(recognizer.state)")
        }
    }
    
    class func showInVC() {
        var window: UIView?
        if !PanView.showed {
            let app: UIApplicationDelegate = UIApplication.shared.delegate!
            window = app.window!
            
            let randowX = arc4random_uniform(UInt32(UIScreen.main.bounds.size.width - 44))
            let randowY = arc4random_uniform(UInt32(64))
            let swichView = PanView(frame: CGRect(x: Int(randowX), y: Int(randowY), width: 50, height: 50))
            swichView.backgroundColor = .white
            
            window?.addSubview(swichView)
            window?.bringSubviewToFront(swichView)
            PanView.showed = true
        } else {
            
        }
    }

}
