//
//  TelegraphTests.swift
//  Telegraph
//
//  Created by Yanko Dimitrov on 1/2/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import UIKit
import XCTest

class TelegraphTests: XCTestCase {
    
    func testSingletonInstance() {
        
        let instanceA = Telegraph.instance
        let instanceB = Telegraph.instance
        
        XCTAssert(instanceA === instanceB, "Singleton instances should point to the same memory address")
    }
}
