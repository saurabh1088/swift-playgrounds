//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Convenience Publishers`
 
 Swift Combine framework provides several convenience publishers which can be used to create publishers
 without need to implement Publisher protocol and implementing it.
 
 - Future
 - Just
 - Deferred
 - Empty
 - Fail
 - Record
 */

import Foundation
import Combine

/// `Future and Promise`

/// Example 1
/// Using `Future`
/// `Future` conceptually can be understood as a context for some value which may not exist yet but may
/// give a eventual result or failure based on completion of some asynchronous operation.
/// In Combine `Future` is a publisher which will eventually produce a single value and finishes else will fail.
/// `Promise` is the eventual result of a `Future`. A `Future` is always initialised with a `Promise`
///
/// A `Future` is fulfilled when a value is passed to `Promise`. Like in `Example 1` below a random `Int`
/// is generated and passed to `Promise`
/// `promise(Result.success(randomNumber))`
///
/// Similarly a `Future` is said to be rejected when error is passed to `Promise`
///
/// `Future` can be said to represent some asynchronous operation and `Promise` is used to deliver either
/// a value or error.

// Case 1 : Success
func generateSomeRandomNumber() -> Future<Int, Never> {
    return Future { promise in
        let randomNumber = Int.random(in: 1...100)
        promise(Result.success(randomNumber))
    }
}

let futurePublisher = generateSomeRandomNumber()
let futurePublisherSubscriber = futurePublisher.sink { receivedValue in
    print("Value published from future publisher : \(receivedValue)")
}

// Case 2 : Failure
enum SomeError: Error {
    case futureRejected
}

let futureRejectedPublisher = Future<Int, Error>.init { promise in
    promise(Result.failure(SomeError.futureRejected))
}

let futureRejectedPublisherSubscriber = futureRejectedPublisher.sink { error in
    print("Error from future publisher : \(error)")
} receiveValue: { receivedValue in
    print("Value published from future publisher : \(receivedValue)")
}

// Case 3 : Finishes immediately
// Once a value is passed to a Future's Promise, the publisher will finish immediately.
// This means for below example of simpleFuture the moment value "First" is published
// publisher will finish. So here the value "Second" won't ever get published.
let simpleFuture = Future<String, Never> { promise in
    promise(Result.success("First"))
    promise(Result.success("Second"))
}

let simpleFutureSubscriber = simpleFuture.sink { receivedValue in
    print("Value published from simpleFuture publisher : \(receivedValue)")
}

// TODO: Create one more example for Future and Promise use case using employee database analogy

/// `Just`
/// 

//: [Next](@next)
