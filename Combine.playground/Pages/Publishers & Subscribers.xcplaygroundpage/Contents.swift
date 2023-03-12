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
 
 A publisher provides data when available and upon request. This "upon request" is important.
 A publisher that has not had any subscription requests will not provide any data.
 
 As mentioned above the Publisher is a protocol ```protocol Publisher<Output, Failure>```
 Here `Output` and `Failure` are associated types.
 
 `About Subscriber`
 
 Subscriber is a protocol which can declare a type which receives input from a publisher.
 ```protocol Subscriber<Input, Failure> : CustomCombineIdentifierConvertible```
 
 As mentioned in Subscriver definition above, the `Input` and `Failure` associated types for a subscriber
 must match with those of publisher it it subscribing to which are `Output` and `Failure`. So the types must match
 i.e. `Input` must match to `Output` and `Failure` to `Failure`. This is important to connect a publisher
 and subscriber together.
 
 It is the subscriber which initiates the request for data, and controls the amount of data it receives. This way the
 role of a subscriber is the one "driving the action" within Combine, as without a subscriber, the other components
 stay idle, which is the publisher won't emit.
 
 `Combine framework built-in subscribers`
 
 Following built-in subscribers can receive unlimited number of values from publishers. These however can't control
 the rate at which to receive values. For controling the rate one needs to implement `Subscriber` protocol.
 
 1. ```sink(receiveCompletion:receiveValue:)```
 2. ```assign(to:on:)```
 
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

/// Example 2
/// Create a publisher to emit a series of values
/// In example below a publisher `multipleValuesPublisher` is created using an array and calling property `publisher`
/// on the array. This `publisher` property `Array` gets by conforming to `Sequence` protocol.
/// `Sequence` protocol has declared `publisher` as
/// ```var publisher: Publishers.Sequence<Self, Never> { get }```
/// So basically calling `publisher` property in below example will create a publisher which will publish
/// all the values of the array to its subscribers.

let multipleValuesPublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher

let subscriptionToMultipleValuePublisher = multipleValuesPublisher.sink { receivedValue in
    print("Received value from my publisher, multipleValuesPublisher :: \(receivedValue)")
}

/// Example 3
/// In previous examples (1 & 2) the subscriber were created using ```.sink```.
/// Example 3 uses another approach ```assign(to:on:)```

let studentsInClassPublisher = ["Harry", "Ron", "Hermoine", "Malfoy", "Frodo"].publisher

// If MagicClass is defined as struct then this example will fail to work and will
// show error :
// Key path value type 'ReferenceWritableKeyPath<MagicClass, Publishers.Sequence<[String], Never>.Output>' (aka 'ReferenceWritableKeyPath<MagicClass, String>') cannot be converted to contextual type 'WritableKeyPath<MagicClass, Publishers.Sequence<[String], Never>.Output>' (aka 'WritableKeyPath<MagicClass, String>')
// This is because the keypath in .assign(to is defined as keyPath: ReferenceWritableKeyPath<Root, Self.Output> and ReferenceWritableKeyPath can be used only with reference types
// So example below will not work for structs

class MagicClass {
    var rollCall: String = String() {
        didSet {
            print("\(rollCall)")
        }
    }
}

let myClass = MagicClass()
let subscriptionToMyClassForRollCall = studentsInClassPublisher.assign(to: \.rollCall, on: myClass)

// Some Foundation types also expose their functionality via publishers. For e.g.
// Timer, NotificationCenter, and URLSession. Example 4 and Example 5 show usage of
// NotificationCenter and Timer

/// Example 4
/// NotificationCenter.Publisher
/// This example uses publisher from NotificationCenter. When a new employee gets added to the company
/// the company posts a notification. When the notification is posted then subscriber may need to take some
/// action.

extension Notification.Name {
    static let newEmployeeAdded = Notification.Name("new_employee_added")
}

struct Employee {
    var name: String
}
struct MyCompany {
    func add(employee: Employee) {
        print("Added a new employee to company, let's notify our subscribers")
        NotificationCenter.default.post(name: .newEmployeeAdded, object: employee)
    }
}

// Reason .map(_:) is used here is to free subscriber from doing any custom work
// otherwise subscriber would have to convert notification object received into
// a more understandable format.
let myNotificationPublisher = NotificationCenter.Publisher(center: .default,
                                                           name: .newEmployeeAdded)
    .map { notification in
        return (notification.object as! Employee).name
    }

let myNotificationSubscription = myNotificationPublisher.sink { receivedValue in
    print("Received value from my publisher, myNotificationPublisher :: \(receivedValue)")
}

let company = MyCompany()
company.add(employee: Employee(name: "Saurabh"))

/// Example 5
/// Timer publisher

let timerPublisher = Timer.publish(every: 2, on: .main, in: .default).autoconnect()

let timerSubscription = timerPublisher.sink { timerPublishedDate in
    print("Received value from my publisher, timerPublisher :: \(timerPublishedDate)")
}

// A time publisher when subscribed with keep on continue publishing. If playground
// example is played before this RunLoop code below then
RunLoop.main.schedule(after: .init(Date(timeIntervalSinceNow: 6))) {
    print("Cancelling timerSubscription")
    timerSubscription.cancel()
}

// TODO: Publishers.Catch (https://developer.apple.com/documentation/combine/publishers/catch)


//: [Next](@next)
