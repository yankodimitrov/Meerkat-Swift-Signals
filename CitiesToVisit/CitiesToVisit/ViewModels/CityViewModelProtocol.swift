//
//  CityViewModelProtocol.swift
//  CitiesToVisit
//
//  Created by Yanko Dimitrov on 1/2/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation
import MapKit

protocol CityViewModelProtocol {
    
    var cityDidChange: ObserversDispatcher<CityViewModelProtocol> {get}
    var enableNextCityButton: Bool {get}
    var cityName: String {get}
    var countryName: String {get}
    var cityNumber: String {get}
    var cityAnnotation: MKAnnotation {get}
    var mapRegion: MKCoordinateRegion {get}
    
    func nextCity()
}
