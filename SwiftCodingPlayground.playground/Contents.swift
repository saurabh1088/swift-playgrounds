// Created by Saurabh Verma on 09/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import UIKit

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Reverse print a given string

/// `String` instance method `reversed()` is used here for reverse printing the given string. `reversed()`
/// doesn't directly returns a String, so one needs to cast it to a String before printing.
func reversePrintAGivenStringUsingAppleAPI() {
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
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

reversePrintAGivenStringUsingAppleAPI()
reversePrintStringWithoutNewAllocation()
