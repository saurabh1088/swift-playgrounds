//: [Previous](@previous)

// Created by Saurabh Verma on 22/04/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Actors`
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
class MessagingService {
    private var messages = [String]()
    
    func received(message: String) {
        messages.append(message)
    }
    
    func readLast() -> String? {
        messages.last
    }
}

func example1() {
    let messagingService = MessagingService()
    let taskOne = Task {
        for message in ["Apple", "Guava", "Grapes", "Orange", "Strawberry"] {
            try await Task.sleep(for: .seconds(1))
            print("Message received : \(message)")
            messagingService.received(message: message)
        }
    }
    
    let taskTwo = Task {
        for message in ["Red", "Blue", "Green", "Yellow", "Voilet"] {
            try await Task.sleep(for: .seconds(1))
            print("Message received : \(message)")
            messagingService.received(message: message)
        }
    }
    
    Task {
        for index in 1...10 {
            try await Task.sleep(for: .seconds(1))
            print("Last message :: \(messagingService.readLast())")
        }
    }
}

example1()

//: [Next](@next)

/*
 Error received while execution :
 Actors(3323,0x16d0a3000) malloc: *** error for object 0x600001710580: pointer being freed was not allocated
 Actors(3323,0x16d0a3000) malloc: *** set a breakpoint in malloc_error_break to debug
 */
