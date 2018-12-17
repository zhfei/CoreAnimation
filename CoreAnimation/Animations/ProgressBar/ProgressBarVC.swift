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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        setupUI()
    }
    

    
    
    // MARK: - Event
    
    // MARK: - Getter, Setter
    
    // MARK: - Public Method
    
    // MARK: - Private Method
    func setupData() {
        
    }
    
    func setupUI() {
        let label = LabelProgressBar(frame: CGRect(x: 20, y: 100, width: 200, height: 20))
        label.text = "账户未登录"
        label.textColor = UIColor(hex: "6a6a77")
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "PingFangSC-Regular", size: 16)
        label.addSubLayer()
        self.view.addSubview(label)
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
