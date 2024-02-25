//: [Previous](@previous)

// Created by Saurabh Verma on 23/02/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Stack`
 `Stack` is a very simple data structure which holds a linear stack of items and follows LIFO approach. A stack
 usually should provide following funtionality
 
 1. peek
 To look at the current topmost element in the stack
 
 2. pop
 Returns the topmost element from stack
 
 3. push
 Adds a new value to stack
 
 Examples :
 - In UIKit UINavigationController maintains the viewcontrollers in stack
 - Function call stack
 */
import Foundation
import XCTest

protocol Stackable {
    associatedtype Element
    var elements: [Element] { get set }
    func peek() -> Element?
    mutating func pop() -> Element?
    mutating func push(_ element: Element)
}

struct Stack<T>: Stackable {
    var elements: [T] = []
    
    func peek() -> T? {
        return elements.last
    }
    
    mutating func pop() -> T? {
        return elements.removeLast()
    }
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Stack using Int data type
func exampleStackDataStructureUsingInt() {
    var stackOfInt = Stack<Int>()
    stackOfInt.push(0)
    stackOfInt.push(1)
    stackOfInt.push(2)
    stackOfInt.push(3)
    print(stackOfInt)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Stack using String data type
func exampleStackDataStructureUsingString() {
    var stackOfString = Stack<String>()
    stackOfString.push("Batman")
    stackOfString.push("Wonder Woman")
    stackOfString.push("Superman")
    print(stackOfString)
}

// MARK: -----------------------------------------------------------------------
// MARK: Unit Tests

class StackTests: XCTestCase {
    var sut: Stack<Int>?
    
    func test_StackPeek() {
        sut = Stack<Int>()
        sut?.push(0)
        sut?.push(1)
        sut?.push(2)
        
        XCTAssertNotNil(sut?.peek())
        XCTAssertEqual(2, sut?.peek())
    }
    
    func test_StackPop() {
        sut = Stack<Int>()
        sut?.push(0)
        sut?.push(1)
        sut?.push(2)
        
        let popResult = sut?.pop()
        XCTAssertNotNil(popResult)
        XCTAssertEqual(2, popResult)
    }
    
    func test_StackPush() {
        sut = Stack<Int>()
        
        XCTAssertNil(sut?.peek())
        
        sut?.push(0)
        
        XCTAssertNotNil(sut?.peek())
        XCTAssertEqual(0, sut?.peek())
    }
}

StackTests.defaultTestSuite.run()

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleStackDataStructureUsingInt()
//exampleStackDataStructureUsingString()

//: [Next](@next)
