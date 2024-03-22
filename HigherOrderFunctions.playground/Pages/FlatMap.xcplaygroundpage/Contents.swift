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
func exampleArrayFlatMap2() {
    let array = ["1", "Two", "3", "4", "Five"]
    let flatArray = array.flatMap { String($0) }
    print(array)
    print(flatArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleArrayFlatMap1()
exampleArrayFlatMap2()


//: [Next](@next)
