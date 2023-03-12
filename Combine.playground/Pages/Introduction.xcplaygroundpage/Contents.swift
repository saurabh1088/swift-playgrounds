//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `What is Combine?`
 
 Quoting from Apple's official documentation (source : https://developer.apple.com/documentation/combine)
 
 `Customize handling of asynchronous events by combining event-processing operators.`
 
 Combine is a framework developed by Apple. It aims to provide declarative APIs for processing values over time.
 This providing of values over time is something we will come to know as publishers, but later on to that.
 This framework was introduced in WWDC 2019
 https://developer.apple.com/videos/play/wwdc2019/721
 https://developer.apple.com/videos/play/wwdc2019/722
 
 Combine enables us to write funtional reactive code by using it's declarative API. So it provides the
 functional reative programming (FRP) paradigm capability to Swift.
 
 Combine helps us, or ot can be said that it's all about defining the process of what needs to be done once
 many values of some type are received over time.
 
 For e.g. in SwiftUI framework the `ObservableObject` and `@Published` are actually using Combine
 behind the scenes.
 
 `Functional Reactive Programming`
 
 Before proceeding with Combine in details, it's necessary to understand what is FRP i.e. Functional Reactive Programming.
 Functional Reactive Programming is a programming paradigm. To understand FRP, one needs to know about
 concepts of `Imperative programming`, `Functional programming` and `Reactive programming`
 
 `Imperative programming`
 It's an approach in software development where program statements modify the state of the program. Solving a
 problem using this approach would mean to write code describing how one should solve the problem. The code
 then is executed sequentially to get the desired outcome. Imperative programming is about HOW to do it.
 
 `Functional programming`
 It's a declarative style of programming. Here the focus is on WHAT to do/solve. Here things are modeled as a
 result of some function which will avoid changing state and mutating data.
 
 `Reactive programming`
 Reactive programming refers to practice of programming with asynchronous data streams or streams of events.
 
 Now having looked into what is Imperative, Functional and Reactive programming we can have more understanding
 of what is `Functional Reactive Programming`.
 
 `Functional Reactive Programming`, builds on the concepts of functional programming along with
 reactive programming. In functional programming we may apply logic to lists of elements, in a functional reactive
 programming it's applied to streams of elements. The kinds of functions in functional programming, such as map,
 filter, and reduce have analogues that can be applied to streams. In addition to functional programming primitives,
 functional reactive programming includes functions to split and merge streams. Like functional programming, you
 may create operations to transform the data flowing through the stream.

 There are many parts of the systems we program that can be viewed as asynchronous streams of information
 - events, objects, or pieces of data. The observer pattern watches a single object, providing notifications of changes
 and updates. If you view these notifications over time, they make up a stream of objects. Functional reactive
 programming, Combine in this case, allows you to create code that describes what happens when getting data
 in a stream.

 You may want to create logic to watch more than one element that is changing. You may also want to include
 logic that does additional asynchronous operations, some of which may fail. You may want to change the content
 of the streams based on timing, or change the timing of the content. Handling the flow of these event streams,
 the timing, errors when they happen, and coordinating how a system responds to all those events is at the heart
 of functional reactive programming.

 A solution based on functional reactive programming is particularly effective when programming user interfaces.
 Or more generally for creating pipelines that process data from external sources or rely on asynchronous APIs.
 
 `Apple frameworks/APIs using Combine`
 - SwiftUI
 - RealityKit
 - NotificationCenter
 - URLSession
 - Timer
 
 `Combine core concepts`
 - Publishers & Subscribers
 - Operators
 - Subjects
 
 `Combine use cases`
 To generalise, one uses Combine when requirement is to react to a variety of inputs over time.
 
 1. User interfaces offer plenty of good use cases to use Combine. For e.g. in SwiftUI a view can be setup to subsribe
 to a viewmodel publishing values which can alter the state of the view. This way the view is refreshed whenever
 it receives new value for published values.
 
 2. You have a view with form having input textfields and finally a button for submission. Textfield needs input validation.
 Every input can be streamed to subscribe by a validator. Similarly the submission button can be setup to get enabled
 only when all input fields are valid.
 
 3. Asynchronous actions can be published and subscribers can choose to respond which can be for e.g. update a view.
  
 */

// Example 1
// Imperative programming
// In the example below we have declared an array containing Int 1 to 10. Desired
// result is to create an array of even number only. The logic here is imperative
// as it is sequentially executing a series of instruction to achieve end result.

print("Example 1 : Imperative programming")

let someArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var evenArrayImperative = [Int]()

for number in someArray {
    if number % 2 == 0 {
        evenArrayImperative.append(number)
    }
}


print("Original array :: \(someArray)")
print("Even array :: \(evenArrayImperative)")


// Example 2
// Functional programming
// In example below the same problem statement of Example 1 is attemped with a
// functional approach.

print("Example 2 : Functional programming")

let evenArrayFunctional = someArray.filter { $0 % 2 == 0 }

print("Original array :: \(someArray)")
print("Even array :: \(evenArrayFunctional)")

// The final filtered array achieved in Example 1 and Example 2 are same in terms
// of result, however there is one important difference. In Example 1 the resulting
// evenArrayImperative was a var but in case of Example 2 the evenArrayFunctional
// is a let constant

//: [Next](@next)
