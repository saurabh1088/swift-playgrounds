//: [Previous](@previous)

// Created by Saurabh Verma on 23/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Reduce`
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Add all elements of an integer array
func exampleReduce1() {
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let sumOfArrayElements = array.reduce(0) { result, element in
        return result + element
    }
    print(array)
    print(sumOfArrayElements)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Concatenate an array of strings
func exampleReduce2() {
    let array = ["Because", "I", "am", "Batman", "!!!"]
    let sentence = array.reduce("") { sentence, word in
        sentence + " " + word
    }
    print(array)
    print(sentence)
}

//exampleReduce1()
//exampleReduce2()

//: [Next](@next)
