//
//  NewMessageController.swift
//  whisperFull
//
//  Created by Khaled AlObaid on 3/5/17.
//  Copyright © 2017 TripleAteam. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
 
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func didClickSend(_ sender: Any) {
        sendMessage()
    }
    
    @IBAction func didClickBack(_ sender: Any) {
        performSegue(withIdentifier: "ChatList", sender: nil)
    }

    let userID = FIRAuth.auth()?.currentUser?.uid
    var fromName = ""
    var toID = ""
    var messagesList = [messageStruct] ()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
//        getChatlist()
        fetchMessages()
        // Do any additional setup after loading the view.
    }
    
    func fetchMessages(){
    
        // fetch chat log from Whisper Database
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("message").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let fromID = snapshotValue?["sender"] as? String
            let text = snapshotValue?["content"] as? String
            let toID = snapshotValue?["receiver"] as? String
            self.messagesList.insert(messageStruct(fromID: fromID, toID: toID, text: text), at: 0)
            self.messageTable.reloadData()
        })
        
        
    
    }
    
    func sendMessage(){
        if (textField.text!.isEmpty){
        // text field is empty, do nothing
        }else{
        // send message to server
            let message = self.textField.text
            let timeStamp = self.timeStamp()
            let info = ["sender" : userID,  "receiver" : toID, "content" : message, "typeOfContent" : "text", "timestamp" : timeStamp] as [String : Any]
            FIRDatabase.database().reference().child("messages").childByAutoId().setValue(info)
        }
        textField.text = ""
    }
    
    func getUserInfo(){
        FIRDatabase.database().reference().child("users").child(userID!).observeSingleEvent(of:.value, with: { (snapshot) in
            if let dic = snapshot.value as? [String : AnyObject] {
                self.fromName = (dic["name"] as? String)!
            }
        })
    }
    
//    func getChatlist(){
//        let ref = FIRDatabase.database().reference().child("message")
//        
//        
//    
//    
//    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = messageTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let fromID = messagesList[indexPath.row].fromID
 
        FIRDatabase.database().reference().child("users").child(fromID!).observeSingleEvent(of:.value, with: { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            cell.textLabel?.text = (snapshotValue?["name"] as? String)!
        })
        cell.detailTextLabel?.text = messagesList[indexPath.row].text
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    


}
