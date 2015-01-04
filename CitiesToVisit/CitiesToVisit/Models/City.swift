//
//  City.swift
//  CitiesToVisit
//
//  Created by Yanko Dimitrov on 1/2/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

struct City: Equatable {
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
}

func ==(lhs: City, rhs: City) -> Bool {
    
    if lhs.name.lowercaseString == rhs.name.lowercaseString &&
       lhs.country.lowercaseString == rhs.country.lowercaseString {
        
        return true
    }
    
    return false
}
