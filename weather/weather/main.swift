//
//  main.swift
//  weather
//
//  Created by Thomas Cowern New on 9/22/17.
//  Copyright © 2017 vetDevHouse. All rights reserved.
//

import Foundation

//for arg in CommandLine.arguments {
//    
//    print(arg)
//    
//}

let weather = Weather()

let location = CommandLine.arguments.dropFirst().joined(separator: " ")


while !weather.finished {
    
    if !weather.apiLaunched {
        weather.getTemp(location: location)
        weather.apiLaunched = true
    }
    
    
}
