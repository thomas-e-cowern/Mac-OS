//
//  weather.swift
//  weather
//
//  Created by Thomas Cowern New on 9/22/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Foundation

class Weather {
    
    var finished = false
    var apiLaunched = false
    
    func getTemp(location: String) -> String {
        
        if let urlEncoded = location.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] \"").inverted) {
            
            if let url = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(urlEncoded)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys") {
                
                URLSession.shared.dataTask(with: url, completionHandler: { (data: Data?, respose: URLResponse?, error: Error?) in
                    if error != nil {
                        print("Api error: \(String(describing: error))")
                    } else {
                        
                        if data != nil {
                            
                            do {
                                
                                let json = try! JSON(data: data!)
                                if let temp = json["query"]["results"]["channel"]["item"]["condition"]["temp"].string {
                                    print("Location: \(location) Temp: \(temp) °F")
                                }
                                
                            } catch {
                                print("Error occured in do-catch")
                            }
                        }
                    }
                    
                    self.finished = true
                }).resume()
            } else {
                self.finished = true
            }
        }
        return ""
    }
}
