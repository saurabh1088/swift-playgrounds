//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Connectable Publishers`
 
 Publishers emit values which subscribers are interested in. Commonly used subscribers however will start demanding
 values immediately. This means if one needs to configure the publisher in any way can be difficult.
 A publisher having multiple subscibers also can lead to situations where a race condition happens (i.e. first subscriber
 received value and finishes even before the second subsciber exists)
 
 By making a publisher connectable, the publisher doesn’t produce any elements until after the connect() call.
 Notice in Example 2 below if the DispatchQueue calling cancellable = connectablePublisher.connect() isn't called
 then publisher won't publish any values
 
 */

import Foundation
import Combine


// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : A subsciber misses out values from publisher
let justPublisher = PassthroughSubject<String, Never>()

let firstSubscriber = justPublisher.sink { receivedValue in
    print("firstSubscriber : Value published from justPublisher publisher : \(receivedValue)")
}

let secondSubscriber = justPublisher.sink { receivedValue in
    print("secondSubscriber : Value published from justPublisher publisher : \(receivedValue)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    let thirdSubscriber = justPublisher.sink { receivedValue in
        print("thirdSubscriber : Value published from justPublisher publisher : \(receivedValue)")
    }
}

justPublisher.send("Batman")


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Creating a Connectable publisher
let connectablePublisher = Just("Superman").makeConnectable()
// cancellable and subscriberThree is defined over here so as to keep it alive in current context
// If declared within DispatchQueue block it would get release too soon.
var cancellable: Cancellable?
var subscriberThree: AnyCancellable?

let subscriberOne = connectablePublisher.sink { receivedValue in
    print("subscriberOne : Value published from connectablePublisher publisher : \(receivedValue)")
}

let subscriberTwo = connectablePublisher.sink { receivedValue in
    print("subscriberTwo : Value published from connectablePublisher publisher : \(receivedValue)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    subscriberThree = connectablePublisher.sink { receivedValue in
        print("subscriberThree : Value published from connectablePublisher publisher : \(receivedValue)")
    }
}

// As our publisher connectablePublisher is a connected publisher by using the
// method makeConnectable() if .connect() isn't called like below then it won't
// publish any value.
// So here in this example once .connect() is called we are fairly certain all
// subscribers are
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    cancellable = connectablePublisher.connect()
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Making a connectable publisher autoconnect
// Note that no .connect() is required in this example unlikely Example 2
// This is because subscriber1 here calls autoconnect() causing publisher to
// start emitting values right away. This leads to subscriber2 not able to receive
// value
// In Swift when you create a Timer publishers then one generally calls it with
// .autoconnect() so in order for it to start sending values right away.

let someConnectablePublisher = Just("Wonder Woman").makeConnectable()
var subscriber2: AnyCancellable?
var someCancellable: Cancellable?

let subscriber1 = someConnectablePublisher
    .autoconnect()
    .sink { receivedValue in
    print("subscriber1 : Value published from someConnectablePublisher publisher : \(receivedValue)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    subscriber2 = someConnectablePublisher.sink { receivedValue in
        print("subscriber2 : Value published from someConnectablePublisher publisher : \(receivedValue)")
    }
}


//: [Next](@next)
