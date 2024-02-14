//: [Previous](@previous)

// Created by Saurabh Verma on 13/02/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


/**
 `Enumerations`
 
 As per definition an enum is a model custom type which defines a list of possible values.
 Unlike C and Objective C, enumerations in Swift DON'T have an integer value set by default.
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Defining an Enumeration
/// As per Apple's recommendations one should give enums singular name so that in usage these are read as
/// intended and self-evident. For example when we assign a direction like below it will be making more sense
///
/// `let directionNorth = Direction.north`
///
/// Rather say if we had named the enums in plural
///
/// `let directionNorth = Directions.north`
enum Direction {
    case north
    case south
    case east
    case west
}

/// Here in this example when `directionNorth` is set to a direction using enum Directions then as per our
/// definition of `Directions` there isn't any value provided and enum in Swift doesn't get any integer value
/// as per some other languages like C or Objective C. Also one can notice that there isn't any rawValue available
/// to call on `directionNorth`. The defined cases are values in their own right, so the print statement below
/// will print `Value of directionNorth :: north`
/// So learning : By default an enum doesn’t come with a raw value.
func exampleEnumerationDefaultValue() {
    let directionNorth = Direction.north
    print("Value of directionNorth :: \(directionNorth)")
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : CaseIterable
/// `CaseIterable`
/// `CaseIterable` is a protocol, which is usually conformed by enums without associated values to access
/// a collection of all of it's cases using `allCases` property.
/// It does not means that one can't use `CaseIterable` with enumeration having associated value, one can
/// use, but then one will need to implement `allCases` property as compiler won't synthesize that.
/// For enum `Direction` at present there is no way to iterate over all cases. Suppose we want some functionality
/// to iterate over all directions we have no way of doing so at present, unless explicitly creating some data structure
/// to record all cases and do so.

enum DirectionWithCaseIterable: CaseIterable {
    case north, south, east, west
}

func exampleEnumerationCaseIterable() {
    DirectionWithCaseIterable.allCases.forEach { direction in
        print("Direction :: \(direction)")
    }
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 4 :
/// `Associated Value`
/// In Swift an enumeration can be defined to store associated values of any type if required. This associated
/// type can be of same or different type for each cases in the enumeration.
enum HTTPResponse {
    case success(Int)
    case error(String)
}

func handleHTTPResponse(_ response: HTTPResponse) {
    switch response {
    case .success(let responseCode):
        print("Success :: \(responseCode)")
    case .error(let errorDesc):
        print("Failure :: \(errorDesc)")
    }
}

func exampleEnumerationWithAssociatedValues() {
    let httpResponseSuccess = HTTPResponse.success(200)
    handleHTTPResponse(httpResponseSuccess)
    let httpResponseFailure = HTTPResponse.error("Network not reachable")
    handleHTTPResponse(httpResponseFailure)
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 5 :


// MARK: -----------------------------------------------------------------------
// MARK: Example 6 :


// MARK: -----------------------------------------------------------------------
// MARK: Example method calls
exampleEnumerationDefaultValue()
exampleEnumerationCaseIterable()
exampleEnumerationWithAssociatedValues()

//: [Next](@next)
