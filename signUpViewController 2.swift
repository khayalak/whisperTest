//
//  signUpViewController.swift
//  whisperFull
//
//  Created by Khaled AlObaid on 2/21/17.
//  Copyright © 2017 TripleAteam. All rights reserved.
//

import UIKit
import Firebase

class signUpViewController: UIViewController {

    @IBOutlet weak var wrongText: UILabel!
    @IBAction func didClickBack(_ sender: Any) {  dismiss(animated: true)  }
    @IBOutlet weak var password1TextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var email = ""
    var currentDate = ""
    var lastSeenTime = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        currentDate = todayDate()
        lastSeenTime = currentTime()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didClickSignUp(_ sender: Any) {
        // manage sign up function
        
        if (nameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (password1TextField.text?.isEmpty)! || (password2TextField.text?.isEmpty)!{
            // one field or more is empty
            self.wrongText.text = "Please enter all fields"
        }else {
        // check if two passwords match
            if (password1TextField.text==password2TextField.text){
                email = emailTextField.text!
                let password = password1TextField.text
                // handule database side
                FIRAuth.auth()?.createUser(withEmail: email, password: password!) { (user, error) in
                    if user != nil{
                    // will come here only if user and pass are in correct format (email style + 6 digit password)
                    // save user email and name into DB
                    let ref = FIRDatabase.database().reference()
                        let name = self.nameTextField.text
                        let imageURL = "http://www.freeiconspng.com/uploads/am-a-19-year-old-multimedia-artist-student-from-manila--21.png"
                        let userId = user?.uid
                        let info = ["name" : name, "email" : self.email, "image" : imageURL, "lastSignIn" : self.currentDate, "lastSeenTime" : self.lastSeenTime]
                        ref.child("users").child(userId!).setValue(info)
                    // go to chats list UI
                    self.performSegue(withIdentifier: "chatList", sender: self)
                    }else{
                    // show message "not met constrans"
                    self.wrongText.text = "enter correct email and =>6 digitd pass"
                    }
                }
                
            }else {
                self.wrongText.text = "Passwords not match"
            }
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // send data to next segue if needed
//        if (segue.identifier == "chatList") {
//            let dest = segue.destination as? chatListViewController
//            dest?.lableText = "Your email is " + self.email
//        }
    }
}
