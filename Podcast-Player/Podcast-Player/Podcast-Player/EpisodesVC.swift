//
//  EpisodesVC.swift
//  Podcast-Player
//
//  Created by Thomas Cowern New on 9/21/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

class EpisodesVC: NSViewController {
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var pausePlayButton: NSButton!
    
    @IBOutlet weak var tableView: NSTableView!
    
    var podcast : Podcast? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateView() {
        
        if podcast?.title != nil {
            titleLabel.stringValue = podcast!.title!
        }
        
        if podcast?.imageUrl != nil {
            print("image available")
            let image = NSImage(byReferencing: URL(string: podcast!.imageUrl!)!)
            imageView.image = image
        } else {
            print("No image available")
        }
        
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
    }
    
    @IBAction func pausePlayClicked(_ sender: Any) {
    }
    
    
}
