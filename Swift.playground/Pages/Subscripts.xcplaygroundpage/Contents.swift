//: [Previous](@previous)

// Created by Saurabh Verma on 25/02/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Subscripts`
 
 `Subscripts` are shortcuts, used to access elements of a collection. Subscripts can be defined by:
 
 - Classes
 - Structures
 - Enumerations
 
 For example elements in an Array can be accessed using index inside square brackets as following
 
 ```
 var someArray = [1, 2, 3, 4, 5]
 someArray[0]
 ```
 
 A type can define more than one subscripts.
 Subscripts aren't limited to single parameter, multiple input parameters can be also provided.
 
 To define one needs to use keyword `subscript`. The definition itself is similar to the way one defines computed
 properties.
 
 Subscripts can be read-only OR read-write. In case of read-only one needs to define only the get block.
 
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Defining an Subscript
struct MultiplicationTable {
    let base: Int
    
    subscript(index: Int) -> Int {
        return base * index
    }
}

func exampleSubscript() {
    let multiplicationTableFive = MultiplicationTable(base: 5)
    print("Table of 5")
    for index in 1...10 {
        print("5 x \(index) = \(multiplicationTableFive[index])")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :
struct ConvertToUpperCaps {
    subscript(text: String) -> String {
        return text.uppercased()
    }
}

func exampleSubscriptUsingStrings() {
    let convertToCaps = ConvertToUpperCaps()
    print(convertToCaps["because"])
    print(convertToCaps["i"])
    print(convertToCaps["am"])
    print(convertToCaps["batman"])
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 :
struct Multiplication {
    subscript(a: Int, b: Int) -> Int {
        return a * b
    }
}

func exampleSubscriptWithMultipleArguments() {
    let multiplier = Multiplication()
    print("12 x 23 = \(multiplier[12, 23])")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example method calls

exampleSubscript()
exampleSubscriptUsingStrings()
exampleSubscriptWithMultipleArguments()

//: [Next](@next)
