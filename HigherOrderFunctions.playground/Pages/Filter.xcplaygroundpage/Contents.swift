//: [Previous](@previous)

// Created by Saurabh Verma on 23/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Filter`
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
func exampleArrayFilter1() {
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let evenNumbers = array.filter { $0 % 2 == 0 }
    print(array)
    print(evenNumbers)
}

exampleArrayFilter1()

//: [Next](@next)
