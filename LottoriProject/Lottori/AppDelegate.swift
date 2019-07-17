//
//  AppDelegate.swift
//  Lottori
//
//  Created by chang sic jung on 21/05/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Thread.sleep(forTimeInterval: 2.0)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UINavigationController(rootViewController: FirstViewController())
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

