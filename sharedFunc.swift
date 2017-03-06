//
//  sharedFunc.swift
//  whisperFull
//
//  Created by Khaled AlObaid on 2/22/17.
//  Copyright © 2017 TripleAteam. All rights reserved.
//

import Foundation
import UIKit
import Firebase


struct messageStruct {
    let fromID : String!
    let toID : String!
    let text : String!
}

struct users {
    let userId : String!
    let name : String!
    let imageUrl : String!
    let email : String!
    let lastSignIn : String!
    let lastSeenTime : String!
}

// code by @leo-dabus from stackoverflow.com
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


extension UIViewController {

// hide keyboard if user click anywhere, code by @Esqarrouth from http://stackoverflow.com/
// put self.hideKeyboardWhenTappedAround() in viewDidLoad() at any UIController
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
// popup messsage and dismiss
    
    func popUpMsgAndDismiss(title : String, message : String, buttonTitle : String){
        
        let title = title
        let message = message
        let buttonTitle = buttonTitle
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: .default, handler: { ACTION in self.dismiss(animated: true, completion: nil)})
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
// current date
    
    func todayDate() -> String {
        let date = Date()
        let formartter = DateFormatter()
        formartter.dateFormat = "dd.MM.yyyy"
        let time = formartter.string(from: date)
        return time
    }
    
    func currentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let hours = "\(hour):\(minutes)"
        return hours
    }
    
// fetch all Whisper users
//    func fetchUsers() -> Array<users> {
//        var allUsers = [users]()
//        let databaseRef = FIRDatabase.database().reference()
//        databaseRef.child("users").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
//            let snapshotValue = snapshot.value as? NSDictionary
//            let name = snapshotValue?["name"] as? String
//            let imageUrl = snapshotValue?["image"] as? String
//            let email = snapshotValue?["email"] as? String
//            allUsers.insert(users(name: name, imageUrl: imageUrl, email: email), at: 0)
//        })
//        print(allUsers)
//        return allUsers
//    }
    
    
}
