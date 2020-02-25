//
//  AppDelegate.swift
//  GoodsDetailDemo
//
//  Created by xiaoyuan on 2020/2/25.
//  Copyright © 2020 enba. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = UINavigationController(rootViewController: GoodsDetailViewController())
        
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

