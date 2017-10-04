//
//  MainWindowController.swift
//  Slack-Clone
//
//  Created by Thomas Cowern New on 10/2/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    var loginVC : LoginViewController?
    var createAccountVC : CreateAccountViewController?
    var splitVC : SplitViewController?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        loginVC = contentViewController as? LoginViewController
    }
    
    func moveToCreateAccount () {
        
        if createAccountVC == nil {
            createAccountVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "createAccountVC")) as? CreateAccountViewController
        }
        
        window?.contentView = createAccountVC?.view
        
    }
    
    func moveToLogin() {
        window?.contentView = loginVC?.view
    }
    
    func moveToChat () {
        
        if splitVC == nil {
            splitVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "SplitVC")) as? SplitViewController
        }
        
        window?.contentView = splitVC?.view
    }
    
}
