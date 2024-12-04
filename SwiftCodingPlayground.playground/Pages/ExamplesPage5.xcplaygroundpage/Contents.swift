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

func stringCodingExampleRemoveDuplicates() {
    let result = removeDuplicates(from: "czechoslovakia")
    print(result)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Check if strings are anagram
func areAnagrams(_ str1: String, _ str2: String) -> Bool {
    return str1.sorted() == str2.sorted()
}

func stringCodingExampleCheckIfAnagrams() {
    print(areAnagrams("listen", "silent"))
    print(areAnagrams("hello", "world"))
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Remove duplicates from given string
func reverseWords(in string: String) -> String {
    let words = string.split(separator: " ")
    return words.map({ String($0.reversed()) }).joined(separator: " ")
}

func stringCodingExampleReverseWordsInString() {
    let result = reverseWords(in: "This is a string and we want to reverse all words keeping order same")
    print(result)
}



// MARK: -----------------------------------------------------------------------
// MARK: Examples
stringCodingExampleRemoveDuplicates()
stringCodingExampleCheckIfAnagrams()
stringCodingExampleReverseWordsInString()

//: [Next](@next)
