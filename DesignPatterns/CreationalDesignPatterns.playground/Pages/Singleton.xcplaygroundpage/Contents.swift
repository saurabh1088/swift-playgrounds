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
/// Singleton pattern offers a controlled access to a single and only instance.
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

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Defining a Singleton
class MySingletonClass {
    static let shared = MySingletonClass()
    private init() {}
    var name: String = String()
}

func example1() {
    let singletonClassInstanceOne = MySingletonClass.shared
    let singletonClassInstanceTwo = MySingletonClass.shared

    singletonClassInstanceOne.name = "Batman"
    singletonClassInstanceTwo.name = "Superman"

    print("singletonClassInstanceOne name :: \(singletonClassInstanceOne.name)")
    print("singletonClassInstanceTwo name :: \(singletonClassInstanceTwo.name)")
}


/// `Swift provides structs and classes both, which one should be used to define a Singleton?`
///
/// Singletons should be defined using classes. Reason for this is that classes are reference type so if one happens
/// to pass a singleton reference along it will be passed as a reference only in case of class. One can define
/// singleton using struct as well, however if the struct is passed along it will get copied technically having multiple
/// instances which will defeat the purpose of having a Singleton.
/// Notice in example below for Singleton `MySingletonStruct`
/// Here `singletonStructInstanceOne` and `singletonStructInstanceTwo` turn out to be two
/// different instances and hold different values for `name`

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Can structs be used as Singletons?
struct MySingletonStruct {
    static let shared = MySingletonStruct()
    private init() {}
    var name: String = String()
}


func example2() {
    var singletonStructInstanceOne = MySingletonStruct.shared
    var singletonStructInstanceTwo = MySingletonStruct.shared

    singletonStructInstanceOne.name = "Batman"
    singletonStructInstanceTwo.name = "Superman"

    // Both singletonStructInstanceOne and singletonStructInstanceTwo end up having
    // different values so proving why defining Singleton using struct can be having
    // side effects and should not be used
    print("singletonStructInstanceOne name :: \(singletonStructInstanceOne.name)")
    print("singletonStructInstanceTwo name :: \(singletonStructInstanceTwo.name)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Can actors be used as Singletons?
actor SingletonUsingActor {
    static let shared = SingletonUsingActor()
    private init() {}
    var name: String = String()
    
    func update(name: String) {
        self.name = name
    }
}

func example3() {
    var singletonActorInstanceOne = SingletonUsingActor.shared
    var singletonActorInstanceTwo = SingletonUsingActor.shared

    Task {
        await singletonActorInstanceOne.update(name: "Batman")
        await singletonActorInstanceTwo.update(name: "Superman")
        
        await print("singletonActorInstanceOne name :: \(singletonActorInstanceOne.name)")
        await print("singletonActorInstanceTwo name :: \(singletonActorInstanceTwo.name)")
    }
}


/// `Why Singleton design pattern is called an anti-pattern?`
///
/// There are several reasons for `Singleton` being called as anti-pattern and is not recommended to use
/// very often.
///
/// - One of the major issue in using a `Singleton` in any application is the `Singleton` ending up becoming
/// a kind of global dump. Left unchecked in a big project one can soon see everyone dumping stuff which is
/// required globally into the `Singleton`. This can have serious consequences as for example a state in some
/// application is saved in a `Singleton` and can be changes from anywhere, this could lead to some unwanted
/// effects which get difficult to take into account while using.
/// - Another issue is with the assumption itself that when something is declared as a `Singleton` then an
/// assumption is made that it will always have a single instance. Then when if in future multiple instances are required
/// it will need a lot many changes.
/// - Using a `Singleton` makes code untestable. Singleton dependencies are not visible as these are used
/// within other places directly accessing the shared instance and not injected. This makes code difficult to test.


// MARK: -----------------------------------------------------------------------
// MARK: Examples
//example1()
//example2()
example3()

//: [Next](@next)
