//
//  HollowOutVC.swift
//  CoreAnimation
//
//  Created by zhoufei on 2018/10/17.
//  Copyright © 2018年 ChenDao. All rights reserved.
//

import UIKit

class HollowOutVC: UIViewController {

    @IBOutlet weak var progressView: ProgressView!
    @IBAction func sliderAction(_ sender: UISlider) {
        self.progressView.progressValue = CGFloat(sender.value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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
