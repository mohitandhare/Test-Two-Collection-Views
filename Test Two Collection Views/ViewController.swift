//
//  ViewController.swift
//  Test Two Collection Views
//
//  Created by Developer Skromanglobal on 22/07/22.
//

import UIKit
import NeumorphismKit
import Alamofire
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var managedObjextContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var OnecollectionView: UICollectionView!
    
    let one_array = ["1","2","3","4"]
    
    var light_value = ["1","0","1","0"]
    
    var device_state_list_load = [DeviceState]()
    
    var dest_button_array = [String]()
    var config_dim_array = [String]()
    var config_button_array = [String]()
    var master_array = [String]()
    var l_state_array = [String]()
    var l_speed_array = [String]()
    var f_state_array = [String]()
    var f_speed_array = [String]()
    
    var increase_dest_button = [String]()
    
    var final_array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        
        
        Get_device_state()
        
        OnecollectionView.delegate = self
        OnecollectionView.dataSource = self
        OnecollectionView.reloadData()
        
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(RefreshButton))
        
        
        
    }
    
    @objc func RefreshButton() {
        Get_device_state()
        OnecollectionView.reloadData()
    }
    
    //MARK: ===== SAVE TO CORE DATA =====
    
    func SaveData() {
        do {
            
            try managedObjextContext.save()
        }
        catch {
            print("Error To Save Data")
        }
    }
    
    
    
    //MARK: ===== DELETE DEVICE DATA FROM CORE DATA =====
    func DeleteDeviceDataFunc() {
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "DeviceState")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReq)
        
        do {
            try managedObjextContext.execute(deleteRequest)
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
    func device_state_Fetch() {
        
        let request = DeviceState.fetchRequest()
        
        do {
        
            device_state_list_load = try managedObjextContext.fetch(request)
            
            
            
            DispatchQueue.main.async { [self] in
                
                
                
                
            }
        }
        
        catch {
            print(error.localizedDescription)
            
        }
    }


}


extension ViewController {
    
    func Get_device_state() {
        
        let device_parameters : Parameters = [
            
            "unique_id": "SKSL_1xGLn8"
        ]
        
        AF.request("http://3.7.18.55:3000/skroman/devicestate/unique_id", method: .post, parameters: device_parameters, encoding: JSONEncoding.default, headers:  nil).response { [self] response in
            
            
            switch response.result {
                
            case .success(let data):
                
                
                do {
                    
                    let jsonOne = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if
                        
                        let parseJson = jsonOne,
                        let result = parseJson["result"] as? NSDictionary,
//                        let deviceStateUid = result["deviceStateUid"] as? String,
                        let deviceUid = result["deviceUid"] as? String,
                        let unique_id = result["unique_id"] as? String,
                        let modelNo = result["modelNo"] as? String,
                        let dest_button = result["dest_button"] as? String,
                        let config_dim = result["config_dim"] as? String,
                        let config_buttons = result["config_buttons"] as? String,
                        let master = result["master"] as? String,
                        let L_state = result["L_state"] as? String,
                        let L_speed = result["L_speed"] as? String,
                        let F_state = result["F_state"] as? String,
                        let F_speed = result["F_speed"] as? String
                            
                            
                        
                    {
                        
                        let saveDeviceStateList = DeviceState(context: self.managedObjextContext)
                        
                        
                        saveDeviceStateList.deviceUid = deviceUid
                        saveDeviceStateList.unique_id = unique_id
                        saveDeviceStateList.modelNo = modelNo
                        saveDeviceStateList.dest_button = dest_button
                        saveDeviceStateList.config_dim = config_dim
                        saveDeviceStateList.config_buttons = config_buttons
                        saveDeviceStateList.master = master
                        saveDeviceStateList.l_state = L_state
                        saveDeviceStateList.l_speed = L_speed
                        saveDeviceStateList.f_state = F_state
                        saveDeviceStateList.f_speed = F_speed
                        
                        let Separate_Dest_Button = dest_button.map(String.init)
                        
                        for separate_dest_button in Separate_Dest_Button {
                            dest_button_array.append(separate_dest_button)
                        }
                        
                        
                        //-------------------------------------------------------
                        
                        let Separate_Config_Dim = config_dim.map(String.init)
                       
                        for seprate_config_dim in Separate_Config_Dim {
                            config_dim_array.append(seprate_config_dim)
                        }
                        //-------------------------------------------------------
                       
                        let Separate_Config_Button = config_buttons.map(String.init)
                        
                        for separate_config_button in Separate_Config_Button {
                            config_button_array.append(separate_config_button)
                        }
                        //-------------------------------------------------------
                        
                        let separate_master = master.map(String.init)
                        
                        for Separate_Master in separate_master {
                            master_array.append(Separate_Master)
                        }
                        //-------------------------------------------------------
                        let Separate_L_State = L_state.map(String.init)
                        
                        for separate_l_state in Separate_L_State {
                            l_state_array.append(separate_l_state)
                        }
                        
                        final_array.append(contentsOf: l_state_array)
                        final_array.append(contentsOf: master_array)
                        dest_button_array.append(contentsOf: master_array)
                        config_button_array.append(contentsOf: master_array)
                        
                        
                        
                        //-------------------------------------------------------
                        
                        let Separate_L_Speed = L_speed.map(String.init)
                        
                        for separate_l_speed in Separate_L_Speed {
                            l_speed_array.append(separate_l_speed)
                        }
                        //-------------------------------------------------------
                        
                        
                        if F_state == "N/A" {
                        }
                        
                        else if F_state == "1" {
                            f_state_array.append(F_state)
                           }
                        
                        else {
                            let Separate_F_State = F_state.map(String.init)
                            
                            for separate_f_state in Separate_F_State {
                                f_state_array.append(separate_f_state)
                            }
                            
                        }
//                        final_array.append(contentsOf: f_state_array)
//                        dest_button_array.append(contentsOf: f_state_array)
//                        config_button_array.append(contentsOf: f_state_array)
                        
                        
                        
                        print("MY L STATE NEW :>>",final_array)
                        //-------------------------------------------------------
                        
                        let Separate_F_Speed = F_speed.map(String.init)
                        
                        for separate_f_speed in Separate_F_Speed {
                            
                            f_speed_array.append(separate_f_speed)
                            
                        }
                    }
                    
                    self.DeleteDeviceDataFunc()
                    self.SaveData()
                    self.device_state_Fetch()
                    self.OnecollectionView.reloadData()
                    
                    
                }
                
                catch {
                    print("Error")
                }
            case .failure(_):
                print("ERROR")
            }
        }
        
        
    }
}

