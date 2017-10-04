//
//  NSAddChannelVC.swift
//  Slack-Clone
//
//  Created by Thomas Cowern New on 10/4/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa
import Parse

class NSAddChannelVC: NSViewController {

    @IBOutlet weak var addChannelTextField: NSTextField!
    
    @IBOutlet weak var addChannelDescription: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addChannelClicked(_ sender: Any) {
        let channel = PFObject(className: "Channel")
        channel["title"] = addChannelTextField.stringValue
        channel["desc"] = addChannelDescription.stringValue
        channel.saveInBackground { (success: Bool?, error: Error?) in
            if success! {
                print("Channel created")
                self.view.window?.close()
            } else {
                print("Error saving channel: \(String(describing: error))")
            }
        }
        
    }
    
    
}
