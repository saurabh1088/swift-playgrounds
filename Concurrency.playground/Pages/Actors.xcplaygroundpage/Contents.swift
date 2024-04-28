//: [Previous](@previous)

// Created by Saurabh Verma on 22/04/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Actors`
 
 Swift has -
 - Struct
 - Class
 - Actor

 Actors are conceptually similar to classes except some differences.

 `What makes Actors and Classes similar?`
 Actors are conceptually classes with some safety features for concurrent environment.
 Actors like classes are reference type.

 `What makes Actors different from classes?`
 Actors ensure safety in concurrent environment.
 Swift compiler ensures no two pieces of code attempts to access actor’s data at same time.
 Compiler safety ensures no boilerplate code required to manage locks
 Actors DO NOT support inheritance.
 Actors DO NOT support final or override keywords : this make sense as they don’t support inheritance
 An actor automatically serialises all access to its properties and methods, which ensures that only one caller can 
 directly interact with the actor at any given time. That in turn gives us complete protection against data races,
 since all mutations will be performed serially, one after the other.

 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Messaging Service without any concurrency considerations
/*
 Executing this example randomly gives below errors, sometimes the execution also
 appears to be stuck.
 
 Error received while execution :
 
 1.
 Actors(3323,0x16d0a3000) malloc: *** error for object 0x600001710580: pointer being freed was not allocated
 Actors(3323,0x16d0a3000) malloc: *** set a breakpoint in malloc_error_break to debug
 
 2.
 Actors(4074,0x16f83b000) malloc: Heap corruption detected, free list is damaged at 0x600001710000
 *** Incorrect guard value: 8261848480
 Actors(4074,0x16f83b000) malloc: *** set a breakpoint in malloc_error_break to debug
 Actors(4074,0x16fb83000) malloc: Heap corruption detected, free list is damaged at 0x600001710080
 *** Incorrect guard value: 72057602293669729
 Actors(4074,0x16fb83000) malloc: *** set a breakpoint in malloc_error_break to debug
 */
protocol MessagingServiceProvider {
    func received(message: String)
    func readLast() -> String?
}

class MessagingService: MessagingServiceProvider {
    private var messages = [String]()
    
    func received(message: String) {
        messages.append(message)
    }
    
    func readLast() -> String? {
        messages.last
    }
}

func exampleWithoutAnyConcurrencyConsiderations() {
    let messagingService = MessagingService()
    let taskOne = Task {
        for message in ["1. Apple", "2. Guava", "3. Grapes", "4. Orange", "5. Strawberry"] {
            try await Task.sleep(for: .seconds(1))
            print("Message received : \(message)")
            messagingService.received(message: message)
        }
    }
    
    let taskTwo = Task {
        for message in ["a. Red", "b. Blue", "c. Green", "d. Yellow", "e. Voilet"] {
            try await Task.sleep(for: .seconds(1))
            print("Message received : \(message)")
            messagingService.received(message: message)
        }
    }
    
    Task {
        for index in 1...10 {
            try await Task.sleep(for: .seconds(1))
            print("\(index). Last message :: \(messagingService.readLast() ?? "EMPTY")")
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Fixing Messaging Service
class MessagingServiceThreadSafe: MessagingServiceProvider {
    private var messages = [String]()
    private let queue = DispatchQueue(label: "messaging.service.queue")
    
    func received(message: String) {
        queue.sync {
            messages.append(message)
        }
    }
    
    func readLast() -> String? {
        queue.sync {
            messages.last
        }
    }
}

func exampleWithConcurrencyConsiderationsUsingSerialQueue() {
    let messagingService = MessagingServiceThreadSafe()
    
    let taskOne = Task {
        for message in ["1. Apple", "2. Guava", "3. Grapes", "4. Orange", "5. Strawberry"] {
            try await Task.sleep(for: .seconds(1))
            print("Message received : \(message)")
            messagingService.received(message: message)
        }
    }
    
    let taskTwo = Task {
        for message in ["a. Red", "b. Blue", "c. Green", "d. Yellow", "e. Voilet"] {
            try await Task.sleep(for: .seconds(1))
            print("Message received : \(message)")
            messagingService.received(message: message)
        }
    }
    
    Task {
        for index in 1...10 {
            try await Task.sleep(for: .seconds(1))
            print("\(index). Last message :: \(messagingService.readLast() ?? "EMPTY")")
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Fixing Messaging Service using Actors
actor MessagingServiceActor {
    private var messages = [String]()
    
    func received(message: String) {
        messages.append(message)
    }
    
    func readLast() -> String? {
        messages.last
    }
}

func exampleWithConcurrencyConsiderationsUsingActors() {
    let messagingService = MessagingServiceActor()
    
    let taskOne = Task {
        for message in ["1. Apple", "2. Guava", "3. Grapes", "4. Orange", "5. Strawberry"] {
            try await Task.sleep(for: .seconds(1))
            print("Message received : \(message)")
            await messagingService.received(message: message)
        }
    }
    
    let taskTwo = Task {
        for message in ["a. Red", "b. Blue", "c. Green", "d. Yellow", "e. Voilet"] {
            try await Task.sleep(for: .seconds(1))
            print("Message received : \(message)")
            await messagingService.received(message: message)
        }
    }
    
    Task {
        for index in 1...10 {
            try await Task.sleep(for: .seconds(1))
            let lastMessage = await messagingService.readLast()
            print("\(index). Last message :: \(lastMessage ?? "EMPTY")")
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleWithoutAnyConcurrencyConsiderations()
//exampleWithConcurrencyConsiderationsUsingSerialQueue()
//exampleWithConcurrencyConsiderationsUsingActors()

//: [Next](@next)
