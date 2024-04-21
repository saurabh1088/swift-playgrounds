//: [Previous](@previous)

// Created by Saurabh Verma on 21/04/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Async Await`
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
// MARK: Examples

//exampleTraditionalAsynchronousOperationWithCompletionBlocks()
exampleAsynchronousOperationWithAsyncAwait()

//: [Next](@next)
