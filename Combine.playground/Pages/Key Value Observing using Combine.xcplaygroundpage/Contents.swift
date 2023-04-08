//: [Previous](@previous)

// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 
 */
import Foundation
import Combine
import UIKit
import PlaygroundSupport

/// Example 1 :
/// This example uses KVO. The name property of model Employee is observed using KVO and when it gets
/// updated then a print statement is executed.
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
    let button = UIButton()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle(employee?.name, for: .normal)
        observation =  employee?.observe(\.name, options: [.new], changeHandler: { object, change in
            print("Employee changed name : \(change.newValue)")
            self.button.setTitle(self.employee?.name, for: .normal)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        employee?.name = "Dark Knight"
    }
    
}


//let myViewController = MyViewController()
//myViewController.employee = Employee(name: "Batman")
//PlaygroundPage.current.needsIndefiniteExecution = true
//PlaygroundPage.current.liveView = myViewController



/// Example 2 :
/// Now same example as above will try with using combine.

class MyViewControllerUsingCombine: UIViewController {
    @objc var employee: Employee? = nil
    var cancellable: Cancellable?
    let button = UIButton()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle(employee?.name, for: .normal)
        cancellable = employee?.publisher(for: \.name)
            .sink(receiveValue: { receivedValue in
                print("Employee changed name : \(receivedValue)")
                self.button.setTitle(self.employee?.name, for: .normal)
            })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        employee?.name = "Man of steel"
    }
    
}

let combineViewController = MyViewControllerUsingCombine()
combineViewController.employee = Employee(name: "Superman")
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = combineViewController

//: [Next](@next)
