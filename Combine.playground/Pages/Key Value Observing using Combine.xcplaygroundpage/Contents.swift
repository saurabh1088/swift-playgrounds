//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 
 */
import Foundation
import Combine
import UIKit
import PlaygroundSupport

class Employee: NSObject {
    //TODO: Without adding dynamic here this example doesn't works, find out why.
    @objc dynamic var name: String
    
    init(name: String) {
        self.name = name
    }
}


class MyViewController: UIViewController {
    @objc var employee: Employee? = nil
    var observation: NSKeyValueObservation?
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observation =  employee?.observe(\.name, options: [.new], changeHandler: { object, change in
            print("Employee changed name : \(change.newValue)")
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        employee?.name = "Dark Knight"
    }
    
}

let myViewController = MyViewController()
myViewController.employee = Employee(name: "Batman")
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = myViewController
//: [Next](@next)
