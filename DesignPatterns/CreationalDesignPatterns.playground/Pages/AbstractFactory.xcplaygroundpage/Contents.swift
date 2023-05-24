// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Abstract Factory`
 
 `Abstract Factory` is a creational design pattern which is used when requirement is to create a group of
 related objects.
 
 In abstract factory design pattern we usually have some abstract products(protocols) which are conformed by a
 variety of different concrete products. Then we have a abstract factory again a protocol which defines contract
 for creating some products, a concrete abstract factory then implements logic to create products.
 Now the client using products will be using abstract factory to get relevant products as per need.
 
 This pattern is useful when one need to create a family of related objects, but don't want to hardcode the
 concrete classes in the code. For e.g to elaborate this point `UniversalApp` defined in example below only
 needs to know a factory and then it will use factory to get objects it want. At no point `UniversalApp` specifies
 any concrete classes of the objects it needs.
 
 `Advantages`
 1. Loose coupling of client code from concrete classes it needs to use, thereby making client side code flexible
 re-usable and adaptable to changes.
 2. Object creation is abstracted.
 3. Think from client code perspective, in below example itself, let's say we need to add support for iPad and need
 to add an iPadButton and so on, the `UniversalApp` code won't need any change as the object creation part
 is encapsulated with factories. So we achieve extensibility.
 4. Testability of code is increased as it's easier to provide mock objects for tests.
 
 `Disadvantages`
 1. Complexity and overhead with creating all those interfaces, protocols and classes etc.
 2. If the related product families continue to grow then this pattern can lead to scalability challenges.
 */

import UIKit
import SwiftUI

/// Example 1
/// `AbstractSwiftUIButton` and `AbstractSwiftUIList` are abstract products. In Swift defined
/// as protocols. `IPhoneButton` and `MACButton` are concrete implementations as per use cases. Here
/// the use case is creating a UI component library then implementing it for various platforms (iOS, macOS, iPadOS etc)
///
/// In the example below we have two products `Button` and `List` which are declared via protocols
/// `AbstractSwiftUIButton` and `AbstractSwiftUIList`. Concrete implementations are provided
/// as per platform so we have following concrete implementations
/// - `IPhoneButton`
/// - `IPhoneList`
/// - `MACButton`
/// - `MACList`
/// There can be many more products but here we have taken only two.
///
/// Now an abstract factory is defined `AbstractUIFactory`
/// Concrete implementations of this abstract factory are :
/// - `IPhoneUIFactory`
/// - `MACUIFactory`
/// Both these factories create products Button and List for respective platforms. Note a single factory here for e.g.
/// IPhoneUIFactory is creating two products i.e. a Button and a List.
///
/// Finally the UniversalApp in example is initialised with a platform specific factory and from factory it gets all
/// the products for creating it's user interface.

// Abstract product Button
typealias UserEventAction = () -> Void
protocol AbstractSwiftUIButton {
    func buttonWith(title: String, action: UserEventAction) -> any View
}

// Abstract product List
protocol AbstractSwiftUIList {
    @ViewBuilder var listView: any View { get }
}

// Concrete products Button and List for iPhone platform
struct IPhoneButton: AbstractSwiftUIButton {
    func buttonWith(title: String, action: () -> Void) -> any View { EmptyView() }
}

struct IPhoneList: AbstractSwiftUIList {
    var listView: any View { EmptyView() }
}

// Concrete products Button and List for Mac platform
struct MACButton: AbstractSwiftUIButton {
    func buttonWith(title: String, action: () -> Void) -> any View { EmptyView() }
}

struct MACList: AbstractSwiftUIList {
    var listView: any View { EmptyView() }
}

// Abstract factory
protocol AbstractUIFactory {
    func makeButton() -> any View
    func makeList() -> any View
}

// Concrete factory responsible for iPhone platform, creating products button and
// list for iPhone platform
struct IPhoneUIFactory: AbstractUIFactory {
    func makeButton() -> any View {
        print("Creating button for iOS")
        return IPhoneButton().buttonWith(title: "iPhone Button", action: {})
    }
    
    func makeList() -> any View {
        print("Creating list for iOS")
        return IPhoneList().listView
    }
}

// Concrete factory responsible for Mac platform, creating products button and
// list for mac platform
struct MACUIFactory: AbstractUIFactory {
    func makeButton() -> any View {
        print("Creating button for macOS")
        return MACButton().buttonWith(title: "Mac Button", action: {})
    }
    
    func makeList() -> any View {
        print("Creating list for macOS")
        return MACList().listView
    }
}

// Finally an App which will use above defined Abstract Factory pattern APIs
enum Platform {
    case iOS
    case macOS
}
struct UniversalApp {
    
    let platform: Platform
    
    var uiFactory: AbstractUIFactory {
        switch platform {
        case .iOS:
            return IPhoneUIFactory()
        case .macOS:
            return MACUIFactory()
        }
    }
    
    func createButton() {
        uiFactory.makeButton()
    }
    
    func createList() {
        uiFactory.makeList()
    }
}

let myMacOSApp = UniversalApp(platform: .macOS)
myMacOSApp.createButton()
myMacOSApp.createList()

let myiOSApp = UniversalApp(platform: .iOS)
myiOSApp.createButton()
myiOSApp.createList()

//##############################################################################

/// Example 2 :

// Some abstract product
protocol Book {
    var title: String { get set }
}

// Concrete implementation of abstract product
struct LiteraryFiction: Book {
    var title: String
}

// Concrete implementation of abstract product
struct ScienceFiction: Book {
    var title: String
}

protocol PublisherFactory {
    func publishBook() -> Book
}

struct LiteraryFictionPublisher: PublisherFactory {
    func publishBook() -> Book {
        return LiteraryFiction(title: "Literary Fiction")
    }
}

struct Library {
    private let publisherFactory: PublisherFactory
    private var catalog = [Book]()
    
    init(publisherFactory: PublisherFactory) {
        self.publisherFactory = publisherFactory
    }
    
    mutating func add(book: Book) {
        catalog.append(publisherFactory.publishBook())
    }
}

//##############################################################################
