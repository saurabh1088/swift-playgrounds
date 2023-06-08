//: [Previous](@previous)

// Created by Saurabh Verma on 06/06/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Closures`
 
 Quoting from Apple's documentation :
 `Closures are self-contained blocks of functionality that can be passed around and used in your code.`
 
 Closures are similar to what we have as blocks in Objective C and C. Also similar to concepts like lambdas in
 some other languages.
 
 Closures can be
 - Assigned to variables
 - Passed as arguments to functions
 - Returned from functions
 - Can capture and store references to any constant or variables from context in which closure is defined
 
 Capturing of constants or variables by closure, from the context in which closure is defined is known as
 `closing over` those constants and variables.
 
 - Global functions are actually a special case of closures which have name but they don't capture values.
 - Nested functiona are also closures which have name, but unlike to gloabl functions these do capture values from
 context these are defined.
 
Syntax
 
 ```
 let aClosure = { (parameters) -> returntype in
     statements
 }
 ```
 */
import Foundation

/// Example 1 : Some closures to start with
let aClosure = {
    print("This is a closure")
}
aClosure()

let closureTakingArguments: (String, String) -> String
closureTakingArguments = { (firstName: String, lastName: String) -> String in
    return "\(firstName) \(lastName)"
}
print(closureTakingArguments("Saurabh", "Verma"))


/// Example 2 : Trailing Closures
func methodWillPerform(count: Int, task: () -> Void) {
    print(count)
    task()
}
methodWillPerform(count: 1) {
    print("methodWillPerform")
}

//: [Next](@next)
