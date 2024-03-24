//: [Previous](@previous)

// Created by Saurabh Verma on 24/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Find largest number from array of numbers
func exampleLargestNumberInArrayUsingMax() {
    let array = [2, 1, 4, 5, 2, 34, 67, 21, 9, 0, 89]
    let largestNumber = array.max()
    print(largestNumber ?? "NOT FOUND")
}

func exampleLargestNumberInArrayUsingLoop() {
    let array = [2, 1, 4, 5, 2, 34, 67, 21, 9, 0, 89]
    var largestNumber = array[0] // Start from first number
    for value in array {
        if value > largestNumber {
            largestNumber = value
        }
    }
    print(largestNumber)
}

func exampleLargestNumberInArrayUsingReduce() {
    let array = [2, 1, 4, 5, 2, 34, 67, 21, 9, 0, 89]
    let largestNumber = array.reduce(array[0]) { $0 > $1 ? $0 : $1 }
    print(largestNumber)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Find smallest number from array of numbers
func exampleSmallestNumberInArrayUsingMin() {
    let array = [2, 1, 4, 5, 2, 34, 67, 21, 9, 0, 89]
    let smallestNumber = array.min()
    print(smallestNumber ?? "NOT FOUND")
}

func exampleSmallestNumberInArrayUsingLoop() {
    let array = [2, 1, 4, 5, 2, 34, 67, 21, 9, 0, 89]
    var smallestNumber = array[0] // Start from first number
    for value in array {
        if value < smallestNumber {
            smallestNumber = value
        }
    }
    print(smallestNumber)
}

func exampleSmallestNumberInArrayUsingReduce() {
    let array = [2, 1, 4, 5, 2, 34, 67, 21, 9, 0, 89]
    let smallestNumber = array.reduce(array[0]) { $0 < $1 ? $0 : $1 }
    print(smallestNumber)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Find largest string in array of strings
func exampleLargestStringInArray() {
    let array = ["Batman", "Wonder Woman", "Superman", "Flash", "Aquaman"]
    let largestString = array.reduce(array[0]) { $0.count > $1.count ? $0 : $1 }
    print(largestString)
}

//exampleLargestNumberInArrayUsingMax()
//exampleLargestNumberInArrayUsingLoop()
//exampleLargestNumberInArrayUsingReduce()
exampleSmallestNumberInArrayUsingMin()
exampleSmallestNumberInArrayUsingLoop()
exampleSmallestNumberInArrayUsingReduce()
exampleLargestStringInArray()

//: [Next](@next)
