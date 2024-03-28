//: [Previous](@previous)

// Created by Saurabh Verma on 28/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Print a given string in alphabet order
func examplePrintStringInAlphaBeticalOrder() {
    let string = "qwertyuiopasdfghjklzxcvbnm"
    let alphaString = string.map { String($0) }.sorted().reduce("") { partialResult, char in
        partialResult + char
    }
    print(alphaString)
}

examplePrintStringInAlphaBeticalOrder()

//: [Next](@next)
