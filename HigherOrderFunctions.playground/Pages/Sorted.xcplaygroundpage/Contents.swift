//: [Previous](@previous)

// Created by Saurabh Verma on 20/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Sorted`
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :

func exampleOneArraySorted() {
    let array = [1, 4, 6, 2, 4, 34, 32, 66, 12, 50, 31, 99, 100, 2342, 123, 321]
    let sortedArray = array.sorted()
    print(array)
    print(sortedArray)
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :

func exampleTwoArraySortedByAscending() {
    
}

func exampleTwoArraySortedByDescending() {
    let array = [0, 34, 23, 123, 321, 456, 32, 55, 66, 90, 1, 4, 2, 5, 7, 99]
    let sortedArray = array.sorted { $0 > $1 }
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 :


// MARK: -----------------------------------------------------------------------
// MARK: Examples

exampleOneArraySorted()
exampleTwoArraySortedByAscending()
exampleTwoArraySortedByDescending()

//: [Next](@next)
