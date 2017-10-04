//
//  EpisodeCell.swift
//  Podcast-Player
//
//  Created by Thomas Cowern New on 9/29/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa
import WebKit

class EpisodeCell: NSTableCellView {

    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var descWebView: WKWebView!
    
    @IBOutlet weak var dateLabel: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
