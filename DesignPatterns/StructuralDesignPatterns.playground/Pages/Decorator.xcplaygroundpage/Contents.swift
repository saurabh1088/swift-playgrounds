// Created by Saurabh Verma on 15/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

//: [<- Composite Pattern](@previous)

/**
 `Decorator`
 
 Decorator design pattern is a structural design pattern which aims at adding some behaviour without altering the
 class itself for which additional behaviour is expected.
 This additional behaviour is expected without necessarily using inheritance.
 
 This additional functionality or behaviour is placed in special wrapper objects called decorators.
 
 
 `What’s the need for decorator pattern?`
 
 1. Well we want to augment an object with some additional functionality but we don’t want to rewrite or alter
 existing code so as to avoid breaking open close principle

 2. Inheritance might not be possible for final types or say value types

 3. So decorator facilitates the addition of behaviour to individual objects without inheriting from them.
 
 4. Decorator patterns provides a flexible way to dynamically extend an object’s behavior without affecting the
 behavior of other objects of the same class.
 
 5. One needs to create variations of an object with different combinations of behaviors and also in process one
 needs to avoid creating many complex subclasses
 
 6. Avoid inheritance
 */
import Foundation

protocol Tea {
    var description: String { get }
    var price: Double { get }
}

class BasicTea: Tea {
    var description: String { return "Have a nice tea!" }
    var price: Double { return 20.00 }
}

enum TeaType {
    case black
    case lemon
    case milk
}

enum TeaFlavours {
    case ginger
    case cinnamon
    case blackPepper
}

class DecoratedTea: Tea {
    let tea: Tea
    let type: TeaType
    let flavour: TeaFlavours
    
    init(tea: Tea, type: TeaType, flavour: TeaFlavours) {
        self.tea = tea
        self.type = type
        self.flavour = flavour
    }
    
    // MARK: Tea protocol conformance
    var description: String {
        return "Have a nice \(type) tea!, with a dash of \(flavour)"
    }
    
    var price: Double {
        return 50.00
    }
}

/// Important point to be noted here is that there are two instances here, tea and gingerTea. Both are different
/// instances, gingerTea is the decorated one utilising the tea instance only.
func exampleDecorator() {
    let tea = BasicTea()
    let gingerTea = DecoratedTea(tea: tea, type: .milk, flavour: .ginger)
    print(tea.description)
    print(gingerTea.description)
}

exampleDecorator()

//: [Facade Pattern ->](@next)
