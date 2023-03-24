//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Creational Design Patters`
 
 Creational design patterns as the name suggests help in creation of objects. Objects which are building blocks
 of any object oriented programming language. Creational patters provide mechanisms which increase the performacne
 usability, flexibility and code re-usability for object creation.
 
 Creational design patters include following patterns :
 
 1. Factory Method
 2. Abstract Factory
 3. Builder
 4, Prototype
 5. Singleton
 */

import Foundation

/// `Singletons`
/// Example 1 : Singleton in Swift

class MySingletonClass {
    static let shared = MySingletonClass()
    private init() {}
    var name: String = String()
}

let singletonClassInstanceOne = MySingletonClass.shared
let singletonClassInstanceTwo = MySingletonClass.shared

singletonClassInstanceOne.name = "Batman"
singletonClassInstanceTwo.name = "Superman"

print("singletonClassInstanceOne name :: \(singletonClassInstanceOne.name)")
print("singletonClassInstanceTwo name :: \(singletonClassInstanceTwo.name)")


struct MySingletonStruct {
    static let shared = MySingletonStruct()
    private init() {}
    var name: String = String()
}

var singletonStructInstanceOne = MySingletonStruct.shared
var singletonStructInstanceTwo = MySingletonStruct.shared

singletonStructInstanceOne.name = "Batman"
singletonStructInstanceTwo.name = "Superman"

print("singletonStructInstanceOne name :: \(singletonStructInstanceOne.name)")
print("singletonStructInstanceTwo name :: \(singletonStructInstanceTwo.name)")



//: [Next](@next)
