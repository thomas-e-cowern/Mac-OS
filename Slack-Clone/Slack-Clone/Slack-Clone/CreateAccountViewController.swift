//
//  CreateAccountViewController.swift
//  Slack-Clone
//
//  Created by Thomas Cowern New on 10/2/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa
import Parse

class CreateAccountViewController: NSViewController {
    
    @IBOutlet weak var nameTextField: NSTextField!
    
    @IBOutlet weak var emailTextField: NSTextField!
    
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBOutlet weak var profilePicIV: NSImageView!
    
    var profilePicFile : PFFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToLogin()
        }
        
    }
    
    @IBAction func chooseImageClicked(_ sender: Any) {
        
        let openPanel = NSOpenPanel()
        
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        
        openPanel.begin { (result) in
            if result.rawValue == NSFileHandlingPanelOKButton {
                if let imageUrl = openPanel.urls.first {
                    if let image = NSImage(contentsOf: imageUrl) {
                        self.profilePicIV.image = image
                        
                        let imageData = self.jpegDataFrom(image: image)
                        let profilePicFile = PFFile(data: imageData)
                        profilePicFile?.saveInBackground()
                    }
                }
            }
        }
        
    }
    
    func jpegDataFrom(image:NSImage) -> Data {
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
        return jpegData
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        PFUser.logOut()
        let user = PFUser()
        user.email = emailTextField.stringValue
        user.password = passwordTextField.stringValue
        user.username = emailTextField.stringValue
        user["name"] = nameTextField.stringValue
//        user["profilePic"] = profilePicFile
        if profilePicFile != nil {
            user["profilePic"] = profilePicFile
        } else {
            print("Problem with picture")

        }
        user.signUpInBackground { (success: Bool, error: Error?) in
            if success == true {
                print("User created")
                if let mainWC = self.view.window?.windowController as? MainWindowController {
                    mainWC.moveToChat()
                }
            } else {
                print("User registration error: \(String(describing: error))")
            }
        }
    }
}
