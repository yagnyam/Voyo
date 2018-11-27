//
//  LoginViewViewController.swift
//  Voyo
//
//  Created by Mac on 10/1/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import VoyoAPI

class LoginViewViewController: UIViewController {

    @IBOutlet weak var userTf: UITextField!
    @IBOutlet weak var passTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        updatePref(key: "UserName", value: userTf.text!)
        updatePref(key: "Password", value: passTf.text!)
        let UserName = userTf.text!
        let Password = passTf.text!
        showOverlay()
        apiManager.getUserAccountsManager().loginToAccount(UserName, password: Password, callback: { (user, error) -> () in
            hideOverlayView()
            DispatchQueue.main.async(execute: { () -> Void in
                if error == .Success {
                    self.navigationController?.popViewController(animated: true)
                }else {
                    simpleAlert(message: "Please enter the valid user details")
                }
            })
        })
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        
        
    }

}
