//: [Previous](@previous)

// Created by Saurabh Verma on 13/02/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.


/**
 `Enumerations`
 
 As per definition an enum is a model custom type which defines a list of possible values.
 Unlike C and Objective C, enumerations in Swift DON'T have an integer value set by default.
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Defining an Enumeration
/// As per Apple's recommendations one should give enums singular name so that in usage these are read as
/// intended and self-evident. For example when we assign a direction like below it will be making more sense
///
/// `let directionNorth = Direction.north`
///
/// Rather say if we had named the enums in plural
///
/// `let directionNorth = Directions.north`
enum Direction {
    case north
    case south
    case east
    case west
}

/// Here in this example when `directionNorth` is set to a direction using enum Directions then as per our
/// definition of `Directions` there isn't any value provided and enum in Swift doesn't get any integer value
/// as per some other languages like C or Objective C. Also one can notice that there isn't any rawValue available
/// to call on `directionNorth`. The defined cases are values in their own right, so the print statement below
/// will print `Value of directionNorth :: north`
/// So learning : By default an enum doesn’t come with a raw value.
func exampleEnumerationDefaultValue() {
    let directionNorth = Direction.north
    print("Value of directionNorth :: \(directionNorth)")
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : CaseIterable
/// `CaseIterable`
/// `CaseIterable` is a protocol, which is usually conformed by enums without associated values to access
/// a collection of all of it's cases using `allCases` property.
/// It does not means that one can't use `CaseIterable` with enumeration having associated value, one can
/// use, but then one will need to implement `allCases` property as compiler won't synthesize that.
/// For enum `Direction` at present there is no way to iterate over all cases. Suppose we want some functionality
/// to iterate over all directions we have no way of doing so at present, unless explicitly creating some data structure
/// to record all cases and do so.

enum DirectionWithCaseIterable: CaseIterable {
    case north, south, east, west
}

func exampleEnumerationCaseIterable() {
    DirectionWithCaseIterable.allCases.forEach { direction in
        print("Direction :: \(direction)")
    }
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 4 :
/// `Associated Value`
/// In Swift an enumeration can be defined to store associated values of any type if required. This associated
/// type can be of same or different type for each cases in the enumeration.
enum HTTPResponse {
    case success(Int)
    case error(String)
}

func handleHTTPResponse(_ response: HTTPResponse) {
    switch response {
    case .success(let responseCode):
        print("Success :: \(responseCode)")
    case .error(let errorDesc):
        print("Failure :: \(errorDesc)")
    }
}

func exampleEnumerationWithAssociatedValues() {
    let httpResponseSuccess = HTTPResponse.success(200)
    handleHTTPResponse(httpResponseSuccess)
    let httpResponseFailure = HTTPResponse.error("Network not reachable")
    handleHTTPResponse(httpResponseFailure)
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 5 : Associated value and CaseIterable
/// Swift compiler will generate implementation for `CaseIterable` protocol requirement itself for enums
/// without having any associated values.
/// But when one tries to conform to `CaseIterable` for an enum having associated values then compiler cries
/// with below error:
/// `Type 'SupportedOS' does not conform to protocol 'CaseIterable'`
enum SupportedOS: CaseIterable {
    case iphone(String)
    case mac(String)
    
    static var allCases: [SupportedOS] {
        return [.iphone("iOS16"), .iphone("iOS17"),
                .mac("Sonoma")]
    }
}

func exampleEnumerationWithAssociatedValuesAndCaseIterable() {
    SupportedOS.allCases.forEach { supportedOS in
        if case .iphone(let supportedInIOS) = supportedOS {
            print("Supported in iOS :: \(supportedInIOS)")
        }
        if case .mac(let supportedInMacOS) = supportedOS {
            print("Supported in macOS :: \(supportedInMacOS)")
        }
    }
}



// MARK: -----------------------------------------------------------------------
// MARK: Example 6 : Enum with initializer
/// Below example shows an enumeration for which in example a rawValue initializer is used. Please note that
/// rawValue initializer is a failable initializer, hence the need to unwrap the value returned.
enum JusticeLeague: String {
    case batman
    case superman
    case wonderwoman
    case flash
    case cyborg
    case aquaman
}

func exampleEnumerationWithInitializer() {
    let batman = JusticeLeague(rawValue: "batman")
    if let enumBatman = batman?.rawValue {
        print("Because I' am :: \(enumBatman)")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 7 : Enumerations in Swift are first class types.
/// `Enumerations in Swift are first class types`
/// This is because enumerations in Swift adopt many features which are supported by classes like :
/// 1. Enums can have computed properties
/// 2. Enums can define functions acting on values it provides
/// 3. Enums can have initializers
/// 4. One can provide additional funtionality to enum by using extensions
/// 5. Enums can conform to protocols
enum Avenger {
    case ironman
    case blackwidow
    case thor
    case captainamerica
    
    init?(withCodeName: String) {
        switch withCodeName.lowercased() {
        case "rich":
            self = .ironman
        case "assasin":
            self = .blackwidow
        case "thunder":
            self = .thor
        case "strong":
            self = .captainamerica
        default:
            return nil
        }
    }
    
    var ability: String {
        switch self {
        case .ironman:
            "I have a strong armour"
        case .blackwidow:
            "I am an assasin"
        case .thor:
            "I am god of thunder"
        case .captainamerica:
            "I have super strength"
        }
    }
    
    func avengersAssemble() {
        print("Avengers assembled!")
    }
}

extension Avenger: CaseIterable {}

func exampleEnumerationShowingFirstClassCapabilities() {
    // Computed Property
    let ironman = Avenger.ironman
    ironman.ability
    
    // Function
    let captain = Avenger.captainamerica
    captain.avengersAssemble()
    
    // Initializer
    let whoami = Avenger(withCodeName: "Assasin")
    whoami?.ability
    
    // Extension and Protocol
    Avenger.allCases.forEach { avenger in
        print("Hello there, my name is :: \(avenger)")
    }
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 8 : Can Enum have stored properties.
/// `NO`
/// If an attempt to add a stored property is taken then compilor cries with below error:
/// `Enums must not contain stored properties`
/// An enum as explained in definition is a common type for a group of related values. So we have a type and
/// then value of that type which we use in code. This means we don't have instance of enums unlike classes
/// and structures. Now one can have static properties defined for an enum as static properties are associated
/// with the type and not instance. But as there is no instance of enum thus it can't have any stored property.
enum AreStoredPropertyPossible {
    case optionOne
    case optionTwo

    static var someStaticProperty = "static"
//    var someStoredProperty: String
}

// MARK: -----------------------------------------------------------------------
// MARK: Example method calls
exampleEnumerationDefaultValue()
exampleEnumerationCaseIterable()
exampleEnumerationWithAssociatedValues()
exampleEnumerationWithAssociatedValuesAndCaseIterable()
exampleEnumerationWithInitializer()
exampleEnumerationShowingFirstClassCapabilities()

//: [Next](@next)
