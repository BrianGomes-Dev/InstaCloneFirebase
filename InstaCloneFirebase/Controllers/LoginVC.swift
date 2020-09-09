//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by user172197 on 9/8/20.
//  Copyright © 2020 Brian Gomes. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LoginClicked(_ sender: Any) {
        
        if emailTxtFld.text != "" && passwordTxtFld.text != ""{
            Auth.auth().signIn(withEmail:  emailTxtFld.text!, password: passwordTxtFld.text!) { (authData, error) in
                             
                  if error != nil{
                      self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                       print(error)
                  }else{
                      self.performSegue(withIdentifier: "LoginVCToFeedVC", sender: self)
                  }
                  
              }
              }else{
                  
                  makeAlert(titleInput: "Error", messageInput: "Invalid Username/Password")
              }
        
    }
    
    
    @IBAction func SignUpClicked(_ sender: Any) {
        
        if emailTxtFld.text != "" && passwordTxtFld.text != ""{
        Auth.auth().createUser(withEmail: emailTxtFld.text!, password: passwordTxtFld.text!) { (authData, error) in
            
            if error != nil{
                self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                 print(error)
            }else{
                self.performSegue(withIdentifier: "LoginVCToFeedVC", sender: self)
            }
            
        }
        }else{
            
            makeAlert(titleInput: "Error", messageInput: "Invalid Username/Password")
        }
    
    }
    
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert,animated: true,completion: nil)
        
        
    }
    
}

