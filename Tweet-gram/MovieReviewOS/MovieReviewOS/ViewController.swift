//
//  ViewController.swift
//  MovieReviewOS
//
//  Created by Thomas Cowern New on 9/24/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var titleField: NSTextField!
    
    @IBOutlet weak var reviewField: NSTextField!
    
    @IBOutlet weak var ratingSlider: NSSlider!
    
    @IBOutlet weak var labelField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func restoreUserActivityState(_ userActivity: NSUserActivity) {
        print("We are restoring")
        if let title = userActivity.userInfo?["title"] as? String {
            titleField.stringValue = title
        }
        if let review = userActivity.userInfo?["reviewText"] as? String {
            reviewField.stringValue = review
        }
        if let rating = userActivity.userInfo?["rating"] as? Float {
            ratingSlider.floatValue = rating
            
            let roundedRating = String(format: "%.1f", rating)
            labelField.stringValue = "Rating -  \(roundedRating)"
        }

    }


}

