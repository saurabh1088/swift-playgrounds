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
// MARK: Example 1 : Operation queue with a single simple operation
func exampleOperationQueue1() {
    let operationQueue = OperationQueue()
    let operation = BlockOperation {
        print("Executing from operation queue : \(Thread.isMainThread)")
    }
    operationQueue.addOperation(operation)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Operation queue performing multiple operations
func exampleOperationQueue2() {
    let operationQueue = OperationQueue()
    let operationOne = BlockOperation {
        print("Operation one")
    }
    let operationTwo = BlockOperation {
        print("Operation two")
    }
    let operationThree = BlockOperation {
        print("Operation three")
    }
    operationQueue.addOperation(operationThree)
    operationQueue.addOperation(operationTwo)
    operationQueue.addOperation(operationOne)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Operation queue with operations having different priority
func exampleOperationQueue3() {
    let operationQueue = OperationQueue()
    
    let operationOne = BlockOperation {
        for value in 1...5 {
            print("\(value). Operation priority : Very low")
        }
    }
    operationOne.queuePriority = .veryLow
    
    let operationTwo = BlockOperation {
        for value in 1...5 {
            print("\(value). Operation priority : Low")
        }
    }
    operationTwo.queuePriority = .low
    
    let operationThree = BlockOperation {
        for value in 1...5 {
            print("\(value). Operation priority : Normal")
        }
    }
    operationThree.queuePriority = .normal
    
    let operationFour = BlockOperation {
        for value in 1...5 {
            print("\(value). Operation priority : High")
        }
    }
    operationFour.queuePriority = .high
    
    let operationFive = BlockOperation {
        for value in 1...5 {
            print("\(value). Operation priority : Very high")
        }
    }
    operationFive.queuePriority = .veryHigh
    
    operationQueue.addOperation(operationOne)
    operationQueue.addOperation(operationTwo)
    operationQueue.addOperation(operationThree)
    operationQueue.addOperation(operationFour)
    operationQueue.addOperation(operationFive)
}


// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleOperationQueue1()
//exampleOperationQueue2()
exampleOperationQueue3()

//: [Next](@next)
