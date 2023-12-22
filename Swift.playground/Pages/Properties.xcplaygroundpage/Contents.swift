//: [Previous](@previous)

// Created by Saurabh Verma on 22/12/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


import Foundation

/**

 `Properties`
 
 `Stored Properties`
 
 - Classes
 - Structures
 
 `Computed Properties`
 
 - Classes
 - Structures
 - Enumerations
 
 `Enumerations doesn't have stored properties`
 
 `Property Observers`
 
 Property observers can be added to stored properties defined as well as to those properties which are inherited
 from parent class.
 
 If an instance of structure is assigned to a let or constant, then one can't modify the property of that structure even
 of the property in structures definition is defined to be a var. The structure instance is assigned to a constant and
 hence it can't change.
 
 `Lazy Properties`
 
 A lazy stored property's initial value isn't calculated until it is used for the first time. A lazy property is always var.
 This is so because the value of a lazy property will be assigned once it's used hence it needs to be a var.
 Lazy properties are great to use for scenarios where the code is expensive and unlikely to be called too often.
 
 */

struct ExampleForLazyProperty {
    var computedProperty: String {
        print("Calculating value for computedProperty...")
        return "This is a computed property"
    }
    
    lazy var lazyProperty: String = {
        print("Setting value for lazyProperty...")
        return "This is a lazy property"
    }()
}

var obj = ExampleForLazyProperty()
print(obj.computedProperty)
print(obj.computedProperty)
print(obj.lazyProperty)
print(obj.lazyProperty)
print(obj.lazyProperty)

/*
 Result of above print statements is like below, note "Setting value for lazyProperty..."
 is printed only once when first time lazy property is accessed, next time it will
 only print the value.
 
 
 Calculating value for computedProperty...
 This is a computed property
 Calculating value for computedProperty...
 This is a computed property
 Setting value for lazyProperty...
 This is a lazy property
 This is a lazy property
 This is a lazy property
 */


//: [Next](@next)
