// Created by Saurabh Verma on 07/07/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Hashable`
 
 `Hashable` is a protocol which means that conforming type can be hashed to produce a hash value.
 */
import UIKit

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Hash value for Swift types from standard library
/// In example below one can see that Swift's types available from standard library like `Int`, `String`, `Float`
/// etc, conform to `Hashable` protocol already and one can get hashValue for these.
func hashableExample1() {
    let integerValue: Int = 1
    let stringValue: String = "abc"
    let floatValue: Float = 1.0
    
    print("Hash value for integerValue :: \(integerValue.hashValue)")
    print("Hash value for stringValue :: \(stringValue.hashValue)")
    print("Hash value for floatValue :: \(floatValue.hashValue)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Custom types conformance when using standard types
struct Employee: Hashable {
    let id: Int
    let name: String
}

/// In the example below, a custom type `Employee` is declared which is having two properties, with both the
/// properties type coming from standard Swift library. In this case, to make this custom type hashable, all one
/// need to do is to have the custom type i.e. `Employee` conform to `Hashable` protocol.
/// Without conforming to `Hashable` protocol, property `hashValue` woudn't be available.
func hashableExample2() {
    let employee = Employee(id: 1, name: "Batman")
    
    print("Hash value for employee :: \(employee.hashValue)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Hash value for enumeration without any associated values
enum JusticeLeague {
    case batman
    case superman
    case wonderwoman
    case flash
}

/// Unlike structures, enumerations when not having any assoicated values, gain conformance to `Hashable`
/// protocol by default and one doesn't need to mark the conformance in declaration.
func hashableExample3() {
    let batman = JusticeLeague.batman
    
    print("Hash value for batman :: \(batman.hashValue)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 :
enum Barcode: Hashable {
    case upc(Int)
    case qrcode(String)
}

/// Contrast to hashableExample3(), when an enumeration is having associated values, and all associated values
/// are already hashable, then compilor will be able to provide the hashValue, however one need to add conformance
/// in the enumeration's declaration.
func hashableExample4() {
    let upc = Barcode.upc(1234567890)
    let qrCode = Barcode.qrcode("qr code value")
    
    print("Hash value for upc :: \(upc.hashValue)")
    print("Hash value for qrCode :: \(qrCode.hashValue)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 : Custom type, with some types not conforming to Hashable
struct Manufacturer {
    let name: String
}

struct Bike: Hashable {
    let name: String
    let company: Manufacturer
    
    static func == (lhs: Bike, rhs: Bike) -> Bool {
        lhs.name == rhs.name && lhs.company.name == rhs.company.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(company.name)
    }
}

/// In this example hash value of type `Bike` is attempted. To do so, `Bike` was made to conform `Hashable`
/// protocol which required implementing `Equatable` conformance as well as implementing `hash(into:)`
/// method as well. This is required because in type `Bike` another type `Manufacturer` is used which
/// doesn't conforms to `Hashable` protocol. One way is to make `Manufacturer` conform to `Hashable`
/// protocol, which would have removed the need to implement `hash(into:)` implementation.
func hashableExample5() {
    let bike = Bike(name: "Duke 390", company: Manufacturer(name: "KTM"))
    
    print("Hash value for bike :: \(bike.hashValue)")
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 6 :
class Student: Hashable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

/// In this example class types are used. One difference class types have from struct is that here class type `Student`
/// was having all properties conforming to `Hashable` still when the class was conformed to `Hashable`
/// the implementation for `Equatable` and `hash(into:)` was required.
func hashableExample6() {
    let student = Student(id: 1, name: "Student")
    
    print("Hash value for student :: \(student.hashValue)")
}


// MARK: -----------------------------------------------------------------------
// MARK: Example method calls
//hashableExample1()
//hashableExample2()
//hashableExample3()
//hashableExample4()
//hashableExample5()
//hashableExample6()
