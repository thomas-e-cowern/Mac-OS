//
//  PodcastsVC.swift
//  Podcast-Player
//
//  Created by Thomas Cowern New on 9/20/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

class PodcastsVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var podcastUrlTextField: NSTextField!
    
    @IBOutlet weak var tableView: NSTableView!
    
    var podcasts : [Podcast] = []
    var episodesVC : EpisodesVC? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        getPodcasts()
    }
    
    func getPodcasts() {
        
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let fetch = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetch.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            do {
                podcasts = try! context.fetch(fetch)
                
                //                print("Get Podcasts: \(podcasts.count)")
            } catch {}
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    @IBAction func addPodcastClicked(_ sender: AnyObject) {
        //        print("AddPodcast Clicked")
        if let url = URL(string: podcastUrlTextField.stringValue) {
            //            print("Url: \(url)")
            URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                
                if error != nil {
                    print("Error: \(error!)")
                } else {
                    
                    if data != nil {
                        let podcastURL = self.podcastUrlTextField.stringValue
                        //                        print("PC text Field 1: \(podcastURL)")
                        let parser = Parser()
                        let info = parser.getPodcastMetaData(data: data!)
                        //                        print("info from Parser: \(parser.getPodcastMetaData(data: data!))")
                        //                        print("PC text Field 2: \(podcastURL)")
                        
                        if !self.podcastExists(rssUrl: podcastURL) {
                            print("New podcast")
                            if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
                                
                                let podcast = Podcast(context: context)
                                
                                podcast.rssUrl = self.podcastUrlTextField.stringValue
                                podcast.imageUrl = info.imageUrl
                                podcast.title = info.title
                                print("New Podcast: \(podcast)")
                                
                                
                                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                                
                                self.getPodcasts()
                                
                                DispatchQueue.main.async {
                                    self.podcastUrlTextField.stringValue = ""
                                }
                            }
                        } else {
                            print("Podcast already exists")
                        }
                    }
                }
                
                }.resume()
            
            
        }
        //        podcastUrlTextField.stringValue = ""
    }
    
    
    func podcastExists(rssUrl: String) -> Bool {
        print("PE rssUrl: \(rssUrl)")
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
            //            print("context: \(context.)")
            let fetch = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetch.predicate = NSPredicate(format: "rssUrl == %@", rssUrl)
            print("Fetch: \(fetch)")
            do {
                let matchingPodcasts = try! context.fetch(fetch)
                //                print("MP Title: \(matchingPodcasts)")
                print("Matching podcasts: \(matchingPodcasts.count)")
                if matchingPodcasts.count >= 1 {
                    print("matches")
                    return true
                } else {
                    print("No match")
                    return false
                }
                
                
            } catch {}
            
        }
        
        return false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "podcastcell", owner: self) as? NSTableCellView
        
        let podcast = podcasts[row]
        
        if podcast.title != nil {
            cell?.textField?.stringValue = podcast.title!
        } else {
            cell?.textField?.stringValue = "Unknown Title"
        }
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        if tableView.selectedRow >= 0 {
            let podcast = podcasts[tableView.selectedRow]
            
            episodesVC?.podcast = podcast
            episodesVC?.updateView()
        }
    }
    
}
