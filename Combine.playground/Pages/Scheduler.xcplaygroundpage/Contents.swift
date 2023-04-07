//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Scheduler`
 `Scheduler` as per definition from official documentation is a protocol defining WHEN & HOW to execute a closure.
 `Scheduler` provides a way to execute instructions is a specific order.
 */
import Foundation
import Combine

let SEPARATOR = "\n################################################################################\n"

// Store subscribers else those will get de-allocated
var subscriptions = Set<AnyCancellable>()

struct CustomPublisher: Publisher {
    typealias Output = String
    typealias Failure = Never
    
    func receive<S>(subscriber: S) where S : Subscriber, CustomPublisher.Failure == S.Failure, CustomPublisher.Output == S.Input {
        
        debugPrint("Received subscription from \(Thread.current.description)")
        subscriber.receive(subscription: Subscriptions.empty)
        DispatchQueue.main.async {
            _ = subscriber.receive("Dark Kinght")
        }
    }
}


//TODO: Revisit examples and add more

/// Example 1 :
/// In method example `publisherSubscribedOnDifferentSerialQueue` we are using ```.subscribe(on:```
/// ```.subscribe(on:```  takes a `Scheduler` which in example's case is a serial dispatch queue.
/// ```.subscribe(on:``` will set the scheduler passed to it as the one on which we like current subscription
/// to be managed on. So this scheduler will be used for :-
/// - Creating the subscription
/// - Cancelling the subscription
/// - Requesting input
/// ```.subscribe(on:``` sets  the scheduler to subscribe the upstream on, but along with this there is
/// side effect, which is when this is used scheduler for downstream will also get changed.
/// So in Example 1, when a serial queue is used as a scheduler, the downstream subscriber .sink also executes
/// the block with print statements on same serial queue scheduler.
func publisherSubscribedOnDifferentSerialQueue() {
    print(SEPARATOR)
    print("Current thread : \(Thread.current.description)")
    let serialQueue = DispatchQueue(label: "com.saurabh.serial")
    let sequencePublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
    let subscriberToSequencePublisher = sequencePublisher
                                            .subscribe(on: serialQueue)
                                            .sink { receivedValue in
                                                print("Received value on thread : \(Thread.current.description)")
                                                print("Value published from sequencePublisher publisher : \(receivedValue)")
                                            }
}

/// Example 2 :
/// ```.subscribe(on:``` takes a scheduler i.e. DispatchQueue.main so everything executes on main
/// thread.
func publisherSubscribedOnSameQueue() {
    print(SEPARATOR)
    print("Current thread : \(Thread.current.description)")
    let sequencePublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
    let subscription = sequencePublisher
                            .subscribe(on: DispatchQueue.main)
                            .sink { receivedValue in
                                print("Received value on thread : \(Thread.current.description)")
                                print("Value published from sequencePublisher publisher : \(receivedValue)")
                            }
}

/// Example 3 :
/// This is practically same as the method above `publisherSubscribedOnSameQueue`. When the operator
/// ```.subscribe(on:``` isn't used then everything happens on same queue.
func publisherSubscribedNotUsingSubscribeOnSchedulerOperator() {
    print(SEPARATOR)
    print("Current thread : \(Thread.current.description)")
    let sequencePublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
    let subscription = sequencePublisher
                            .sink { receivedValue in
                                print("Received value on thread : \(Thread.current.description)")
                                print("Value published from sequencePublisher publisher : \(receivedValue)")
                            }
}

// TODO: In Example 4, concurrent queue is used, check why published values are printed sequentially
/// Example 4 :
/// A concurrent queue is used.
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

/// Example 5 :
func publisherSubscriberWithReceivedOnDifferentScheduler() {
    print(SEPARATOR)
    print("Current thread : \(Thread.current.description)")
    let differentQueue = DispatchQueue(label: "com.saurabh.differentQueue")
    let sequencePublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
    
    // Preferred approach
    let subscription = sequencePublisher
        .receive(on: differentQueue)
        .sink { receivedValue in
            print("Received value on thread : \(Thread.current.description)")
            print("Value published from sequencePublisher publisher : \(receivedValue)")
        }
    
    /*
    // Works same, but should not be preferred.
    let subscription = sequencePublisher
        .sink { receivedValue in
            differentQueue.async {
                print("Received value on thread : \(Thread.current.description)")
                print("Value published from sequencePublisher publisher : \(receivedValue)")
            }
        }
     */
}

/// Example 6 :
func somePipeline() {
    print(SEPARATOR)
    print("Current thread : \(Thread.current.description)")
    let someQueue = DispatchQueue.global(qos: .default)
    let publisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
        .map { receivedValue in
            print("map operator closure : \(Thread.current.description)")
            print("Received value : \(receivedValue)")
        }
        .subscribe(on: someQueue)
        .receive(on: DispatchQueue.main)
        .sink { receivedValue in
            print("Received value on thread : \(Thread.current.description)")
            print("Value published from publisher publisher : \(receivedValue)")
        }
        .store(in: &subscriptions)
        
}

/// Example 7 :
/// Here we are using a custom publisher to demonstrate functioning of :
/// 1. ```.subscribe(on:```
/// 2. ```.receive(on: someQueue)```
///
/// ```.subscribe(on:``` will determine on which scheduler/queue subscribe, cancel, and request operations
/// are performed. So in our cusomt publisher(`CustomPublisher`) case the ```receive<S>(subscriber:```
/// gets called on the queue/scheduler specified but this method.
///
/// ```.receive(on: someQueue)``` will determine on which queue values are received, so if we want
/// values to receive on some different queue then it can be specified here.
///
/// Play around with below method changing queues for these methods and observe behaviour.
func customPublisherSubscribedOnDifferentQueue() {
    let someQueue = DispatchQueue.global(qos: .default)
    let someOtherQueue = DispatchQueue.global(qos: .default)
    let customPublisher = CustomPublisher()
    let subscription = customPublisher
                        .subscribe(on: someQueue)
                        .receive(on: someQueue)
                        .sink { receivedValue in
                            print("Received value on thread : \(Thread.current.description)")
                            print("Value published from customPublisher publisher : \(receivedValue)")
                        }
                        .store(in: &subscriptions)
}

func immediateSchedulerExample() {
    let immediateScheduler = ImmediateScheduler.shared
    let sequencePublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
    let subscription = sequencePublisher
        .receive(on: immediateScheduler)
        .sink { receivedValue in
            print("Received value on thread : \(Thread.current.description)")
            print("Value published from customPublisher publisher : \(receivedValue)")
        }
}


//publisherSubscribedOnDifferentSerialQueue()
//publisherSubscribedOnSameQueue()
//publisherSubscribedNotUsingSubscribeOnSchedulerOperator()
//publisherSubscribedOnConcurrentQueue()
//publisherSubscriberWithReceivedOnDifferentScheduler()
//somePipeline()
//customPublisherSubscribedOnDifferentQueue()
//immediateSchedulerExample()

//: [Next](@next)
