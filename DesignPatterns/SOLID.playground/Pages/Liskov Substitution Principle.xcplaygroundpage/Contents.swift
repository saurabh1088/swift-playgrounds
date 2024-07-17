//: [Previous](@previous)

// Created by Saurabh Verma on 05/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Liskov Substitution Principle`
 
 As per Liskov Substitution Principle objects of a superclass should be replacable with objects of it's derived
 subclasses without breaking the program/application, or without affecting the correctness of the program.
 
 This principle ensures that a subclass can stand in for its superclass without causing unexpected behavior.
 
 In the example below for implementation of Area protocol `FourSideShape` it doesn't matter if Rectangle is
 passed or a Square, the area calculator method will be able to handle it.
 
 `Why?`
 1. Enhances Robustness by ensuring that the inherited classes enhance the base class without changing its
 fundamental behavior.
 2. Enhances Reliability by ensuring that subclass instances can be used in place of superclass instances.
 3. Enhances Maintainability as it leads to clear inheritance hierarchies.
 */
import Foundation

protocol Area {
    associatedtype T
    func areaOf(shape: T) -> Double
}

class Rectangle {
    var length: Double
    var breadth: Double
    
    init(length: Double, breadth: Double) {
        self.length = length
        self.breadth = breadth
    }
}

class Square: Rectangle {
    var side: Double
    
    init(side: Double) {
        self.side = side
        super.init(length: side, breadth: side)
    }
}

class FourSideShape: Area {
    typealias T = Rectangle
    func areaOf(shape: Rectangle) -> Double {
        return shape.length * shape.breadth
    }
}

let aRectangle = Rectangle(length: 12, breadth: 4)
let aSquare = Square(side: 4)
let areaCalculator = FourSideShape()
print("Area of aRectangle :: \(areaCalculator.areaOf(shape: aRectangle))")
print("Area of aSquare :: \(areaCalculator.areaOf(shape: aSquare))")

//: [Next](@next)
