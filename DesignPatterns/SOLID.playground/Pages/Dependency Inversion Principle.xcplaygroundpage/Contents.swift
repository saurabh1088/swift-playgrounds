//: [Previous](@previous)

// Created by Saurabh Verma on 05/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

// TODO: Explore and find more suitable examples

/**
 `Dependency Inversion Principle`
 
 First thing first, Dependency Inversion Principle has NOTHING to do with Dependency Injection.
 
 High leve module should not depend upon low level modules, both should depend upon abstraction.
 Also abstraction should not depend upon details, details should depend on abstractions.
 */

import Foundation

/// Below example has low level modules of `EmailModule` and `SMSModule` which deal with logistics of
/// actually sending some mail or message to user.
/// Hight level module is `OrderManager` which has some functionality in which at some events it needs to notify
/// users, it can take a decision to notify via email or SMS.
/// In current implementation `Messaging` is dependent on low level modules and it needs to know about
/// these low level module APIs to actually perform messaging.
/// Any changes in low level modules might actually need to have high level module also need updates.
///
/// LOW LEVEL MODULES
class EmailModule {
    func sendEmailToUsers() {
        print("Sending email to users")
    }
}

class SMSModule {
    func sendSMSToUsers() {
        print("Sending SMS to users")
    }
}

/// HIGH LEVEL MODULE
enum UserCommunicationMode {
    case email
    case sms
}

class User {
    var preferredMode: UserCommunicationMode = .email
}

class OrderManager {
    let emailModule: EmailModule
    let smsModule: SMSModule
    let user: User
    
    init(user: User, emailModule: EmailModule, smsModule: SMSModule) {
        self.user = user
        self.emailModule = emailModule
        self.smsModule = smsModule
    }
    
    func sendEmail() {
        emailModule.sendEmailToUsers()
    }
    
    func sendSMS() {
        smsModule.sendSMSToUsers()
    }
    
    func orderUpdates() {
        print("Order created....")
        print("Order payment received...")
        print("Order confirmed...")
        print("Notifying user...")
        user.preferredMode == .email ? sendEmail() : sendSMS()
    }
}

func violationExample() {
    let user = User()
    let orderManager = OrderManager(user: user,
                                    emailModule: EmailModule(),
                                    smsModule: SMSModule())
    orderManager.orderUpdates()
}

/// In above aproach the implementation of `OrderManager` ends up needing a lot of dependencies as well
/// as getting dependent on low level modules of `EmailModule` and `SMSModule`, which it shoudn't.
/// It should only need to know that there is some messaging module and it needs to call it and that's it, there
/// shouldn't be intricate details required for it to know if there is a email module or sms module etc.
/// Ideally there should be a OrderManager, a User and OrderManager should send some message to user
/// which may depend upon user's preferred mode of communication. Which is what is followed in example below
/// with BetterOrderManager which only knows there is a messanger module and call it's send message function.
/// Better solutions is to follow abstration and have both low level and high level modules depend upon those
/// abstractions.

protocol Messanger {
    func sendAMessage()
}

class EmailMessanger: Messanger {
    func sendAMessage() {
        print("Sending email to users")
    }
}

class SMSMessanger: Messanger {
    func sendAMessage() {
        print("Sending SMS to users")
    }
}

class BetterOrderManager {
    let messanger: Messanger
    init(messanger: Messanger) {
        self.messanger = messanger
    }
    
    func orderUpdates() {
        print("Order created....")
        print("Order payment received...")
        print("Order confirmed...")
        print("Notifying user...")
        messanger.sendAMessage()
    }
}

func principledExample() {
    let orderManager = BetterOrderManager(messanger: SMSMessanger())
    orderManager.orderUpdates()
}


violationExample()
principledExample()

//: [Next](@next)
