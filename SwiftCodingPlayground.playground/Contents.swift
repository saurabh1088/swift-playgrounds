// Created by Saurabh Verma on 19/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import UIKit

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Reverse print a given string

/// `String` instance method `reversed()` is used here for reverse printing the given string. `reversed()`
/// doesn't directly returns a String, so one needs to cast it to a String before printing.
/// Return type for `reversed()` method is `ReversedCollection<Self>`. It returns a view which represents
/// elements of the collection it gets called on in reverse order. This kind of provides access to the collection elements
/// in reverse order without allocating new memory space.
///
/// `Complexity`
///
func reversePrintStringUsingAppleAPI() {
    let string = "What a lovely day!!!"
    let reversedString = String(string.reversed())
    print(string)
    print(reversedString)
}

func reversePrintStringWithoutNewAllocation() {
    let string = "Because, I am Batman!"
    for char in string.reversed() {
        print(char, terminator: "")
    }
    print("")
}

func reversePrintStringUsingHigherOrderFunction() {
    let string = "Stay curious, stay humble."
    let reversedString = string.reduce("") { partialResult, character in
        "\(character)" + partialResult
    }
    print(reversedString)
}

func reversePrintStringUsingInsert() {
    let string = "Success is the sum of small efforts repeated day in and day out."
    var reversedString = String()
    for char in string {
        reversedString.insert(char, at: reversedString.startIndex)
    }
    print(reversedString)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

reversePrintStringUsingAppleAPI()
reversePrintStringWithoutNewAllocation()
reversePrintStringUsingHigherOrderFunction()
reversePrintStringUsingInsert()
