//: [Previous](@previous)

// Created by Saurabh Verma on 17/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Grand Central Dispatch`
 
 `Grand Central Dispatch` or `GCD` is a low level API managing concurrent operations. So basically it
 provides support for concurrent code execution on multicore hardware in macOS, iOS, watchOS, and tvOS.
 
 It's very difficult for an application running on a multicore hardware to efficiently utilise those multi-cores all by
 itself, this is even when we discount other applications as well competing for resources on that same hardware,
 or the complexity of application running on different hardwares having variety of different configurations and
 computing power available.
 
 Due to this above mentioned complexity GCD functions at low level, at system level, so that it can take balanced
 decision around these complexities.
 
 `Grand Central Dispatch` APIs comes from `Dispatch` framework, which is a part of `Foundation`
 framework.
 
 `Grand Central Dispatch` works with queues. It takes tasks and dispatches those tasks onto queues.
 So while interacting with the APIs as a developmer one doesn't need to worry regarding thread management.
 
 While talking about GCD, we come across queues and work items.
 
 `DispatchQueue`
 As mentioned in GCD, tasks are dispatched to a queue. `DispatchQueue` helps define object which manages
 execution of tasks. So basically it represents a queue in GCD. `DispatchQueue` are FIFI queues and the
 tasks can be submitted to a `DispatchQueue` as block objects. Taks which are submitted to `DispatchQueue`
 are executed on a pool of threads which are managed by system. There is a main `DispatchQueue` which
 guarantees tasks submitted will get executed on main thread, as for other queues, there is no gurantee which thread
 will be used to execute it.
 
 `Attempting to synchronously execute a task on main queue results in deadlock.`
 
 */
import Foundation

/// Example 1 : Main Dispatch Queue
/// One can access main queue with `DispatchQueue.main`. Main queue is the queue associated with the
/// main thread of application. Any task submitted on main queue gets executed on main thread.
/// `DispatchQueue.main.async` is usually used to submit a block of code to be used to update UI as all
/// UI changes need to happen on main thread.

let mainQueue = DispatchQueue.main
mainQueue.async {
    print("mainQueue :: am i printed from main thread :: \(Thread.isMainThread)")
}

/// Example 2 : Global queue
/// `globalQueueQOSBackground` is a global concurrent queue with QoS as background. In example below
/// onto this queue two tasks are submitted which are printing some statements. When executed the print statements
/// on console appear jumbled up between the two tasks, which should happen as because of queue being concurrent
/// both tasks are performed concurrently.
let globalQueueQOSBackground = DispatchQueue.global(qos: .background)

let globalQueueQOSBackgroundTask1 = {
    for index in 1...5 {
        print("\(index). globalQueueQOSBackground 😀")
    }
}
let globalQueueQOSBackgroundTask2 = {
    for index in 1...5 {
        print("\(index). globalQueueQOSBackground 😍")
    }
}

globalQueueQOSBackground.async {
    globalQueueQOSBackgroundTask1()
}

globalQueueQOSBackground.async {
    globalQueueQOSBackgroundTask2()
}

/// Example 3 : Global queue with `DispatchWorkItem`
/// Queue `dispatchQueueWorkItem` is a global concurrent queue with QoS as default. To this dispatch
/// queue there are two `DispatchWorkItem's` are submitted.

let dispatchQueueWorkItem = DispatchQueue.global(qos: .default)

let dispatchQueueWorkItemOne = DispatchWorkItem {
    for index in 1...5 {
        print("\(index). dispatchQueueWorkItem 🐶")
    }
}

let dispatchQueueWorkItemTwo = DispatchWorkItem {
    for index in 1...5 {
        print("\(index). dispatchQueueWorkItem 🐱")
    }
}

dispatchQueueWorkItem.async(execute: dispatchQueueWorkItemOne)
dispatchQueueWorkItem.async(execute: dispatchQueueWorkItemTwo)

/// Example 4 : Serial queue
/// Below example show how to create a custom serial queue. the queue created needs a label. Usual naming
/// conventions followed is to use reverse domain name similar to app id. This helps in identifying the queue in
/// event of any issues.
let serialDispatchQueue = DispatchQueue(label: "my.serial.queue")

