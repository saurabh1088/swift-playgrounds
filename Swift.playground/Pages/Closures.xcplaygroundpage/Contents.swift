//: [Previous](@previous)

// Created by Saurabh Verma on 06/06/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Closures`
 
 Quoting from Apple's documentation :
 `Closures are self-contained blocks of functionality that can be passed around and used in your code.`
 
 Closures are similar to what we have as blocks in Objective C and C. Also similar to concepts like lambdas in
 some other languages.
 
 Closures can be
 - Assigned to variables
 - Passed as arguments to functions
 - Returned from functions
 - Can capture and store references to any constant or variables from context in which closure is defined
 
 Capturing of constants or variables by closure, from the context in which closure is defined is known as
 `closing over` those constants and variables.
 
 - Global functions are actually a special case of closures which have name but they don't capture values.
 - Nested functiona are also closures which have name, but unlike to global functions these do capture values from
 context these are defined.
 
Syntax
 
 ```
 let aClosure = { (parameters) -> returntype in
     statements
 }
 ```
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Some closures to start with
func closureExample1() {
    let aClosure = {
        print("This is a closure")
    }
    aClosure()

    let closureTakingArguments: (String, String) -> String
    closureTakingArguments = { (firstName: String, lastName: String) -> String in
        return "\(firstName) \(lastName)"
    }
    print(closureTakingArguments("Saurabh", "Verma"))
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Trailing Closures
func methodWillPerform(count: Int, task: () -> Void) {
    print(count)
    task()
}

func closureExample2() {
    methodWillPerform(count: 1) {
        print("methodWillPerform")
    }
}


/// `Capturing Values`
/// Closures can capture constants and variables from surrounding context in which they are defined. Once
/// captures, closures can refer to and modify these constants and variables from within closure body even though
/// the original scope defining those no longer exists.

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Capturing values
/// In below example we have defined a method :
/// ```func collect(_ object: String) -> () -> [String]```
/// This method returns a closure which captures a collection(array of String in this example).
/// Now when this method is called and it returns a closure, the returned closure is capturing the collection so
/// subsequent calling the returned closure appends items to captured collection, so we get items added to the
/// collection.
/// Also calling method again creates another closure which has it's own reference to a new and separate collection.
/// So in example below we have create two collections using returned closures one collecting cookies and another
/// collecting marbles.

func collect(_ object: String) -> () -> [String] {
    var objects = [String]()
    var collection = {
        objects.append(object)
        return objects
    }
    return collection
}

func closureExample3() {
    print("closureExample3 :: Let's collect some cookies")
    let collectCookies = collect("Cookies")
    collectCookies()
    print(collectCookies())
    
    print("closureExample3 :: Let's collect some marbles")
    let collectMarbles = collect("Marbles")
    collectMarbles()
    collectMarbles()
    collectMarbles()
    print(collectMarbles())
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 : Closures Are Reference Types
/// collectSomething in example below is also having reference to save closure returned when `collect(`
/// method was called. So as closures are reference types both collectStickers and collectSomething are actually
/// refering to same closure and thus will append to same collection captured underneath.

func closureExample4() {
    let collectStickers = collect("Sticker")
    collectStickers()
    collectStickers()
    let collectSomething = collectStickers
    collectSomething()
}

/// `Escaping vs Non-escaping closures`
///
/// `Escaping Closures`
/// A closure when passed to a function, is said to escape, if it gets executed after the function returns.

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 : Escaping closure
/// Function functionTakingEscapingClosure takes an escaping closure and it needs to mark with keyword @escaping
/// else the compiler with cry with below error :
/// `Escaping closure captures non-escaping parameter 'completion'`
func functionTakingEscapingClosure(completion: @escaping () -> ()) {
    print("functionTakingEscapingClosure :: started executing function")
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        completion()
    }
    print("functionTakingEscapingClosure :: finished executing function")
}

func closureExample5() {
    functionTakingEscapingClosure {
        print("functionTakingEscapingClosure :: executing passed closure")
    }
}


/// `Autoclosures`
/// `Autoclosure` is a Swift language feature allowing to automatically convert an expression passed to
/// a function into closure.
/// Autoclosures helps to delay evaluation of expression unless it is actually required. This is a syntactic convenience
/// and it lets to omit the braces which otherwise would have been needed if instead od autoclosure an explicit
/// closure was passed to function.

// MARK: -----------------------------------------------------------------------
// MARK: Example 6 : Autoclosures
struct Employee: CustomStringConvertible {
    var firstName: String
    var lastName: String
    var description: String {
        print("Employee :: Describing employee...")
        return "\(firstName) \(lastName)"
    }
}

struct EmployeeCatalog {
    var isDebugMode: Bool = false
    func validateEmployee(_ employeeDesc: String) {
        // Some validation logic for employee
        if isDebugMode {
            print("DEBUG :: EmployeeCatalog :: Validating employee")
            employeeDesc
        }
    }
}

let employee = Employee(firstName: "Saurabh", lastName: "Verma")
var employeeCatalog = EmployeeCatalog()

/// In above case even if isDebugMode is false for EmployeeCatalog, when employee.description is passed to
/// function validateEmployee, then description for employee gets evaluated and we see `Employee :: Describing employee...`
/// getting printed. This even though this won't be needed as in the funtion validateEmployee description won't
/// get used.
/// This problem could be solved via passing a closure instead of string in following manner.

extension EmployeeCatalog {
    func validateEmployee(with debugDescription: () -> String) {
        // Some validation logic for employee
        if isDebugMode {
            print("DEBUG :: EmployeeCatalog :: using closure :: Validating employee")
            debugDescription()
        }
    }
}


/// Above way works well and now when employee.description is passed wrapped in a closure then the closure
/// is evaluated only if it's required, hence if isDebugMode is false for EmployeeCatalog then evaluating this closure
/// is never required and hence unecessary calculating description of employee is saved.
/// However this makes syntax cumbersome to look at. So here comes solution using autoclosure.

extension EmployeeCatalog {
    func validateEmployee(usingAutoclosure closure: @autoclosure () -> String) {
        // Some validation logic for employee
        if isDebugMode {
            print("DEBUG :: EmployeeCatalog :: using autoclosure :: Validating employee")
            closure()
        }
    }
}

func closureExample6() {
    print("closureExample6 :: Without using autoclosure")
    employeeCatalog.validateEmployee(employee.description)
    
    print("closureExample6 :: Using explicit closure")
    employeeCatalog.validateEmployee(with: { employee.description })
    
    print("closureExample6 :: Using autoclosure")
    employeeCatalog.validateEmployee(usingAutoclosure: employee.description)
}

//closureExample1()
//closureExample2()
//closureExample3()
//closureExample4()
//closureExample5()
//closureExample6()

//: [Next](@next)

