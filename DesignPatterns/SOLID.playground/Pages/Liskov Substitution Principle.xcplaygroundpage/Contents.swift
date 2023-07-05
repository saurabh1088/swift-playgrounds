//: [Previous](@previous)

// Created by Saurabh Verma on 05/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Liskov Substitution Principle`
 
 As per Liskov Substitution Principle objects of a superclass should be replacable with objects of it's derived
 subclasses without breaking the program/application.
 
 In the example below for implementation of Area protocol `FourSideShape` it doesn't matter if Rectangle is
 passed or a Square, the area calculator method will be able to handle it.
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