let serialDispatchQueueTaskOne = DispatchWorkItem {
    for index in 1...5 {
        print("\(index). serialDispatchQueueTaskOne 🏏")
    }
}
let serialDispatchQueueTaskTwo = DispatchWorkItem {
    for index in 1...5 {
        print("\(index). serialDispatchQueueTaskTwo 🏀")
    }
}

serialDispatchQueue.async(execute: serialDispatchQueueTaskOne)
serialDispatchQueue.async(execute: serialDispatchQueueTaskTwo)
//: [Next](@next)

/// Example 5 : Async vs Sync
/// In example below we have a queue `concurrentQueueExample5` onto which a task is submitted. Now
/// within that task another task is dispatched to a different queue `innerConcurrentQueueExample5`.
/// Task submitted to `innerConcurrentQueueExample5` is using `sync`.
/// Here `sync` will be in context of the executing context so what we are saying is that from queue `concurrentQueueExample5`
/// we are synchronously dispatching a task on some other queue. Now the destination queue could be serial or
/// concurrent (it's concurrent here) but because the task is dispatched as `sync` so the queue dispatching
/// synchronously will wait till the queue onto which task is dispatched is finished with the task.
/// So because of this in below example `concurrentQueueExample5` WAITS till `innerConcurrentQueueExample5`
/// is finished with it's task.
///
/// If instead of `sync`, the task to `innerConcurrentQueueExample5` is dispatched as `async` then
/// result would be different.
let concurrentQueueExample5 = DispatchQueue.global(qos: .default)
let innerConcurrentQueueExample5 = DispatchQueue.global(qos: .default)
concurrentQueueExample5.async {
    print("Started some work from concurrentQueueExample5")
    innerConcurrentQueueExample5.sync {
        for index in 1...20 {
            print("\(index). Now printing from innerConcurrentQueueExample5 🛺")
        }
    }
    print("Completed work from concurrentQueueExample5")
}

/// Example 6 :
/// Below example creates a messaging service. The service keeps a record of messages sent to it and can
/// read out the recent message sent to it.
/// Messages to this messaging service as dispatched over a concurrent queue. If at the same time attempt
/// is made to read the recent message the result could be unexpected as while reading can turn up different
/// message than actually being set now.
/// This issue can be resolved by two ways.
/// 1. One way is to add a new message to message array by dispatching it over a serial queue.
/// 2. Another way is to dispatch it over a concurrent queue using a dispatch barrier as used in `RobustMessaging`
// https://www.avanderlee.com/swift/concurrent-serial-dispatchqueue/
public class Messaging {
    public var recentMessage: String {
        return messages.last ?? "NULL"
    }
    private var messages: [String] = []
    
    public func send(message: String) {
        self.messages.append(message)
        print("Expected :: \(message) | Actual :: \(self.recentMessage)")
    }
}

let someMessanger = Messaging()
someMessanger.send(message: "Hello")
print("\n** \(String(describing: someMessanger.recentMessage)) **\n")

