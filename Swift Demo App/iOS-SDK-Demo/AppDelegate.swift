//
//  AppDelegate.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

@UIApplicationMain
class ALDemoAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Initializing our SDK at launch is very important as it'll start preloading ads in the background.        
        ALSdk.initializeSdk()

        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barTintColor = UIColor(red: 10.0/255.0, green: 131.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        return true
    }
}
