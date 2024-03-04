//: [Previous](@previous)

// Created by Saurabh Verma on 04/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Result`
 
 ```
 @frozen
 enum Result<Success, Failure> where Failure : Error
 ```
 
 `Result` in Swift is implemented as a enumeration which represents either a success or a failure. Success and
 failure are two cases for this enumeration with associated value types for both.
 */
import Foundation

enum NumberConverterError: Error {
    case notAValidNumber
}

func convertToInteger(_ value: String) -> Result<Int, NumberConverterError> {
    if let number = Int(value) {
        return .success(number)
    } else {
        return .failure(.notAValidNumber)
    }
}

func exampleResultTypeSuccess() {
    let result = convertToInteger("42")
    switch result {
    case .success(let success):
        print("Successfully converted and received value :: \(success)")
    case .failure(let failure):
        print("Error occurred while conversion :: \(failure)")
    }
}

func exampleResultTypeFailure() {
    let result = convertToInteger("Integer")
    switch result {
    case .success(let success):
        print("Successfully converted and received value :: \(success)")
    case .failure(let failure):
        print("Error occurred while conversion :: \(failure)")
    }
}

exampleResultTypeSuccess()
exampleResultTypeFailure()

//: [Next](@next)
