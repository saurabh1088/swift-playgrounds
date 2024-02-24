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

func exampleStackDataStructureUsingInt() {
    var stackOfInt = Stack<Int>()
    stackOfInt.push(0)
    stackOfInt.push(1)
    stackOfInt.push(2)
    stackOfInt.push(3)
    print(stackOfInt)
}

func exampleStackDataStructureUsingString() {
    var stackOfString = Stack<String>()
    stackOfString.push("Batman")
    stackOfString.push("Wonder Woman")
    stackOfString.push("Superman")
    print(stackOfString)
}

exampleStackDataStructureUsingInt()
exampleStackDataStructureUsingString()

//: [Next](@next)
