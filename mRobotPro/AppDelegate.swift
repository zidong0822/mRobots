//
//  AppDelegate.swift
//  mRobotPro
//
//  Created by harvey on 16/7/1.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
     
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = UINavigationController(rootViewController:SelectViewController())
        window?.backgroundColor = UIColor.darkGrayColor()
        window?.makeKeyAndVisible()
        switch getControl() {
        case 10:
            window?.rootViewController = UINavigationController(rootViewController:SelectViewController())
        case 0:
            window?.rootViewController = UINavigationController(rootViewController:mTankViewController())
        case 1:
            window?.rootViewController = UINavigationController(rootViewController:mDroneViewController())
        default:
            window?.rootViewController = UINavigationController(rootViewController:SelectViewController())
        }
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {
 
    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {
    
    }


}

