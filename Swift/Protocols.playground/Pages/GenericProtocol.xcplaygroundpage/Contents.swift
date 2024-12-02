//: [Previous](@previous)

// Created by Saurabh Verma on 02/12/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Generic Protocol
protocol Container {
    associatedtype Element
    var elements: [Element] { get }
    func add(element: Element)
    func remove(element: Element)
}

class GenericContainer<Content: Equatable>: Container, CustomStringConvertible {
    var elements = [Content]()
    
    var description: String {
        return elements.reduce("") { partialResult, content in
            partialResult + "\n \(content)"
        }
    }
    
    func add(element: Content) {
        elements.append(element)
    }
    
    func remove(element: Content) {
        elements.removeAll(where: { $0 == element })
    }
}

func example1() {
    let integerContainer = GenericContainer<Int>()
    integerContainer.add(element: 1)
    integerContainer.add(element: 2)
    integerContainer.add(element: 3)
    print(integerContainer)
    integerContainer.remove(element: 2)
    print(integerContainer)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples
example1()

//: [Next](@next)
