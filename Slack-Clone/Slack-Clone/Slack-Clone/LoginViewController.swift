//
//  LoginViewController.swift
//  Slack-Clone
//
//  Created by Thomas Cowern New on 10/2/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa
import Parse

class LoginViewController: NSViewController {

    
    @IBOutlet weak var emailTextField: NSTextField!
    
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createAccountClicker(_ sender: Any) {
        
        if let mainWC = view.window?.windowController as? MainWindowController {
            mainWC.moveToCreateAccount()
        }
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        PFUser.logInWithUsername(inBackground: emailTextField.stringValue, password: passwordTextField.stringValue) { (user: PFUser?, error: Error?) in
            if error == nil {
                
                if let userEmail = PFUser.current()?.email {
                    print("User \(userEmail) logged in")
                    
                }
                if let mainWC = self.view.window?.windowController as? MainWindowController {
                    mainWC.moveToChat()
                }
            } else {
                print("Login error: \(String(describing: error))")
            }
        }
        
    }
    

    
}

