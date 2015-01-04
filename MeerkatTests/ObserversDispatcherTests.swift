//
//  ObserversDispatcherTests.swift
//  Meerkat
//
//  Created by Yanko Dimitrov on 12/30/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import UIKit
import XCTest

class ObserversDispatcherTests: XCTestCase {
    
    class Subject {
        
        let valueDidChange = ObserversDispatcher<Subject>()
    }
    
    var subject = Subject()
    
    override func setUp() {
        super.setUp()
        
        subject = Subject()
    }
    
    func testThatWeCanAddNewObserver() {
        
        subject.valueDidChange.addObserver(self, withCallback: { sender in })
        
        XCTAssertTrue(subject.valueDidChange.hasObserver(self), "We should be able to add a new observer")
    }
    
    func testThatWeAreUnableToAddTheSameObserverWithDifferentCallback() {
        
        var isSecondCallbackCalled = false
        
        subject.valueDidChange.addObserver(self, withCallback: { sender in })
        
        subject.valueDidChange.addObserver(self, withCallback: {
            sender in
            
            isSecondCallbackCalled = true
        })
        
        subject.valueDidChange.dispatchWithSender(subject)
        
        XCTAssertFalse(isSecondCallbackCalled, "We should be unable to add the same observer with different callback")
    }
    
    func testThatWeCanRemoveObserver() {
        
        subject.valueDidChange.addObserver(self, withCallback: { sender in })
        subject.valueDidChange.removeObserver(self)
        
        XCTAssertFalse(subject.valueDidChange.hasObserver(self), "We should be able to remove an observer")
    }
    
    func testThatWeCanRemoveAllObservers() {
        
        class SecondObserver {}
        
        let secondObserver = SecondObserver()
        
        subject.valueDidChange.addObserver(self, withCallback: { sender in })
        subject.valueDidChange.addObserver(secondObserver, withCallback: { sender in })
        
        subject.valueDidChange.removeAllObservers()
        
        XCTAssertFalse(subject.valueDidChange.hasObserver(self), "We should be able to remove all observers")
        XCTAssertFalse(subject.valueDidChange.hasObserver(secondObserver), "We should be able to remove all observers")
    }
    
    func testThatWeCanNotifyObservers() {
        
        var isCallbackCalled = false
        
        subject.valueDidChange.addObserver(self, withCallback: {
            sender in
            
            isCallbackCalled = true
        })
        
        subject.valueDidChange.dispatchWithSender(subject)
        
        XCTAssertTrue(isCallbackCalled, "We should be able to notify the observers")
    }
}
