//: [Previous](@previous)

// Created by Saurabh Verma on 22/04/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Task`
 
 Task as pe Apple's official documentation is a unit of asynchronous work.
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Simple Task
func exampleSimpleTask() {
    Task {
        print("This is printed from a Task")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

exampleSimpleTask()

//: [Next](@next)
