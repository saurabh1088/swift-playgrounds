//: [Previous](@previous)

// Created by Saurabh Verma on 12/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Composite`
 Composite design pattern helps one create a tree-like structure of objects where both the individual objects and
 the compositions of objects can be accessed and manipulated in a consistent way.
 
 Composite lets clients treat individual objects and compositions of objects uniformly
 
 A composite design pattern usually consists of following players :
 
 1. Component
 Component here is an abstraction/protocol/interfact. This is common to both collections and individual objects.
 All the elements in the tree structure being implemented using composite design pattern should derive from this
 only.

 2. Primitive
 Primitives are individual objects in the tree structure which do not contain any child components.
 
 3. Composite
 Composite holds array or collection of components.
 
 So in `Composite` design pattern both Composite and Primitive will conform to Component.
 
 - Primitive
 
 */
import Foundation

/// Example 1 :
/// `Employee` below act as our Component
protocol Person {
    var name: String { get }
}

/// `Employee` is a Primitive here, it cannot have any further hierarchy in a tree structure.
class Employee: Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

/// `Manager` is a Composite in a sense that a manager will manage a team of employees, however a manager
/// also is an employee.
class Manager: Person {
    var name: String
    var team = [Person]()
    
    init(name: String) {
        self.name = name
    }
    
    func addToTeam(member: Person) {
        team.append(member)
    }
}

// TODO: Add a description for Manager class to print the hierarchy
func exampleComposite() {
    let employee1 = Employee(name: "employee1")
    let employee2 = Employee(name: "employee2")
    let employee3 = Employee(name: "employee3")
    let employee4 = Employee(name: "employee4")
    
    let seniorManager = Manager(name: "seniorManager")
    let manager = Manager(name: "manager")
    manager.addToTeam(member: employee3)
    manager.addToTeam(member: employee4)
    seniorManager.addToTeam(member: employee1)
    seniorManager.addToTeam(member: employee2)
    seniorManager.addToTeam(member: manager)
}
//: [Next](@next)
