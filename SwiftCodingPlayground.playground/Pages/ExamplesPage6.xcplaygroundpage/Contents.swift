//: [Previous](@previous)

// Created by Saurabh Verma on 26/04/25
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Check if two strings are anagram

func areAnaagrams(_ string1: String, _ string2: String) -> Bool {
    let sortedString1 = string1.sorted().reduce("") { partialResult, character in
        partialResult + String(character)
    }
    let sortedString2 = string2.sorted().reduce("") { partialResult, character in
        partialResult + String(character)
    }
    return sortedString1 == sortedString2
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples
areAnaagrams("elbow", "below")

//: [Next](@next)
