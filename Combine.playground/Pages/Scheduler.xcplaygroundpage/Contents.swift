//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Scheduler`
 `Scheduler` as per definition from official documentation is a protocol defining WHEN & HOW to execute a closure.
 `Scheduler` provides a way to execute instructions is a specific order.
 */
import Foundation

let SEPARATOR = "\n################################################################################\n"

//TODO: Revisit examples and add more

/// Example 1 :
/// In method example `publisherSubscribedOnDifferentSerialQueue` we are using ```.subscribe(on:```
/// ```.subscribe(on:```  takes a `Scheduler` which in example's case is a serial dispatch queue.
/// Now using .subscribe(on: operator values will be emitted from serial queue which is provided as a `Scheduler`
/// meaning all values will be emitted on a serial dispatch queue, hence values will appear sequentially.
func publisherSubscribedOnDifferentSerialQueue() {
    print(SEPARATOR)
    print("Current thread : \(Thread.current)")
    let serialQueue = DispatchQueue(label: "com.saurabh.serial")
    let sequencePublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
    let subscriberToSequencePublisher = sequencePublisher
                                            .subscribe(on: serialQueue)
                                            .sink { receivedValue in
                                                print("Received value on thread : \(Thread.current)")
                                                print("Value published from sequencePublisher publisher : \(receivedValue)")
                                            }
}

/// Example 2 :
/// ```.subscribe(on:``` takes a scheduler i.e. DispatchQueue.main so everything executes on main
/// thread.
func publisherSubscribedOnSameQueue() {
    print(SEPARATOR)
    print("Current thread : \(Thread.current)")
    let sequencePublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
    let subscription = sequencePublisher
                            .subscribe(on: DispatchQueue.main)
                            .sink { receivedValue in
                                print("Received value on thread : \(Thread.current)")
                                print("Value published from sequencePublisher publisher : \(receivedValue)")
                            }
}

func publisherSubscribedOnConcurrentQueue() {
    print(SEPARATOR)
    print("Current thread : \(Thread.current)")
    let concurrentQueue = DispatchQueue.global(qos: .userInteractive)
    let sequencePublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
    let subscription = sequencePublisher
                            .subscribe(on: concurrentQueue)
                            .sink { receivedValue in
                                print("Received value on thread : \(Thread.current)")
                                print("Value published from sequencePublisher publisher : \(receivedValue)")
                            }
}

publisherSubscribedOnConcurrentQueue()



//let subscriberToSequencePublisherReceivesOnSomeQueue = sequencePublisher
//    .receive(on: someQueue)
//    .sink { receivedValue in
//        print("Received value on thread : \(Thread.current)")
//        print("Value published from sequencePublisher publisher : \(receivedValue)")
//    }

//: [Next](@next)
