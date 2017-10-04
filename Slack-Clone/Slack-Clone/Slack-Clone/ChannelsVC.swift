//
//  ChannelsVC.swift
//  Slack-Clone
//
//  Created by Thomas Cowern New on 10/3/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa
import Parse

class ChannelsVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var profilePicIV: NSImageView!
    
    @IBOutlet weak var nameTextLabel: NSTextField!
    
    var addChannelWC : NSWindowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
    }
    
    override func viewDidAppear() {
        if let user = PFUser.current() {
            if let name = user["name"] {
                nameTextLabel.stringValue = name as! String
            }
            
            if let imageFile = user["profilePic"] as? PFFile {
                imageFile.getDataInBackground(block: {(data:Data?, error: Error?) in
                    if error == nil {
                        if data != nil {
                            let image = NSImage(data: data!)
                            self.profilePicIV.image = image
                        }
                    }
                })
                
            } else {
                self.profilePicIV.image = #imageLiteral(resourceName: "picture")
            }
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        if let userEmail = PFUser.current()?.email {
            print("User \(userEmail) logged out")
            PFUser.logOut()
        }
        if let mainWC = self.view.window?.windowController as? MainWindowController {
            mainWC.moveToLogin()
        }
    }
    
    @IBAction func addClicked(_ sender: Any) {
        addChannelWC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "addChannelWC"))  as? NSWindowController
        addChannelWC?.showWindow(nil)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "channelCell"), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = "Hello"
            
            return cell
        }
        return nil
    }
}
