#Meerkat - Swift Signals
Allows one-to-many communication between objects via observable properties (signals), while keeping your classes loosely coupled.

![Swift Signals UML class diagram](https://raw.githubusercontent.com/yankodimitrov/Meerkat-Swift-Signals/master/meerkat-uml-class-diagram.png "Figure 1. Swift Signals UML class diagram")

*Figure 1: Swift Signals UML class diagram*

##Concept
- Each signal is a separate property that represents a specific event type and dispatches only to observers that are interested in it;
- A signal property can have zero or N observers. Allowing for one-to-one or one-to-many communication;
- Any object can act as an observer;
- To register as an observer the object must provide a callback method/closure which accepts as an argument the sender of that signal. The type of the sender is defined when creating the signal property and usually is the type of the class that contains it;

##Installation
- Copy the contents of the <code>Meerkat/Meerkat</code> folder to your project:
    - <code>ObserversDispatchable.swift</code>
    - <code>ObserversDispatcher.swift</code>

##Usage

####1. Define an observable signal property

The <code>nameDidChange</code> property found in the <code>NameHolder</code> protocol's definition below is an example of an observable property. Here the type of the sender is set to an instance of the <code>NameHolder</code> protocol:

```swift
protocol NameHolder {
    
    var nameDidChange: ObserversDispatcher<NameHolder> {get}
    var name: String {get set}
}
```
####2. Observe the signal property

The <code>NameObserver</code> class accepts an implementation of the <code>NameHolder</code> protocol in its initializer and adds itself as an observer to the <code>nameDidChange</code> signal. Upon deinitialization it removes itself from the list with observers:

```swift
class NameObserver {

    let subject: NameHolder
    
    init(nameHolder: NameHolder) {
        
        subject = nameHolder
        
        subject.nameDidChange.addObserver(self, withCallback: {
            sender in
            
            println("name changed to \(sender.name)")
        })
    }
    
    deinit {
        
        subject.nameDidChange.removeObserver(self)
    }
}
```

####3. Dispatch the signal

The <code>Person</code> class shown below implements the <code>NameHolder</code> protocol and dispatches the <code>nameDidChange</code> signal when a new value is set to the <code>name</code> property:

```swift
class Person: NameHolder {
    
    let nameDidChange = ObserversDispatcher<NameHolder>()
    
    var name: String {
        
        didSet {
            nameDidChange.dispatchWithSender(self)
        }
    }
    
    init(name: String) {
        
        self.name = name
    }
}
```

```swift
let person = Person(name: "John")
let observer = NameObserver(nameHolder: person)
        
person.name = "Mike"

// console output: "name changed to Mike"

```

##Examples
Inside the repository you will find two example projects: Telegraph and CitiesToVisit.

####1. Telegraph
*Telegraph* is an example of creating a custom central notification hub, an alternative to <code>NSNotificationCenter</code>. 

```swift
class Telegraph {
    
    class var instance: Telegraph {
        
        struct Singleton {
            static let instance = Telegraph()
        }
        
        return Singleton.instance
    }
    
    private init() {}
    
    let networkWasLost = ObserversDispatcher<Telegraph>()
    
    func dispatch<T: ObserversDispatchable where T.Sender == Telegraph>(property: T) {
        
        property.dispatchWithSender(self)
    }
}
```

Where you can dispatch a signal by calling the <code>dispatch</code> method with an observable property that is part of the <code>Telegraph</code> class:

```swift
let telegraph = Telegraph.instance
    
telegraph.dispatch(telegraph.networkWasLost)
```

####2. Cities To Visit

*Cities to visit* is an simple example of implementing the MVVM architecture using signals to communicate between the Model, ViewModel and the View (ViewController).

##Inspiration
This project was inspired by [Robert Penner's](https://github.com/robertpenner) work on the [ActionScript 3 Signals library](https://github.com/robertpenner/as3-signals).

##License
Meerkat - Swift Signals is released under the MIT license. See the LICENSE.txt file for more info.