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
 
 Computed properties are always var as their values are never fixed and may change.
 
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
 
 `Lazy Properties : static var/let`
 
 A lazy stored property's initial value isn't calculated until it is used for the first time. A lazy property is always var.
 This is so because the value of a lazy property will be assigned once it's used hence it needs to be a var.
 Lazy properties are great to use for scenarios where the code is expensive and unlikely to be called too often.
 
 `Note: Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties, however these aren't required to be marked with lazy keyword.`
 
 `Type Properties`
 
 These are properties which belong to a Type rather than belonging to the instance of the Type.
 Type properties can be both
 - Stored (var or let)
 - Computed (var ONLY)
 
 Stored type properties should always have a default value, because Type doesn't have any initializer which can
 initialize it's type properties and assign some value.
 
 Stored type properties when accessed for first time are lazily initialized. Swift gurantees that these will get initialized
 only once even if accessed by multiple threads simultaneously. There is no need to add keyword lazy.
 
 `What's the difference between static and class keyword?`
 
 `static`  and `class` both are keywords used to declare a Type property. `class` keyword can be used for
 computed properties for class Types so as to allow subclasses to override those.

 `class` keyword can only be used within a class Type, using inside struct will give compilor error with message :
 Class properties are only allowed within classes; use 'static' to declare a static property.
 
 Even in class, using `class` keyword for stored property will make compiler cry :
 Class stored properties not supported in classes; did you mean 'static'?.
 
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
/// Concept of property wrapper in Swift helps in defining a layer which separates the code defining a property
/// from code which manages how the property is stored.
/// Use case for property wrapper is that suppose we have to define a property on which one needs to apply some
/// custom logic, for example we want to define a property and make sure it is thread safe, then those thread
/// safety check needs to go for all properties which needs such feature. Using property wrapper one can add
/// such c feature in a wrapper and then use the property wrapper on any property where such use case is expected.
///
/// Property wrapper basically is a `type` which wraps a given value to add some additional logic to it.
///
/// For example, let's say we need to define a property but also need to make sure it's never greater than 10.
/// Below code example `LessThanTen` & `exampleCustomPropertyWrapper()` shows how to achieve
///  that using a property wrapper.

/// When `@propertyWrapper` is used then compiler expects type to provide a `wrappedValue` else it will complain
/// with error :
/// Property wrapper type 'LessThanTen' does not contain a non-static property named 'wrappedValue'
///
/// `Can property wrapper be applied to Global variables?`
/// NO
///
/// `Can property wrapper be applied to computed properties?`
/// NO
///
/// `Can property wrapper be applied to a local variable?`
/// YES, for example one can apply a property wrapper to a variable defined locally withing scope of a function.
/// See example function below `exampleUsingPropertyWrapperInsideFunction()`
///
/// `Can one use @propertyWrapper on classes and structures both?`
/// YES


@propertyWrapper
struct LessThanTen {
    private var value = 0
    var wrappedValue: Int {
        get { return value }
        set { value = min(newValue, 10) }
    }
}

struct UsingCustomPropertyWrapper {
    @LessThanTen var someNumber: Int
}

func exampleCustomPropertyWrapper() {
    var obj = UsingCustomPropertyWrapper()
    obj.someNumber = 12
    print("Tried to set value to 12, here's the result : \(obj.someNumber)")
}

/// `Property Wrappers : With initializers`
///
/// One can also define a property wrapper with initializers so that some initial value can be set. For example
/// on the example above of `LessThanTen` the property wrapper can only be used for values which need
/// to be less than 10, so the usage is pretty restricted, it would be great if we can set a custom maximum value.

@propertyWrapper
struct RestrictValueToMaximum {
    private var number: Int
    private var maximum: Int
    
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    
    /// It makes sense to call the argument as wrappedValue even though in initializer is setting the property
    /// number because technically wrappedValue is returning number itself, but as number is private and should
    /// be so as someone using this property wrapper need not to know about it so calling it wrappedValue gives
    /// correct impression that the wrapped value by the property wrapper will be initialzed to passed value.
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        self.number = min(wrappedValue, maximum)
    }
}

