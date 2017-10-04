//
//  TheSplitController.swift
//  Podcast-Player
//
//  Created by Thomas Cowern New on 9/21/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

class TheSplitController: NSSplitViewController {

    @IBOutlet weak var podcastsItem: NSSplitViewItem!
    
    @IBOutlet weak var episodesItem: NSSplitViewItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if let podcastsVC = podcastsItem.viewController as? PodcastsVC {
            if let episodesVC = episodesItem.viewController as? EpisodesVC {
                podcastsVC.episodesVC = episodesVC
                episodesVC.podcastsVC = podcastsVC
            }
        }
        
    }
    
}
