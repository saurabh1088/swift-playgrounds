// Created by Saurabh Verma on 11/07/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Key Value Coding & Key Value Observing`
 
 `Key-Value Coding (KVC)`
 It is a technique in Objective-C and to some extent in Swift, which allows one to access an object's properties
 indirectly using string identifiers. This implies one can get or set value of a property using a string rather than
 accessing the property directly.
 
 `Key-Value Observing (KVO)`
 It is a mechanism which allows objects to be notified of changes to specified properties of other objects. It's commonly
 used for implementing the observer pattern, enabling one object to observe changes in another object's properties.
 
 `Is KVC & KVO available in Swift?`
 Yes KVS and KVO are available in Swift, however it works with some constraints.
 */
import UIKit

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Creating Key Value Coding complaint class and accessing values
class Employee: NSObject {
    @objc let id: Int
    @objc let name: String
    @objc let address: Address
    
    init(id: Int, name: String, address: Address) {
        self.id = id
        self.name = name
        self.address = address
    }
}

class Address: NSObject {
    @objc let zipcode: Int
    @objc let addressLine1: String
    @objc let street: String
    @objc let city: String
    @objc let country: String
    
    init(zipcode: Int, addressLine1: String, street: String, city: String, country: String) {
        self.zipcode = zipcode
        self.addressLine1 = addressLine1
        self.street = street
        self.city = city
        self.country = country
    }
}

/// Important to note here is that any the property being accessed using `value(forKey:)` should be KVC
/// complaint. In Swift class, to make so, one need to mark property with `@objc`. If property isn't marked with
/// `@objc` then at runtime following error will be thrown.
///
/// `Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<__lldb_expr_7.Employee 0x600000250880> valueForUndefinedKey:]: this class is not key value coding-compliant for the key name.'`
func exampleKeyValueCodingComplaintClass() {
    let address = Address(zipcode: 100,
                          addressLine1: "Wayn Manor",
                          street: "Dark Street",
                          city: "Gotham",
                          country: "USA")
    let employee = Employee(id: 1, 
                            name: "Batman", 
                            address: address)
    if let employeeName = employee.value(forKey: "name"),
       let employeeId = employee.value(forKey: "id"),
       let employeeCity = employee.value(forKeyPath: "address.city") {
        print("Employee details ::")
        print("ID : \(employeeId)")
        print("Name : \(employeeName)")
        print("City : \(employeeCity)")
    }
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Key Value Observing
class ClassWithObservableProperties: NSObject {
    @objc dynamic var observable: String
    @objc var nonobservable: String
    
    init(observable: String, nonobservable: String) {
        self.observable = observable
        self.nonobservable = nonobservable
    }
}

/// `Passing reference to non-'@objc dynamic' property 'observable' to KVO method 'observe(_:options:changeHandler:)' may lead to unexpected behavior or runtime trap`
class ObservingClass: NSObject {
    @objc let someObservable: ClassWithObservableProperties
    var observation: NSKeyValueObservation?
    
    init(someObservable: ClassWithObservableProperties) {
        self.someObservable = someObservable
        super.init()
        self.observation = self.observe(\.someObservable.observable, options: [.old, .new], changeHandler: { object, change in
            if let oldValue = change.oldValue, let newValue = change.newValue {
                print("*******************************************************")
                print("Old Value : \(oldValue)")
                print("New Value : \(newValue)")
            }
        })
    }
}

func exampleKeyValueObserving() {
    let observableObject = ClassWithObservableProperties(observable: "-", nonobservable: "Start")
    let observingObject = ObservingClass(someObservable: observableObject)
    observableObject.observable = "Change 1"
    observableObject.observable = "Change 2"
    observableObject.observable = "Change 3"
}

// MARK: -----------------------------------------------------------------------
// MARK: Example method calls

//exampleKeyValueCodingComplaintClass()
exampleKeyValueObserving()
