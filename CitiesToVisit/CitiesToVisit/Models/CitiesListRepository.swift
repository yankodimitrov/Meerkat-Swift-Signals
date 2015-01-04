//
//  CitiesListRepository.swift
//  CitiesToVisit
//
//  Created by Yanko Dimitrov on 1/4/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

class CitiesListRepository: CitiesRepository {
    
    let currentCityDidChange = ObserversDispatcher<CitiesRepository>()
    
    var currentCity: City? {
        
        if currentIndex < citiesList.count && citiesList.count > 0 {
            return citiesList[currentIndex]
        }
        
        return nil
    }
    
    var currentCityIndex: Int {
        return currentIndex
    }
    
    var citiesCount: Int {
        return citiesList.count
    }
    
    private lazy var citiesList = [City]()
    private var currentIndex = 0
    
    ///////////////////////////////////////////////////////
    // MARK: - Methods
    ///////////////////////////////////////////////////////
    
    func add(city: City) {
        
        if !contains(city) {
            
            citiesList.append(city)
        }
    }
    
    func contains(city: City) -> Bool {
        
        return citiesList.filter({ $0 == city }).count > 0
    }
    
    func next() {
        
        currentIndex += 1
        
        if currentIndex >= citiesList.count {
            
            currentIndex = 0
        }
        
        currentCityDidChange.dispatchWithSender(self)
    }

}
