//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Swift is a protocol oriented language`
 
 While working in Swift, don't start with a Class, start with a Protocol.
 
 WWDC Video : https://developer.apple.com/videos/play/wwdc2015/408/
 
 Classes Issues
 1. Implicit Sharing
    So you have Class A and Class B. Class A shares some data with Class B. In world of classes as we deal
    with references so now even though A has shared data with B, they both actually share a reference. Now if
    A happens to modify data it shared, the change B will also see even if B was not expecting that change.
    So what do we do.
    In order to solve these unwanted issues one may start to
        - copying everything which leads to
        - inefficiency which causes race conditions
        - to avoid race conditions you add locks
        - locks further make code more inefficient
        - locks also cause deadlocks
        - code complexity has already increased and so are bugs
 
 2. Class inheritance is too intrusive
    Class inheritance is monolithic. One gets one superclass. So what if one needs differnt behaviours. While
    choosing superclass one has to be very carefull.
    Single inheritance causes weight gain.
    Superclasses stored properties even if one doesn't needs comes as burden and one needs to initialize those.
    One can't retroactively model and change superclass later.
    One should know what needs to override and what not to.
 
 3. Lost Type Relationships
    Classe are not a good design fit for solutions where type relationship matter. ```as! ASubclass```
 
 Protocol conformances can be written in angle brackets, or they can be written in a trailing `where` clause, where
 one can also specify relationships between different type parameters.
 
 ```
 protocol Animal {}
 func feed<A>(_ animal: A) where A: Animal
 ```
 
 This declaration is identical to below one. The bottom one reduces the syntactic complexity as the top one with
 the type parameter and where clause looks too complex.
 ```
 func feed(_ animal: some Animal)
 ```
 
 An abstract type that represents a placeholder for a specific concrete type is called an opaque type.
 The specific concrete type that is substituted in is called the underlying type.
 For values with opaque type, the underlying type is fixed for the scope of the value.
 Both below declarations declare an opaque type.
 
 ```
 some Animal
 <T: Animal>
 ```
        
 */
import Foundation
import UIKit
import XCTest

/// Example : Lost Type Relationships with Classes
/// We declared a superclass `CollectionClass` with a method `biggerThan(other: CollectionClass)` which
/// takes another collection and returns a bool based on size comparison. Now `CollectionClass` is supposed to
/// be implemented by a subclass and at this point we don't know what could be implementation for our method
/// `biggerThan(other: CollectionClass)`  and as the method body can't be left empty usually it's implemented
/// by adding a `fatalError` assuming all subclasses to provide a proper implementation. In case a subclass
/// fails to do so we will get this fatalError.
class CollectionClass {
    func biggerThan(other: CollectionClass) -> Bool {
        fatalError("Implement by subclass")
    }
}

class OrderedCollection<T>: CollectionClass {
    var values = [T]()
    override func biggerThan(other: CollectionClass) -> Bool {
        // Now here we can't simply compare as values.count > other.values.count
        // doing so will give error Value of type 'Collection' has no member 'values'
        // reason being we don't know the other which is Collection type implements
        // values or not. So to fix this we have to type cast other to a specific
        // type
        // return values.count > other.values.count (Value of type 'Collection' has no member 'values')
        return values.count > (other as! OrderedCollection).values.count
    }
}

/// Let's see what `Protocols` has to offer.
/// So immediately in the protocols definition itself there is one clear advantage that now no function body is
/// required. So conforming types can provide their implementations and the runtime check for method implementation
/// in case of classes is replaced with a static check in case of protocol which gives compile issue if you try implementing
/// method body in protocol declaration or don't implement method in your conforming type.
///
/// Implementation 1 :
/// In below implementation there are some benefits but still we are casting type in method implementation. This
/// also can be improved using Self (self with a capital S). Self acts as a placeholder for the type that is going to
/// conform the protocol.

/*
protocol Collection {
    func biggerThan(other: Collection) -> Bool
}

struct Ordered<T>: Collection {
    var values = [T]()
    func biggerThan(other: Collection) -> Bool {
        return values.count > (other as! Ordered).values.count
    }
}
*/

/// Implementation 2 :
/// Here in our implementatio of method `biggerThan(other: Self) -> Bool` instead of using `Collection`
/// in method signature, we have used Self
protocol Collection {
    func biggerThan(other: Self) -> Bool
}

