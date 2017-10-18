//
//  AppDelegate.swift
//  JetWoman
//
//  Created by Thomas Cowern New on 9/25/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBAction func resetScoreClicked(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "highscore")
        UserDefaults.standard.synchronize()
        if let VC = NSApplication.shared().windows.first?.contentViewController as? ViewController {
            
            if let scene = VC.skView.scene as? GameScene {
                scene.updateHighScore()
            }
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
