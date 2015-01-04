//
//  CityViewController.swift
//  CitiesToVisit
//
//  Created by Yanko Dimitrov on 1/2/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import UIKit
import MapKit

class CityViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cityNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var nextCityButton: UIButton!
    
    var viewModel: CityViewModelProtocol? {
        didSet {
            viewModel?.cityDidChange.removeObserver(self)
            viewModel?.cityDidChange.addObserver(self, withCallback: handleCityChange)
        }
    }
    
    deinit {
        
        viewModel?.cityDidChange.removeObserver(self)
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - View
    ///////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCityView()
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - Methods
    ///////////////////////////////////////////////////////
    
    private func updateCityView() {
        
        if let model = viewModel {
            
            cityNumberLabel.text = model.cityNumber
            cityLabel.text = model.cityName
            countryLabel.text = model.countryName
            nextCityButton.enabled = model.enableNextCityButton
            
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(model.cityAnnotation)
            mapView.setRegion(model.mapRegion, animated: true)
        }
        
    }
    
    private func handleCityChange(sender: CityViewModelProtocol) {
        
        updateCityView()
    }
    
    @IBAction func handleNextCityTap(sender: UIButton) {
        
        viewModel?.nextCity()
    }
}