struct Ordered<T>: Collection {
    var values = [T]()
    func biggerThan(other: Ordered) -> Bool {
        return values.count > values.count
    }
}

//##############################################################################

/// `Protocol vs Inheritance : Use case study`
/// Swift encourages to start with Protocol always as a rule of thumb.
/// Below example illustrates a project designed using inheritance. Project will have a developer and tester who
/// are defined as team members via class inheritance.
///
class TeamMember {
    var name: String
    var project: String
    
    init(name: String, project: String) {
        self.name = name
        self.project = project
    }
}

class SomeDeveloper: TeamMember {
    func doDevelopment() {
        print("Inheritance :: Developing")
    }
}

class SomeTester: TeamMember {
    func doTesting() {
        print("Inheritance :: Testing")
    }
}

class SomeProject {
    var developer: SomeDeveloper
    var tester: SomeTester
    
    init(developer: SomeDeveloper, tester: SomeTester) {
        self.developer = developer
        self.tester = tester
    }
    
    func startProject() {
        developer.doDevelopment()
        tester.doTesting()
    }
}

let someDeveloper = SomeDeveloper(name: "Batman", project: "Justice League")
let someTester = SomeTester(name: "Superman", project: "Justice League")
let someProject = SomeProject(developer: someDeveloper, tester: someTester)
someProject.startProject()


/// Protocol approach
protocol Member {
    var name: String { get set }
    var project: String { get set }
}

protocol DevelopmentTasks {
    func doDevelopment()
}

protocol TestingTasks {
    func doTesting()
}

struct Developer: Member, DevelopmentTasks {
    var name: String
    var project: String
    
    func doDevelopment() {
        print("Protocols :: Developing")
    }
}

struct Tester: Member, TestingTasks {
    var name: String
    var project: String
    
    func doTesting() {
        print("Protocols :: Testing")
    }
}

struct Project {
    var developer: DevelopmentTasks
    var tester: TestingTasks
    
    func startProject() {
        developer.doDevelopment()
        tester.doTesting()
    }
}

let developer = Developer(name: "Batman", project: "Justice League")
let tester = Tester(name: "Superman", project: "Justice League")
let project = Project(developer: developer, tester: tester)
project.startProject()


/// This all is fine, now suppose due to some criticality we need more hands and we want out developer also
/// should be able to do some testing. How to handle such ask. How to make our developers also perform testing
/// tasks. In inheritance example one might need to further add testing methods to developer class causing a
/// code repetition. Also this is just a sample example a developer and a tester perform many tasks so a whole lot
/// of logic might be required to move to our developer class just to make developer also compatible to handle testing
/// tasks. One can add those methods to base class but that will unecessarily add those tasks to some other team members
/// who inherit from `TeamMember` class.
/// In case of protocol we only need to have our developer struct conform to testing task protocol and in project
/// pass along developer for testing tasks as well. While in case of inheritance we might need to modify project
/// class itself to have developer perform testing tasks.
/// Also for unit testing we have a great advantage. The way Project is defined it has developer and tester properties
/// defined as of type conforming `DevelopmentTasks` or `TestingTasks` so for testing if actual types
/// are not safe to use one can implement mock developer and tester by conforming to these protocols and passing
/// on to the project.
extension Developer: TestingTasks {
    func doTesting() {
        print("Developer")
        print("Protocol :: Testing")
    }
}

let anotherProject = Project(developer: developer, tester: developer)
anotherProject.startProject()

//##############################################################################

/// `Protocol : Property requirements`
/// Protocol doesn't specifies if the property in requirement needs to be implemented as stored property or
/// computed property.
///
/// `{ get set }`
/// Property is gettable and settable both, so while comforming protocol it CAN'T be a constant stored property
/// or a read-only computed property as both these types are not settable.
///
/// `{ get }`
/// Property can be any kind and also be settable.
protocol PropertyRequirements {
    var thisPropertyMustBeSettable: String { get set }
    var thisPropertyCanBeSettableOrReadOnly: String { get }
}

