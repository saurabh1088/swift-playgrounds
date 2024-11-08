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
 So while interacting with the APIs as a developer one doesn't need to worry regarding thread management.
 
 While talking about GCD, we come across queues and work items.
 
 `DispatchQueue`
 As mentioned in GCD, tasks are dispatched to a queue. `DispatchQueue` helps define object which manages
 execution of tasks. So basically it represents a queue in GCD. `DispatchQueue` are FIFO queues and the
 tasks can be submitted to a `DispatchQueue` as block objects. Tasks which are submitted to `DispatchQueue`
 are executed on a pool of threads which are managed by system. There is a main `DispatchQueue` which
 guarantees tasks submitted will get executed on main thread, as for other queues, there is no gurantee which thread
 will be used to execute it.
 
 `Attempting to synchronously execute a task on main queue results in deadlock.`
 
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Main Dispatch Queue
/// One can access main queue with `DispatchQueue.main`. Main queue is the queue associated with the
/// main thread of application. Any task submitted on main queue gets executed on main thread.
/// `DispatchQueue.main.async` is usually used to submit a block of code to be used to update UI as all
/// UI changes need to happen on main thread.

func dispatchQueueExample1() {
    let mainQueue = DispatchQueue.main
    mainQueue.async {
        print("mainQueue :: Am i printed from main thread :: \(Thread.isMainThread)")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Global queue
/// `globalQueueQOSBackground` is a global concurrent queue with QoS as background. In example below,
/// two tasks are submitted onto this queue, which are printing some statements. When executed the print statements
/// on console appear jumbled up between the two tasks, which should happen as because of queue being concurrent
/// both tasks are performed concurrently.
func dispatchQueueExample2() {
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
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Global queue with DispatchWorkItem
/// Queue `dispatchQueueWorkItem` is a global concurrent queue with QoS as default. To this dispatch
/// queue there are two `DispatchWorkItem's` are submitted.
///
/// This one and the dispatchQueueExample2 are same functionally except use of DispatchWorkItem here.
func dispatchQueueExample3() {
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
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 : Serial queue
/// Below example shows how to create a custom serial queue. The queue created needs a label. Usual naming
/// conventions followed is to use reverse domain name similar to app id. This helps in identifying the queue in
/// event of any issues.
func dispatchQueueExample4() {
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
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 : Async vs Sync
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
func dispatchQueueExample5() {
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
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 6 :
/// Below example creates a messaging service. The service keeps a record of messages sent to it and can
/// read out the recent message sent to it.
/// Messages to this messaging service as dispatched over a concurrent queue. If at the same time attempt
/// is made to read the recent message the result could be unexpected as while reading can turn up different
/// message than actually being set now.
/// This issue can be resolved by two ways.
/// 1. One way is to add a new message to message array by dispatching it over a serial queue.
/// 2. Another way is to dispatch it over a concurrent queue using a dispatch barrier as used in `RobustMessaging`
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

func dispatchQueueExample6() {
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
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 7 :
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

func dispatchQueueExample7() {
    let messageEnvironmentQueue = DispatchQueue.global(qos: .userInitiated)
    let messageDispatcherQueue = DispatchQueue.global(qos: .userInitiated)
    let messageDispatchQueue = DispatchQueue.global(qos: .userInitiated)

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
        print("\n** \(String(describing: robustMessaging.recentMessage)) **\n")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 8 : Initially inactive queue
/// Usually as soon as tasks are submitted to a queue, the queue will schedule execution of those tasks
/// immediately.
func dispatchQueueExample8() {
    let initiallyInactiveQueue = DispatchQueue(label: "some.initiallyInactive.queue", attributes: .initiallyInactive)
    initiallyInactiveQueue.async {
        print("Executing from initiallyInactive queue")
    }
    print("Tasks submitted to initiallyInactive queue")
    print("About to activate initiallyInactiveQueue")
    initiallyInactiveQueue.activate()
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 9 : autoreleaseFrequency
// TODO: Need to figure out exact relevance of autoreleaseFrequency and update example accordingly.
class TestClassForAutoRelease {
    init() { print("TestClassForAutoRelease initialised") }
    func doSomeWork() { print("This is TestClassForAutoRelease instance") }
    deinit { print("TestClassForAutoRelease de-initialised") }
}
func dispatchQueueExample9() {
    let autoreleaseDispatchQueue = DispatchQueue(label: "some.autorelease.queue", autoreleaseFrequency: .workItem)
    print("Dispatch will begin")
    autoreleaseDispatchQueue.async {
        autoreleasepool {
            let objectForAutoreleaseClass = TestClassForAutoRelease()
            objectForAutoreleaseClass.doSomeWork()
        }
        print("Sleeping for some time")
        sleep(20)
        print("Awake now")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 10 :
/// DispatchQueue also provides a way to return some value from task scheduled synchronously over a queue.
func dispatchQueueExample10() {
    let someSerialQueue = DispatchQueue(label: "some.serial.queue")
    let result = someSerialQueue.sync {
        return 2 * 2
    }
    print("Result from queue :: \(result)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 11 :
/// Here the `DispatchWorkItem` get executed on current thread when `perform()` is called on it.
func dispatchQueueExample11() {
    let dispatchWorkItem = DispatchWorkItem {
        print("This is dispatch work item")
        if let threadName = Thread.current.name {
            print("Thread \(threadName) is executing on main thread :: \(Thread.isMainThread)")
        }
    }
    dispatchWorkItem.perform()
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 12 : DispatchGroup example
/// `DispatchGroup`
/// `DispatchGroup` helps to monitor a group of tasks as single unit.
func dispatchQueueExample12() {
    let dispatchGroup = DispatchGroup()
    let dispatchQueueConcurrent = DispatchQueue.global(qos: .default)
    let workItemOne = DispatchWorkItem {
        for index in 1...5 {
            print("\(index). Performing workItemOne 🍷")
        }
    }
    let workItemTwo = DispatchWorkItem {
        for index in 1...5 {
            print("\(index). Performing workItemTwo 🍸")
        }
    }
    
    dispatchQueueConcurrent.async(group: dispatchGroup, execute: workItemOne)
    dispatchQueueConcurrent.async(group: dispatchGroup, execute: workItemTwo)
    
    dispatchGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
        print("Performed all tasks dispatched to dispatchQueueConcurrent")
    }))
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 13 : Dispatch group wait on few tasks before proceeding
/// This example uses `DispatchGroup` to schedule few tasks as a group and also lets define a condition
/// for one task to only executed once others are finished. Tasks workItemA, workItemB and workItemC are
/// dispatched to a global concurrent queue so these will get executed concurrently, but workItemB here will
/// only get executed once workItemA and workItemC are both finished.
func dispatchQueueExample13() {
    let dispatchGroup = DispatchGroup()
    let someConcurrentDispatchQueue = DispatchQueue.global(qos: .default)
    let workItemA = DispatchWorkItem {
        for index in 1...5 {
            print("\(index). Executing workItemA 🫥")
        }
    }
    let workItemB = DispatchWorkItem {
        for index in 1...5 {
            print("\(index). Executing workItemB 🤡")
        }
    }
    let workItemC = DispatchWorkItem {
        for index in 1...5 {
            print("\(index). Executing workItemC 👾")
        }
    }
    
    someConcurrentDispatchQueue.async(group: dispatchGroup, execute: workItemA)
    someConcurrentDispatchQueue.async(group: dispatchGroup, execute: workItemC)
    dispatchGroup.wait()
    someConcurrentDispatchQueue.async(group: dispatchGroup, execute: workItemB)
    
    dispatchGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
        print("Performed all tasks dispatched to someConcurrentDispatchQueue")
    }))
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 14 : Dispatch queues with different QoS
func dispatchQueueExample14() {
    let backgroundQOSQueue = DispatchQueue.global(qos: .background)
    let defaultQOSQueue = DispatchQueue.global(qos: .default)
    let unspecifiedQOSQueue = DispatchQueue.global(qos: .unspecified)
    let userInitiatedQOSQueue = DispatchQueue.global(qos: .userInitiated)
    let userInteractiveQOSQueue = DispatchQueue.global(qos: .userInteractive)
    
    DispatchQueue.global().async {
        backgroundQOSQueue.async {
            print("Inside queue with QOS :: background")
            for index in 1...5 {
                print("     background \(index)")
            }
        }
        defaultQOSQueue.async {
            print("Inside queue with QOS :: default")
            for index in 1...5 {
                print("     default \(index)")
            }
        }
        unspecifiedQOSQueue.async {
            print("Inside queue with QOS :: unspecified")
            for index in 1...5 {
                print("     unspecified \(index)")
            }
        }
        userInitiatedQOSQueue.async {
            print("Inside queue with QOS :: userInitiated")
            for index in 1...5 {
                print("     userInitiated \(index)")
            }
        }
        userInteractiveQOSQueue.async {
            print("Inside queue with QOS :: userInteractive")
            for index in 1...5 {
                print("     userInteractive \(index)")
            }
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 15 : DispatchWorkItem with cancel
/// In the example below, a `DispatchWorkItem` is created and dispatched multiple times on a global `DispatchQueue`.
/// `DispatchWorkItem` provides a instance method `cancel()` which cancels the work item asynchronously.
/// Catch however is that if the workitem for which `cancel()` is called is currently in progress, that will finish
/// it's execution without any issues. If however the work item is attempted to dispatched again, then it won't
/// be executed as it's already cancelled.
func dispatchQueueExample15() {
    let dispatchQueue = DispatchQueue.global(qos: .background)
    let workItem = DispatchWorkItem {
        print("Starting some work...")
        for index in 1...10 {
            print("\(index). Performing some work")
        }
        print("Work finished")
    }
    
    dispatchQueue.async(execute: workItem)
    dispatchQueue.async(execute: workItem)
    print("Dispatched work item two times")
    workItem.cancel()
    print("Cancelled the work item")
    print("Dispatching work item three times more")
    dispatchQueue.async(execute: workItem)
    dispatchQueue.async(execute: workItem)
    dispatchQueue.async(execute: workItem)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 16 : DispatchWorkItem with cancelling long running task
func dispatchQueueExample16() {
    let dispatchQueue = DispatchQueue.global(qos: .background)
    
    var workItem: DispatchWorkItem!
    workItem = DispatchWorkItem {
        print("Started work item...")
        for index in 1...50 {
            if !workItem.isCancelled {
                print("\(index). performing work item...")
                sleep(1)
            }
        }
        print("Finishing work item!!!")
    }
    
    dispatchQueue.async(execute: workItem)
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        workItem.cancel()
        print("Did work item cancel? \(workItem.isCancelled)")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//dispatchQueueExample1()
//dispatchQueueExample2()
//dispatchQueueExample3()
//dispatchQueueExample4()
//dispatchQueueExample5()
//dispatchQueueExample6()
//dispatchQueueExample7()
//dispatchQueueExample8()
//dispatchQueueExample9()
//dispatchQueueExample10()
//dispatchQueueExample11()
//dispatchQueueExample12()
//dispatchQueueExample13()
//dispatchQueueExample14()
//dispatchQueueExample15()
dispatchQueueExample16()

//: [Next](@next)