struct UsingRestrictValueToMaximumWrapper {
    /// This declaration using property wrapper is using the initializer to set wrapped value and maximum value
    /// This can also be defined as with same results:
    /// ```
    /// @RestrictValueToMaximum(maximum: 20) var value: Int = 1
    /// ```
    /// This is so because Swift treats assignment (= 1) like a wrappedValue argument and then will set the
    /// assigned value to the wrappedValue so in above declaration wrappedValue will get treated as 1 and
    /// maximum as 20.
    @RestrictValueToMaximum(wrappedValue: 1, maximum: 20) var value: Int
}

func exampleRestrictValuePropertyWrapper() {
    var obj = UsingRestrictValueToMaximumWrapper()
    print("Default value is : \(obj.value)")
    print("Setting value to greater than 20...")
    obj.value = 100
    print("Value now is : \(obj.value)")
}

func exampleUsingPropertyWrapperInsideFunction() {
    @LessThanTen var localVariable: Int
    localVariable = 20
    print("Value of localVariable : \(localVariable)")
}

struct StructureWithTypeProperties {
    /// Not giving initial value here will make compiler cry with error :
    /// 'static var' declaration requires an initializer expression or an explicitly stated getter
    static var typeStoredProperty = "Stored Type Property"
    static var typeComputedProperty: String {
        "Computed Type Property"
    }
}

class ClassWithTypeProperties {
    /// Using class keyword here will make compiler cry :
    /// Class stored properties not supported in classes; did you mean 'static'?
    static var typeStoredProperty = "Stored Type Property"
    static var typeComputedProperty: String {
        "Computed Type Property"
    }
    class var overrideableTypeComputedProperty: String {
        "Overrideable Computed Type Property"
    }
}

class SubclassClassWithTypeProperties: ClassWithTypeProperties {
    override class var overrideableTypeComputedProperty: String {
        "Overridden Computed Type Property from Parent"
    }
}

/// `Projected Value from property wrapper`

@propertyWrapper
struct EvenNumberChecker {
    private var number: Int
    private(set) var projectedValue: Bool
    
    var wrappedValue: Int {
        get { number }
        set { 
            if newValue % 2 == 0 {
                number = newValue
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        self.number = 0
        self.projectedValue = true
    }
}

@propertyWrapper
struct WrapperWithProjectedValueAsSelf {
    var projectedValue: WrapperWithProjectedValueAsSelf { self }
    var twoTimes: Int
    var threeTimes: Int
    private var number: Int
    var wrappedValue: Int {
        get { number }
        set {
            number = newValue
            twoTimes = number * 2
            threeTimes = number * 3
        }
    }
    
    init() {
        number = 0
        twoTimes = 0
        threeTimes = 0
    }
}

struct UsingEvenNumberChecker {
    @EvenNumberChecker var value: Int
}

struct UsingWrapperWithProjectedValueAsSelf {
    @WrapperWithProjectedValueAsSelf var value: Int
}

func examplePropertyWrapperEvenNumberChecker() {
    var obj = UsingEvenNumberChecker()
    obj.value = 3
    print("Value set is \(obj.value), projected value : \(obj.$value)")
    
    obj.value = 20
    print("Value set is \(obj.value), projected value : \(obj.$value)")
    
}

func examplePropertyWrapperWithProjectedValueAsSelf() {
    var obj = UsingWrapperWithProjectedValueAsSelf()
    obj.value = 2
    print("Value : \(obj.value)")
    print("Value two times : \(obj.$value.twoTimes)")
    print("Value three times : \(obj.$value.threeTimes)")
}

func exampleTypeProperties() {
    print(StructureWithTypeProperties.typeStoredProperty)
    print(StructureWithTypeProperties.typeComputedProperty)
    
    print(SubclassClassWithTypeProperties.typeStoredProperty)
    print(SubclassClassWithTypeProperties.typeComputedProperty)
    print(SubclassClassWithTypeProperties.overrideableTypeComputedProperty)
}

/// Examples
//exampleForLazyProperty()
//exampleCustomPropertyWrapper()
//exampleRestrictValuePropertyWrapper()
//exampleUsingPropertyWrapperInsideFunction()
//exampleTypeProperties()
//examplePropertyWrapperEvenNumberChecker()
examplePropertyWrapperWithProjectedValueAsSelf()

// TODO: Check this : https://www.swiftbysundell.com/articles/property-wrappers-in-swift/
// TODO: Explore projected values for property wrappers

//: [Next](@next)
