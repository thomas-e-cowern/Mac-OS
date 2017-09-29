//
//  AppDelegate.swift
//  MovieReviewOS
//
//  Created by Thomas Cowern New on 9/24/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func application(_ application: NSApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]) -> Void) -> Bool {
        
        if let userDict = userActivity.userInfo {
            
            print(userDict)
            
        }
        
        if let window = NSApplication.shared().windows.first {
            
            window.contentViewController?.restoreUserActivityState(userActivity)
        }
        
        return true
    }


}

