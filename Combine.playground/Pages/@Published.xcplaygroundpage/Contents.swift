//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `@Published`
 `@Published` is a property wrapper which can be applied to any property defined in a class which can publish
 some value.
 With SwiftUI framework, `@Published` properties combined with `ObservableObject` help redraw the
 view whenever the published property changes.
 `@Published` property wrapped is class constrained. Means a property in struct can't use @Published wrapper.
 `@Published` property has a wrapped value and a projected value. The projected value is accessed by $ sign
 notation and will result in a publisher.
 
 `When does @Published wrapper publishes it's changes to property?`
 `@Published` marked property will publish the value in property's `willSet` block. It's IMPORTANT to
 understand the implications of this as also show in example below. This behaviour implies that any subscriber
 to @Published property will receive update before the value is actually changed.
 
 In example below the print statement from within the subscriber closure :
 ```print("Value of @Published property : \(employeeOne.certification)")```
 will end up printing the existing value of property and not the one which is actually published.
 
 `But why even willSet, can't this be done in didSet?`
 Probably because doing so in willSet can allow SwiftUI framework to compare and calculate if the view body
 which is usually a subscriber to published properties need to be rendered again or not.
 */
import Foundation

// Example 1 : @Published property
class Employee {
    @Published var certification: String = String()
}

let employeeOne = Employee()
let cancellable = employeeOne.$certification.sink { receivedValue in
    print("Value published from employeeOne @Published property : \(receivedValue)")
    print("Value of @Published property : \(employeeOne.certification)")
}
employeeOne.certification = "Java"

/// `ObservableObject`
/// `ObservableObject` is a protocol which synthesizes an `objectWillChange` publisher.
// Example 2 : ObservableObject
class Company: ObservableObject {
    @Published var headCount: Int = 1
    @Published var ceo: String = "Batman"
    var headQuarter: String = "Batcave"
}

let someCompany = Company()
let someCompanySubscriber = someCompany.objectWillChange.sink { _ in
    print("Details about someCompany changed")
}

// When a @Published property of an ObservableObject is changed then objectWillChange
// will be fired.
someCompany.ceo = "Superman"
// headQuarter isn't a @Published so objectWillChange will not fire.
someCompany.headQuarter = "Krypton"
//: [Next](@next)
