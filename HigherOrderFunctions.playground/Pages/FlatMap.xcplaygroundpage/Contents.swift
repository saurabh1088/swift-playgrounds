//: [Previous](@previous)

// Created by Saurabh Verma on 22/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


/**
 `Flat Map`
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
func exampleArrayFlatMap1() {
    let array = [[1, 2, 3], [4, 5], [6], [7, 8, 9, 10], [11, 12, 13, 14, 15, 16], [[17], [18, 19, 20]]]
    let flatArray = array.flatMap { $0 }
    print(array)
    print(flatArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :
/// NOTE: 'flatMap' is deprecated: Please use compactMap(_:) for the case where closure returns an optional value.
/// This example will work fine and return an array with nil values removed but one should use compactMap for the same.
func exampleArrayFlatMap2() {
    let array = ["1", "Two", "3", "4", "Five"]
    let flatArray = array.flatMap { Int($0) }
    print(array)
    print(flatArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 :
// TODO: Check what's the optional optional is referred to in the example at below link
// https://www.hackingwithswift.com/articles/205/whats-the-difference-between-map-flatmap-and-compactmap
struct Employee {
    let id: Int
    let name: String
    let linkedInURL: String
}

func exampleArrayFlatMap3() {
    let employees = [Employee(id: 1, name: "Batman", linkedInURL: "https://www.linkedin.com/in/Batman-1"),
                     Employee(id: 2, name: "Superman", linkedInURL: ""),
                     Employee(id: 3, name: "Wonder Woman", linkedInURL: "https://www.linkedin.com/in/WW-1"),
                     Employee(id: 4, name: "Aquaman", linkedInURL: "")]
    let linkedInURLs = employees.map { URL(string: $0.linkedInURL) }
    print(employees)
    print(linkedInURLs)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleArrayFlatMap1()
//exampleArrayFlatMap2()
//exampleArrayFlatMap3()


//: [Next](@next)
