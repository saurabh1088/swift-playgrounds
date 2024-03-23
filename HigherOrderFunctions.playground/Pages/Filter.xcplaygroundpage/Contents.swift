//: [Previous](@previous)

// Created by Saurabh Verma on 23/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Filter`
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
func exampleArrayFilter1() {
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let evenNumbers = array.filter { $0 % 2 == 0 }
    print(array)
    print(evenNumbers)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :
struct Movie: CustomStringConvertible {
    let title: String
    let releaseYear: Int
    
    var description: String {
        return "\(releaseYear) : \(title)"
    }
}

func exampleArrayFilter2() {
    let movies = [Movie(title: "Dune 2", releaseYear: 2024),
                  Movie(title: "Oppenheimer", releaseYear: 2023),
                  Movie(title: "Jawan", releaseYear: 2023),
                  Movie(title: "Dangal", releaseYear: 2016),
                  Movie(title: "Animal", releaseYear: 2023)]
    let movies2023 = movies.filter({ $0.releaseYear == 2023 })
    print(movies)
    print(movies2023)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 :
// TODO: Figure out why this isn't working
/*
func exampleArrayFilter3() {
    let movies = [Movie(title: "Dune 2", releaseYear: 2024),
                  Movie(title: "Oppenheimer", releaseYear: 2023),
                  Movie(title: "Jawan", releaseYear: 2023),
                  Movie(title: "Dangal", releaseYear: 2016),
                  Movie(title: "Animal", releaseYear: 2023)]
    let predicate2024 = #Predicate<Movie> { movie in
        movie.releaseYear == 2024
    }
    var movies2024 = [Movie]()
    do {
        movies2024 = try movies.filter(predicate2024)
    } catch {
        print("Error while filtering movies based on predicate")
    }
    print(movies)
    print(movies2024)
}
*/

//exampleArrayFilter1()
//exampleArrayFilter2()
//exampleArrayFilter3()

//: [Next](@next)
