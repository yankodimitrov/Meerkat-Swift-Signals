//
//  ViewController.swift
//  Telegraph
//
//  Created by Yanko Dimitrov on 1/2/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let telegraph = Telegraph.instance
        
        telegraph.networkWasLost.addObserver(self, withCallback: {
            sender in
            
            println("Network is unreachable!")
        })
        
        telegraph.dispatch(telegraph.networkWasLost)
    }
    
    deinit {
        
        Telegraph.instance.networkWasLost.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

