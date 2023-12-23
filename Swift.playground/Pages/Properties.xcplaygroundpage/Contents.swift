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
 
 Computed properties are always var as theit values are never fixed and may change.
 
 `Enumerations doesn't have stored properties`
 
 `Property Observers`
 
 Property observers can be added to :
 - Defined Stored property
 - Inherited Stored property
 - Inherited Computed property
 
 Computed property that one define doesn't need to add property observer as that can be done in property setter
 itself.
 
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

func exampleForLazyProperty() {
    var obj = ExampleForLazyProperty()
    print(obj.computedProperty)
    print(obj.computedProperty)
    print(obj.lazyProperty)
    print(obj.lazyProperty)
    print(obj.lazyProperty)
}

/*
 Result of execution of above function exampleForLazyProperty is like below,
 note "Setting value for lazyProperty..."
 is printed only once when first time lazy property is accessed, next time it will
 only print the value.
 Basically the closure associated with lazy property will be executed only once
 when the first time lazy property is accessed.
 
 
 Calculating value for computedProperty...
 This is a computed property
 Calculating value for computedProperty...
 This is a computed property
 Setting value for lazyProperty...
 This is a lazy property
 This is a lazy property
 This is a lazy property
 */

/// `What will happen if a lazy stored property is accessed by multiple thread simultaneously?`
///
/// In this case if the lazy property when accessed by multiple thread simultaneously was still not initialized then
/// there is no gurantee that it will get initialized only once.

/// `Property Wrappers`
///
///

exampleForLazyProperty()

//: [Next](@next)
