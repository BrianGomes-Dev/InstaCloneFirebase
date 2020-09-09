//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by user172197 on 9/8/20.
//  Copyright © 2020 Brian Gomes. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LoginClicked(_ sender: Any) {
        performSegue(withIdentifier: "LoginVCToFeedVC", sender: self)
    }
    
    @IBAction func SignInClicked(_ sender: Any) {
        
    }
}

