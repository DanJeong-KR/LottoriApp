//
//  AppDelegate.swift
//  Lottori
//
//  Created by chang sic jung on 21/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      // for first screen
        Thread.sleep(forTimeInterval: 1.3)
      
      // init rootVC
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
      
      // firebase
      FirebaseApp.configure()
        
        return true
    }
    
}

