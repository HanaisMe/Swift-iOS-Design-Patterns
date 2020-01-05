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
    
    // MARK: - First Scene Coordinator (Strong Reference)
    var stagesSceneCoordinator : StagesSceneCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - Set up the first scene coordinator
        let navVC = UINavigationController()
        navVC.navigationBar.backgroundColor = Constants.red
        navVC.navigationBar.tintColor = Constants.red
        let firstCoordinator = StagesSceneCoordinator(navigationController: navVC)
        firstCoordinator.start()
        self.stagesSceneCoordinator = firstCoordinator
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        return true
    }
}

