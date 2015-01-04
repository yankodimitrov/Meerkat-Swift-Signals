//
//  CitiesRepository.swift
//  CitiesToVisit
//
//  Created by Yanko Dimitrov on 1/2/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

protocol CitiesRepository {
    
    var currentCityDidChange: ObserversDispatcher<CitiesRepository> {get}
    var currentCity: City? {get}
    var currentCityIndex: Int {get}
    var citiesCount: Int {get}
    
    func add(city: City)
    func next()
}
