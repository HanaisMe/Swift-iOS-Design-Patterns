//
//  AppDelegate.swift
//  SplatoonStages
//
//  Created by Jeongsik Lee on 2019/12/30.
//  Copyright © 2019 Jeongsik Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let stagesVC: StagesViewController = ViewControllers.initiate(from: .main)
        let navVC = UINavigationController.init(rootViewController: stagesVC)
        navVC.navigationBar.backgroundColor = Constants.red
        navVC.navigationBar.tintColor = Constants.red
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        return true
    }
}

