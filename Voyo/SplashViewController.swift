//
//  SplashViewController.swift
//  Voyo
//
//  Created by Mac on 11/15/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func scanAction(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        VC.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(VC, animated: true)
    }
    
    

}
