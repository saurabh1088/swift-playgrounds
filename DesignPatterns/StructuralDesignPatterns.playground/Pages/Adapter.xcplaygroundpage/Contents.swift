//: [Previous](@previous)

// Created by Saurabh Verma on 24/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Adapter`
 `Adapter` design pattern is a structural design pattern that allows objects with incompatible interfaces to work
 together. In other words, it transforms the interface of an object to adapt it to a different object.
 */
import Foundation

/// Example 1 : A conceptual one
/// In example below we have a `Client` which can take up tasks of string types. `Client` uses APIs
/// provided by `Target` which can work with Strings. Now some new APIs are required to be consumed to
/// perform some different tasks, these APIs `Adaptee` can provide but `Adaptee` can only understand Int.
/// So here comes need for adapter pattern. An `Adapter` is defined which helps `Client` to adapt using
/// `Adaptee` APIs

class Adaptee {
    func iWorkWithIntOnly(_ value: Int) {
        print("Adaptee :: Value is :: \(value)")
    }
}

class Target {
    func iWorkWithStringOnly(_ value: String) {
        print("Target :: Value is :: \(value)")
    }
}

class Adapter: Target {
    var adaptee: Adaptee
    init(adaptee: Adaptee) {
        self.adaptee = adaptee
        super.init()
    }
    
    func iMakeAdapteeWorkWithString(_ value: String) {
        if let intValue = Int(value) {
            adaptee.iWorkWithIntOnly(intValue)
        }
    }
}

struct Client {
    var tasks = [String]()
    
    func apiUsingTarget() {
        let target = Target()
        for task in tasks {
            target.iWorkWithStringOnly(task)
        }
    }
    
    func apiUsingAdaptee() {
        let adapter = Adapter(adaptee: Adaptee())
        for task in tasks {
            adapter.iMakeAdapteeWorkWithString(task)
        }
    }
}

let client = Client(tasks: ["1", "2", "3"])
client.apiUsingTarget()
client.apiUsingAdaptee()

//: [Next](@next)
