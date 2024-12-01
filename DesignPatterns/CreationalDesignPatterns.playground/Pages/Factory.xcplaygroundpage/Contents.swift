//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Factory Method`
 
 `Factory Method` is a creational design pattern, as creational design patterns are all about removing the
 complexities while creating objects, so is the case with factory pattern.
 `Factory Method` pattern tries to encapsulate implementation details for creating objecs which have a
 common ancestor i.e. base class.
 `Factory Method` pattern basically means defining a method which then will be used for creating objects
 instead of directly calling expected objects initialisers. Subclasses can override the implementation to change
 class of object which will get created.
 
 Using `Factory Method` one can have a `Client` object which will be using some instances of other
 types but is not initialising those directly by calling their initialisers. Instead it uses a factory method. The factory
 method does this initialisation and hands over object to `Client` object.
 
 `How to differentiate Factory Method pattern with Abstract Factory pattern?`
 
 Factory Method is one usually can start with before moving towards Abstract Factory. Abstract Factory classes
 may often use set of Factory Method itself.
 Factory Method is usually creating a single product while a Abstract Factory will provide a set of products to
 client using APIs.
 
 Good discussion on this thread :
 https://stackoverflow.com/questions/5739611/what-are-the-differences-between-abstract-factory-and-factory-design-patterns
 
 `Use case for using Factory Method?`
 
 Factories are more flexible in naming and allows to express more from what is expected and asked.
 
 */

import Foundation

/// Example 1 :
protocol Currency {
    var currencySymbol: String { get }
    var currencyCode: String { get }
}

class Dollar: Currency {
    var currencySymbol: String { return "$" }
    var currencyCode: String { return "USD" }
}

class Rupee: Currency {
    var currencySymbol: String { return "₹" }
    var currencyCode: String { return "INR" }
}

protocol Exchange {
    func localCurrency() -> Currency
}

class DollarExchange: Exchange {
    func localCurrency() -> Currency {
        return Dollar()
    }
}

class RupeeExchange: Exchange {
    func localCurrency() -> Currency {
        Rupee()
    }
}

class InternationalTraveller {
    func getCurrencyFrom(exchange: Exchange) {
        print("Received \(exchange.localCurrency().currencySymbol) \(exchange.localCurrency().currencyCode)")
    }
}

func exampleOne() {
    let traveller = InternationalTraveller()
    traveller.getCurrencyFrom(exchange: DollarExchange())
}

exampleOne()

//: [Next](@next)
