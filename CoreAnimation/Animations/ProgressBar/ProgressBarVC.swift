//
//  ProgressBarVC.swift
//  CoreAnimation
//
//  Created by 周飞 on 2018/11/20.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class ProgressBarVC: UIViewController {
    // MARK: - Life Cycle

    @IBOutlet weak var upProgress: LabelProgressBar!
    @IBOutlet weak var downProgress: PartArcView!
    
    @IBAction func changeValue(_ sender: UISlider) {
        if sender.tag == 100 {
            upProgress.progressValue = CGFloat(sender.value)
        } else {
            downProgress.progressValue = CGFloat(sender.value)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
//        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let label = LabelProgressBar(frame: CGRect(x: 20, y: 100, width: 200, height: 20))
//        label.text = "账户未登录"
//        label.textColor = UIColor(hex: "6a6a77")
//        label.textAlignment = NSTextAlignment.center
//        label.font = UIFont(name: "PingFangSC-Regular", size: 16)
//        label.backgroundColor = UIColor.lightGray
//        self.view.addSubview(label)
//
//        let layer = CAShapeLayer()
//        layer.backgroundColor = UIColor.red.cgColor
//        layer.bounds = CGRect(x: 0, y: 0, width: 200, height: 20)
//        label.layer.addSublayer(layer)
        
        print("...")
    }
    
    
    // MARK: - Event
    
    // MARK: - Getter, Setter
    
    // MARK: - Public Method
    
    // MARK: - Private Method
    func setupData() {
        
    }
    
    func setupUI() {
        let label = LabelProgressBar(frame: CGRect(x: 20, y: 100, width: 200, height: 20))
        self.view.addSubview(label)
        
        let widthV = self.view.frame.size.width
        let heightV = self.view.frame.size.height
        
        
        var progressView = PartArcView(frame: CGRect(x: 10, y: 200, width: widthV-20, height: 200))
        self.view.addSubview(progressView)
    }
    
    func resetData() {
        
    }
    
    func resetUI() {
        
    }
    
    // MARK: - Delegate
    
    // MARK: - NSCopying
    
    // MARK: - NSObject
    
    // MARK: - Extension


}
