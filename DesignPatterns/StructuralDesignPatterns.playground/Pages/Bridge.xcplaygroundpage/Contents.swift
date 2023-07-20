// Created by Saurabh Verma on 24/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

//: [<- Adaptor](@previous)

/**
 `Bridge`
 Bridge design pattern is a structural design pattern that decouples an abstraction from its implementation so
 that both can vary independently.
 */
import UIKit

/// Example : The problem

protocol Shape {
    func draw()
}

class Circle: Shape {
    func draw() {
        print("Did draw a circle")
    }
}

class Square: Shape {
    func draw() {
        print("Did draw a square")
    }
}

// Now if we want a red circle then
class RedCircle: Circle {
    override func draw() {
        print("Did draw a red circle")
    }
}

/// This approach works fine, but this example is very simple. Suppose we only have two shapes like above, i.e.
/// Circle and Square if we consider even seven colors, we are looking at fourteen classes to have each share
/// corresponds to each color.
/// This problem could be solved using bridge pattern.

protocol ColoredShape {
    var shape: Shape { get set }
    func draw()
}

class RedColoredShape: ColoredShape {
    var shape: Shape
    init(shape: Shape) {
        self.shape = shape
    }
    func draw() {
        print(shape.draw())
    }
}

let redCircle = RedColoredShape(shape: Circle())

//: [Composite Pattern ->](@next)
