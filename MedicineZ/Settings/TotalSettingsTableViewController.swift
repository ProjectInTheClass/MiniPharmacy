//
//  TotalSettingsTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 13/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit
import UserNotifications
class TotalSettingsTableViewController: UITableViewController {

//    var alarmGranted = UserDefaults.standard.bool(forKey: "alarmGranted")
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBAction func alarmSwitch(_ sender: Any) {
        UserDefaults.standard.set(alarmSwitch.isOn, forKey: "switchState")
        //        if UserDefaults.standard.bool(forKey: "switchState") == true {
        //
        //        } else {
        //
        //        }
        let alertController = UIAlertController (title: "알림 설정 변경", message: "설정화면으로 이동할까요?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "이동", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = UNUserNotificationCenter.current()
           notificationCenter.getNotificationSettings { settings in
                
                if settings.alertSetting == .enabled {
                    DispatchQueue.main.async{
                        self.alarmSwitch.isOn = true
                        
                    }
                }else{
                    DispatchQueue.main.async{
                        self.alarmSwitch.isOn = false
                        
                    }
            }
                
        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            
            if settings.alertSetting == .enabled {
                DispatchQueue.main.async{
                    self.alarmSwitch.isOn = true}
            }else{
                DispatchQueue.main.async{

                    self.alarmSwitch.isOn = false}
            }
            
        }
        
    }
    
    


}
