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
func exampleArrayDeclarationAndCreation() {
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
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 :

var greeting = "Hello, playground"

//: [Next](@next)
