//
//  HollowOutVC.swift
//  CoreAnimation
//
//  Created by zhoufei on 2018/10/17.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class HollowOutVC: UIViewController {

    @IBOutlet weak var progressView: PartArcView!
    @IBAction func sliderAction(_ sender: UISlider) {
        self.progressView.progressValue = CGFloat(sender.value)
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(goToWipe))
        
        self.navigationItem.setRightBarButton(rightItem, animated: true)
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        PanView.showInVC()
    }
    
    @objc func goToWipe() {
        self.navigationController?.pushViewController(WipeViewController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.bgImageView.image = UIImage.zhf_waterImage("cheat", waterText: "这里是水印！！", rect: self.bgImageView.bounds)
//        self.bgImageView.image = UIImage.zhf_waterImage("cheat", rect: self.bgImageView.bounds, waterImageName: "cheat", waterRect: CGRect(x: 20, y: 20, width: 100, height: 100))
//        self.bgImageView.image = UIImage.zhf_clipCircleImage("BigPic2", rect: self.bgImageView.bounds, circleRect: CGRect(x: 100, y: 20, width: 80, height: 80))
//        self.bgImageView.image = UIImage.zhf_clipCircleImage("BigPic2", rect: self.bgImageView.bounds, circleRect: CGRect(x: 100, y: 20, width: 80, height: 80), borderWidth: 5, borderColor: UIColor.blue)
        
        UIImage.zhf_cutScreenWithView(self.view) {image,data in
            self.bgImageView.image = image
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
