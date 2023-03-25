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
/// `Singleton` creational design patterns is a pattern which creates a one and only one instance out of it's definition.
/// When one is using singleton then at any given time there should be only a single instace of the Singleton present
/// and it should be accessible.
///
/// Basically a Singleton design patters ensures that one and only one instance of the entity is instantiated.
///
/// In Swift when a Signleton is defined, in order to fulfil the design pattern requirements following things are required.
///
/// 1. There should be a `shared` `static` property which holds the instance of the class. It's static so
/// that it can be accessed on class itself as we won't be instantiating Singleton from outside.
///
/// 2. The initialiser should be marked `private` because not doing so will let anyone instantiate the class
/// and will defeat the whole purpose of having singleton in first place.
///
/// So basically all we want is Global Access & Single Instance when we talk about singletons.
///
/// `Why static keyword for shared instance property?`
///
/// Well the shared instance property while defining a Singleton should be marked as `static`. If not done
/// then in order to access the property one need to instantiate the Signleton first. so static keyword ensures
/// the shared property is a type property and can be called on type.
/// `static` also provides benefits like the property will be initialised lazily. (`static` properties are lazy by default
/// and need not to be marked with `lazy` keyword)
/// Also `static` ensures even when singleton is accessed across multiple threads simultaneously the property
/// is initialised only once, so providing thread safety.

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
