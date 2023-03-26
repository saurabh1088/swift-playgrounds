//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Factory`
 
 `Factory` is a creational design pattern, do note however it's not at all related to `Abstract Factory`.
 As creational design patterns are all about removing the complexities while creating objects, so is the case with
 factory pattern. `Factory` pattern tries to encapsulate implementation details for creating objecs which have
 a common ancestor i.e. base class.
 In `Factory` pattern the clien uses a product object which it receives from a common interface without caring
 about the exact type of concrete object returned via `Factory`
 */

import Foundation

protocol UITheme {
    func fontSize() -> CGFloat
    func padding() -> CGFloat
}



//: [Next](@next)
