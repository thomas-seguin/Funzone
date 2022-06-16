//
//  RegisterViewController.swift
//  Project1
//
//  Created by admin on 6/5/22.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var fNameTxt: UITextField!
    @IBOutlet weak var lNameTxt: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   
    @IBAction func registerClick(_ sender: Any) {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let passwordPattern = #"(?=.{8,})"#
        var valid = true
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "home") else{
            return
        }
        if fNameTxt.text?.range(of: #"[a-zA-Z]"#,options: .regularExpression) == nil{
            print("fname fail")
            valid = false
        }
        
        if lNameTxt.text?.range(of: #"[a-zA-Z]"#,options: .regularExpression) == nil{
            print("lname fail")
            valid = false
        }
        
        let emailResult = emailTxt.text?.range(
            of: emailPattern,
            options: .regularExpression
        )
        
        let passResult = passTxt.text?.range(of: passwordPattern, options: .regularExpression)
        
        if(emailResult == nil){
            print("bad email")
            valid = false
        }
        
        if(passResult == nil){
            print("bad pass")
            valid = false
        }

        let email = emailTxt.text ?? ""
        let password = passTxt.text ?? ""
        if(valid){
        createUser(email: emailTxt.text ?? "", firstName: fNameTxt.text ?? "", lastName: lNameTxt.text ?? "")
        
        do {
            try keychainManger.save(service: "funzone",
                                    account: email,
                                    password: password.data(using: .utf8) ?? Data())
            present(vc,animated: true)
        } catch {
            print("failed to save to keychain")
        }
        } else {
            errorLabel.isHidden = false
        }
    }
    
    
    
    @IBAction func textChange(_ sender: Any) {
        if(emailTxt.text != nil && passTxt.text != nil && fNameTxt.text != nil && lNameTxt.text != nil){
            registerButton.isEnabled = true
        }
    }
    
    
    func createUser(email: String, firstName: String, lastName: String){
       let newUser = UserItem(context: context)
        newUser.email = email
        newUser.firstName = firstName
        newUser.lastName = lastName
        do{
            try context.save()
        } catch{
            print("failed to create user")
        }
    }
    
}


