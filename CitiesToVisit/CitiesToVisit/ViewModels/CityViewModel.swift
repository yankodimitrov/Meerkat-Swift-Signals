//
//  CityViewModel.swift
//  CitiesToVisit
//
//  Created by Yanko Dimitrov on 1/4/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation
import  MapKit

class CityViewModel: CityViewModelProtocol {
    
    let cityDidChange = ObserversDispatcher<CityViewModelProtocol>()
    
    var enableNextCityButton: Bool {
        return repository.citiesCount > 0
    }
    
    var cityName: String {
        return repository.currentCity?.name ?? ""
    }
    
    var countryName: String {
        return repository.currentCity?.country ?? ""
    }
    
    var cityNumber: String {
        
        if repository.citiesCount <= 0 {
            return "00/00"
        }
        
        let currentCity = formatCityNumber(repository.currentCityIndex + 1)
        let citiesCount = formatCityNumber(repository.citiesCount)
        
        return "\(currentCity)/\(citiesCount)"
    }
    
    var cityAnnotation: MKAnnotation {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = cityLocation
        annotation.title = cityName
        annotation.subtitle = countryName
        
        return annotation
    }
    
    var mapRegion: MKCoordinateRegion {
        return MKCoordinateRegionMakeWithDistance(cityLocation, 8000, 8000)
    }
    
    var cityLocation: CLLocationCoordinate2D {
        
        if let city = repository.currentCity {
            
            return CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)
        }
        
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    private let repository: CitiesRepository
    
    ///////////////////////////////////////////////////////
    // MARK: - Initializers
    ///////////////////////////////////////////////////////
    
    init(repository: CitiesRepository) {
        
        self.repository = repository
        
        repository.currentCityDidChange.addObserver(self, withCallback: {
            [weak self] sender in
            
            if let sender = self {
                
                sender.cityDidChange.dispatchWithSender(sender)
            }
        })
    }
    
    deinit {
        
        repository.currentCityDidChange.removeObserver(self)
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - Methods
    ///////////////////////////////////////////////////////
    
    func nextCity() {
        
        repository.next()
    }
    
    private func formatCityNumber(number: Int) -> String {
        
        if number < 10 {
            return "0\(number)"
        }
        
        return "\(number)"
    }

}
