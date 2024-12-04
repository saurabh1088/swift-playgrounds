//: [Previous](@previous)

// Created by Saurabh Verma on 04/12/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Remove duplicates from given string
func removeDuplicates(from string: String) -> String {
    var seen = Set<Character>()
    return string.filter { seen.insert($0).inserted }
}

func exampleRemoveDuplicates() {
    let result = removeDuplicates(from: "czechoslovakia")
    print(result)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Check if strings are anagram
func areAnagrams(_ str1: String, _ str2: String) -> Bool {
    return str1.sorted() == str2.sorted()
}

func exampleStringCheckIfAnagrams() {
    print(areAnagrams("listen", "silent"))
    print(areAnagrams("hello", "world"))
}


// MARK: -----------------------------------------------------------------------
// MARK: Examples
exampleRemoveDuplicates()
exampleStringCheckIfAnagrams()

//: [Next](@next)
