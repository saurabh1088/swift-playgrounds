//: [Previous](@previous)

// Created by Saurabh Verma on 06/12/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import Foundation

/**
 `Self vs self`
 
 `Self : The one with uppercase S`
 
 `Self` refers to the type that conforms to the protocol. It allows for defining requirements that are dependent
 on the specific type conforming to the protocol.
 
 
 `self : The one with lowercase s`
 
 `self` refers to the instance of the conforming type within methods, similar to this in other languages.
 */
// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
protocol Duplicatable {
    // Self here is a return type, and this will refer to the conforming type.
    // Which means, the type which conforms to this protocol will match the type
    // of Self.
    func duplicate() -> Self
}

struct TwiceTheInteger: Duplicatable {
    var value: Int
    
    func duplicate() -> TwiceTheInteger {
        TwiceTheInteger(value: value * 2)
    }
}

func example1() {
    let twiceTheInteger = TwiceTheInteger(value: 10)
    let duplicate = twiceTheInteger.duplicate()
    print(duplicate)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples
example1()


//: [Next](@next)
