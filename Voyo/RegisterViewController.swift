//
//  RegisterViewController.swift
//  Voyo
//
//  Created by Mac on 10/4/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import KDPulseButton
import VoyoAPI

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scanBtn: KDPulseButton!
    var userDetails : VoyoUserAccount!
    var screenRect: CGRect = UIScreen.main.bounds
    var auth = String()
    var accessoryView: VSNumberKeyboardAccessoryView?

    override func viewDidLoad() {
        super.viewDidLoad()
        scanBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startScanForDevice()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanAction(_ sender: KDPulseButton) {
        startScanForDevice()
    }
    
    func startScanForDevice() {
        scanBtn.startAnimation()
        scanBtn.isEnabled = false
        
        apiManager.getVoyoDeviceManager().scanForDevice { (device, error) in

            if error == .Success {
                self.stopAntion()
                
                // is there any scope for detect two not register devices at time
                self.showAlertToGetSerialNumber(device!, "", self.userDetails)

            }else {
                simpleAlert(message: error.description)
                self.stopAntion()
            }
        }
    }
    
    func showAlertToGetSerialNumber(_ identifider: DeviceIdentifier, _ serial: String, _ user: VoyoUserAccount) {
        
            let alertController = UIAlertController(title: "", message: "Please Enter VOYO Device Serial Number", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
                if let TF = alertController.textFields?[0] {
                    showOverlay()
                    apiManager.getVoyoDeviceManager().registerDevice(identifider, serial: TF.text!, user: user , callback: { (VoyoDevice, Error) in
                        if Error == .Success {
                            let deviceSerial = VoyoDevice?.deviceSerial
                            apiManager.activateScanPro(self.auth, deviceSerial!, { (vehicle, error) in
                                if error == .Success {
                                    
                                    self.navigationController?.popViewController(animated: true)
                                    
                                }else {
                                    hideOverlayView()
                                    simpleAlert(message: error.localizedDescription)
                                }
                            })
                        }else {
                            hideOverlayView()
                            simpleAlert(message: Error.description)
                        }
                    })
                    
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = ""
                textField.autocorrectionType = .no
                self.accessoryView = VSNumberKeyboardAccessoryView(textInput: textField)
                textField.inputAccessoryView = self.accessoryView
                textField.autocapitalizationType = .allCharacters
                textField.delegate = self
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if (newText?.count ?? 0) > 0 {
            
                let currentText = textField.text ?? ""
                let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
                return true
            
        }
        return true
        
    }
    
    func stopAntion() {
        DispatchQueue.main.async(execute: { () -> Void in
            self.scanBtn.isEnabled = true
            self.scanBtn.stopAnimation()
        })
        
    }


}
