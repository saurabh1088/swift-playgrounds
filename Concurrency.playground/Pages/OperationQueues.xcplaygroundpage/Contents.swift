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
// MARK: Example 4 : Operation queue with operations having dependencies
func exampleOperationQueue4() {
    let operationQueue = OperationQueue()
    
    let operationOne = BlockOperation {
        for index in 1...10 {
            print("\(index). Performing operation one")
        }
    }
    
    let operationTwo = BlockOperation {
        for index in 1...10 {
            print("\(index). Performing operation two")
        }
    }
    
    let operationThree = BlockOperation {
        for index in 1...10 {
            print("\(index). Performing operation three")
        }
    }
    
    operationOne.addDependency(operationThree)
    
    operationQueue.addOperation(operationOne)
    operationQueue.addOperation(operationTwo)
    operationQueue.addOperation(operationThree)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 : Operation queue with operations having completion blocks
func exampleOperationQueue5() {
    let operationQueue = OperationQueue()
    
    let operationOne = BlockOperation {
        for index in 1...10 {
            print("\(index). Performing operation one")
        }
    }
    operationOne.completionBlock = {
        print("✅ Operation one completed")
    }
    
    let operationTwo = BlockOperation {
        for index in 1...10 {
            print("\(index). Performing operation two")
        }
    }
    operationTwo.completionBlock = {
        print("✅ Operation two completed")
    }
    
    operationQueue.addOperation(operationOne)
    operationQueue.addOperation(operationTwo)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 6 : Trigerring an operation without a operation queue
/// One can perform an operation without needing operation queue. Operations have a `start()` method which
/// can be called directly to start the operation. This is manual execution, caveat however is that there is more
/// burden on the code as if the operation isn't in a ready state could lead to exception.
func exampleOperationQueue6() {
    let operation = BlockOperation {
        print("Performing some operation")
    }
    operation.start()
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 7 : maxConcurrentOperationCount
func exampleOperationQueue7() {
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 1
    
    let operationOne = BlockOperation {
        for index in 1...5 {
            print("\(index). performing operation one")
        }
    }
    
    let operationTwo = BlockOperation {
        for index in 1...5 {
            print("\(index). performing operation two")
        }
    }
    
    let operationThree = BlockOperation {
        for index in 1...5 {
            print("\(index). performing operation three")
        }
    }
    
    operationQueue.addOperation(operationOne)
    operationQueue.addOperation(operationTwo)
    operationQueue.addOperation(operationThree)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 8 : OperationQueue main
func exampleOperationQueue8() {
    let operationQueueMain = OperationQueue.main
    
    let operation = BlockOperation {
        print("Performing operation from main thread? :: \(Thread.isMainThread)")
    }
    
    operationQueueMain.addOperation(operation)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 9 :
class MyCustomOperation: Operation {
    override func main() {
        print("Performing custom operation")
    }
}

func exampleOperationQueue9() {
    let operationQueue = OperationQueue()
    
    let operation = MyCustomOperation()
    
    operationQueue.addOperation(operation)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleOperationQueue1()
//exampleOperationQueue2()
//exampleOperationQueue3()
//exampleOperationQueue4()
//exampleOperationQueue5()
//exampleOperationQueue6()
//exampleOperationQueue7()
//exampleOperationQueue8()
exampleOperationQueue9()

//: [Next](@next)
