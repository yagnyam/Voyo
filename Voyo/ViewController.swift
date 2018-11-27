//
//  ViewController.swift
//  Voyo
//
//  Created by Mac on 10/1/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import VoyoAPI
import CoreBluetooth


class DeviceCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var btnLbl: UILabel!
    
}

class ViewController: UIViewController, CBCentralManagerDelegate {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    var linkedDeviceArr = [VoyoDevice!]()
    var auth = String()
    var userDetails: VoyoUserAccount!
    
    var manager:CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager = VoyoAPIManager(Environment.Prod).getAPI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            showOverlay()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.loginAction()
            }
            break
        case .poweredOff:
            print("Bluetooth is Off.")
            simpleAlert(message: "Please turn in Bluetooth")
            break
        case .resetting:
            break
        case .unauthorized:
            break
        case .unsupported:
            break
        case .unknown:
            break
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let UserName = getPrefName(key: "UserName", value: "")
        let Password = getPrefName(key: "Password", value: "")
    
        if UserName == "" {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewViewController") as! LoginViewViewController
            VC.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(VC, animated: true)
            
        }else {
            manager = CBCentralManager()
            manager.delegate = self
            
        }
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        loginAction()
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        showOverlay()
        loginAction()
    }
    
    @IBAction func addAction(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        VC.auth = self.auth
        VC.userDetails = self.userDetails
        self.navigationController!.pushViewController(VC, animated: true)
    }
    
    func loginAction() {
        let UserName = getPrefName(key: "UserName", value: "")
        let Password = getPrefName(key: "Password", value: "")
        
        apiManager.getUserAccountsManager().loginToAccount(UserName, password: Password, callback: { (user, error) -> () in
            hideOverlayView()
            DispatchQueue.main.async(execute: { () -> Void in
                if error == .Success {
                    print(user!.firstName)
                    self.linkedDeviceArr = []
                    self.nameLbl.text = user!.name.capitalized
                    for device in user!.linkedDevices {
                        self.linkedDeviceArr.append(device)
                    }
                    self.userDetails = user!
                    let authToken = user?.authToken
                    if authToken != nil {
                        var authTokenString = ""
                        for char in authToken! {
                            // Formats UInt8 into hex string with leading 0
                            authTokenString.append(String(format: "%02x", char))
                        }
                        self.auth = authTokenString
                    }
//                    self.loginBtn.isHidden = true
                }else {
//                    self.loginBtn.isHidden = false
                }
                self.tableView.reloadData()
            })
        })
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linkedDeviceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DeviceCell
        let data = linkedDeviceArr[indexPath.row]
        cell.nameLbl.text = data?.name.capitalized
        cell.btnLbl.backgroundColor = UIColor.red
        print(data?.state)
        print(data?.connected)
        
        if data?.connected == .Connected {
            cell.btnLbl.backgroundColor = UIColor.green
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = linkedDeviceArr[indexPath.row]
//        registerDevice(data)
//        if data.connected == .Connected {
        self.scan(data!)
//        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scan(_ data: VoyoDevice) {
        
        
        apiManager.activateScanPro(auth, "\(data.deviceSerial)", { (vehicle, error) in
            
            if error == .Success {
                
//                let VP = data.requestLocalParameter(VehicleParamID.VEHICLE_SPEED)
//                print(VP?.valueAsString)
                
                let vin = vehicle?.vin ?? ""
                //                    self.detailsLbl.text = "\(email)\n\(firstName)\n\(lastName)\nVIN : \(vin)"
//                print("make : \(vehicle?.make)\nModel : \(vehicle?.model)Year : \n\(vehicle?.year)\nVIN : \(vin)")
                
                let alert = UIAlertController(title: "Vehicle Details", message: "Make : \(vehicle!.make ?? "")\nModel : \(vehicle!.model ?? "")\nYear : \(vehicle!.year ?? "")\nVIN : \(vin)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "VoyoResultViewController") as! VoyoResultViewController
                    VC.hidesBottomBarWhenPushed = true
                    VC.vehicle = data
                    VC.auth = self.auth
                    self.navigationController!.pushViewController(VC, animated: true)
                    
                    }))
                self.present(alert, animated: true, completion: nil)
                
                //                    for data in (vehicle?.controllerList)! {
                //
                //                        for code in data.dtcList {
                //                            self.detailsLbl.text = "\(email)\n\(firstName)\n\(lastName)\nVIN : \(vin)\nDTC : \(code.long_description)"
                //
                //                        }
                //
                //
                //                    }
                
            }
            
        })
        
    }
    
    func registerDevice() {
        
        apiManager.getVoyoDeviceManager().scanForDevice { (DeviceIdentifier, error) in
            
            if error == .Success {
                
                apiManager.getVoyoDeviceManager().registerDevice(DeviceIdentifier!, serial: "B3KV-ZXC9", user: self.userDetails , callback: { (VoyoDevice, Error) in
                    
                    if Error == .Success {
                        let deviceSerial = VoyoDevice?.deviceSerial
                        apiManager.activateScanPro(self.auth, deviceSerial!, { (vehicle, error) in
                            if error == .Success {
                                
                            }
                        })
                    }
                })
            }
        }
    }
    
}





