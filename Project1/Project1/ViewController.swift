//
//  ViewController.swift
//  Project1
//
//  Created by admin on 6/2/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var rememberSwitch: UISwitch!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    let userDefaults = UserDefaults()
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        let check = UserDefaults.standard.bool(forKey: "remember")
         
         if(check == false){
             rememberSwitch.isOn = false
            
         }
           
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let check = UserDefaults.standard.bool(forKey: "remember")
         
         if(check == true){
             print("sending")
             guard let vc = storyboard?.instantiateViewController(withIdentifier: "home")else {
                 return
             }
             present(vc, animated: true)
         }
        
    }
    
    


    @IBAction func loginClick(_ sender: Any) {
        let email = emailTxt.text ?? "test"
        let pass = passTxt.text
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "home")else {
            return
        }
        guard let data = keychainManger.get(service: "funzone", account: email) else {
            print("failed to read password")
            return
        }
        let password = String(decoding: data, as: UTF8.self)
        if(password == pass){
            
            if rememberSwitch.isOn{
                
                userDefaults.set(true, forKey: "remember")
            } else {
               
                userDefaults.set(false, forKey: "remember")
            }
            present(vc, animated: true)
            
        }else {
            errorLabel.isHidden = false
        }
    
    }
    
    
    
    @IBAction func textChange(_ sender: Any) {
        if emailTxt.text != nil{
            loginButton.isEnabled = true
        }
        
    }
}



class keychainManger {
    enum KeychainError: Error{
        case duplicateEntry
        case unkown(OSStatus)
    }
    static func save(
        service: String,
        account: String,
        password: Data
        ) throws{
        //service account password class
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword ,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject,
        ]
            
           let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status != errSecDuplicateItem else {
                throw KeychainError.duplicateEntry
            }
            
            guard status == errSecSuccess else {
                throw KeychainError.unkown(status)
            }
            
            print("saved")
    }
    
    static func get(
        service: String,
        account: String
    )  -> Data?{
        //service account class return data
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        print(status)
        
        return result as? Data
    }
}

