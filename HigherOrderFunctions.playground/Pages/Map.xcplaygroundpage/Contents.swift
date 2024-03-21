// Created by Saurabh Verma on 20/03/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


/**
 `map(_:)`
 */
import UIKit

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
func exampleArrayMap1() {
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let arrayMapped = array.map { value in
        value * 2
    }
    print(array)
    print(arrayMapped)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :
struct Employee {
    let id: Int
    let name: String
}
func exampleArrayMap2() {
    let array = [Employee(id: 1, name: "Batman"),
                 Employee(id: 2, name: "Superman"),
                 Employee(id: 3, name: "Wonder Woman"),
                 Employee(id: 4, name: "Flash"),
                 Employee(id: 5, name: "Aquaman"),
                 Employee(id: 6, name: "Cyborg")]
    let employeeNames = array.map { $0.name }
    let employeeIds = array.map { $0.id }
    print(array)
    print(employeeNames)
    print(employeeIds)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples :

//exampleArrayMap1()
//exampleArrayMap2()
