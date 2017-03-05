//
//  signInViewController.swift
//  whisperFull
//
//  Created by Khaled AlObaid on 2/21/17.
//  Copyright © 2017 TripleAteam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class signInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var wrongInput: UILabel!
    
    var userName : String = ""
    var lastSeenTime = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        lastSeenTime = currentTime()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickSignIn(_ sender: Any) {
        
        // handule sign in function
        let email = self.email.text
        let password = self.password.text
        // database code
        FIRAuth.auth()?.signIn(withEmail: email!, password: password!) { (user, error) in
            if user != nil {
            // information matched database
            self.wrongInput.text = ""
            self.userName = (user?.email)!
            self.password.text = ""
//                // add sign in timestamp
                let ref = FIRDatabase.database().reference()
                let time = self.todayDate()
                ref.child("users").child((user?.uid)!).child("lastSignIn").setValue(time)
                ref.child("users").child((user?.uid)!).child("lastSeenTime").setValue(self.lastSeenTime)
                // go to chatlist
            self.performSegue(withIdentifier: "chatList", sender: self)
            }else {
            // information not found on database
                if (email=="") {
                    self.wrongInput.text = "Email is required"
                }else if (password==""){
                    self.wrongInput.text = "Password is required"
                }else{
                    self.wrongInput.text = "Email or password is wrong"
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // send data to next segue if needed
        if (segue.identifier == "chatList") {
        let dest = segue.destination as? chatListViewController
//           dest?.lableText = "Your email is " + self.userName
        }


    }

    


}
