//: [Previous](@previous)

// Created by Saurabh Verma on 05/12/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import UIKit

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 :
// TODO: Elaborate the example
protocol Automobile {
    var name: String { get }
    var price: Double { get }
    var color: String { get }
    var seats: Int { get }
}

protocol Engine {
    var name: String { get }
    var power: Double { get }
    var capacity: Double { get }
    var fuelType: String { get }
}

class ICECars: Automobile, Engine {
    var power: Double
    var capacity: Double
    var fuelType: String
    let name: String
    let price: Double
    let color: String
    let seats: Int
    
    init(power: Double, capacity: Double, fuelType: String, name: String, price: Double, color: String, seats: Int) {
        self.power = power
        self.capacity = capacity
        self.fuelType = fuelType
        self.name = name
        self.price = price
        self.color = color
        self.seats = seats
    }
}
