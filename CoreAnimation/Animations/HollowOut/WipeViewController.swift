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
    @IBOutlet weak var topView: BorderView!
    
    var _sizeStartP: CGPoint = CGPoint(x: 0, y: 0)
    var oldSize: CGSize = CGSize(width: 0, height: 0)
    var width: CGFloat = 0
    var height: CGFloat = 0
    var targetR: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(wipePanGestureEvent(_:)))
        self.view.addGestureRecognizer(pan)
    }

    @objc func wipePanGestureEvent(_ panGesture: UIPanGestureRecognizer) {
//        let nowPoint = panGesture.location(in: self.wipeImageView)
//        self.wipeImageView.image = UIImage.zhf_wipeImage(self.wipeImageView, currentPoint: nowPoint)
        
        switch panGesture.state {
        case UIGestureRecognizer.State.began:
            _sizeStartP = panGesture.location(in: self.wipeImageView)
            oldSize = self.wipeImageView.bounds.size
        case UIGestureRecognizer.State.changed:
            let curP = panGesture.location(in: self.wipeImageView)

            let w = curP.x - _sizeStartP.x
            let h = curP.y - _sizeStartP.y

            self.width = oldSize.width + w
            self.height = oldSize.height + h

            targetR = CGRect(x: _sizeStartP.x, y: _sizeStartP.y, width: w, height: h)
            self.topView.targetRect = targetR

        case UIGestureRecognizer.State.ended:
            UIImage.zhf_cutScreenWithView(self.wipeImageView, cutFrame: targetR) { (image, data) in
                self.wipeImageView.image = image
                self.topView.targetRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            }

        default:
            print("---")
        }
        
    }

    

}
