//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Subject`
 `Subject` is a protocol describing a publisher which can be used to inject values into a stream. For this it
 provides `send(_:)` method. Subject is helpful in adapting existing imperative code to Combine model.
 
 `PassthroughSubject`
 `PassthroughSubject` is a concrete implementation of `Subject` protocol. So basically `PassthroughSubject`
 is a subject which broadcasts values to downstream subscribers.
 `PassthroughSubject` doesn't have an initial value. `PassthroughSubject` also doesn't have a buffer
 of most recently published element. If no subscribers are present or the demand is zero then it will drop the values.
 `PassthroughSubject` only passes through values, meaning it will not capture any state, unlike `CurrentValueSubject`.
 */
import Foundation
import Combine

let passthroughSubject = PassthroughSubject<String, Never>()
let subscriptionToPassthroughSubject = passthroughSubject.sink { receivedValue in
    print("Value published from passthroughSubject publisher : \(receivedValue)")
}

passthroughSubject.send("Batman")
passthroughSubject.send("Superman")
// We can mark completion with subject calling like below, this will send completion
// signal to the subscribers. Any values if tried after sending completion will not
// be sent.
passthroughSubject.send(completion: .finished)
passthroughSubject.send("This value doesn't get published")


// Unlike PassthroughSubject, CurrentValueSubject needs to have an initial value.
let currentValueSubject = CurrentValueSubject<String, Never>("Initial Value")
let subscriptionToCurrentValueSubject = currentValueSubject.sink { receivedValue in
    print("Value published from currentValueSubject publisher : \(receivedValue)")
}
// Even if we run the playground here for our subject currentValueSubject without
// sending any value via send(_:), because CurrentValueSubject has an initial value
// so our subscriber receives that value and closure will get executed.
// We can however send further values.
print("Current value of our currentValueSubject : \(currentValueSubject.value)")

// Now let's see what happens once we use send(_:) on CurrentValueSubject.
currentValueSubject.send("Wonder Woman")
print("currentValueSubject value after using send(_:) with new value : \(currentValueSubject.value)")

// TODO: Create a custom subscriber and try using PassthroughSubject's `func send(subscription: Subscription)` method


//: [Next](@next)
