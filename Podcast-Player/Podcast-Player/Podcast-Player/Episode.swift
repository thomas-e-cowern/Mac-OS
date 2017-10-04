//
//  Episode.swift
//  Podcast-Player
//
//  Created by Thomas Cowern New on 9/29/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

class Episode {
    
    var title = ""
    var pubDate = Date()
    var htmlDescription = ""
    var audioUrl = ""
    
    static let formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return formatter
        
    }()
}
