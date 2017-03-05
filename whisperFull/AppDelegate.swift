//
//  AppDelegate.swift
//  whisperFull
//
//  Created by Khaled AlObaid on 2/21/17.
//  Copyright © 2017 TripleAteam. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        return true
    }

 


}

