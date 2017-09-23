//
//  AppDelegate.swift
//  Link-It
//
//  Created by Thomas Cowern New on 9/19/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item : NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        item.title = "Link It"
        item.action = #selector(AppDelegate.linkIt)
        
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func linkIt() {
        print("We made it!")
        
    }
    
}

