//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Convenience Publishers`
 
 Swift Combine framework provides several convenience publishers which can be used to create publishers
 without need to implement Publisher protocol and implementing it.
 
 - Future
 - Just
 - Deferred
 - Empty
 - Fail
 - Record
 */

import Foundation
import Combine

/// Example 1
/// Using `Future`

func generateSomeRandomNumber() -> Future<Int, Never> {
    return Future { promise in
        let randomNumber = Int.random(in: 1...100)
        promise(Result.success(randomNumber))
    }
}

let futurePublisher = generateSomeRandomNumber()
let futurePublisherSubscriber = futurePublisher.sink { receivedValue in
    print("Value published from future publisher : \(receivedValue)")
}

//: [Next](@next)
