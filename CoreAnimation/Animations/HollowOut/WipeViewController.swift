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
    
    var _sizeStartP: CGPoint = CGPoint(x: 0, y: 0)
    var oldSize: CGSize = CGSize(width: 0, height: 0)
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(wipePanGestureEvent(_:)))
        self.view.addGestureRecognizer(pan)
    }

    func wipePanGestureEvent(_ panGesture: UIPanGestureRecognizer) {
//        let nowPoint = panGesture.location(in: self.wipeImageView)
//        self.wipeImageView.image = UIImage.zhf_wipeImage(self.wipeImageView, currentPoint: nowPoint)
        
        switch panGesture.state {
        case UIGestureRecognizerState.began:
            _sizeStartP = panGesture.location(in: self.wipeImageView)
            oldSize = self.wipeImageView.bounds.size
        case UIGestureRecognizerState.changed:
            let curP = panGesture.location(in: self.wipeImageView)
            
            let w = curP.x - _sizeStartP.x
            let h = curP.y - _sizeStartP.y
            
            self.width = oldSize.width + w
            self.height = oldSize.height + h
            
        case UIGestureRecognizerState.ended:
            UIImage.zhf_cutScreenWithView(self.wipeImageView, cutFrame: CGRect(x: _sizeStartP.x, y: _sizeStartP.y, width: self.width, height: self.height)) { (image, data) in
                self.wipeImageView.image = image
            }
            
        default:
            print("---")
        }
        
    }

    

}
