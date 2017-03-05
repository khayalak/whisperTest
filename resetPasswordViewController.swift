//
//  resetPasswordViewController.swift
//  whisperFull
//
//  Created by Khaled AlObaid on 2/21/17.
//  Copyright © 2017 TripleAteam. All rights reserved.
//

import UIKit
import Firebase

class resetPasswordViewController: UIViewController {

    @IBOutlet weak var resetTextFiled: UITextField!
    @IBAction func didClickBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didClickReset(_ sender: Any) {
        // handule reset function
        let userEmail = resetTextFiled.text
        // pop up meaasge and dismiss
        popUpMsgAndDismiss(title : "Reset password", message : "reset email will be sent only if this email exist in our database", buttonTitle : "Sounds good!")
        // database reset side
        FIRAuth.auth()?.sendPasswordReset(withEmail: userEmail!) { (error) in
            // ...
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
