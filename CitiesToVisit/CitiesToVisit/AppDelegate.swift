//
//  AppDelegate.swift
//  CitiesToVisit
//
//  Created by Yanko Dimitrov on 1/2/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let cities = CitiesListRepository()
        
        cities.add(City(name: "Vienna", country: "Austria", latitude: 48.208174, longitude: 16.373819))
        cities.add(City(name: "Berlin", country: "Germany", latitude: 52.520007, longitude: 13.404954))
        cities.add(City(name: "San Francisco", country: "USA", latitude: 37.774929, longitude: -122.419416))
        cities.add(City(name: "Cape Town", country: "South Africa", latitude: -33.924869, longitude: 18.424055))
        cities.add(City(name: "Krakow", country: "Poland", latitude: 50.064650, longitude: 19.944980))
        cities.add(City(name: "Kyoto", country: "Japan", latitude: 35.011636, longitude: 135.768029))
        cities.add(City(name: "Sydney", country: "Australia", latitude: -33.867487, longitude: 151.206990))
        
        let cityViewModel = CityViewModel(repository: cities)
        
        let cityViewController: CityViewController = storyboard.instantiateInitialViewController() as CityViewController
            cityViewController.viewModel = cityViewModel
        
        window?.rootViewController = cityViewController
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

