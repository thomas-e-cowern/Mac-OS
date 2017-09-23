//
//  MyBarController.swift
//  Touchbar App
//
//  Created by Thomas Cowern New on 9/22/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

@available(OSX 10.12.2, *)
class MyBarController: NSWindowController {

    @IBOutlet weak var colorPicker: NSColorPickerTouchBarItem!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        print("Hello World")
        
        colorPicker.isEnabled = true
        
        colorPicker.target = self
        colorPicker.action = #selector(colorPicked)
    }
    
    func colorPicked() {
        
        print(colorPicker.color)
        self.contentViewController?.view.layer?.backgroundColor = colorPicker.color.cgColor
        
    }
}