let messageEnvironmentQueue = DispatchQueue.global(qos: .userInitiated)
let messageDispatcherQueue = DispatchQueue.global(qos: .userInitiated)
let messageDispatchQueue = DispatchQueue.global(qos: .userInitiated)
let messageOne = DispatchWorkItem { someMessanger.send(message: "message 1") }
let messageTwo = DispatchWorkItem { someMessanger.send(message: "message 2") }
let messageThree = DispatchWorkItem { someMessanger.send(message: "message 3") }
let messageFour = DispatchWorkItem { someMessanger.send(message: "message 4") }
let messageFive = DispatchWorkItem { someMessanger.send(message: "message 5") }
let messageSix = DispatchWorkItem { someMessanger.send(message: "message 6") }
let messageSeven = DispatchWorkItem { someMessanger.send(message: "message 7") }
let messageEight = DispatchWorkItem { someMessanger.send(message: "message 8") }
let messageNine = DispatchWorkItem { someMessanger.send(message: "message 9") }
let messageTen = DispatchWorkItem { someMessanger.send(message: "message 10") }
messageEnvironmentQueue.async {
    print("Starting sending messages")
    messageDispatcherQueue.sync {
        messageDispatchQueue.async(execute: messageOne)
        messageDispatchQueue.async(execute: messageTwo)
        messageDispatchQueue.async(execute: messageThree)
        messageDispatchQueue.async(execute: messageFour)
        messageDispatchQueue.async(execute: messageFive)
        messageDispatchQueue.async(execute: messageSix)
        messageDispatchQueue.async(execute: messageSeven)
        messageDispatchQueue.async(execute: messageEight)
        messageDispatchQueue.async(execute: messageNine)
        messageDispatchQueue.async(execute: messageTen)
    }
    print("Messages sent, let's read the last one")
    print("\n** \(String(describing: someMessanger.recentMessage)) **\n")
}

/// `RobustMessaging` uses a concurrent queue to append any new message it will receive. On the concurrent
/// queue a barrier is also set.
///
/// `Dispatch barrier`
/// A dispatch barrier helps creating a synchronization point for tasks executing in a concurrent dispatch queue.
/// So the queue will act like a normal concurrent queue. When a task is submitted to it using a barrier then when this
/// task block with barrier flag is executing then the queue will behave like a serial queue. So the queue while
/// executing the task marked with barrier will make sure that it is executing this barrier task only. Any tasks submitted
/// prior to executing barrier task will be completed before.
/// Once all previous tasks are done and barrier task is reaches then queue will not exeucte any other task while
/// executing this barrier task. Once barrier task is finished, queue will continue with other tasks concurrently.
public class RobustMessaging {
    private let queue = DispatchQueue(label: "some.concurrent.queue", attributes: .concurrent)
    public var recentMessage: String {
        return messages.last ?? "NULL"
    }
    private var messages: [String] = []
    
    public func send(message: String) {
        queue.async(flags: .barrier) {
            self.messages.append(message)
            print("Expected :: \(message) | Actual :: \(self.recentMessage)")
        }
    }
}

let robustMessaging = RobustMessaging()
let robustMessageOne = DispatchWorkItem { robustMessaging.send(message: "robust message 1") }
let robustMessageTwo = DispatchWorkItem { robustMessaging.send(message: "robust message 2") }
let robustMessageThree = DispatchWorkItem { robustMessaging.send(message: "robust message 3") }
let robustMessageFour = DispatchWorkItem { robustMessaging.send(message: "robust message 4") }
let robustMessageFive = DispatchWorkItem { robustMessaging.send(message: "robust message 5") }
let robustMessageSix = DispatchWorkItem { robustMessaging.send(message: "robust message 6") }
let robustMessageSeven = DispatchWorkItem { robustMessaging.send(message: "robust message 7") }
let robustMessageEight = DispatchWorkItem { robustMessaging.send(message: "robust message 8") }
let robustMessageNine = DispatchWorkItem { robustMessaging.send(message: "robust message 9") }
let robustMessageTen = DispatchWorkItem { robustMessaging.send(message: "robust message 10") }
messageEnvironmentQueue.async {
    print("Starting sending messages")
    messageDispatcherQueue.sync {
        messageDispatchQueue.async(execute: robustMessageOne)
        messageDispatchQueue.async(execute: robustMessageTwo)
        messageDispatchQueue.async(execute: robustMessageThree)
        messageDispatchQueue.async(execute: robustMessageFour)
        messageDispatchQueue.async(execute: robustMessageFive)
        messageDispatchQueue.async(execute: robustMessageSix)
        messageDispatchQueue.async(execute: robustMessageSeven)
        messageDispatchQueue.async(execute: robustMessageEight)
        messageDispatchQueue.async(execute: robustMessageNine)
        messageDispatchQueue.async(execute: robustMessageTen)
    }
    print("Messages sent, let's read the last one")
    print("\n** \(String(describing: someMessanger.recentMessage)) **\n")
}
