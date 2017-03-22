//
//  chatListViewController.swift
//  whisperFull
//
//  Created by Khaled AlObaid on 2/21/17.
//  Copyright © 2017 TripleAteam. All rights reserved.
//

import UIKit
import Firebase

class chatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let user = FIRAuth.auth()?.currentUser?.uid
    
    // database reference
    let ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var chatListTable: UITableView!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBAction func didClickSignOut(_ sender: Any) {
        // sign out code from Firebase doc
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // return to sign in UI
        self.performSegue(withIdentifier: "home", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        chechIfSignIn()
        findUserName()
//        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    
    func chechIfSignIn(){
        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
        } else {
            // No user is signed in.
            self.performSegue(withIdentifier: "home", sender: self)
        }
    }
    
    func findUserName(){
        // code by Brian Voong from https://twitter.com/buildthatapp
        FIRDatabase.database().reference().child("users").child(user!).observeSingleEvent(of:.value, with: { (snapshot) in
            if let dic = snapshot.value as? [String : AnyObject] {
                self.navBarTitle.title = (dic["name"] as? String)!
            }
        })
    }
    
    
    
    
    // table view fucntions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatListTable.dequeueReusableCell(withIdentifier: "chatsCell", for: indexPath)
        cell.textLabel?.text = "حبيبة خالد"
        cell.detailTextLabel?.text = "هلا والله خلودي معليش ما انتبهت للجوال 😗"
        return cell
    }
    
    
    
    
}
