//
//  ViewController.swift
//  Tweet-gram
//
//  Created by Thomas Cowern New on 9/23/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa
import OAuthSwift
import SwiftyJSON
import Kingfisher



class ViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    @IBOutlet weak var loginButton: NSButton!
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var imageUrls : [String] = []
    var tweetUrls : [String] = []
    
    var loginState = 0
    
    let oauthswift = OAuth1Swift(
        consumerKey:    "bHL5GhfI1cTfYtJZGZoLppjfo",
        consumerSecret: "OjoKy0X2vKu3mjuBVsWkY1CJK6FUEM7EUUAVAl2fPXmvtf7glx",
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 300, height: 300)
        layout.sectionInset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        checkLogin()
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "TweetGramItem", for: indexPath)
        
        let urlString = imageUrls[indexPath.item]
        
        let url = URL(string: urlString)
        item.imageView?.kf.setImage(with: url)
        
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        collectionView.deselectAll(nil)
        
        if let indexPath = indexPaths.first {
            
            if let url = URL(string: tweetUrls[indexPath.item]) {
                
                NSWorkspace.shared().open(url)
            }
        }
    }
    
    func checkLogin() {
        
        if let oauthToken = UserDefaults.standard.string(forKey: "oauthToken") {
            if let oauthTokenSecret = UserDefaults.standard.string(forKey: "oauthTokenSecret") {
                
                oauthswift.client.credential.oauthToken = oauthToken
                oauthswift.client.credential.oauthTokenSecret = oauthTokenSecret
                loginState = 1
                loginButton.title = "Log Out"
                
                getTweets()
                
            }
            
        }
        
    }
    
    func logIn() {
        
        
        loginButton.title = "Log Out"
        // authorize
        let _ = oauthswift.authorize(
            //          for returnging to vetdevhouse.com;
            //          withCallbackURL: URL(string: "http://www.vetdevhouse.com")!
            //          for returning to the app;
            withCallbackURL: URL(string: "Tweet-gram://Wemadeit")!,
            success: { credential, response, parameters in
                print("Token: \(credential.oauthToken)")
                print("TokenSec: \(credential.oauthTokenSecret)")
                print("UserId: \(String(describing: parameters["user_id"]))")
                
                UserDefaults.standard.set(credential.oauthToken, forKey: "oauthToken")
                
                UserDefaults.standard.set(credential.oauthTokenSecret, forKey: "oauthTokenSecret")
                
                UserDefaults.standard.synchronize()
                self.loginState = 1
                self.getTweets()
                
        },
            failure: { error in
                print(error.localizedDescription)
        }
        )
    }
    
    func getTweets() {
        
        let _ = oauthswift.client.get("https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: ["tweet_mode" : "extended", "count" : 200],
                                      success: { response in
                                        //                                        if let dataString = response.string {
                                        //                                            print(dataString)
                                        //                                        }
                                        let json = JSON(data: response.data)
                                        
                                        var retweeted = false
                                        
                                        for (_,tweetJson):(String, JSON) in json {
                                            
                                            for (_,mediaJson):(String, JSON) in tweetJson["retweeted_status"][]["extended_entities"]["media"] {
                                                
                                                retweeted = true
                                                
                                                if let url = mediaJson["media_url_https"].string {
                                                    self.imageUrls.append(url)
                                                }
                                                if let expandedUrl = mediaJson["expanded_url"].string {
                                                    self.tweetUrls.append(expandedUrl)
                                                    
                                                }
                                                
                                            }
                                            
                                            if retweeted == false {
                                                
                                                for (_,mediaJson):(String, JSON) in tweetJson["extended_entities"]["media"] {
                                                    
                                                    //                                                print(mediaJson["media_url_https"])
                                                    if let url = mediaJson["media_url_https"].string {
                                                        self.imageUrls.append(url)
                                                    }
                                                    if let expandedUrl = mediaJson["expanded_url"].string {
                                                        self.tweetUrls.append(expandedUrl)
                                                        
                                                    }
                                                    
                                                }
                                            }
                                        }
                                        
                                        
                                        self.collectionView.reloadData()
        },
                                      failure: { error in
                                        print(error)
        }
        )
        
        
    }
    
    func logOut() {
        
        UserDefaults.standard.removeObject(forKey: "oauthToken")
        UserDefaults.standard.removeObject(forKey: "oauthTokenSecret")
        loginButton.title = "Log In"
        loginState = 0
        imageUrls = []
        tweetUrls = []
        collectionView.reloadData()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        if loginState == 0 {
            
            logIn()
            
        } else {
            
            logOut()
            
        }
        
        
    }
    
}