extension ViewController {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return final_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneCell", for: indexPath) as! OneCollectionViewCell
        
        cell.light_number.text = dest_button_array[indexPath.row]
        cell.on_off_value = final_array[indexPath.row]
        cell.config_button_value = config_button_array[indexPath.row]
        
        
        cell.master_value = final_array.last
        
//        let size = final_array.count
//        cell.fan_value = final_array[size-3]
//
        
        if cell.master_value == "1" {
            cell.initial_values_label.isHidden = true
            cell.light_number.isHidden = true
            cell.on_off_image.isHidden = true
            cell.config_button_image.image = UIImage(named: "master")
        }
        
    
       
        
        
        
        // == ON/OFF IMAGE VIA VALUE ==
        
        if cell.on_off_value == "1" {
            
            
            cell.on_off_image.layer.cornerRadius = cell.on_off_image.frame.height/2
            cell.on_off_image.backgroundColor = UIColor.green
        }
        
        else {
            
            cell.on_off_image.layer.cornerRadius = cell.on_off_image.frame.height/2
            cell.on_off_image.backgroundColor = UIColor.red
            
        }
        

        
        // == CONFIG BUTTON WHAT IMAGE IS ( LIGHT, DOOR, CURTAINS )
        
        if cell.config_button_value == "L" {
           
            cell.on_off_image.isHidden = false
            cell.initial_values_label.isHidden = false
            cell.light_number.isHidden = false
            cell.initial_values_label.text = "L"
            cell.config_button_image.image = UIImage(named: "Light")
        }
        
        else if cell.config_button_value == "D" {
            
            cell.on_off_image.isHidden = true
            cell.initial_values_label.text = "D"
            cell.config_button_image.image = UIImage(named: "Door")
        }
        
        else if cell.config_button_value == "C" {
            
            cell.on_off_image.isHidden = true
            cell.initial_values_label.text = "C"
            cell.config_button_image.image = UIImage(named: "Cutains_Close")
        }
        
        else if cell.config_button_value == "M" {
            
            cell.on_off_image.isHidden = true
            cell.initial_values_label.text = "M"
            cell.config_button_image.image = UIImage(named: "master")
        }
        
        
        return cell
    }
    
}
