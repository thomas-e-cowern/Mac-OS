//
//  Parser.swift
//  Podcast-Player
//
//  Created by Thomas Cowern New on 9/20/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Foundation

class Parser {
    
    func getPodcastMetaData(data: Data) -> (title: String?, imageUrl: String?) {
        
        let xml = SWXMLHash.parse(data)
        
        print("Parser: \(xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)")
        
        
        return (xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
        
    }
}
