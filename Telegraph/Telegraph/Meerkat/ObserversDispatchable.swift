//
//  ObserversDispatchable.swift
//  Meerkat
//
//  Created by Yanko Dimitrov on 12/30/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import Foundation

public protocol ObserversDispatchable {
    
    typealias Sender
    
    func addObserver(observer: AnyObject, withCallback: (sender: Sender) -> Void)
    func removeObserver(observer: AnyObject)
    func removeAllObservers()
    func dispatchWithSender(sender: Sender)
}