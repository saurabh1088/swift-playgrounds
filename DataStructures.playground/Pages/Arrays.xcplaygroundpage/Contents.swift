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
// MARK: Example 3 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 :


exampleArrayDeclarationAndCreation()
exampleArrayAvailableHelperProperties()

var greeting = "Hello, playground"

//: [Next](@next)
