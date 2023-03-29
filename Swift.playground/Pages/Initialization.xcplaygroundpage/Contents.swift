// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Initialization`
 
 `Classes` and `Structs` must set all of theier stored properties to an appropriate initial value well in time
 by when instance is created.
 
 `When initial value for a stored property is set either as default value or set in initializer, will property observers get called?`
 
 No in this case no property observers will get called.
 
 `What do initializers in Swift return?`
 
 Swift initializers unlike Objective C, doesn't return any value.
 
 If a property is having some default value, then its a good practice to provide this default value in property declaration
 itself rather than providing it in initializer. The end result in both the cases is same however providing default value
 at time of declaration itself makes initializers short and cleaner.
 This way one can also utilize Swift's type inference.
 Also this way default initializers can be utilized.
 
 
 A constant stored property (let someProperty) can be assigned a value during initialization. In case of classes, this
 can only be done by class introducing the property, subclasses can't further modify this conntant property.
 
 `Initializer Delegation`
 
 `Initializer Delegation` is concept of one initializer calling another one. This is desirable to avoid code
 duplication. For value types `Initializer Delegation` is pretty straight forward. One can call ```self.init```
 from within initializers.
 
 */
import UIKit

/// Struct Employee below doesn't need any definition of initializer, for value types a default initializer is already
/// generated. So for structs a memberwise initializer get generated automatically and can be used, any default value
/// properties can be omitted from memberwise initializer.
struct Employee {
    var id: Int
    var name: String
    var dateOfJoining: Date
}
let employee1 = Employee(id: 1, name: "Batman", dateOfJoining: Date())

/// However if we were to define a custom initializer for our struct, things will change. We dfined a new struct
/// `StartUp` with two stored properties, also this struct defines a custom initializer which always sets the
/// founnded stored property value to current date. Notice the memberwise initializer for this struct is now no
/// longer available.

struct StartUp {
    var name: String
    var founded: Date
    init(name: String) {
        self.name = name
        self.founded = Date()
    }
}

let newStartUp = StartUp(name: "Justice League")
// Below will give compile error : Extra argument 'founded' in call
// let newStartUp = StartUp(name: "Justice League", founded: Date())

/// However lets go back to our previous struct Employee and add a new initializer in an extension, as struct
/// is already defined. Now let's see what all initializers are available.
/// We notice that when a custom initializer is defined in an extension then the memberwise initializer remains
/// available to use.
extension Employee {
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.dateOfJoining = Date()
    }
}

let employee2 = Employee(id: 2, name: "Superman", dateOfJoining: Date())
let employee3 = Employee(id: 3, name: "Wonder Woman")
