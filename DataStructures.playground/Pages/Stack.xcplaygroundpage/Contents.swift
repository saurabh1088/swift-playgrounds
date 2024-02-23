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

struct Stack<Element> {
    private var elements: [Element] = []
    
    func peek() -> Element? {
        return elements.last
    }
    
    mutating func pop() -> Element? {
        return elements.removeLast()
    }
    
    mutating func push(_ element: Element) {
        elements.append(element)
    }
}

func exampleStackDataStructure() {
    var stackOfInt = Stack<Int>()
    stackOfInt.push(0)
    stackOfInt.push(1)
    stackOfInt.push(2)
    print(stackOfInt)
}

exampleStackDataStructure()

//: [Next](@next)