struct ImplementationOne: PropertyRequirements {
    // Marking this property as let or a read-only computed property will give compile
    // time issue : Type 'ImplementationOne' does not conform to protocol 'PropertyRequirements'
    var thisPropertyMustBeSettable: String {
        get {
            return "Computed \(self.thisPropertyCanBeSettableOrReadOnly)"
        }
        set(newValue) {
            thisPropertyCanBeSettableOrReadOnly = newValue
        }
    }
    var thisPropertyCanBeSettableOrReadOnly: String
}

struct ImplementationTwo: PropertyRequirements {
    var thisPropertyMustBeSettable: String
    let thisPropertyCanBeSettableOrReadOnly: String
}


/// `Stored properties can't be added to class/struct extension, what about if a protocol is conformed in extension?`
/// If a protocol is conformed in a type's extension then also the protocol definition doesn't allows extension to
/// conform requirement of the property by adding it as stored property. Remember a protocol's property requirements
/// can be satisfied by either a stored or computed property, but in extension stored property will not be allowed.

protocol AddSomeProperties {
    var property: String { get }
}

struct Employee {
    var name: String?
}

extension Employee {
    /// Try to add below and compiler will cry with error "Extensions must not contain stored properties"
    //var id: Int
    
    var fullName: String {
        return "Mr. \(name ?? String())"
    }
}

/// As soon as this extension is declared and if one let Xcode provide protocol method stubs the default stubs
/// added from Xcode itself are a computed property.
extension Employee: AddSomeProperties {
    /// Try to add below and compiler will cry with error "Extensions must not contain stored properties"
    //var property: String
    
    var property: String {
        return "Sample value"
    }
}

//##############################################################################

/// `Constraints on Protocols`
///
/// Example 1 : Constraint a protocol to be conformed only by class types
/// Attempt to below will make compiler cry with error :
/// Non-class type 'AttemptToConform' cannot conform to class protocol 'OnlyForClasses'
// struct AttemptToConform: OnlyForClasses {}

protocol OnlyForClasses: AnyObject {
    var classOnly: String? { get set }
}

class ConformProtocol: OnlyForClasses {
    var classOnly: String?
}

/// Example 2 : Constraint on a specific class type
protocol OnlyForUIView: UIView {
    var uiViewOnly: String? { get set }
}

/// This will make compiler cry with error :
/// 'OnlyForUIView' requires that 'SomeViewController' inherit from 'UIView'
// class SomeViewController: UIViewController, OnlyForUIView { var uiViewOnly: String? }
/// Example below for a `CustomView` inheriting from `UIView` however is perfectly valid.
class CustomView: UIView, OnlyForUIView {
    var uiViewOnly: String?
}

//##############################################################################

/// `Optional requirements in Protocols`
/// Optional requirements are the ones which are not mandatory to be implemented by conforming type.
///
/// Option 1 :
/// Below example shows how to achieve that, however there is one caveat. This protocol with optional requirement
/// `WithSomeOptionalRequirements` is restricted for class types only due to use of `@objc`
///
/// Option 2 :
/// Another way is to add an extension to protocol and implement the requirement which is to be made optional.
/// This way the protocol need not the @objc modifier and even value types can use it, however the conforming types
/// even though are not required to implement the method still they will get the default implementation from
/// extension so technically it's not an optional requirement as the requirement still get fulfilled.
///
/// Option 3 :
/// Probably the best approach would be to keep the requirements which are optional as part of a separate
/// protocol altogether so that one can compose required protocols and implement as per requirement.

@objc protocol WithSomeOptionalRequirements {
    @objc optional var optionalProperty: String { get set }
    var mandatoryProperty: String { get set }
}

class ClassImplementingProtocol: WithSomeOptionalRequirements {
    var mandatoryProperty: String = "Mandatory"
}

class ClassUsingProtocolType {
    var someProtocolType: WithSomeOptionalRequirements
    
    init(someProtocolType: WithSomeOptionalRequirements) {
        self.someProtocolType = someProtocolType
    }
}

class ClassUsingProtocolTypeTests: XCTestCase {
    func testClassUsingProtocolType() {
        let objectConformedProtocol = ClassImplementingProtocol()
        let object = ClassUsingProtocolType(someProtocolType: objectConformedProtocol)
        XCTAssertNil(object.someProtocolType.optionalProperty)
    }
}

ClassUsingProtocolTypeTests.defaultTestSuite.run()

//##############################################################################

