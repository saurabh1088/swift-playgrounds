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

/// `Initialization for Reference types`
/// For reference types the initialization should make sure not only to initialize stored properties the class type
/// introduces, but also the stored properties it is inheriting from it's parent.
/// To help aid this requirement Swift provides two kinds of initializers
///
/// 1. `Designated Initializers`
/// 2. `Convenience Initializers`
///
/// `Designated Initializers`
///
/// These are the primary initializers and these fully initialize a class and also call superclass initializers.
/// Calling superclass initializer is important so as to make sure to initialize stored properties of superclass as
/// well and in this manner class object instantiated is fully initialized.
/// Every class MUST have at least ONE designated initializer.
///
/// `Convenience Initializers`
///
/// Convenience initializers support initialization process for a class but are secondary and not mandatory so unless
/// there is requirement there is no need to add them. Convenience initializers are marked with convenience.
///
/// `Rules for Initializer delegation for Class types`
/// 1. A designated initializer MUST call a designated initializer from it's immediate superclass
/// 2. A convenience initializer (if defined) MUST call another initializer from SAME class (this could be designated
/// initializer or another convenience initializer)
/// 3. A convenience initializer MUST eventually call a designated initializer.
///
/// `Class initialization in Swift`
/// Class initialization in Swift is a two-phase process.
/// In 1st Phase each stored property is assigned an initial value by the class which introduced the property.
/// In 2nd Phase, class gets an opprtunity to customize it's stored properties before the instance is is fully realized
/// ready for use.
/// This two phase initialization helps preventing any stored value being accidently used without being properly
/// initialized. Also this helps preventing stored property values being assigned to some other values by any another
/// initializer.