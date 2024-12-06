//: [Previous](@previous)

// Created by Saurabh Verma on 06/12/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import Foundation

/**
 `Self vs self`
 
 `Self : The one with uppercase S`
 
 `Self` refers to the type that conforms to the protocol. It allows for defining requirements that are dependent
 on the specific type conforming to the protocol.
 
 
 `self : The one with lowercase s`
 
 `self` refers to the instance of the conforming type within methods, similar to this in other languages.
 */
// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
protocol Duplicatable {
    // Self here is a return type, and this will refer to the conforming type.
    // Which means, the type which conforms to this protocol will match the type
    // of Self.
    func duplicate() -> Self
}

struct TwiceTheInteger: Duplicatable {
    var value: Int
    
    func duplicate() -> TwiceTheInteger {
        // self here is the instance
        TwiceTheInteger(value: self.value * 2)
    }
}

func example1() {
    let twiceTheInteger = TwiceTheInteger(value: 10)
    let duplicate = twiceTheInteger.duplicate()
    print(duplicate)
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 :
class Employee: Duplicatable {
    var name: String
    
    /// NOTE: If required is not used here, compilor cries with below error
    /// `Constructing an object of class type 'Self' with a metatype value must use a 'required' initializer`
    required init(name: String) {
        self.name = name
    }
    
    /// NOTE: If instead of Self here Employee was used as return type compilor will cry with below error
    /// `Method 'duplicate()' in non-final class 'Employee' must return 'Self' to conform to protocol 'Duplicatable'`
    /// This happens because class Employee is not final and once can subclass it in which case the return
    /// type will be the subclass and hence Self make more sense here to incorporate possibility of subclasses,
    /// or one can use concrete type if the class is marked as final.
    func duplicate() -> Self {
        // Below line is same as writing : return Employee(name: self.name)
        return Self(name: self.name)
    }
}

func example2() {
    let instance = Employee(name: "John")
    let duplicateInstance = instance.duplicate()
    print("Are instance and duplicateInstance same? \(instance === duplicateInstance)")
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 3 :
class CEO: Employee {
    let designation: String = "CEO"
    
    required init(name: String) {
        super.init(name: name)
    }
}

func example3() {
    let ceo = CEO(name: "John")
    let coCeo = ceo.duplicate()
    print("Type of ceo : \(type(of: ceo))")
    print("Type of ceo : \(type(of: coCeo))")
    print("Are instance and duplicateInstance same? \(ceo === coCeo)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 :
/**
 Here is a final class, to conform to `Duplicatable` protocol any of two implementations would work
 
 ```
 func duplicate() -> Self {
     return Self(value: self.value)
 }
 ```
 
 OR
 
 ```
 func duplicate() -> SomeFinalClass {
     return SomeFinalClass(value: self.value)
 }
 ```
 */
final class SomeFinalClass: Duplicatable {
    var value: String
    
    init(value: String) {
        self.value = value
    }
    
//    func duplicate() -> Self {
//        return Self(value: self.value)
//    }
    
    func duplicate() -> SomeFinalClass {
        return SomeFinalClass(value: self.value)
    }
}

func example4() {
    let someFinalClass = SomeFinalClass(value: "Hello")
    let duplicateInstance = someFinalClass.duplicate()
    print("Are instance and duplicateInstance same? \(someFinalClass === duplicateInstance)")
}


// MARK: -----------------------------------------------------------------------
// MARK: Examples
//example1()
//example2()
//example3()
//example4()

//: [Next](@next)
