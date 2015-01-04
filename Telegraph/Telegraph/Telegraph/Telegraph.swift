//
//  Telegraph.swift
//  Telegraph
//
//  Created by Yanko Dimitrov on 1/2/15.
//  Copyright (c) 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public class Telegraph {
    
    public class var instance: Telegraph {
        
        struct Singleton {
            static let instance = Telegraph()
        }
        
        return Singleton.instance
    }
    
    private init() {}
    
    public let networkWasLost = ObserversDispatcher<Telegraph>()
    
    public func dispatch<T: ObserversDispatchable where T.Sender == Telegraph>(property: T) {
        
        property.dispatchWithSender(self)
    }
}
