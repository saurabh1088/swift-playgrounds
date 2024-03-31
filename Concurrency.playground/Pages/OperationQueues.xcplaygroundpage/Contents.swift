//: [Previous](@previous)

// Created by Saurabh Verma on 31/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `OperationQueue`
 
 `OperationQueue` is built on top of GCD, thereby providing a higher level abstraction for achieving concurrency.
 
 One typically adds operations, represented by abstract class `Operation` to `OperationQueue` and the
 queue will execute those operations. Operation queue will invoke these operations based on their priority and readiness.
 
 Operation once added to a queue can't be deleted.
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
func exampleOperationQueue1() {
    let operationQueue = OperationQueue()
    let operation = BlockOperation {
        print("Executing from operation queue")
    }
    operationQueue.addOperation(operation)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples
exampleOperationQueue1()

//: [Next](@next)
