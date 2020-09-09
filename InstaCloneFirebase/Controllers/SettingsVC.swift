//
//  SettingsVC.swift
//  InstaCloneFirebase
//
//  Created by user172197 on 9/8/20.
//  Copyright © 2020 Brian Gomes. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func LogoutClicked(_ sender: Any) {
       performSegue(withIdentifier: "settingsVCToLoginVC", sender: nil)
    }
    
}
