//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Builder`
 `Builder` is a creational design pattern which helps constructing a complex object in a step by step manner.
 The core idea is to buid an object by a dedicated builder type, rather than by building it via various initialiser from
 within.
 
 For example let's consider a struct House having several properties
 
 ```
 struct House {
     var numberOfBedrooms: Int
     var numberOfParking: Int
     var hasLawn: Bool
     var hasPool: Bool
 }
 ```
 
 This needs to be initialised like below
 
 ```
 let house = House(numberOfBedrooms: 2,
                   numberOfParking: 1,
                   hasLawn: true,
                   hasPool: false)
 ```
 
 There are only four properties House struct has at this moment, these can grow and so will the size of initialiser.
 Also if some of the properties can be nil or some default values then one need to create some convenience initialisers
 to cater to those demands as passing nil or default values to a huge initialiser always is again cumbersome.
 So one usually ends up in having multiple initialisers for instantiating entities like this.
 
 Builder creation design pattern tries to solve this problem in following manner. Here the properties are set and
 the object is configured by a series of chained methods ending in a build method to instantiate.
 
 ```
 let house = HouseBuilder()
     .withBedrooms(2)
     .parkings(1)
     .hasLawn()
     .build()
 ```
 
 Builder pattern may seems to be adding a more lot of code for creating objects but it does have its benefits.
 
 - Firstly it helps to remove lot of public APIs (initialisers) which need to be kept available to cater to every use
 case.
 - Secondly it can also help to prevent sharing the mutable state.
 
 
 NOTE: It's not always possible to have only one builder, if complex cases one might have to create different
 builders to create the complex object.
 */

import Foundation

/// Example 1
enum HouseType {
    case highRise
    case villa
    case bunglow
    case duplex
}

protocol HousePlan {
    var type: HouseType { get set }
    var buildArea: Float { get set }
    var carpetArea: Float { get set }
}

class House: HousePlan, CustomStringConvertible {
    var type: HouseType = .highRise
    var buildArea: Float = 0.0
    var carpetArea: Float = 0.0
    var description: String {
        return "House : \(type), with build area of \(buildArea) and carpet area \(carpetArea)"
    }
}

protocol HouseBuilder {
    func setType() -> HouseBuilder
    func setBuildArea() -> HouseBuilder
    func setCarpetArea() -> HouseBuilder
    func build() -> House
}

class HighRiseApartmentBuilder: HouseBuilder {
    private var highRiseHouse = House()
    func setType() -> HouseBuilder {
        highRiseHouse.type = .highRise
        return self
    }
    
    func setBuildArea() -> HouseBuilder {
        highRiseHouse.buildArea = 1440.0
        return self
    }
    
    func setCarpetArea() -> HouseBuilder {
        highRiseHouse.carpetArea = 1000.0
        return self
    }
    
    func build() -> House {
        return highRiseHouse
    }
}

func exampleOne() {
    let apartment = HighRiseApartmentBuilder()
        .setType()
        .setCarpetArea()
        .setBuildArea()
        .build()
    print(apartment.description)
}

/// Example 2 : Using multiple builders for same object

class Person: CustomStringConvertible {
    var houseNumber = 0
    var streetName = String()
    var city = String()
    
    var company = String()
    var designation = String()
    
    var description: String {
        return """
                I live at \(houseNumber), \(streetName), \(city)
        I work in
        \(company) as a \(designation)
        """
    }
}

class PersonBuilder {
    var person = Person()
    var lives: PersonAddressBuilder {
        return PersonAddressBuilder(person: person)
    }
    var works: PersonJobBuilder {
        return PersonJobBuilder(person: person)
    }
    func build() -> Person {
        return person
    }
}

class PersonAddressBuilder: PersonBuilder {
    convenience init(person: Person) {
        self.init()
        self.person = person
    }
    
    func inHouseNumber(_ houseNumber: Int) -> PersonAddressBuilder {
        person.houseNumber = houseNumber
        return self
    }
    
    func onStreet(_ street: String) -> PersonAddressBuilder {
        person.streetName = street
        return self
    }
    
    func inCity(_ city: String) -> PersonAddressBuilder {
        person.city = city
        return self
    }
}

class PersonJobBuilder: PersonBuilder {
    convenience init(person: Person) {
        self.init()
        self.person = person
    }
    
    func inCompany(_ company: String) -> PersonJobBuilder {
        person.company = company
        return self
    }
    
    func withDesignation(_ designation: String) -> PersonJobBuilder {
        person.designation = designation
        return self
    }
}

func exampleTwo() {
    let personBuilder = PersonBuilder()
    let person = personBuilder
        .lives.inHouseNumber(750)
        .onStreet("Road number 1")
        .inCity("Hyderabad")
        .works.inCompany("Magneta")
        .withDesignation("Software Engineer")
        .build()
    print(person)
}


exampleOne()
exampleTwo()

//: [Next](@next)
