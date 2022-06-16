//
//  SettingsViewController.swift
//  Project1
//
//  Created by admin on 6/5/22.
//

import UIKit

class SettingsViewController: UIViewController {
    let userDefaults = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func signOut(_ sender: Any) {
        
        userDefaults.set(false, forKey: "remember")
       
        
        
        
       
    }
    

}
