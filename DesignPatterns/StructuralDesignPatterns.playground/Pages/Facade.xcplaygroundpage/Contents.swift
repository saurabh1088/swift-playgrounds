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

// TODO: Move it to behavioural design pattern.
class ExpressionProcessor
{
  var variables: [Character:Int] = ["1": 1,
                                    "2": 2,
                                    "3": 3,
                                    "4": 4,
                                    "5": 5,
                                    "6": 6,
                                    "7": 7,
                                    "8": 8,
                                    "9": 9,
                                    "0": 0]
    
    subscript(_ key: Character) -> Int {
        get {
            return variables[key] ?? 0
        }
        set(newValue) {
            variables[key] = newValue
        }
    }

  func calculate(_ expression: String) -> Int
  {
    // todo
      
      let validatePlus = expression.components(separatedBy: "+")
      for item in validatePlus {
          if item.count > 1, item.components(separatedBy: "-").count == 0 {
              return 0
          }
      }
      
      let validateMinus = expression.components(separatedBy: "-")
      for item in validateMinus {
          if item.count > 1, item.components(separatedBy: "+").count == 0 {
              return 0
          }
      }
      
      
      var index = 0
      var chars = Array(expression)
      var chars1 = [Character]()
      for char in expression {
          chars1.append(char)
      }
      var output = (variables[chars[0]] ?? 0)
      while index < chars.count {
          switch chars[index] {
          case "+":
              if let value = variables[chars[index + 1]] {
                  output = output + value
              } else {
                  return 0
              }
          case "-":
              if let value = variables[chars[index + 1]] {
                  output = output - value
              } else {
                  return 0
              }
          default:
              print("")
          }
          index += 1
      }
      
      return output
  }
}

let expre = ExpressionProcessor()
print(expre.calculate("1-xy"))


// TODO: Mediator example, move appropriately to relevant page
class Participant
{
  private let mediator: Mediator
  var value = 0

  init(_ mediator: Mediator) {
    self.mediator = mediator
    self.mediator.participants.append(self)
  }

  func say(_ n: Int) {
    mediator.broadcast(n, self)
  }
}

class Mediator {
  var participants = [Participant]()
  func broadcast(_ value: Int, _ participant: Participant) {
      for p in participants {
          if p === participant {
              
          } else {
              p.value = value
          }
      }
  }
}




// TODO: Iterator example, move appropriately to relevant page
class Node<T>
{
  let value: T
  var left: Node<T>? = nil
  var right: Node<T>? = nil
  var parent: Node<T>? = nil

  init(_ value: T)
  {
    self.value = value
  }

  init(_ value: T, _ left: Node<T>, _ right: Node<T>)
  {
    self.value = value
    self.left = left
    self.right = right

    // todo: try to guess what's missing here
    self.left!.parent = self
    self.right!.parent = self
  }

  
  public var preOrder: [T]
  {
    // todo
    var output = [T]()
    output.append(self.value)
    
    var leftPart = self.left
    var rightPartValue = self.right!.value
    while leftPart != nil {
        output.append(leftPart!.value)
        if let part = leftPart, let otherPart = part.right {
            rightPartValue = otherPart.value
        }
        leftPart = leftPart?.left
    }
    output.append(rightPartValue)
    
    var rightPart = self.right
    while rightPart != nil {
        output.append(rightPart!.value)
        rightPart = rightPart?.right
    }

    return output
  }
}

// TODO: Memento example, move appropriately to relevant page
class Token {
  var value = 0
  init(_ value: Int) {
    self.value = value
  }
  static func ==(_ lhs: Token, _ rhs: Token) -> Bool {
    return lhs.value == rhs.value
  }
}

class Memento {
  var tokens = [Token]()
}

class TokenMachine {
  var tokens = [Token]()

  func addToken(_ value: Int) -> Memento {
        let token = Token(value)
        tokens.append(token)
      let memento = Memento()
      memento.tokens = tokens
      return memento
  }

  func addToken(_ token: Token) -> Memento {
    // todo
      tokens.append(token)
      let memento = Memento()
      memento.tokens = tokens
      return memento
      
  }

  func revert(to m: Memento){
    // todo
      tokens = m.tokens
  }
}



// TODO: Null Object example, move appropriately to relevant page
protocol Log {
  var recordLimit: Int { get }
  var recordCount: Int { get set }
  func logInfo(_ message: String)
}

enum LogError : Error {
  case recordNotUpdated
  case logSpaceExceeded
}

class Account {
  private var log: Log
  init(_ log: Log) {
    self.log = log
  }

  func someOperation() throws {
    let c = log.recordCount
    log.logInfo("Performing an operation")
    if (c+1) != log.recordCount
    {
      throw LogError.recordNotUpdated
    }
    if log.recordCount >= log.recordLimit
    {
      throw LogError.logSpaceExceeded
    }
  }
}

class NullLog : Log {
    var recordLimit: Int = 100
    var recordCount: Int = 0
    func logInfo(_ message: String) {
        recordCount += 1
        recordLimit = recordLimit + recordCount
    }
}


// TODO: Observer example, move appropriately to relevant page
// TODO: Solve correctly
class Game {
  var rats = [Rat]()
  func ratAdded(_ rat: Rat) {
    rats.append(rat)
    for rat in rats {
        rat.attack = rats.count
    }
  }
  func ratKilled() {
    rats.removeLast()
    for rat in rats {
        rat.attack = rats.count
    }
  }
}

class Rat {
  private let game: Game
  var attack = 1

  init(_ game: Game) {
    self.game = game
    game.ratAdded(self)
  }

  func kill() {
    game.ratKilled()
  }
}
