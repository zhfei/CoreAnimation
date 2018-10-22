//
//  WipeViewController.swift
//  CoreAnimation
//
//  Created by zhoufei on 2018/10/22.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class WipeViewController: UIViewController {

    @IBOutlet weak var wipeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(wipePanGestureEvent(_:)))
        self.view.addGestureRecognizer(pan)
    }

    func wipePanGestureEvent(_ panGesture: UIPanGestureRecognizer) {
        let nowPoint = panGesture.location(in: self.wipeImageView)
        self.wipeImageView.image = UIImage.zhf_wipeImage(self.wipeImageView, currentPoint: nowPoint)
    }

    

}
