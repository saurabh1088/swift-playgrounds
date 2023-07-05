//: [Previous](@previous)

// Created by Saurabh Verma on 05/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Interface Segregation Principle`
 
 Interface Segregation Principle states that interfaces should be segregated enough so as to not force a client
 implementing the interface, implement functionality which they don't need.
 In terms of for example say classes and protocols, while implementing a protocol, a class shoudn't be forced to
 implement methods in protocol which it doesn't needs.
 Interfaces/Protocols should be focused.
 */
import Foundation

protocol AllInOneKindViolatingISP {
    func print()
    func fax()
    func scan()
}

/// `AllInOneKindViolatingISP` violates the Interface Segregation Principle as it forces a client to
/// implement various behaviours. Suppose one need to implement a Printer which can only print. If Printer tries
/// to implement `AllInOneKindViolatingISP` then it needs to forcefully implement fax and scan as well
/// which isn't desirabel. One way to overcome is implement print function properly and make other ones throw
/// exceptions.

class NotAGoodPrinterImplementation: AllInOneKindViolatingISP {
    func print() {
        Swift.print("Do some printing")
    }
    
    func fax() {
        Swift.print("Throw some error telling I can't fax")
    }
    
    func scan() {
        Swift.print("Throw some error telling I can't scan")
    }
}

/// In order to correctly impplement following Interface Segregation Principle one needs to segregate protocols.

protocol Printer {
    func print()
}

protocol Fax {
    func fax()
}

protocol Scanner {
    func scan()
}

protocol AllInOne: Printer, Scanner, Fax {}

class ClassicPrinter: Printer {
    func print() {
        Swift.print("Do some printing")
    }
}

class AllInOneMachine: AllInOne {
    func print() {
        Swift.print("Do some printing")
    }
    
    func fax() {
        Swift.print("Do some fax")
    }
    
    func scan() {
        Swift.print("Do some scanning")
    }
}

//: [Next](@next)
