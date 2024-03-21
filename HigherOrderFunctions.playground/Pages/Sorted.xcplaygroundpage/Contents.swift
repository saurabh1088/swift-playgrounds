//: [Previous](@previous)

// Created by Saurabh Verma on 20/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Sorted`
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
func exampleArraySorted() {
    let array = [86, 24, 53, 12, 95, 63, 42, 71, 38, 77, 57, 19, 5, 33, 49, 28, 92, 67, 14, 81]
    let sortedArray = array.sorted()
    print(array)
    print(sortedArray)
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :
func exampleArraySortedByAscending() {
    let array = [86, 24, 53, 12, 95, 63, 42, 71, 38, 77, 57, 19, 5, 33, 49, 28, 92, 67, 14, 81]
    let sortedArray = array.sorted { $0 < $1 }
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 :
func exampleArraySortedByDescending() {
    let array = [86, 24, 53, 12, 95, 63, 42, 71, 38, 77, 57, 19, 5, 33, 49, 28, 92, 67, 14, 81]
    let sortedArray = array.sorted { $0 > $1 }
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 :
func exampleArraySortedByDescendingUsingFullClosureSyntax() {
    let array = [86, 24, 53, 12, 95, 63, 42, 71, 38, 77, 57, 19, 5, 33, 49, 28, 92, 67, 14, 81]
    let sortedArray = array.sorted { elementA, elementB in
        elementA > elementB
    }
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 :
func exampleArrayOfStringSorted() {
    let array = ["Batman", "Superman", "Flash", "Wonder Woman", "Aquaman"]
    let sortedArray = array.sorted()
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 6 :
func exampleArrayOfStringSortedByAscending() {
    let array = ["Batman", "Superman", "Flash", "Wonder Woman", "Aquaman"]
    let sortedArray = array.sorted { elementOne, elementTwo in
        elementOne < elementTwo
    }
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 7 :
func exampleArrayOfStringSortedByDescending() {
    let array = ["Batman", "Superman", "Flash", "Wonder Woman", "Aquaman"]
    let sortedArray = array.sorted { $0 > $1 }
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 8 :
struct Employee: CustomStringConvertible {
    var id: Int
    var name: String
    
    var description: String {
        return "\(id) : \(name)"
    }
}

func exampleArraySortedByForCustomTypes() {
    let array = [Employee(id: 234, name: "Batman"),
                 Employee(id: 123, name: "Superman"),
                 Employee(id: 333, name: "Wonder Woman"),
                 Employee(id: 456, name: "Flash"),
                 Employee(id: 999, name: "Aquaman")]
    let sortedArray = array.sorted { employeeA, employeeB in
        employeeA.id > employeeB.id
    }
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 9 : Using SortComparator
/// `SortComparator`
/// Using `SortComparator` one can implement sorting algorithm for conforming types and then further
/// pass on the `SortComparator` to a `Sequence`  `sorted<Comparator>(using comparator: Comparator)` method
///
/// One great advantage of using `SortComparator` is that it encapsulates the sorting algorithm to a separate
/// type and this can be very useful for unit testing the sorting algorithm itself.
struct Movie: CustomStringConvertible {
    var title: String
    var director: String
    var yearOfRelease: Int
    
    var description: String {
        return "\(title) : \(director) : \(yearOfRelease)"
    }
}

struct MovieSortComparator: SortComparator {
    typealias Compared = Movie
    var order: SortOrder
    
    func compare(_ lhs: Movie, _ rhs: Movie) -> ComparisonResult {
        if lhs.yearOfRelease < rhs.yearOfRelease {
            return .orderedAscending
        } else {
            return .orderedDescending
        }
    }
}

struct MovieSortComparatorAdvanced: SortComparator {
    
    enum SortKey {
        case title
        case director
        case yearOfRelease
    }
    
    typealias Compared = Movie
    var order: SortOrder
    let sortKey: SortKey
    
    func compare(_ lhs: Movie, _ rhs: Movie) -> ComparisonResult {
        switch sortKey {
        case .title:
            if lhs.title > rhs.title {
                return .orderedDescending
            } else {
                return .orderedAscending
            }
        case .director:
            if lhs.director > rhs.director {
                return .orderedDescending
            } else {
                return .orderedAscending
            }
        case .yearOfRelease:
            if lhs.yearOfRelease > rhs.yearOfRelease {
                return .orderedDescending
            } else {
                return .orderedAscending
            }
        }
    }
}

func exampleArraySortedByUsingSortComparator() {
    let array = [Movie(title: "Dune 1", director: "Denis Villeneuve", yearOfRelease: 2021),
                 Movie(title: "Dune 2", director: "Denis Villeneuve", yearOfRelease: 2024),
                 Movie(title: "Oppenheimer", director: "Christopher Nolan", yearOfRelease: 2023),
                 Movie(title: "The Dark Knight", director: "Christopher Nolan", yearOfRelease: 2008)]
    let movieSortComparator = MovieSortComparator(order: .forward)
    let sortedArray = array.sorted(using: movieSortComparator)
    print(array)
    print(sortedArray)
}

func exampleArraySortedByUsingSortComparatorAdvanced() {
    let array = [Movie(title: "Dune 1", director: "Denis Villeneuve", yearOfRelease: 2021),
                 Movie(title: "Dune 2", director: "Denis Villeneuve", yearOfRelease: 2024),
                 Movie(title: "Oppenheimer", director: "Christopher Nolan", yearOfRelease: 2023),
                 Movie(title: "The Dark Knight", director: "Christopher Nolan", yearOfRelease: 2008)]
    let advancedMovieSortComparator = MovieSortComparatorAdvanced(order: .forward, sortKey: .director)
    let sortedArray = array.sorted(using: advancedMovieSortComparator)
    print(array)
    print(sortedArray)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 10 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 11 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 12 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 13 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 14 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 15 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 16 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 17 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 18 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 19 :

// MARK: -----------------------------------------------------------------------
// MARK: Example 20 :



// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleArraySorted()
//exampleArraySortedByAscending()
//exampleArraySortedByDescending()
//exampleArraySortedByDescendingUsingFullClosureSyntax()
//exampleArrayOfStringSorted()
//exampleArrayOfStringSortedByAscending()
//exampleArrayOfStringSortedByDescending()
//exampleArraySortedByForCustomTypes()
//exampleArraySortedByUsingSortComparator()
exampleArraySortedByUsingSortComparatorAdvanced()

//: [Next](@next)
