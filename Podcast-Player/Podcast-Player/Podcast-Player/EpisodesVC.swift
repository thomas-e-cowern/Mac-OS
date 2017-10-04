//
//  EpisodesVC.swift
//  Podcast-Player
//
//  Created by Thomas Cowern New on 9/21/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa
import AVFoundation

class EpisodesVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var pausePlayButton: NSButton!
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var deleteButton: NSButton!
    
    var podcast : Podcast? = nil
    var podcastsVC : PodcastsVC? = nil
    var episodes : [Episode] = []
    var player : AVPlayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        updateView()
    }
    
    func updateView() {
        
        if podcast?.title != nil {
            titleLabel.stringValue = podcast!.title!
        } else {
            titleLabel.stringValue = ""
        }
        
        if podcast?.imageUrl != nil {
            //            print("image available")
            let image = NSImage(byReferencing: URL(string: podcast!.imageUrl!)!)
            imageView.image = image
        } else {
            print("No image available")
            imageView.image = nil
        }
        
        if podcast != nil {
            tableView.isHidden = false
            deleteButton.isHidden = false
            
        } else {
            tableView.isHidden = true
            deleteButton.isHidden = true
            
        }
        
        pausePlayButton.isHidden = true
        
        getEpisodes()
        
    }
    
    func getEpisodes() {
        
        if podcast?.rssUrl != nil {
            
            if let url = URL(string: (podcast?.rssUrl)!) {
                
                URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                    
                    if error != nil {
                        print("Error: \(error!)")
                    } else {
                        
                        if data != nil {
                            
                            let parser = Parser()
                            self.episodes = parser.getEpisodes(data: data!)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                    }
                    
                    }.resume()
            }
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            context.delete(podcast!)
            
            (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
            
            podcastsVC?.getPodcasts()
            
            titleLabel.stringValue = ""
            
            imageView.image = nil
            
            
            
            
        }
        
    }
    
    @IBAction func pausePlayClicked(_ sender: Any) {
        if pausePlayButton.title == "Pause" {
            player?.pause()
            pausePlayButton.title = "Play"
        } else {
            player?.play()
            pausePlayButton.title = "Pause"
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let episode = episodes[row]
        let cell = tableView.make(withIdentifier: "episodeCell", owner: self) as? EpisodeCell
        cell?.titleLabel?.stringValue = episode.title
        
        cell?.descWebView.loadHTMLString(episode.htmlDescription, baseURL: nil)
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM d, yyyy"
        cell?.dateLabel?.stringValue = dateformatter.string(from: episode.pubDate)
        
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow >= 0 {
            
            let episode = episodes[tableView.selectedRow]
            print("AudioUrl \(episode.audioUrl)")
            if let url = URL(string: episode.audioUrl) {
                
                player?.pause()
                player = nil
                
                player = AVPlayer(url: url)
                player?.play()
                
            }
            
            pausePlayButton.isHidden = false
            pausePlayButton.title = "Pause"
        }
    }
}
