//: [Previous](@previous)

// Created by Saurabh Verma on 02/06/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


/**
 `Phantom Types`
 
 `Phantom Types` could be defined as the generic types which aren't used in the concrete implementation.
 
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Without phantom types
/// In example below, we have structs defining employee and company. Both employee and company will need
/// a unique identity. For providing identity we have `Identifier` which provides a property `id`. Both
/// `Employee` and `Company` further use this `Identifier` type to declare their unique identifiers.
/// Now in example `exampleWithoutPhantomType()` an employee and a company are created and then
/// are compared if their identifiers are equal. This comparison shouldn't be valid as identity of an emplyee is
/// altogether different from identity of a company. However as same `Identifier` was used to define the
/// identities for both, it works and we get printed result `Employee and company are same`. However
/// this is wrong.
/// In Example 2 below, we will see how to overcome this issue using phantom types and have more type
/// safety with our logic.
struct Identifier: Equatable {
    let id: Int
}

struct Employee {
    let employeeId: Identifier
}

struct Company {
    let registrationId: Identifier
}


func exampleWithoutPhantomType() {
    let employee = Employee(employeeId: Identifier(id: 1))
    let company = Company(registrationId: Identifier(id: 1))
    if employee.employeeId == company.registrationId {
        print("Employee and company are same")
    }
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Using phantom types
/// In example below we defined a identifier almost same as example 1 above, however there is a key difference.
/// In `SafeIdentifier` there is a generic type defined which is `Type`. However this isn't used in the
/// struct's definition further. However now when our `SafeEmployee` and `SafeCompany` use this new
/// `SafeIdentifier` type for defining their identities, one gets type safety from compilor. Now one can no
/// longer accidently compare identity of an employee against that of company, which in previous implementation
/// would have been possible and could have lead to potential issues.
struct SafeIdentifier<PhantomType>: Equatable {
    let id: Int
}

enum IdType {
    enum Employee {}
    enum Company {}
}

struct SafeEmployee {
    let employeeId: SafeIdentifier<IdType.Employee>
}

struct SafeCompany {
    let registrationId: SafeIdentifier<IdType.Company>
}

func exampleWithPhantomTypes() {
    let employee = SafeEmployee(employeeId: SafeIdentifier<IdType.Employee>(id: 1))
    let company = SafeCompany(registrationId: SafeIdentifier<IdType.Company>(id: 1))
    /// Attempt to uncomment below code will make compilor cry with error :
    /// `Cannot convert value of type 'SafeIdentifier<IdType.Company>' to expected argument type 'SafeIdentifier<IdType.Employee>'`
//    if employee.employeeId == company.registrationId {
//        print("Employee and company are same")
//    }
}


// MARK: -----------------------------------------------------------------------
// MARK: Example method calls
exampleWithoutPhantomType()
exampleWithPhantomTypes()

//: [Next](@next)
