//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Publishers & Subscribers`
 
 `Publishers` and  `Subscribers` form the core concepts of combine framework. It's important to discuss
 and learn publishers and subscribers along with each other.
 
 `About Publisher`
 
 Publisher is a protocol which can declare a type which can deliver a sequence of values over time.
 ```protocol Publisher<Output, Failure>```
 So a publisher is someone who is going to emit/deliver/expose a series of values over time, then there is
 subscriber who subscribes to revieve all these values.
 Publishers define how the values or error are produced. It only will emit values when explicitly requested by
 a subscriber.
 So it's actually the subscriber which has the control with itself to determine how fast it can receive values from a
 publisher. So a publisher without any subsriber is NOT going to emit any data, as no one is asking anything from it.
 Also as subscriber is in control so the volume of data processed through a stream is controllable as well as cancellable.
 
 */

import Foundation
import Combine

/// Example 1
/// Create a Publisher
/// In example below a publisher `mySimplePublisher` is created using `Just`
/// `Just` is a publisher which will emit the value just once(to subscribers) and then finishes. It's one among
/// few convenience publishers provided by Combine framework.
/// `Just` publisher will always produce a value and can't fail with an error.

let mySimplePublisher = Just(4)

// Here if this playground is executed till this point then it does nothing, as
// till here we have declared a publisher but there is no subscriber to ask for value
// this publisher is going to emit.

let mySubscription = mySimplePublisher.sink { receivedValue in
    print("Received value from my publisher, mySimplePublisher :: \(receivedValue)")
}

// Now we have defines a subscription(i.e. mySubscription) for our publisher mySimplePublisher
// Playground executed at this point will show output by executing the print statement.

//: [Next](@next)
