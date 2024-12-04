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


// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Future Success
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


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Future Failure
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


// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Future Finishes immediately, it's one shot
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


// MARK: -----------------------------------------------------------------------
// MARK: Example 4 : Just Publisher
let justAPublisher = Just("Batman")
let justPublisherSubscriber = justAPublisher.sink { receivedValue in
    print("Value published from justAPublisher publisher : \(receivedValue)")
}

// #############################################################################

/// `Deferred`
/// `Deferred` is a publisher which awaits subscription before creating the publisher. `Deferred` publishers
/// are executed only when someone subscribes to them. It kind of makes the publisher lazy.
/// For example, the `Future` publisher is too eager and will run as soon as its created.


// MARK: -----------------------------------------------------------------------
// MARK: Example 4 : Deferred Publisher
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

// #############################################################################

/// `Empty`
/// `Empty` as the name suggests is a publisher which won't publish anything. It can be initialised using below
/// initialiser. Here `completeImmediately` can be used to configure it to finish immediately.
/// `init(completeImmediately: Bool)`
/// `completeImmediately` if however `false` will cause publisher to never finish as showm below in
/// example for publisher `emptyPublisherNotCompletingImmediately`
///
/// Empty publishers can be used for scenarios where requirement from a publisher is not to receive any value
/// but just want to get notify that some task is done.


// MARK: -----------------------------------------------------------------------
// MARK: Example 5 : Empty publisher with completeImmediately as true
// emptyPublisherCompleteImmediately will finish immediately so for .sink subscriber
// receiveCompletion block will be called, but receiveValue closure will never get
// called as the publisher never publishes any value.
let emptyPublisherCompleteImmediately = Empty<Int, Never>(completeImmediately: true)

let subscriberToEmptyPublisherCompleteImmediately = emptyPublisherCompleteImmediately.sink(receiveCompletion: { _ in
    print("Publisher emptyPublisherCompleteImmediately finished")
}, receiveValue: { receivedValue in
    print("Value published from emptyPublisherCompleteImmediately publisher : \(receivedValue)")
})


// MARK: -----------------------------------------------------------------------
// MARK: Example 6 : Empty publisher with completeImmediately as false
// emptyPublisherNotCompletingImmediately will never publishe any value as being
// an Empty publisher, but also it will never complete due to completeImmediately set
// to false.
// For .sink subscriber both receiveCompletion and receiveValue closures will
// never get called.
let emptyPublisherNotCompletingImmediately = Empty<Int, Never>(completeImmediately: false)

let subscriberToEmptyPublisherNotCompletingImmediately = emptyPublisherNotCompletingImmediately.sink(receiveCompletion: { _ in
    print("Publisher emptyPublisherNotCompletingImmediately finished")
}, receiveValue: { receivedValue in
    print("Value published from emptyPublisherNotCompletingImmediately publisher : \(receivedValue)")
})

// #############################################################################

/// `Fail`
/// `Fail` publisher will immediately fail with a specified error.


// MARK: -----------------------------------------------------------------------
// MARK: Example 7 : Fail publisher
enum FailError: Error {
    case failPublisherError
}

let failPublisher = Fail<String, FailError>(error: FailError.failPublisherError)

let subscriberToFailPublisher = failPublisher.sink(receiveCompletion: { error in
    print("Publisher failPublisher failed with error : \(error)")
}, receiveValue: { receivedValue in
    print("Value published from failPublisher publisher : \(receivedValue)")
})

// #############################################################################

/// `Record`
/// `Record` is a publisher which allows for recording a series of values and a completion. These can be later
/// playbacked for subscribers.


// MARK: -----------------------------------------------------------------------
// MARK: Example 8 : Record publisher with output
let recordPublisherWithOutput = Record<Int, Never>(output: [1, 2, 3], completion: .finished)

let subscriberToRecordPublisherWithOutput = recordPublisherWithOutput.sink { receivedValue in
    print("Value published from recordPublisherWithOutput publisher : \(receivedValue)")
}

let recordedPublisher = Record<String, Error> { recording in
    recording.receive("Batman")
    recording.receive("Wonder Woman")
    recording.receive("Superman")
    recording.receive(completion: .finished)
}

let subscriberToRecordedPublisher = recordedPublisher.sink(receiveCompletion: { _ in
    print("Publisher recordedPublisher completed")
}, receiveValue: { receivedValue in
    print("Value published from recordedPublisher publisher : \(receivedValue)")
})

//: [Next](@next)
