//: [Previous](@previous)

// Created by Saurabh Verma on 23/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Compact Map`
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
func exampleCompactMap1() {
    let array = ["1", "2", "Three", "4", "Five", "6", "7", "Eight", "9", "Ten"]
    let usingArrayMap = array.map({ Int($0) })
    let usingCompactMap = array.compactMap { Int($0) }
    print(array)
    print(usingArrayMap)
    print(usingCompactMap)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :
struct EndPoint: CustomStringConvertible {
    let url: String
    var description: String {
        return url
    }
}

func exampleCompactMap2() {
    let endpoints = [EndPoint(url: "https://www.google.com/maps"),
                     EndPoint(url: "https://www.google.com/"),
                     EndPoint(url: ""),
                     EndPoint(url: "https://www.apple.com/"),
                     EndPoint(url: "")]
    let validEndpoints = endpoints.compactMap({ URL(string: $0.url) })
    print(endpoints)
    print(validEndpoints)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleCompactMap1()
//exampleCompactMap2()

//: [Next](@next)