/// `Protocol associated type`
/// Associated type (`associatedtype`) are a powerful way to make protocol generic.
/// To understand suppose we want to declare a protocl to store some data type. This protocol will have a single
/// requirement of a method to save data(let's not worry about where). So how do we declare is and for which
/// data type, String, Int, Float etc or any custom type. This problem can be solved by using an associatedtype.
///
/// So an associatedtype is a replacement of a specific type withing a protocol's definition so that this placeholder type
/// can be provided by conforming type and thus can be utilised for multiple types, instead of ending up defining
/// protocol for every possible types.

protocol Storage {
    associatedtype DataType
    func storeThis(_ data: DataType)
}

struct Database {
    static var shared = Database()
    private init() {}
    var storage = [Any]()
}

struct IntStorage: Storage {
    typealias DataType = Int
    func storeThis(_ data: DataType) {
        Database.shared.storage.append(data)
    }
}

/// When protocol with associated type is implemented then Xcode can help provide adding stubs, but that also
/// adds a typealias. This typealias however is not mandatory as Swift can infer type from protocols implementation.
struct StringStorage: Storage {
    func storeThis(_ data: String) {
        Database.shared.storage.append(data)
    }
}

//##############################################################################

/// `Protocols and Polymorphism`
/// In example method `examplePolymorphismUsingProtocols` below the `myGarage` array can hold
/// any type which conforms to `Vehicle` protocol, so basically `myGarage` can hold any `Vehicle`, but
/// these `Vehicle` types don't share any common ancestor, which is there is no common inheritance relationship
/// here. So here there is no `V-Table` dispatch happening. Instead here the mechanism used will be `Protocol Witness Table`.
protocol Vehicle {
    func drive()
}

struct Car: Vehicle {
    func drive() {
        print("Driving a Car 🚗")
    }
}

struct Bike: Vehicle {
    func drive() {
        print("Driving a Bike 🏍️")
    }
}

func examplePolymorphismUsingProtocols() {
    var myGarage = [Vehicle]()
    myGarage.append(Car())
    myGarage.append(Bike())
    for vehicle in myGarage {
        vehicle.drive()
    }
}

//##############################################################################

/// `Declaring type as protocol vs concrete type`
/// Below a protocol Foo is declared which then is extended to provide a default implementation of property moo.
/// Protocol is conformed by class Bar, which implements the property. Further in example method exampleDeclaringTypeAsProtocolVsConcreteType
/// one can observe the difference in which implementation will be called if a variable is declared to be of type
/// protocol vs to be of a concrete type which conforms the protocol. When declared as protocol type, the default
/// protocol's implementation in extension is given preference.
protocol Foo {
    var moo: String {get}
}

extension Foo {
    var moo: String {
        return "Moo"
    }
    func test() {
        print("Protocol version")
        print("Foo \(moo)")
    }
}

class Bar: Foo {
    var moo: String {
        return "Moooooooo"
    }
    
    func test() {
        print("Class version")
        print("Bar \(moo)")
    }
}

func exampleDeclaringTypeAsProtocolVsConcreteType() {
    let b: Bar = Bar()
    b.test()

    let p: Foo = Bar()
    p.test()
}


// TODO: https://www.avanderlee.com/swift/associated-types-protocols/
// TODO: https://khawerkhaliq.com/blog/swift-associated-types-self-requirements/

//##############################################################################

/// `QnA`
/// `Can a protocol add a requirement to add stored properties?`
/// NO.
/// Protocols can only define property name, type and if it's gettable or settable or both. The conforming type
/// has freedom to choose if this can be implemented as stored property or computed property, unless restricted
/// by other factors like an extension to an existing type can't add stored properties, in that case only computed
/// property can be added.
///
/// `A protocol marks a method as mutating. If this protocol is conformed by a class, does class also need to use keyword mutating`
/// NO
/// `mutating` keyword is used only for structures and enumerations. As it's not applicable for class types
/// thus while conforming this protocol via a class type this keyword can be skipped.
///
/// `A type completes all requirements of some protocol, but doesn't conforms to it in declaration, can we assume as all requirements are met, the protocol is conformed by type?`
/// NO
/// Even if all requirements are met, it's not conformance unless the conformance is explicitly declared in type's
/// declataion or added in an extension to the type in question.

//: [Next](@next)
