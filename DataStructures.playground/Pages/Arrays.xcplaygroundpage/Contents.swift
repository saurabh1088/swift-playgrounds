//: [Previous](@previous)

// Created by Saurabh Verma on 18/02/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


/**
 `Array`
 
 `Array` in Swift is implemented using structures and generics. The declaration is as below:
 ```
 struct Array<Element>
 
 - Holds elements of single type
 - Array is declared as a struct so Array itself is a value type, however it can
 hold elements which are reference type.
 ```
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Declaring & Creating Arrays
/// Declaration simply using list of comma separated values to hold
let someIntArray = [1, 2, 3, 4, 5]
let someStringArray = ["Batman", "Superman", "Wonder Woman", "Aquaman"]

/// Declaration of an empty array
/// While declaraing an empty Array, compiler will mandate to provide type it will hold else it will cry with error:
///
/// `Empty collection literal requires an explicit type`
/// ```
/// let emptyArray = []
/// ```
let emptyIntArray: [Int] = []

/// One can also declare using generic syntax like Array<TypeOfElementToHold>
let arrayUsingGenericSyntax: Array<Int> = Array()

func exampleArrayDeclarationAndCreation() {
    print(someIntArray)
    print(someStringArray)
    print("Have we created emptyIntArray as empty :: \(emptyIntArray.isEmpty)")
    print("arrayUsingGenericSyntax created with syntax Array<Int> and Array(), is it empty? :: \(arrayUsingGenericSyntax.isEmpty)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Array available helper properties
func exampleArrayAvailableHelperProperties() {
    // Check if Array is empty
    print("Is emptyIntArray empty :: \(emptyIntArray.isEmpty)")
    
    // Count of elements
    print("someIntArray contains \(someIntArray.count) elements")
    
    // Get first element
    if let firstElement = someStringArray.first {
        print("First element in someStringArray :: \(firstElement)")
    }
    
    // Get last element
    if let lastElement = someStringArray.last {
        print("Last element in someStringArray :: \(lastElement)")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Array capacity
/// `Array's capacity`
/// `capacity` is an instance property on Array, it gives a count of number of elements array can contain without
/// allocating new storage.
/// For Array the compiler will reserve certain amount of memory to hold its contents. When one appends more
/// elements to the Array then if more storage is required then the new storage allocate is in multiples of old storage
/// size.
///
/// For example in the example method below the array `someArray` defined initially is having 5 elements so
/// at this time both `count` and `capacity` of the array is 5. If another element is appended to `someArray`
///
/// Note: Both insert and append have same result on capacity, removal however doesn't changes the capacity.
func exampleArrayCapacity() {
    // Append
    var someArray = [1, 2, 3, 4, 5]
    print("Capacity & count of someArray once array is initialised with some values")
    print("Count :: \(someArray.count)")
    print("Capacity :: \(someArray.capacity)")
    someArray.append(6)
    print("Capacity & count of someArray once more value is appended to it")
    print("Count :: \(someArray.count)")
    print("Capacity :: \(someArray.capacity)")
    
    // Insert
    var anotherArray = [1, 2, 3, 4, 5]
    print("Capacity & count of anotherArray once array is initialised with some values")
    print("Count :: \(anotherArray.count)")
    print("Capacity :: \(anotherArray.capacity)")
    anotherArray.insert(0, at: 0)
    print("Capacity & count of anotherArray once an element is inserted at some index")
    print("Count :: \(anotherArray.count)")
    print("Capacity :: \(anotherArray.capacity)")
    anotherArray.remove(at: 0)
    anotherArray.remove(at: 1)
    print("Capacity & count of anotherArray once an element is removed from some index")
    print("Count :: \(anotherArray.count)")
    print("Capacity :: \(anotherArray.capacity)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 : Reserve Capacity
/// As per Apple's documentation for method `reserveCapacity(_:)` the newly allocated storage might be greater
/// than the requested capacity.
func exampleArrayReserveCapacity() {
    var exampleArrayNoReserve = [1, 2, 3, 4, 5]
    print("Capacity for exampleArrayNoReserve :: \(exampleArrayNoReserve.capacity)")
    exampleArrayNoReserve.append(6)
    print("Capacity for exampleArrayNoReserve on append :: \(exampleArrayNoReserve.capacity)")
    
    var exampleArrayWithReserve = [1, 2, 3, 4, 5]
    print("Capacity for exampleArrayWithReserve :: \(exampleArrayWithReserve.capacity)")
    exampleArrayWithReserve.reserveCapacity(6)
    exampleArrayWithReserve.append(6)
    print("Capacity for exampleArrayWithReserve on append with reserve :: \(exampleArrayWithReserve.capacity)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 :


exampleArrayDeclarationAndCreation()
exampleArrayAvailableHelperProperties()
exampleArrayCapacity()
exampleArrayReserveCapacity()

//TODO: Check discussion regarding performance
// https://developer.apple.com/documentation/swift/array/reservecapacity(_:)-5cknc

//: [Next](@next)
