//
//  AppDelegate.swift
//  Slack-Clone
//
//  Created by Thomas Cowern New on 10/2/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa
import Parse

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let config = ParseClientConfiguration { (configThing: ParseMutableClientConfiguration) in
            configThing.applicationId = "slack-dopple"
            configThing.server = "http://slack-dopple.herokuapp.com/parse"
        }
        
        Parse.initialize(with: config)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

