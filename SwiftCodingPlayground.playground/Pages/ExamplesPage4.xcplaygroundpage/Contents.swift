//: [Previous](@previous)

// Created by Saurabh Verma on 19/04/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
/// Project is using many strings which are optional, in which case one need to show “NOT AVAILABLE” on UI,
/// how to handle this?

struct Employee {
    let id: Int
    let name: String
    let seatNumber: String?
}

struct EmployeeDetailsViewer {
    func showDetailsFor(employee: Employee) {
        print("Emp ID : \(employee.id)")
        print("Name : \(employee.name)")
        print("Seat No. : \(employee.seatNumber)")
    }
    
    func newShowDetailsFor(employee: Employee) {
        print("Emp ID : \(employee.id)")
        print("Name : \(employee.name)")
        print("Seat No. : \(employee.seatNumber.valueElseDefaultMessage)")
    }
}

extension Optional where Wrapped == String {
    var valueElseDefaultMessage: String {
        self ?? "NOT AVAILABLE"
    }
}



func exampleOptionalWithAndWithoutHelperExtension() {
    let employeeOne = Employee(id: 1, name: "Batman", seatNumber: "ODC-1")
    let employeeTwo = Employee(id: 2, name: "Superman", seatNumber: nil)
    
    let viewer = EmployeeDetailsViewer()
    viewer.showDetailsFor(employee: employeeOne)
    viewer.newShowDetailsFor(employee: employeeTwo)
}

exampleOptionalWithAndWithoutHelperExtension()

//: [Next](@next)
