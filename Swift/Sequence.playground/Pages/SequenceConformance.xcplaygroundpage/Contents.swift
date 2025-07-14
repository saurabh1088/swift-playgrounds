//: [Previous](@previous)

// Created by Saurabh Verma on 07/14/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
/// Only conforming to Sequence protocol gives error.
///
/// `Type 'CustomSequence' does not conform to protocol 'Sequence'`
///
/// ```
/// struct CustomSequence: Sequence {}
/// ```
struct CustomSequence: Sequence, IteratorProtocol {
    var element: Int = 1

    mutating func next() -> Int? {
        element = element * 10
        return element
    }
    
    func makeIterator() -> CustomSequence {
        return self
    }
}

func exampleSequence() {
    let sequence = CustomSequence()
    
    for element in sequence {
        print(element)
        if element > 1000 { break }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Repeated Access
// TODO: Need to explore this

// MARK: -----------------------------------------------------------------------
// MARK: Examples
//exampleSequence()


//: [Next](@next)
