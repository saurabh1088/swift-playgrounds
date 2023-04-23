//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Swift is a protocol oriented language`
 
 While working in Swift, don't start with a Class, start with a Protocol.
 
 WWDC Video : https://developer.apple.com/videos/play/wwdc2015/408/
 
 Classes Issues
 1. Implicit Sharing
    So you have Class A and Class B. Class A shares some date with Class B. In world of classes as we deal
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
    choosing superclass one has to be veru carefull.
    Single inheritance causes weight gain.
    Superclasses stored properties even if one doesn't needs comes as burden and one needs to initialize those.
    One can't retroactively model and change superclass later.
    One should know what needs to override and what not to.
 
 3. Lost Type Relationships
    Classe are not a good design fit for solutions where type relationship matter. ```as! ASubclass```
        
 */
import Foundation

/// Example : Lost Type Relationships with Classes
/// We declared a superclass `Collection` with a method `biggerThan(other: Collection)` which
/// takes another collection and returns a bool based on size comparison. Now `Collection` is supposed to
/// be implemented by a subclass and at this point we don't know what could be implementation for our method
/// `biggerThan(other: Collection)`  and as the method body can't be left empty usually it's implemented
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

// TODO: Watch https://developer.apple.com/videos/play/wwdc2015/408/


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
/// shoule be able to do some testing. How to handle such ask. How to make out developer also perform testing
/// tasks. In inheritance example one might need to further add testing methods to developer class causing a
/// code repetition. Also this is just a sample example a developer and a tester perform many tasks so a whole lot
/// of logic might be required to move to our develer class just to make developer also compatible to handle testing
/// tasks. One can add those methods to base class but that will unecessarily add those tasks to some other team members
/// who inherit from `TeamMember` class.
/// In case of protocol we only need to have our developer struct conform to testing taska protocol and in project
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



//: [Next](@next)
