//
//  VoyoResultViewController.swift
//  Voyo
//
//  Created by Mac on 11/15/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import VoyoAPI

class DTCErrorCell: UITableViewCell {
    
    @IBOutlet weak var controllerLbl: UILabel!
    @IBOutlet weak var descriLbl: UILabel!
    
}

class VoyoResultViewController: UIViewController {

    var vehicle : VoyoDevice!
    var auth = String()

    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var odoLbl: UILabel!
    @IBOutlet weak var tirePreLbl: UILabel!
    @IBOutlet weak var vehicleDetailsLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var allData : [VehicleParamGroupID : VehicleParameterGroup]?
    var localParams : [VehicleParamID : VehicleParameter] = [:]
    var dumtotalDTSList = [DtcModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for id in VehicleParamGroupID.LOCAL.getParamsInGroup() {
             let valueA = vehicle.subscribeToLocalParameter(id, maxRate: 1000, period: 30000)!
            vehicle.addNotifyTarget(valueA) {
                
                switch valueA.ID {
                    
                case .VEHICLE_SPEED :
                    var unitsVal = String()
                    if valueA.units?.unitAbbreviation() != nil {
                        unitsVal = (valueA.units?.unitAbbreviation())!
                    }
                    print("Vehilce Speed is : \(valueA.valueAsString) \(unitsVal)")
                    let val = valueA.valueAsString
                    DispatchQueue.main.async(execute: {
                        self.speedLbl.text = val
                        if val == "nil" {
                            self.speedLbl.text = val
                        }
                    })
                    
                case .ODOMETER :
                    var unitsVal = String()
                    if valueA.units?.unitAbbreviation() != nil {
                        unitsVal = (valueA.units?.unitAbbreviation())!
                    }
                    print("Vehilce Speed is : \(valueA.valueAsString) \(unitsVal)")
                    let val = valueA.valueAsString
                    DispatchQueue.main.async(execute: {
                        self.odoLbl.text = "Odometer  : \(val)"
                        if val == "nil" {
                            self.odoLbl.text = ""
                        }
                    })
                    
                case .ABS_BRAKE:
                    break
                case .AC_COMPRESSOR:
                    break
                case .ACCEL_VARIANCE:
                    break
                case .ACCEL_X:
                    break
                case .ACCEL_Y:
                    break
                case .ACCEL_Z:
                    break
                case .ACCELERATOR:
                    break
                case .ALARM:
                    break
                case .AMBIENT_LIGHT:
                    break
                case .AMBIENT_TEMP:
                    break
                case .ANY_DOOR:
                    break
                case .ANY_WINDOW:
                    break
                case .AUTOKEY_ENABLED:
                    break
                case .AUTOKEY_STATE:
                    break
                case .BAROMETER:
                    break
                case .BATT_CHARGE:
                    break
                case .BATT_VOLTAGE:
                    break
                case .BRAKE_PEDAL:
                    break
                case .BRAKE_SWITCH:
                    break
                case .BUFFERED_BYTES:
                    break
                case .BUFFERING:
                    break
                case .CLUTCH_POSITION:
                    break
                case .CLUTCH_STATE:
                    break
                case .CONFIG_STATE:
                    break
                case .CONTROLS_PERMITTED:
                    break
                case .DATA_BUFFERING:
                    break
                case .DRIVER_AIRBAG:
                    break
                case .DRIVER_DOOR:
                    break
                case .DRIVER_LOCK:
                    break
                case .DRIVER_OCCUPANT:
                    break
                case .DRIVER_SC_AIRBAG:
                    break
                case .DRIVER_SEATBELT:
                    break
                case .DRIVER_WINDOW:
                    break
                case .DTC_COUNT:
                    break
                case .ENGINE_COOLANT:
                    break
                case .ENGINE_IFE:
                    break
                case .ENGINE_LOAD:
                    break
                case .ENGINE_MAF:
                    break
                case .ENGINE_MAP:
                    break
                case .ENGINE_RPM:
                    break
                case .ENGINE_RUNNING:
                    break
                case .ERROR_BITS_H:
                    break
                case .ERROR_BITS_L:
                    break
                case .FCA:
                    break
                case .FL_TIRE_PRESSURE:
                    break
                case .FOG_LIGHTS:
                    break
                case .FR_TIRE_PRESSURE:
                    break
                case .FUEL_LEVEL:
                    break
                case .GPS_ALTITUDE:
                    break
                case .GPS_FIX_MODE:
                    break
                case .GPS_HEADING:
                    break
                case .GPS_LATITUDE:
                    break
                case .GPS_LONGITUDE:
                    break
                case .GPS_SATELLITES:
                    break
                case .GPS_SPEED:
                    break
                case .HAZARDS:
                    break
                case .HEADLIGHT_SWITCH:
                    break
                case .HEADLIGHTS:
                    break
                case .HOOD:
                    break
                case .HORN:
                    break
                case .IMMOBILIZER_ENABLED:
                    break
                case .IMPACT:
                    break
                case .INTAKE_TEMP:
                    break
                case .INTERIOR_LIGHT:
                    break
                case .KEY_POSITION:
                    break
                case .LOCK_CONTROLS:
                    break
                case .MINUTES_ON:
                    break
                case .OBD_SERIAL:
                    break
                case .OIL_LIFE:
                    break
                case .OIL_PRESSURE:
                    break
                case .PARKING_BRAKE:
                    break
                case .PASS_AIRBAG:
                    break
                case .PASS_DOOR:
                    break
                case .PASS_LOCK:
                    break
                case .PASS_OCCUPANT:
                    break
                case .PASS_SC_AIRBAG:
                    break
                case .PASS_SEATBELT:
                    break
                case .PASS_WINDOW:
                    break
                case .PROPULSION_ACTIVE:
                    break
                case .RL_AIRBAG:
                    break
                case .RL_DOOR:
                    break
                case .RL_LOCK:
                    break
                case .RL_OCCUPANT:
                    break
                case .RL_SC_AIRBAG:
                    break
                case .RL_SEATBELT:
                    break
                case .RL_TIRE_PRESSURE:
                    break
                case .RL_WINDOW:
                    break
                case .RR_AIRBAG:
                    break
                case .RR_DOOR:
                    break
                case .RR_LOCK:
                    break
                case .RR_OCCUPANT:
                    break
                case .RR_SC_AIRBAG:
                    break
                case .RR_SEATBELT:
                    break
                case .RR_TIRE_PRESSURE:
                    break
                case .RR_WINDOW:
                    break
                case .SGEE_LOADED_ID:
                    break
                case .SGEE_LOADING:
                    break
                case .SHIFTER_GEAR:
                    break
                case .SLEEP_STATE:
                    break
                case .STABILITY:
                    break
                case .STEERING_ANGLE:
                    break
                case .STOPPED_DURATION:
                    break
                case .TIMESTAMP:
                    break
                case .TRACTION:
                    break
                case .TRANS_GEAR:
                    break
                case .TRIP_ACTIVE:
                    break
                case .TRIP_COUNT:
                    break
                case .TRIP_DISTANCE:
                    break
                case .TRIP_DURATION:
                    break
                case .TRIP_IDLE_SAVED:
                    break
                case .TRIP_IFE_SUM:
                    break
                case .TRIP_MAF_SUM:
                    break
                case .TRIP_MAP_RPM_SUM:
                    break
                case .TRUNK:
                    break
                case .TRUNK_CONTROL:
                    break
                case .TRUNK_LOCK:
                    break
                case .TRUNK_WINDOW:
                    break
                case .TURN_SIGNALS:
                    break
                case .VIN:
                    break
                case .WIPERS_SPEED:
                    break
                case .WIPERS_STATE:
                    break
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scan(vehicle)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    
        self.vehicle.disableAllLocalParameters()
    }
    
}

extension VoyoResultViewController : UITableViewDelegate, UITableViewDataSource {
    func scan(_ data: VoyoDevice) {
        dumtotalDTSList = []
        apiManager.activateScanPro(auth, "\(data.deviceSerial)", { (vehicle1, error) in
            if error == .Success {
                let vin = vehicle1?.vin ?? ""
                let vehicleDetails = (vehicle1!.year ?? "") + (vehicle1!.make ?? "")! + (vehicle1!.model ?? "")!
                self.vehicleDetailsLbl.text = "VIN : \(vin)\n\(vehicleDetails)"
                
                for controller in (vehicle1?.controllerList)! {
                    let VoyoController = VOYOControllerModel()
                    VoyoController.address = controller.address ?? 0
                    VoyoController.request_id = controller.request_id ?? 0
                    VoyoController.name = controller.name ?? ""
                    VoyoController.response = controller.response ?? ""
                    VoyoController.bus = controller.bus ?? ""
                    VoyoController.show = controller.show ?? false
                    VoyoController.vin = vehicle1?.vin ?? ""
                    
                    for dtc in controller.dtcList {
                        let voyodtc = DtcModel()
                        voyodtc.id = dtc.id ?? 0
                        voyodtc.start_time = dtc.start_time ?? 0
                        voyodtc.end_time = dtc.end_time ?? 0
                        voyodtc.dtc_number = dtc.dtc_number ?? 0
                        voyodtc.synptom = dtc.symptom ?? 0
                        voyodtc.response = dtc.response ?? ""
                        voyodtc.active = dtc.active ?? false
                        voyodtc.pending = dtc.pending ?? false
                        voyodtc.history = dtc.history ?? false
                        voyodtc.light = dtc.light ?? false
                        voyodtc.dtc_name = dtc.dtc_name ?? ""
                        voyodtc.short_description = dtc.short_description ?? ""
                        voyodtc.long_descriptipn = dtc.long_description ?? ""
                        voyodtc.severity = dtc.severity ?? 0
                        voyodtc.address = controller.address ?? 0
                        voyodtc.vin = vehicle1?.vin ?? ""
                        voyodtc.controllerName = controller.name ?? ""
                        self.dumtotalDTSList.append(voyodtc)
                       
                        VoyoController.dtclist.append(voyodtc)
                    }
                }
                
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dumtotalDTSList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DTCErrorCell", for: indexPath) as! DTCErrorCell
        let data = dumtotalDTSList[indexPath.row]
        cell.controllerLbl.text = "Controller : \(data.controllerName)"
        cell.descriLbl.text = "\(data.dtc_name) - \(data.short_description == "" ? ("Short description as EMPTY"): (data.short_description))"
        
        return cell
    }
    
}


class DtcModel: NSObject {
    var id = Int()
    var start_time = Int64()
    var end_time = Int64()
    var dtc_number = Int()
    var synptom = Int()
    var response = String()
    var active = Bool()
    var pending = Bool()
    var history = Bool()
    var light = Bool()
    var dtc_name = String()
    var short_description = String()
    var long_descriptipn = String()
    var severity = Int()
    var vin = String()
    var address = Int()
    var controllerName = String()
}

class VOYOControllerModel: NSObject {
    var address = Int()
    var request_id = Int()
    var name = String()
    var response = String()
    var bus = String()
    var show = Bool()
    var vin = String()
    var dtclist = [DtcModel]()
}

class VoyoVehicleModel: NSObject {
    var date = Date()
    var serial = String()
    var vin = String()
    var make = String()
    var model = String()
    var year = String()
    var odometer = Double()
    var total_codes = Int()
    var total_controllers = Int()
    var controllerList = [VOYOControllerModel]()
}
