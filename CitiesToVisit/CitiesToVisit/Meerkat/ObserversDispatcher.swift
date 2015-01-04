//
//  ObserversDispatcher.swift
//  Meerkat
//
//  Created by Yanko Dimitrov on 12/30/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import Foundation

private class Observer<Sender> {
    
    weak var reference: AnyObject?
    let callback: (sender: Sender) -> Void
    
    init(reference: AnyObject, callback: (sender: Sender) -> Void) {
        
        self.reference = reference
        self.callback = callback
    }
}

public class ObserversDispatcher<SenderType>: ObserversDispatchable {
    
    typealias Sender = SenderType
    
    private lazy var observers = [Observer<Sender>]()
    
    deinit {
        
        removeAllObservers()
    }
    
    public func hasObserver(observer: AnyObject) -> Bool {
        
        if observers.filter({ $0.reference === observer }).count > 0 {
            
            return true
        }
        
        return false
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - ObserversDispatchable
    ///////////////////////////////////////////////////////
    
    public func addObserver(observer: AnyObject, withCallback: (sender: Sender) -> Void) {
        
        if !hasObserver(observer) {
            
            let element = Observer(reference: observer, callback: withCallback)
            
            observers.append(element)
        }
        
    }
    
    public func removeObserver(observer: AnyObject) {
        
        for (index, element) in enumerate(observers) {
            
            if element.reference === observer {
                
                observers.removeAtIndex(index)
                
                break
            }
        }
        
    }
    
    public func removeAllObservers() {
        
        observers.removeAll(keepCapacity: false)
    }
    
    public func dispatchWithSender(sender: Sender) {
        
        observers.map({ $0.callback(sender: sender) })
    }
}
