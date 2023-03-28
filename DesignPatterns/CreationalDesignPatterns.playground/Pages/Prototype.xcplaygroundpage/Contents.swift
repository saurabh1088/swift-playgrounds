//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Prototype`
 `Prototype` is a creational design pattern which lets us copy an existing object. So it helps to create a new
 object which is copy of some existing one.
 */

import Foundation

class Wrapper<T> {
    let element: T
    
    init(element: T) {
        self.element = element
    }
}

let someIntegerWrapper = Wrapper<Int>(element: 4)
print("Value of wrapper someIntegerWrapper :: \(someIntegerWrapper.element)")

// Now suppose we want to copy our Wrapper, so to do this maybe we add extension to
// our Wrapper class and can write something like below.

extension Wrapper {
    func copyWrapper() -> Wrapper<T> {
        let copyElement = element
        return Wrapper(element: copyElement)
    }
}

let copySomeIntegerWrapper = someIntegerWrapper.copyWrapper()
print("Value of wrapper copySomeIntegerWrapper :: \(copySomeIntegerWrapper.element)")

print("\n-------------------------------------------------------------------\n")

// Fine, this is good so far. Now problem comes if generic type T in Wrapper is
// itself reference type.

class Employee: NSCopying {
    var id: Int
    var name: String
    var address: Address

    init(id: Int, name: String, address: Address) {
        self.id = id
        self.name = name
        self.address = address
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Employee(id: id, name: name, address: address.copy() as! Address)
    }
}

class Address: NSCopying {
    var streetName: String
    
    init(streetName: String) {
        self.streetName = streetName
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Address(streetName: streetName)
    }
}

let employeeWrapper = Wrapper<Employee>(element: Employee(id: 1,
                                                          name: "Batman",
                                                          address: Address(streetName: "Gotham")))

let copyEmployeeWrapper = employeeWrapper.copyWrapper()

copyEmployeeWrapper.element.name = "Dark Knight"
copyEmployeeWrapper.element.address.streetName = "Arkham"

// We can see here that even though the intent was to create a new copy of employee
// but one can see from the print statements that changing one is changing both,
// which means it's not the copy which is created but both are practically same
// reference.
print("employeeWrapper name :: \(employeeWrapper.element.name)")
print("Address of our employeeWrapper :: \(employeeWrapper.element.address.streetName)")
print("copyEmployeeWrapper name :: \(copyEmployeeWrapper.element.name)")
print("Address of our copyEmployeeWrapper :: \(copyEmployeeWrapper.element.address.streetName)")

print("\n-------------------------------------------------------------------\n")

class CopyableWrapper<T: NSCopying>: NSCopying {
    let element: T
    
    init(element: T) {
        self.element = element
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        guard let newElement = element.copy() as? T else {
            fatalError()
        }
        let newWrapper = CopyableWrapper(element: newElement)
        return newWrapper
    }
}

let copyableWrapperEmployee = CopyableWrapper(element: Employee(id: 1, name: "Batman", address: Address(streetName: "Gotham")))

let copyOfCopyableWrapperEmployee = copyableWrapperEmployee.copy() as! CopyableWrapper<Employee>
copyOfCopyableWrapperEmployee.element.name = "Dark Knight"
copyOfCopyableWrapperEmployee.element.address.streetName = "Arkham"


print("copyableWrapperEmployee name :: \(copyableWrapperEmployee.element.name)")
print("Address of our copyableWrapperEmployee :: \(copyableWrapperEmployee.element.address.streetName)")
print("copyOfCopyableWrapperEmployee name :: \(copyOfCopyableWrapperEmployee.element.name)")
print("Address of our copyOfCopyableWrapperEmployee :: \(copyOfCopyableWrapperEmployee.element.address.streetName)")

print("\n-------------------------------------------------------------------\n")

//: [Next](@next)
