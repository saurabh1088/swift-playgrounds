// Created by Saurabh Verma on 06/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import UIKit

/// `What is the difference between the Float, Double, and CGFloat data types in Swift?`
///
/// CGFloat depends upon the CPU architecture. Which means if build is for 64 bit CPU then CGFloat is equivalent
/// to Double type and when build is for 32 bit CPU then CGFloat is equivalent to Float type.
/// In CGBase.h header a typedef is defined for the same based on architecture of CPU.
/// CGFloat even has a property `var native: CGFloat.NativeType` which tell its type (Double or Float)


/// `What is the default data type Swift uses when you define a decimal number?`
///
/// Swift uses Double by default when it sees a decimal number without any explicit type defined for it.
/// Swift defaults to Double as Double is more accurate data type in comparison to Float.

let someNumber = 3.14
print("Default type of someNumber is :: \(type(of: someNumber))")

let explicitFloat: Float = 3.14
print("Type of explicitFloat is :: \(type(of: explicitFloat))")

/// `What causes a deadlock? Code example showing a deadlock scenario?`
///
/// A deadlock occurs if for example say there are two tasks which are waiting for each other to finish. Let's say
/// we synchronously submit some task on main queue. Main queue is serial queue. Adding any task to main
/// queue synchronously basically creates a deadlock.
///
/// Trying to execute below DispatchQueue block will make below runtime exception :
/// `error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).`

/// Example 1 :
/// Here a deadlock occurs as the current context is Main itself. So we are dispatching some task synchronously
/// making main queue wait till the task is finished. But the task is dispatched to the main queue itself which is
/// waiting for the task to finish so it won't perform the task. So this creates a deadlock.
//DispatchQueue.main.sync {
//    print("This will not get printed")
//}

/// Example 2 :
/// Here again the current context is Main. From main a task is dispatched to a serial queue synchronously. Main
/// queue will wait till the task is finished. No deadloack is caused if the second print statement is not dispatched.
/// However once the second print statement is dispatched from within the task block deadlock occurs.
/// Reason for deadlock is that for second print statement task the current context is the serialQueue which is
/// a serial queue so will execute tasks one by one. It's executing a task and synchronously another task is given
/// to it. The second print statement forms a part of original task itself so unless that is performed second print
/// statement can't be executed. But unless second print is executed original task can't be completed. Hence
/// deadlock.
let serialQueue = DispatchQueue(label: "my.serial.queue")

//serialQueue.sync {
//    print("Print from serialQueue")
//    // This causes deadlock
//    serialQueue.sync {
//        print("Print again from serialQueue")
//    }
//}

/// `Can we check if code is running on main thread?`
///
/// Yes this can be checked using API `Thread.isMainThread` as shown in example below.

print("Is this running on main thread :: \(Thread.isMainThread)")
DispatchQueue.global(qos: .background).async {
    print("Is global dispatchqueue with background qos running on main thread :: \(Thread.isMainThread)")
}

/// `How to execute some code on main thread?`
///
/// There are following ways to execute something on main thread.
/// 1. Using `DispatchQueue.main`, this is associated with main thread and any task dispatched to it will
/// get executed on main thread.

DispatchQueue.main.async {
    print("Does DispatchQueue.main executes this on main thread :: \(Thread.isMainThread)")
}

/// 2. Usine `performSelector(onMainThread:with:waitUntilDone:)`
class SomeClass: NSObject {
    @objc func callMeOnMainThread() {
        print("Am I i.e. callMeOnMainThread getting called on main thread :: \(Thread.isMainThread)")
    }
    func execute() {
        self.performSelector(onMainThread: #selector(callMeOnMainThread),
                             with: nil,
                             waitUntilDone: false)
    }
}

let object = SomeClass()
object.execute()
