// Created by Saurabh Verma on 16/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

//: [<- Decorator Pattern](@previous)

/**
 `Facade`
 Facade structural design patterns aims in exposing several components through a single interface, thereby
 providing a simple, easy to use and understand, user interface over a large and sophisticated body of code.
 */
import Foundation

/// Example 1 :
/// Example below describes how a facade pattern is implemented and used. Here we have some classes
/// providing APIs for giving various solutions for creating and delivering a real estate project. A real estate project
/// will need a civil engineer to design the plan, some workers to construct the buildings as per plan and some
/// basic requirements like electrical wiring, gas connection, plumbing etc which are covered under necessities.
/// Class `Builder` is a facade here which uses all these APIs and creates the project. So for an end client
/// the `Builder` interface and it's APIs are much easier to use and manage.
/// Also it helps in situations where say instead of using `Builder` one uses `CivilEngineer`, `Worker`
/// and `Necessities` individually and then in future the implementation of `CivilEngineer`, `Worker`
/// or `Necessities` changes, then one will need to change a lot of code. Instead if all these were being used
/// via facade `Builder` only change will be required in the `Builder`.
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
