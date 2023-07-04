//: [Previous](@previous)

// Created by Saurabh Verma on 04/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Open Closed Principle`
 
 This principle states that a classes/modules/methods should be open for extension but closed for modifications.
 This means that once a class is written/designed, then to add new functionality it should not be modified, instead
 it should have been designed in a way that it should be able to be extended to add those functionalities.
 */

import Foundation

/// To give example for open closed principle, let's consider a vehicle dealer, represented by `Dealer` class.
/// A dealer has an inventory of vehicles which can range from differnet color or category. Dealer has a way to
/// filter vehicle by color. In current way of implementation suppose in future dealer also wants to filter vehicle
/// by category, then one needs to write additional method to do the filter, like declared below in an extensio to
/// `Dealer` class.
enum ColorOptions {
    case red
    case blue
    case black
    case white
}

enum VehicleCategory {
    case sedan
    case suv
    case hatch
    case mpv
}

class Vehicle: CustomStringConvertible {
    var color: ColorOptions
    var category: VehicleCategory
    
    init(color: ColorOptions, category: VehicleCategory) {
        self.color = color
        self.category = category
    }
    
    var description: String {
        return "A \(color) \(category)"
    }
}

/// Here dealer has an option to filter inventory by color and get all vehicles belonging to a particulat colot. This
/// is greate, however soon we will need a way to filter via category as well.
class Dealer {
    var inventory = [Vehicle]()
    func filterBy(color: ColorOptions) -> [Vehicle] {
        return inventory.filter({ $0.color == color })
    }
}

/// In future requirement comes in to filter via category, so then one can add one more function doing precisely
/// that.
/// HOWEVER, this VIOLATES OPEN CLOSED PRINCIPLE
extension Dealer {
    func filterBy(category: VehicleCategory) -> [Vehicle] {
        return inventory.filter({ $0.category == category })
    }
}


/// `Solution via conformance to Open closed principle`

protocol Criteria {
    associatedtype T
    func isMatched(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<C: Criteria>(_ items: [T], criteria: C) -> [T] where C.T == T
}

class ColorCriteria: Criteria {
    typealias T = Vehicle
    var color: ColorOptions
    
    init(color: ColorOptions) {
        self.color = color
    }
    
    func isMatched(_ item: Vehicle) -> Bool {
        return item.color == color
    }
}

class ScalableDealer: Filter {
    typealias T = Vehicle
    var inventory = [Vehicle]()
    
    func filter<C>(_ items: [Vehicle], criteria: C) -> [Vehicle] where C : Criteria, Vehicle == C.T {
        var filteredItems = [Vehicle]()
        for item in items {
            if criteria.isMatched(item) {
                filteredItems.append(item)
            }
        }
        return filteredItems
    }
}

let vehicles = [Vehicle(color: .black, category: .suv),
                Vehicle(color: .black, category: .hatch),
                Vehicle(color: .red, category: .suv),
                Vehicle(color: .red, category: .sedan),
                Vehicle(color: .red, category: .mpv),
                Vehicle(color: .red, category: .hatch),
                Vehicle(color: .blue, category: .suv),
                Vehicle(color: .white, category: .suv)]

func exampleOneUsingOpenCloseViolation() {
    let dealer = Dealer()
    dealer.inventory = vehicles
    
    let filteredVehiclesByColor = dealer.filterBy(color: .red)
    for vehicle in filteredVehiclesByColor {
        print("exampleOneUsingOpenCloseViolation :: filter \(vehicle.color) :: \(vehicle)")
    }
    
    let filteredVehiclesByCategory = dealer.filterBy(category: .suv)
    for vehicle in filteredVehiclesByCategory {
        print("exampleOneUsingOpenCloseViolation :: filter \(vehicle.category) :: \(vehicle)")
    }
}

func exampleTwoUsingConformanceOfOpenClosedPrinciple() {
    let scalableDealer = ScalableDealer()
    scalableDealer.inventory = vehicles
    
    let filterByRed = ColorCriteria(color: .red)
    let filteredVehiclesByColor = scalableDealer.filter(scalableDealer.inventory, criteria: filterByRed)
    for vehicle in filteredVehiclesByColor {
        print("exampleTwoUsingConformanceOfOpenClosedPrinciple :: filter \(vehicle.color) :: \(vehicle)")
    }
    
}

exampleOneUsingOpenCloseViolation()
exampleTwoUsingConformanceOfOpenClosedPrinciple()

//: [Next](@next)
