// Created by Saurabh Verma on 16/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

//: [<- Decorator Pattern](@previous)

/**
 `Facade`
 Facade structural design patterns aims in exposing several components through a single interface, thereby
 providing a simple, easy to use and understand, user interface over a large and sophisticated body of code.
 */
import Foundation

class CivilEngineer {
    func designBuildingPlan() {
        print("Building plan designed")
    }
}

class Worker {
    func constructBuilding() {
        print("Constructing building...")
    }
}

class Necessities {
    func addNecessities() {
        print("Necessities plumbing, wiring etc added")
    }
}

class Builder {
    let engineer: CivilEngineer
    let workers: [Worker]
    let necessities: Necessities
    
    init(engineer: CivilEngineer, workers: [Worker], necessities: Necessities) {
        self.engineer = engineer
        self.workers = workers
        self.necessities = necessities
    }
    
    func constructProject() {
        engineer.designBuildingPlan()
        workers.map({ $0.constructBuilding() })
        necessities.addNecessities()
        print("Project completed")
    }
}

func exampleFacadePattern() {
    let engineer = CivilEngineer()
    let worker1 = Worker()
    let worker2 = Worker()
    let necessities = Necessities()
    let builder = Builder(engineer: engineer,
                          workers: [worker1, worker2],
                          necessities: necessities)
    builder.constructProject()
}

exampleFacadePattern()
//: [Flyweight Pattern ->](@next)
