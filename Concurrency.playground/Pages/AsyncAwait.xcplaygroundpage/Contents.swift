//: [Previous](@previous)

// Created by Saurabh Verma on 21/04/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Async Await`
 
 `What is async?`
 `async` keyword when used for a function indicates that the function performs some asynchronous operation.
 
 `What is await?`
 When some function is called which is asyncronous, then one needs to wait till the asynchronous operation is
 ready, execution is suspended till the method returns. To mark this suspension point in the code, one needs to
 mark it with `await`.
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Without using async await
typealias AsyncronousOperationCompletionBlock = (Result<String, AsyncronousOperationError>) -> ()

enum AsyncronousOperationError: Error {
    case asyncOperationFailed
}

func performAsyncronousOperationWith(completion: @escaping AsyncronousOperationCompletionBlock) {
    DispatchQueue.global().async {
        for index in 1...10 {
            let percentage = (Double(index) / 10.0) * 100
            print("Loading \(percentage)%...")
            sleep(1)
        }
        
        let randomResult = Bool.random()
        if randomResult {
            DispatchQueue.main.async {
                completion(.success("Async operation successful!!!"))
            }
        } else {
            DispatchQueue.main.async {
                completion(.failure(AsyncronousOperationError.asyncOperationFailed))
            }
        }
    }
}

func exampleTraditionalAsynchronousOperationWithCompletionBlocks() {
    performAsyncronousOperationWith { result in
        switch result {
        case .success(let data):
            print(data)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Using Async/Await
func performAsyncronousOperation() async throws -> Result<String, AsyncronousOperationError> {
    try await Task.sleep(for: .seconds(10))
    let randomResult = Bool.random()
    return randomResult ? .success("Async operation successful!!!") : .failure(AsyncronousOperationError.asyncOperationFailed)
}

func exampleAsynchronousOperationWithAsyncAwait() {
    Task {
        do {
            let result = try await performAsyncronousOperation()
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        } catch {
            print("Some error occurred while executing function performAsyncronousOperation")
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Default execution of multiple async functions one after another
func performAsyncOperationA() async throws {
    Task.init {
        for index in 1...10 {
            try await Task.sleep(for: .seconds(1))
            print("\(index). Performing async operation A")
        }
    }
}

func performAsyncOperationB() async throws {
    Task.init {
        for index in 1...10 {
            try await Task.sleep(for: .seconds(1))
            print("\(index). Performing async operation B")
        }
    }
}

func performAsyncOperationC() async throws {
    Task.init {
        for index in 1...10 {
            try await Task.sleep(for: .seconds(1))
            print("\(index). Performing async operation C")
        }
    }
}

func exampleMultipleAsyncFunctionsCallsDefaultBehaviour() {
    Task {
        try await performAsyncOperationA()
        try await performAsyncOperationB()
        try await performAsyncOperationC()
    }
}


// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleTraditionalAsynchronousOperationWithCompletionBlocks()
//exampleAsynchronousOperationWithAsyncAwait()
exampleMultipleAsyncFunctionsCallsDefaultBehaviour()

//: [Next](@next)