//
//  allUsersViewController.swift
//  whisperFull
//
//  Created by Khaled AlObaid on 2/22/17.
//  Copyright © 2017 TripleAteam. All rights reserved.
//

import UIKit
import Firebase

class allUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var userList = [users] ()
    var lastLogIn = ""
    var lastSeenTime = ""
    
    @IBOutlet weak var userListTable: UITableView!
    @IBAction func didClickBack(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        fetchAllUsers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchAllUsers(){
        // fetch all users from Whisper Database
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("users").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let uName = snapshotValue?["name"] as? String
            let UImageUrl = snapshotValue?["image"] as? String
            let UEmail = snapshotValue?["email"] as? String
            let lastSignIn = snapshotValue?["lastSignIn"] as? String
            let lastSeenTime = snapshotValue?["lastSeenTime"] as? String
            self.userList.insert(users(name: uName, imageUrl: UImageUrl, email: UEmail, lastSignIn: lastSignIn, lastSeenTime : lastSeenTime), at: 0)
            self.userListTable.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userListTable.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row].name
        lastLogIn = userList[indexPath.row].lastSignIn
        lastSeenTime = userList[indexPath.row].lastSeenTime
        let t = todayDate()
        if (self.lastLogIn==t) {
        self.lastLogIn = "Today"
        }
        cell.detailTextLabel?.text = "last seen " + lastLogIn + " at " + lastSeenTime
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("test")
        performSegue(withIdentifier: "selectUser", sender: nil)
//        let chatLog = chatLogController()
//        navigationController?.pushViewController(chatLog, animated: true)
        
        
    }
    
    

}
