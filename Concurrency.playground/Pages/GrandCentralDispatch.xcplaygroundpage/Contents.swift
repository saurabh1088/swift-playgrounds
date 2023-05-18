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

/// Example 5 :
