//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 Generally app contains a lot of code using completion handlers. Completion handlers are closures which the caller
 of the API provides and it gets executed once the API finishes.
 Combine can be used as an alternative and closure code can be removed.
 */
import Foundation
import Combine

// Below method takes a completion handler from caller and executes the handler
// once it completes some asynchronous operation. Asynchronous operation is mimicked
// by a delay.
typealias CompletionHandler = (String) -> Void
func someAsynchronousFunctionTakingCompletionHandler(completionHandler: @escaping CompletionHandler) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        completionHandler("Batman")
    }
}

someAsynchronousFunctionTakingCompletionHandler { value in
    print("Because I am \(value)")
}

// Combine version of same API
// Here there is no closure passed to API. Instead the asynchronous API executes
// it's asynchronous operation and once finished it will invoke the promise passing
// in the result (success or failure)
// The caller of the API will receive this result and can take further action.
enum CustomError: Error {
    case someFailure
}
func someAsynchronousFunctionUsingCombine() -> Future<String, CustomError> {
    return Future { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            promise(Result.success("Dark Knight"))
            //promise(Result.failure(CustomError.someFailure))
        }
    }
}

let cancellable = someAsynchronousFunctionUsingCombine()
    .sink { status in
        print("Status \(status)")
    } receiveValue: { receivedValue in
        print("Because I am \(receivedValue)")
    }

//: [Next](@next)
