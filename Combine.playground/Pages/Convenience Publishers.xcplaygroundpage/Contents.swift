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

// Example 1 : Future Success
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

// Example 2 : Future Failure
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

// Example 3 : Future Finishes immediately, it's one shot
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

// #############################################################################

/// `Just`
/// `Just` is a simple publisher which publishes an output and then finishes. `Just` publisher will always
/// publish a value, i.e. it can't fail with an error.
///
/// One work around for Just to fail is to use `setFailureType(to:)` on Just publisher. `setFailureType(to:)`
/// returns a publisher which can send specified failure type.
///
/// As per definition `struct Just<Output>` the output can be any type.

// Example 1 : Just Publisher

let justAPublisher = Just("Batman")
let justPublisherSubscriber = justAPublisher.sink { receivedValue in
    print("Value published from justAPublisher publisher : \(receivedValue)")
}

// #############################################################################

/// `Deferred`
/// `Deferred` is a publisher which awaits subscription before creating the publisher. `Deferred` publishers
/// are executed only when someone subscribes to them. It kind of makes the publisher lazy.
/// For example, the `Future` publisher is too eager and will run as soon as its created.

// Example 1 : Deferred Publisher

let anEagerPublisher = Future<String, Error> { promise in
    print("Creating a eager publisher")
    promise(Result.success("Batman"))
}

// If playground is executed at this point i.e. without creating a subscriber the
// closure for Future publisher still gets executed.

let lazyDeferredPublisher = Deferred {
    Future<String, Error> { promise in
        print("Creating a lazy deferred publisher")
        promise(Result.success("Batman"))
    }
}

// Here for the publisher only sink(receiveCompletion:receiveValue:) was available
// as the publisher is defined to fail as well.
// However if publisher would have been Future<String, Never> i.e. which never fails
// then sink(receiveValue:) could have been used.
let subscriberToLazyDeferredPublisher = lazyDeferredPublisher.sink(receiveCompletion: { _ in
    print("Finished publishing")
}, receiveValue: { receivedValue in
    print("Value published from lazyDeferredPublisher publisher : \(receivedValue)")
})

//: [Next](@next)
