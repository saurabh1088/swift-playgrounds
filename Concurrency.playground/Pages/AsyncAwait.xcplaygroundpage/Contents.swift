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
 
 WWDC 2021
 https://developer.apple.com/videos/play/wwdc2021/10132

 While writing asynchronous code using completion handler approach, one needs to ensure that the completion 
 handler gets called for all possible scenarios. Compiler will not make any issues if the completion handler isn’t
 called and this can lead to unexpected results.

 Properties and initialisers can also be async. Only read-only properties can be async.

 TODOs
 Check AsyncSequence

 A function marked with keyword async can suspend, and when it suspends, it also suspends its callers. So 
 callers for an async function should also be async.

 Frequent error when an async method is called : async method used in a context that does not support concurrency.
 This error comes as async functions needs to be called by async functions only and eventually from some asynchronous context.
 To bridge this gap between synchronous and asynchronous worlds one need to use Task.

 Apple recommends not using get in name of async functions.

 Continuations
 Continuations must be resumed exactly once on every path.
 Discarding continuation without resuming is not allowed.
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
func performAsyncOperationA() async throws -> String {
    try await Task.sleep(for: .seconds(5))
    print("Completed operation A")
    return "A"
}

func performAsyncOperationB() async throws -> String {
    try await Task.sleep(for: .seconds(5))
    print("Completed operation B")
    return "B"
}

func performAsyncOperationC() async throws -> String {
    try await Task.sleep(for: .seconds(5))
    print("Completed operation C")
    return "C"
}

func exampleMultipleAsyncFunctionsCallsDefaultBehaviour() {
    Task {
        let resultA = try await performAsyncOperationA()
        let resultB = try await performAsyncOperationB()
        let resultC = try await performAsyncOperationC()
        
        let results = [resultA, resultB, resultC]
        print(results)
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 : Making multiple aysn functions execute in parallel
func exampleMultipleAsyncFunctionsExecutedInParallel() {
    Task {
        async let resultA = performAsyncOperationA()
        async let resultB = performAsyncOperationB()
        async let resultC = performAsyncOperationC()
        
        let results = try await [resultA, resultB, resultC]
        print(results)
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 : Nested completion blocks
enum JusticeLeagueMember: String {
    case Batman
    case Superman
    case WonderWoman
}

func contactAndRecruit(_ member: JusticeLeagueMember, completion: @escaping AsyncronousOperationCompletionBlock) {
    DispatchQueue.global().async {
        for index in 1...5 {
            sleep(1)
            print("\(index). In talks for recruiting with : \(member.rawValue)")
        }
        
        DispatchQueue.main.async {
            completion(.success("Recruited : \(member.rawValue)"))
        }
    }
}

func exampleMultipleNestedAsyncFunctionCalls() {
    contactAndRecruit(.Batman) { result in
        switch result {
        case .success(let data):
            print(data)
            contactAndRecruit(.Superman) { result in
                switch result {
                case .success(let data):
                    print(data)
                    contactAndRecruit(.WonderWoman) { result in
                        switch result {
                        case .success(let data):
                            print(data)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 6 : Same as Example 5 but using structured concurrency
func contactAndRecruit(_ member: JusticeLeagueMember) async -> String? {
    let task = Task {
        for index in 1...5 {
            sleep(1)
            print("\(index). In talks for recruiting with : \(member.rawValue)")
        }
    }
    await task.value
    return "Recruited : \(member.rawValue)"
}

func exampleMultipleNestedAsyncFunctionCallsUsingStructuredConcurrency() {
    Task {
        let resultBatman = await contactAndRecruit(.Batman)
        print(resultBatman ?? "Failed recruiting Batman")
        
        let resultSuperman = await contactAndRecruit(.Superman)
        print(resultSuperman ?? "Failed recruiting Superman")
        
        let resultWonderWoman = await contactAndRecruit(.WonderWoman)
        print(resultWonderWoman ?? "Failed recruiting Wonder Woman")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleTraditionalAsynchronousOperationWithCompletionBlocks()
//exampleAsynchronousOperationWithAsyncAwait()
//exampleMultipleAsyncFunctionsCallsDefaultBehaviour()
//exampleMultipleAsyncFunctionsExecutedInParallel()
//exampleMultipleNestedAsyncFunctionCalls()
//exampleMultipleNestedAsyncFunctionCallsUsingStructuredConcurrency()

//: [Next](@next)
