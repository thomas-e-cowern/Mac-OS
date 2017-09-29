//
//  ViewController.swift
//  MovieReviewiOS
//
//  Created by Thomas Cowern New on 9/24/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var labelRating: UILabel!
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var reviewText: UITextView!
    
    @IBOutlet weak var ratingsSlider: UISlider!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        createActivity()
        
        reviewText.delegate = self
        
    }
    
    func createActivity() {
        
        let activity = NSUserActivity(activityType: "com.vetdevhouse.moviereview.createReview")
        var reviewDictionary : [AnyHashable : Any]? = [:]
        activity.title = "Creating Movie Review"
        reviewDictionary?["title"] = titleText.text
        reviewDictionary?["reviewText"] = reviewText.text
        reviewDictionary?["rating"] = ratingsSlider.value
        self.userActivity = activity
        self.userActivity?.becomeCurrent()
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        
        var reviewDictionary : [AnyHashable : Any]? = [:]
        reviewDictionary?["title"] = titleText.text
        reviewDictionary?["reviewText"] = reviewText.text
        reviewDictionary?["rating"] = ratingsSlider.value
        activity.addUserInfoEntries(from: reviewDictionary!)
        print("Asked for an update")
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        
        let rating = String(format: "%.1f", sender.value)
        
        print(rating)
        
        labelRating.text = "Rating -  \(rating)"
        
        userActivity?.needsSave = true
        
    }
 
    func textViewDidChange(_ textView: UITextView) {
        print("Review Text Did Change")
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        
        userActivity?.needsSave = true
        print("text field changed")
    }

}

