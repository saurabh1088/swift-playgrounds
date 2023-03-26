//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Factory`
 
 `Factory` is a creational design pattern, as creational design patterns are all about removing the complexities
 while creating objects, so is the case with factory pattern.
 `Factory` pattern tries to encapsulate implementation details for creating objecs which have a common ancestor i.e. base class.
 In `Factory` pattern the clien uses a product object which it receives from a common interface without caring
 about the exact type of concrete object returned via `Factory`
 
 In this pattern there is a `Factory` which creates some objects. These objects are the products, client needs
 eventualy and asks a `Factory` to provide those.
 
 `How to differentiate Factory pattern with Abstract Factory pattern?`
 Good Explanation :-
 https://stackoverflow.com/questions/5739611/what-are-the-differences-between-abstract-factory-and-factory-design-patterns
 */

import Foundation

protocol UITheme {
    func fontSize() -> CGFloat
    func padding() -> CGFloat
}



//: [Next](@next)
