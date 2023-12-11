// Created by Saurabh Verma on 06/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import UIKit

let INDICATOR =
"------------------Executing code example %@-----------------------------------"

// MARK: -----------------------------------------------------------------------
// MARK: Question 1
/// `What is the difference between the Float, Double, and CGFloat data types in Swift?`
///
/// CGFloat depends upon the CPU architecture. Which means if build is for 64 bit CPU then CGFloat is equivalent
/// to Double type and when build is for 32 bit CPU then CGFloat is equivalent to Float type.
/// In CGBase.h header a typedef is defined for the same based on architecture of CPU.
/// CGFloat even has a property `var native: CGFloat.NativeType` which tell its type (Double or Float)


// MARK: -----------------------------------------------------------------------
// MARK: Question 2
/// `What is the default data type Swift uses when you define a decimal number?`
///
/// Swift uses Double by default when it sees a decimal number without any explicit type defined for it.
/// Swift defaults to Double as Double is more accurate data type in comparison to Float.

func codeExampleQuestion2() {
    let someNumber = 3.14
    print("Default type of someNumber is :: \(type(of: someNumber))")

    let explicitFloat: Float = 3.14
    print("Type of explicitFloat is :: \(type(of: explicitFloat))")
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 3
/// `What causes a deadlock? Code example showing a deadlock scenario?`
///
/// A deadlock occurs if for example say there are two tasks which are waiting for each other to finish. Let's say
/// we synchronously submit some task on main queue. Main queue is serial queue. Adding any task to main
/// queue synchronously basically creates a deadlock.
///
/// Trying to execute below DispatchQueue block will make below runtime exception :
/// `error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).`

/// Example 1 :
/// Here a deadlock occurs as the current context is Main itself. So we are dispatching some task synchronously
/// making main queue wait till the task is finished. But the task is dispatched to the main queue itself which is
/// waiting for the task to finish so it won't perform the task. So this creates a deadlock.
//DispatchQueue.main.sync {
//    print("This will not get printed")
//}

/// Example 2 :
/// Here again the current context is Main. From main a task is dispatched to a serial queue synchronously. Main
/// queue will wait till the task is finished. No deadloack is caused if the second print statement is not dispatched.
/// However once the second print statement is dispatched from within the task block deadlock occurs.
/// Reason for deadlock is that for second print statement task the current context is the serialQueue which is
/// a serial queue so will execute tasks one by one. It's executing a task and synchronously another task is given
/// to it. The second print statement forms a part of original task itself so unless that is performed second print
/// statement can't be executed. But unless second print is executed original task can't be completed. Hence
/// deadlock.
let serialQueue = DispatchQueue(label: "my.serial.queue")

//serialQueue.sync {
//    print("Print from serialQueue")
//    // This causes deadlock
//    serialQueue.sync {
//        print("Print again from serialQueue")
//    }
//}


// MARK: -----------------------------------------------------------------------
// MARK: Question 4
/// `Can we check if code is running on main thread?`
///
/// Yes this can be checked using API `Thread.isMainThread` as shown in example below.

func codeExampleQuestion4() {
    print("Is this running on main thread :: \(Thread.isMainThread)")
    DispatchQueue.global(qos: .background).async {
        print("Is global dispatchqueue with background qos running on main thread :: \(Thread.isMainThread)")
    }
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 5
/// `How to execute some code on main thread?`
///
/// There are following ways to execute something on main thread.
/// 1. Using `DispatchQueue.main`, this is associated with main thread and any task dispatched to it will
/// get executed on main thread.

func codeExampleQuestion5A() {
    DispatchQueue.main.async {
        print("Does DispatchQueue.main executes this on main thread :: \(Thread.isMainThread)")
    }
}

/// 2. Usine `performSelector(onMainThread:with:waitUntilDone:)`
class SomeClass: NSObject {
    @objc func callMeOnMainThread() {
        print("Am I i.e. callMeOnMainThread getting called on main thread :: \(Thread.isMainThread)")
    }
    func execute() {
        self.performSelector(onMainThread: #selector(callMeOnMainThread),
                             with: nil,
                             waitUntilDone: false)
    }
}

func codeExampleQuestion5B() {
    let object = SomeClass()
    object.execute()
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 6
/// `Take an array and give a resulting array with elements multiplied by a factor.`

func byFactorOf(_ array: [Int], _ factor: Int) -> [Int] {
    return array.map { $0 * factor }
}

func codeExampleQuestion6() {
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    print(byFactorOf(array, 10))
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 7
/// `What kind of keywords can be used with guard to exit the scope once conditions are not met?`
///
/// With `guard` one can use following keywords to exit the scope.
/// 1. `return`
/// 2. `break`
/// 3. `continue`
/// 4. `throw`

struct Employee {
    var id: Int
    var name: String
}

enum EmployeeValidationError: Error {
    case invalidEmployeeId
    case invalidName
}

struct Company {
    var employees = [Employee]()
    
    mutating func addValid(employees: [Employee]) {
        for employee in employees {
            guard !employee.name.isEmpty else {
                print("Employee \(employee.id) had empty name")
                continue
            }
            self.employees.append(employee)
        }
    }
    
    func listOfEmployees() {
        for employee in employees {
            print(employee.name)
        }
    }
    
    func findAnyEmployeeHavingInvalidName() {
        for employee in employees {
            print("findInvalidEmployee for employee :: \(employee.name)")
            guard !employee.name.isEmpty else {
                print("Employee \(employee.id) had empty name")
                break
            }
        }
    }
    
    func doesAnyEmployeeHavingInvalidId() throws {
        for employee in employees {
            guard employee.id > 0 else {
                throw EmployeeValidationError.invalidEmployeeId
            }
        }
    }
}

let employee1 = Employee(id: 1, name: "Batman")
let employee2 = Employee(id: 2, name: "Superman")
let invalidEmployee = Employee(id: 0, name: "")
var company = Company()
company.addValid(employees: [employee1, employee2, invalidEmployee])
company.listOfEmployees()
company.employees = [invalidEmployee, employee2, employee1]
company.findAnyEmployeeHavingInvalidName()
do {
    try company.doesAnyEmployeeHavingInvalidId()
} catch {
    print("Company does contain employees with invalid id")
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 8
/// `What is a throwing function in Swift?`
///
/// A throwing funtion in Swift means a function which will flag something once some error occures while execution.
/// A function can be declared as throwing by using `throws`.

enum APIError: Error {
    case clientError
    case serverError
}

struct Networking {
    static func responseFromAPICall(_ httpCode: Int) throws -> Bool {
        switch httpCode {
        case 200..<300:
            return true
        case 400..<500:
            throw APIError.clientError
        case 500..<600:
            throw APIError.serverError
        default:
            return false
        }
    }
}

// This will set isAPISuccess200 to true
let isAPISuccess200 = try Networking.responseFromAPICall(200)
// This will set isAPISuccess400 to nil
let isAPISuccess400 = try? Networking.responseFromAPICall(400)
// This will cause an exception which is not handled and result in runtime error "error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)."
//let isAPISuccess401 = try! Networking.responseFromAPICall(401)

var isAPISuccess500: Bool
do {
    try isAPISuccess500 = Networking.responseFromAPICall(500)
} catch APIError.clientError {
    print("There was a client error")
} catch APIError.serverError {
    print("There was a server error")
} catch {
    print("Unexpected error")
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 9
/// `What are disadvantages of MVVM design pattern?`
///
/// Following blogpost from the creator of MVVM design pattern(John Gossman) himself talks about disadvantages.
/// https://learn.microsoft.com/en-us/archive/blogs/johngossman/advantages-and-disadvantages-of-m-v-vm
///
/// The obvious and foremost purpose of MVVM design pattern is to abstraction of view. Abstraction of view here
/// means that the view should be free from business logic so that it can be re-used. This also means that when
/// business logic is segregated from view layer the resulting view model layer which gets created is great to be
/// unit tested hence increating code coverage.
///
/// Here are some disadvantages which an MVVM might have
///
/// 1. For simple UI, MVVM may turn out to be overkill.
///
/// 2. For bigger complex projects view-models itself could be hard to design to achieve abstraction and generality.
///
/// 3. View-model use data-binding to communicate with views. Data-bindings is declarative and can be harder
/// to debug.
///
/// 4. MVVM might lead to writing same pattern of code in multiple view-models.
///
/// 5. MVVM adaptation might lead to a tight coupling with UI framework which is being used for e.g. UIKit or SwiftUI.
/// If same codebase is required to work with some other UI framework in future then its challenging.


// MARK: -----------------------------------------------------------------------
// MARK: Question 10
/// `Write an example showing retain cycle`

class Bike {
    var name: String
    var onStart: (() -> Void)?
    
    init(name: String) {
        self.name = name
        print("Bike \(name) is initialized")
    }
    
    func goVroom() {
        print("Bike will go vrooooom!!!")
    }
    
    deinit {
        print("Bike \(name) is deinitialized")
    }
}

func normalInitDeInit() {
    let yamaha = Bike(name: "FZ-X")
}
normalInitDeInit()

func creatingARetainCycle() {
    let yamaha = Bike(name: "MT-01")
    yamaha.onStart = {
        yamaha.goVroom()
    }
}
creatingARetainCycle()

func avoidCreatingRetainCycle() {
    let yamaha = Bike(name: "R15-V4")
    yamaha.onStart = { [weak yamaha] in
        yamaha?.goVroom()
    }
}
avoidCreatingRetainCycle()


// MARK: -----------------------------------------------------------------------
// MARK: Question 11
/// `I missed calling super methods in the ViewController I implemented, can I expect any issues?`
///
/// Yes, there will be side effects. It's important to call parent class overridden methods for certain methods ONLY.
/// For e.g. there is a view controller's lifecycle method `loadView()` this needs to be implemented when not
/// using any storyboard or XIBs, but this implementation in a UIViewController's subclass should NOT call super.
/// But for say `viewDidLoad` one should call `super.viewDidLoad`
///
/// Now talking about `viewDidLoad` from `UIViewController` itself, the immediate subclass can skip
/// calling it without any issues as there isn't anything `UIViewController` implements but in a more deep
/// hierarchy there could be a lot, so it's a good practice to call super wherever it's not explicitly mandated to NOT
/// to call, which is in case of `loadView()` as the documentation for `loadView()` warns not to call super.
///
/// Not calling super in overridden implementation when expected can have following consequences :
///
/// 1. UIViewController is always aubclassed and not used directly. Further as being object oriented and class type
/// one always have inheritance and some other view-controller's inheriting from a base viewcontroller. Whatever the
/// setting being, if there is a hierarchy and the child misses calling it's super cycle methods wherever required
/// will leave the viewcontroller's setup itself incomplete.
///
/// 2. The super version might be setting up something for e.g. some delegates or datasources at common place
/// which might miss out and lead to unexpected behaviours.


// TODO: This question calls for more discussion.
// MARK: -----------------------------------------------------------------------
// MARK: Question 12
/// `How does one decides to use GCD or Operation Queues? What's the difference between these?`
///
/// `GCD` and `OperationQueue` are two ways once can implement concurrency in iOS/macOS development.
///
/// `GCD vs OperationQueue`
///
/// 1. `GCD` is a low level C API enabling one to write code to use concurrency. `OperationQueue` is a high
/// level abstraction built on top of `GCD`.
///
/// 2. `GCD` is FIFO but `OperationQueue` isn't.
///
/// 3. `GCD` being low level can be more efficient and performant.
///
/// 4. `GCD` provides a simple and very easy to use APIs than `OperationQueue`, for basic concurrency
/// needs `GCD` is a great choice.
///
/// 5. `OperationQueue` can be used when one needs to have a finer control over tasks executions. So
/// if tasks which needs to be executed using concurrency are having complex dependencies then `OperationQueue`
/// should be used.
///
/// 6. `OperationQueue` should also be used if the tasks need to be cancelled or suspended during the course
/// of execution.


// MARK: -----------------------------------------------------------------------
// MARK: Question 13
/// `Why camel casing is used for variable and function names?`
///
/// Came case(camelCase) is a convention followed by various programming languages. Reason for using this
/// approach are :
///
/// 1. Camel case combine words in a single word by capitalizing first letter of every new word. This makes it
/// very readable as it's very evident and visible where each words begin and end. So basically it helps in
/// readability. Now readability can be very important while debugging and maintaing code.
///
/// 2. Following a convention helps to achieve consistency in naming across any codebase.


// MARK: -----------------------------------------------------------------------
// MARK: Question 14
/// `Can we declare a struct as open, like one can declare an open class?`
///
/// NO, `open` was introduced in Swift as an added access level for classes and class members to provide
/// a distinction from `public` access modifier.
/// As from Apple's documentation itself `Open access applies only to classes and class members, and it differs from public access by allowing code outside the module to subclass and override`
/// So when a class or it's members are declared as `open` then it means and any module importing the module
/// in which this open class is declared is free to subclass or override it. So one must be aware of consequences of
/// someone using and subclassing/oerriding hence classes or class members declared as open must be declared
/// only if necessary.
///
/// Using `open` for a struct makes compiler cry with below error :
/// Only classes and overridable class members can be declared 'open'; use 'public'


// MARK: -----------------------------------------------------------------------
// MARK: Question 15
/// `We have to establish communication between two objects, what are options?`
///
/// There are following ways of communication between objects.
///
/// `One to One : Involves two objects only`
///
/// 1. Delegation pattern
/// 2. Closures
/// 3. Method calls
/// 4. Properties
///
/// `Many to Many`
///
/// 1. Notifications
/// 2. KVO


// MARK: -----------------------------------------------------------------------
// MARK: Question 16
/// `In a design pattern MVVM what could be the responsibilities of controller?`
///
/// - Even with an iOS App using MVVM design pattern, in UIKit there will be viewcontrollers to manage the
/// views. Managing view hierarchy and displaying views on screen and playing part in responder chain still
/// remains with viewcontrollers.
///
/// - Viewcontroller will create appropriate bindings between view model and view. This binding is what communicates
/// changes from view-model to view.
///
/// - Viewcontroller will offcource continue to handle user input, it anyways is a part of responder chain. Also it
/// will take user input and pass it to view-model
///
/// - Viewcontroller will control the navigation, push/pop of subsequent viewcontrollers and segues in case of
/// storyboards.


// MARK: -----------------------------------------------------------------------
// MARK: Question 17
/// `In a MVVM design pattern how does view-model receives information?`
///
/// MVVM design pattern consists of Model - View - ViewModel. There exists a binding between view and
/// view-model. There exists a communication channel between view and view-model via bindings. So a view-model
/// is able to communicate changes to view layer when to update.
/// This communication can be done via help of a controller which can create bindings and pass on information
/// related to user events to view-model. Or in case of using a reactive framework like Combine this could be
/// done using a publisher subscriber model wherein the view subscribes to view-model published properties.
/// In reactive case for example if using SwiftUI+Combine the view can directly provide information of user events
/// like selecting an option on some ui component, entering some text etc. Once user event happens view-model
/// appropriate handler can be called to let view-model get that information.
///
/// View-model also contains business logic and it is also responsible for communicating changes happened to
/// model layer back to the view layer. So it must receive information about model changes which it receives from
/// APIs it calls to get updated models.
///
/// Dependency injection can be used to provide view-model information coming from source external to it when
/// it's getting initialised.


// MARK: -----------------------------------------------------------------------
// MARK: Question 18
/// `Is optional in Swift value type or reference type?`
///
/// `Optional` in swift represents a type which may or may not have a value. Behind the scenes optional is
/// actually implemented as a enumeration with two cases.  Something like this
/// ```
/// enum OptionalValue<T> {
///     case None
///     case Some(T)
/// }
/// ```
/// So basically its an enumeration with two cases None and Some, with some implecating an associated value
/// of the type matching for which optional is defined.


// MARK: -----------------------------------------------------------------------
// MARK: Question 19
/// `Does functions in Swift have retain count?`
///
/// NO
/// No, functions in Swift do not have a retain count. This is because functions are not objects. They are simply
/// blocks of code that are executed when they are called. Functions are first-class citizens in Swift, which means
/// that they can be treated like variables and passed around as values.
/// When a function is called, the compiler creates a new stack frame for the function. This stack frame contains
/// all of the local variables and parameters for the function. When the function returns, the stack frame is
/// destroyed and the memory used by the local variables and parameters is freed.
/// Since functions are not objects, they do not need to be managed by the reference counting system. The
/// reference counting system is only used to manage objects.


// MARK: -----------------------------------------------------------------------
// MARK: Question 20
/// `Does closures in Swift have retain count?`
///
/// YES
/// Closures are reference types so they have retain count. Reference types are objects that can be referenced
/// by other objects. When a closure is referenced by another object, the closure's retain count is incremented.
/// This means that the closure will not be deallocated until its retain count reaches zero.
/// This is the reason when self is captured in a closure then it can lead to memory leaks. Wheras self inside a
/// function doesn't causes any issues.


// MARK: -----------------------------------------------------------------------
// MARK: Question 21
/// `Does Implicitly Unwrapped Optionals in Swift have retain count?`


// MARK: -----------------------------------------------------------------------
// MARK: Question 22
/// `What are implicitly unwrapped optionals?`
///
/// https://cocoacasts.com/when-should-you-use-implicitly-unwrapped-optionals
/// Implicitly unwrapped optional behaves as optional, which means it is allowed to have no value. Implicitly
/// unwrapped optional promises that it will have some value when accessed. Even though one can access
/// an implicitly unwrapped optional directly, still one can access via optional binding or optional chaining or nil
/// check
///
/// In below example `ImplicitUnwrappedOptional` defines a property `iuo` which is implicitly unwrapped
/// optional. An instance is created with this property passed as nil and then in the print statement this property
/// is accessed without any optional specific handling.
///
/// `@IBOutlet weak var tableView: UITableView!`
/// IBOutlets are example of implicitly unwrapped optionals. These are marked so as these only have value once
/// the view hierarchy has been loaded during viewcontroller's lifecycle.
/// It is important to note that IBOutlets are not loaded until the view controller's view is loaded. This means that
/// one cannot access IBOutlets before the view controller's viewDidLoad() method is called.
/// Accessing an IBOutlet before the view controller's viewDidLoad() method is called, your app will crash.
///
/// One more use-case for implicitly unwrapped optionals is that Objective-C doesn't guarantees if an object is
/// non-nil. So when Swift imports Objective-C APIs it will import those as implicitly unwrapped optionals by default
/// unless one uses the nullability annotations in Objective-C APIs being imported.
///

struct ImplicitUnwrappedOptional {
    // Implicitly unwrapped optional
    var iuo: String!
}

// Instance with implicitly unwrapped optional set to nil
let iuoExample = ImplicitUnwrappedOptional(iuo: nil)
// Here we are accessing the implicitly unwrapped optional directly
print("Value of iuoExample.iuo :: \(String(describing: iuoExample.iuo))")

// One can use ways to unwrap an implicitly unwrapped optionals as well, but that
// defeats the purpose of declaring them as implicitly unwrapped itself as when
// we declare something to be implicitly unwrapped we are promising that it's value
// will be there.
if let iuoValue = iuoExample.iuo {
    print("Value of iuoExample.iuo :: \(iuoValue)")
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 23
/// `Any vs AnyObject`
///
/// Both `Any` and `AnyObject` in Swift are special types used for type erasure.
/// Difference being `Any` can be used for any type be it value type ot reference type even for functions.
/// Whereas `AnyObject` is specifially for class types.
///
/// So
/// `Any` can represent an instance of any type at all, including function types and optional types.
/// `AnyObject` can represent an instance of any class type.
///
/// `AnyObject` is actually a protocol to which all classes implicitly conform to. Only classes conform to `AnyObject`
/// so using `AnyObject` one can restrict a protocol to be used only for class types.
///
/// `Swift 2` used to map `id` type from Objective C to `AnyObject`. `AnyObject` as mentioned above
/// is only for classes, but `Swift 2` also provided implicit conversions to AnyObject for some bridged value
/// types such as String, Array, Dictionary, which can be easily used with NSString, NSArray and NSDictionary etc.
/// But this lead to confusion as to what can be converted using NSObject and what cannot. String in Swift is value
/// type but still can be casted to `AnyObject` and used as `NSString` in Objective C while not all value
/// types from Swift can be (the ones not having any bridged types).
/// So to end this confusion from `Swift 3` change was made to map `id` type to `Any` so that it can be
/// used for any value type, or reference type etc. So now with this change any Swift value type can be passed
/// to Objective C APIs and can be extracted as Swift types.
/// https://cocoacasts.com/what-is-anyobject-in-swift

struct TestAny { }
class TestAnyObject { }

let packOfAny: [Any] = [1, "two", { print("Three") }, TestAny(), TestAnyObject()]

/// Both `packOfAnyObjectsError` and `packOfAnyObjectsErrorStill` will give error Type of
/// expression is ambiguous without more context.
//let packOfAnyObjectsError: [AnyObject] = [1, "two", TestAny()]
//let packOfAnyObjectsErrorStill: [AnyObject] = [TestAnyObject(), { print("Closures are referece types but not AnyObject") }]
let packOfLegalAnyObjects: [AnyObject] = [TestAnyObject(), TestAnyObject()]


// MARK: -----------------------------------------------------------------------
// MARK: Question 24
/// `How many times does application(_:didFinishLaunchingWithOptions:) gets called?`
///
/// `application(_:didFinishLaunchingWithOptions:)` is called only once.


// MARK: -----------------------------------------------------------------------
// MARK: Question 25
/// `How can one avoid excessive thread creation?`
///
/// While developing code for some concurrent operations, if some task scheduled blocks a thread, then system
/// will create additional thread for the concurrent queue to address other tasks on the queue.
/// If many tasks dispatched to concurrent queue blocks then it can lead to many thread getting created which
/// can eventually lead to system running out of threads.
/// This can also happen if an application is creating too many private concurrent queues.
///
/// So ideally to avoid exessive thread creation one can follow two approaches :
///
/// 1. Instead of creating private concurrent queues, one should use any one of global concurrent queues provided
/// by GCD.
/// 2. For serial queue as well that target of the queue can be set to one of the global concurrent queue, this still
/// maintains the serialised behaviour but prevents creating separate queues further creating more threads.


// MARK: -----------------------------------------------------------------------
// MARK: Question 26
/// `What is App App thinning, Bitcode, Slicing?`
///
/// `App Thinning`
/// There are various iOS devices available with varying degree of screen sizes, resolution and architecture.
/// An app usually need to add multiple assets catering to different device types. This means when users
/// downloads an app on their device, then chances are the app might be containing resources which might
/// never be used. Also let's say for a gaming app some resources might be only required once user crosses
/// a certain level in the game. It would be nice if user gets only what they need when they install the app.
/// App thinning is enabled by default for all apps that are submitted to the App Store.
/// `App Thinning` is the process of delivering a tailored binary to the devices.
/// There are three main aspects of App thinning
/// 1. App Slicing
/// 2. Bitcode
/// 3. On demand resources
///
/// `App Slicing`
/// As per Apple :
/// `Slicing is the process of creating and delivering variants of the app bundle for different target devices`
/// `App Slicing` helps delivering only relevant assets to each device downloading App. App slicing is done
/// by App store when an app is submitted to it. So this means that the app uploaded to App store continues to
/// be the full version with all assets required for all possible devices. The app store will slice the app based on
/// devices app supports.
///
/// `Bitcode`
/// With bitcode enabled(this can be enabled from Xcode for a target/project), when an application is archived, then, the
/// compiler will produce binaries containing bitcode rather than machine code. App store will compile bitcode
/// down to machine code. With bitcode App store gets flexibility to compile bitcode again in future if say some
/// advancements in compiler itself are made, this without asking for any actions from app developer part.
/// `Bitcode` is a pre-requisite of `Slicing`
/// NOTE: When bitcode is enabled, the dSYMs generated are for bitcode binary, so those can't be used to
/// de-symbolicate the crash reports for the crashes observed by the app in production (i.e. on customers devices).
/// So dSYMs have to be downloaded from app store and saved for using further.
///
/// `On demand resources`
/// These resources are hosted on Apple servers and can be made available for the App as per request. These
/// are the files which can be downloaded after app's first installation.
///


// MARK: -----------------------------------------------------------------------
// MARK: Question 27
/// `How would one design a scalable and reusable architecture for an iOS app?`
///
/// One can consider various apspects in order to design a scalable and reusable architecture for an iOS App.
///
/// 1. `Architectures` : One should choose an architectural pattern to follow and decide based on what suits
/// the application the most. MVC could be a good starting point for simple applications. Alternatives which can
/// be considered are MVVM, Clean architecture or VIPER.
///
/// 2. One must follow principle of `Separation of Concerns` while developing the application modules
/// types and components. This help to isolate responsibilities. isolating responsibilities helps to reduce bulk
/// handling by a single type therby reducing stron coupling and less chances of intrducing bugs. Also bug found
/// in one isolated component could mean the fix could be easily found and fixed without affecting whole lot of
/// other codebase.
///
/// 3. Ensure using `Dependency Injection` this again will prevent loose coupling and also contribute
/// towards making the code more flexible and testable via unit testing.
///
/// 4. Leverage modern programming paradigms like reactive programming using frameworks like `Combine`
/// For an iOS app using `Combine` framework to handle event driven behaviour can greatly simplify the code
/// and make code lot cleaner.
///
/// 5. Target `Unit Testing` for the app and aim for a good code coverage. Unit testing and aim to achieve
/// a good code coverage forces to write the code itself in a testable manner reducing some issues like tight
/// coupling and single responsibility principle violations.


// MARK: -----------------------------------------------------------------------
// MARK: Question 28
/// `What is the role of protocols in iOS development? How do they promote code reusability and maintainability?`
///
/// `Code Reusability`
/// One can declare protocol which multiple type can conform to. One can also club multiple protocols and create
/// a protocol composition. One can add some implementation via protocol extensions thereby all conforming type
/// getting that implementation automatically.
/// These feature enable multiple objects even though unrelated, can obtain a common functionality by conforming
/// to a protocol.
///
/// `Interoperability`
/// One get Interoperability by protocol as unrelated objects can communicate to each other via protocol.
///
/// `Loose Coupling`
/// When objects communicate via protocols, then there is loose coupling between objects instead on the case
/// when the objects directly refer to each other anc communicate.
///
/// `Dependency Injection`
/// Procols are used to procide dependencies to objects, instead of direclty instantiating the object itself. This also
/// leaves option to provide mock data by adhering to the protocol and creating a mock object. Thus way it also
/// helps achieving unit testing.
///
/// `Multiple Inheritance`
/// A type can conform to multiple protocols thus getting behaviours from multiple sources.


// MARK: -----------------------------------------------------------------------
// MARK: Question 29
/// `How would you ensure efficient networking and data loading in an iOS app? What techniques or frameworks would you use?`
///
/// `Asynchronous`
/// Network requests should be made asynchronously so as to avoid blocking main thread, which is where all
/// UI related events and tasks takes place, Any network request if happens on main thread will block the main
/// thread and make UI unresponsive leading to extremely bad user experience.
///
/// `Caching`
/// Design networking with appropriate caching in mind as it will allow to possibly cache some request responses
/// which could not be changing too frequently so avoid making unecessary network traffic. This improves performance
/// of the app.
/// If one has to load many images then it's always best to use image caching so as to provide a smooth UI
/// experience.
///
/// `Pagination`
/// While designing UI for a very large data set, techniques like pagination can be employed so as to display
/// as well as load small data sets at a time. This reduces the payload of network request and makes a smooth
/// user experience.
///
/// `Background Fetch & Push Notifications`
/// Background Fetch and Push Notifications can be employed to efficiently give updaetes ensuring the app
/// has latest information available without blindly making too many network calls while app is being used. This
/// helps users perceiving less loading time altogether.
///
/// `Optimized Data Formats`
/// Use some Optimized data formats for transfer payloads and design APIs in away to only receive what's needed
/// and not let the payload with a lot of clutter which isn't going to be used at all.
///
/// `Request Prioritization and Throttling`
/// Implement mechanisms to prioritize network requests based on their importance or urgency. Throttling
/// techniques, such as debouncing or rate limiting, can prevent excessive or unnecessary network requests,
/// improving performance and conserving resources.
///
/// `Reachability`
/// Frameworks like `Reachability` could be used to monitor network reachability and thereby handling to
/// take appropriate actions and provide feedback to user.
///
/// `Performance Monitoring and Analytics`
/// Incorporate performance monitoring and analytics tools, such as Firebase Performance Monitoring or New
/// Relic, to track and analyze network-related metrics. This helps identify bottlenecks, optimize performance,
/// and make informed decisions for further improvements.
///
/// `Background Transfer Service`
/// Use the Background Transfer Service provided by iOS to handle large file downloads or uploads in the
/// background, even when the app is not actively running. This allows the app to continue transferring data
/// efficiently, even if the user switches to a different app or the device enters a low-power state.


// MARK: -----------------------------------------------------------------------
// MARK: Question 30
/// `What is App Analytics (from App Store Connect)?`
///
/// `App Analytics` provides with insightful data about downloads, re-downloads, proceeds and more. It provides
/// helpful data while respecting user's privacy. It provides several metrics for example :
///
/// `Impression`
/// Any time a user sees the app icon is counted as an impression. App Analytics provides impressions over
/// time period, this data can be viewed over time.
///
/// `Project page view`
/// Any time a user sees app's project page is counted as project page view. Project page also contains the app
/// icon, so a project page view also increases impression by one.
///
/// There are also variations of these metrics namely `Unique impressions` and `Unique product page view`
/// For example, if someone searches for an app and sees the app in search results, then this is counted as an
/// impression as search result if returns the app will show app icon. Now when from search results when user
/// taps search result of an app then user is taken to that app's home page view. In this case there are two
/// impressions and one product page view AND just one unique impression as both impressions are from same
/// user.
///
/// `Conversion rate`
/// Conversion rate is the percentage of people who downloads the app after seeing it on app store. This is calculated
/// by taking total downloads and total unique impressions.
///
/// `Total downloads`
/// Total downloads include both first-time downloads(GET or BUY button) and re-downloads(Cloud icon with
/// arrow, autodownloads are not included when re-downloads are counted)
///
/// These metrics help to understand how effectively one is acquiring the users.
///
/// App analytics also helps to discover how users are discovering apps by territory, source type and page type.
/// One can for example view metrics by territory, like one can see conversion rate as per territory and get to
/// understand which territory has low conversion rate and then work on it.
///
/// Source type
/// 1. App store browse
/// 2. App store search (someone finds and downloads)
/// 3. App referrer (someone discover app inside another app on app store, could be in-app advertisement)
/// 4. Web referrer (through weblink via web advertisement, if app is discovered through browser other than
/// safari then it will show up as an app refer for that browser, instead of web refer)
///
/// Page type
/// 1. Product page (the app store product page)
/// 2. Store sheet (looks similar to product page, but exists outside the app store, pops from bottom of screen,
/// this is SKStoreProductViewController)
/// 3. No page (when  user downloads app without visiting product page, by directly tapping link on app store page)
///
/// Peer group benchmark
/// This puts performance of app into context by comparing the performance to that of similar apps.


// MARK: -----------------------------------------------------------------------
// MARK: Question 31
/// `How would you design an iOS app that needs to be able to handle a large number of users?`
///
/// There are many aspects to look into when designing an iOS app to handle large number of users.
///
/// 1. Backend Architecture.
/// iOS App will be one to one or to say the device having App is used by one user at a time, so multiple users
/// are actually going to have impact on the backend services which are going to take the load. So basically the
/// backend should be scalable.
///     - Backend itself should be scalable to address increase in load
///     - Load balancer should be used to help manage incoming traffic
///     - Caching layer could be implemented at backend to provide faster turnaround time for frequently accessed data
///     - Serverless architecture could be leveraged to run services without having to manage the underlying infrastructure.
///
/// 2. Database Management
/// Database should be scalable as per the load expected, and NoSQL databases should be opted if large amount
/// of data which can grow is expected. Database indexing, sharding or partitioning should be implemented to
/// optimise queries and distribute load across multiple servers.
///
/// 3. Asynchronous Operations
/// Asynchronous techniques must be used to prevent app freezing UI giving an extremely bad user experience.
/// Using asynchronous operations smartly gives user impression of fast and responsive app and helps reducing
/// perceived stress on backend services.
///
/// 4. Caching
/// One can plan to cache data which doesn't change frequently on the fron end itself so as to reduce traffic on
/// backend thereby reducing the stress on it.
///
/// 5. Content Delivery Network
/// CDNs can help providing content like assets, images, videos etc. These CDN can provide from geographically
/// distributed servers to minimize latency and improve download speeds.
///
/// 6. Analytics
/// Implement analytics to capture data. This captured data can help paint a picture of how users are using the
/// app and can help understand the areas that might need improvements.
///


// MARK: -----------------------------------------------------------------------
// MARK: Question 32
/// `How to reverse loop through an array and print all values?`
///
/// Straight and obvious answer would be to use .reversed()
/// .reversed() works, but it will do some computation to reverse the array which needs to be traversed in reverse
/// order.
/// Same thing can be achieved via using index and then figuring out reverse number from array.
///
/// There is one more option however, which is using stride. Benefits of using stride are
/// 1. One can move forward or backward very easily
/// 2. Clean and simple code
/// 3. Not integer values are also possible
/// 4. Very easy to iterate with a particular jump.

let someArray = Array(1...100)
for number in someArray.reversed() {
    print("Using reversed() :: \(number)")
}

for (index, number) in someArray.enumerated() {
    let num = someArray[someArray.count - index - 1]
    print("Using index :: \(num)")
}

for number in stride(from: 100, through: 1, by: -1) {
    print("Using stride from through :: \(number)")
}

for number in stride(from: 100, to: 2, by: -2) {
    print("Using stride from to :: \(number)")
}

// Custom function to reverse array
func flip(_ array: inout [Int]) {
    var begin = 0
    var end = array.count - 1
    
    while begin < end {
        let temp = array[begin]
        array[begin] = array[end]
        array[end] = temp
        begin += 1
        end -= 1
    }
}

var someNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
flip(&someNumbers)


// MARK: -----------------------------------------------------------------------
// MARK: Question 33
/// `What's the difference in weak and unowned and how to decide which one to use?`
///
/// Both weak and unowned are used to resolve memory retain cycle between two types holding strong reference
/// to each other. In such case one makes one of the reference as weak or unowned so as to break the retain
/// cycle.
/// Now there is difference, obviously between these and these should be used as per case by case.
/// As for difference the major difference is
///
/// `weak` can be nil so it always declared as optional, whereas `unowned` will always have a value so can't
/// be nil.
///
/// From Apple's documentation itself :
///
/// _Define a capture in a closure as an unowned reference when the closure and the instance it captures will
/// always refer to each other, and will always be deallocated at the same time._
///
/// _Conversely, define a capture as a weak reference when the captured reference may become nil at some
/// point in the future. Weak references are always of an optional type, and automatically become nil when the
/// instance they reference is deallocated. This enables you to check for their existence within the closure’s
/// body._
///
/// `Memory Leak`
/// Below example shows memory leakage.

class ClassA {
    var beOne: ClassB?
    deinit {
        print("De-initializing ClassA")
    }
}

class ClassB {
    var aOne: ClassA
    init(aOne: ClassA) {
        self.aOne = aOne
    }
    deinit {
        print("De-initializing ClassB")
    }
}

func exampleForMemoryLeakage() {
    var objectA: ClassA? = ClassA()
    // TODO: Update to remove force unwrap
    var objectB: ClassB? = ClassB(aOne: objectA!)
    objectA?.beOne = objectB
    objectA = nil
    objectB = nil
}

exampleForMemoryLeakage()

/// `Using weak to break memory leak`
class Person {
    var name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("De-initializing Person")
    }
}

class Apartment {
    var name: String
    weak var tenant: Person?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("De-initializing Apartment")
    }
}

func exampleResolvingMemoryLeakWithWeak() {
    var person = Person(name: "Batman")
    var apartment = Apartment(name: "Batcave")
    person.apartment = apartment
    apartment.tenant = person
}

exampleResolvingMemoryLeakWithWeak()

class User {
    var name: String
    var creditCard: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("De-initializing User")
    }
}

class CreditCard {
    var type: String
    unowned var holder: User
    
    init(type: String, holder: User) {
        self.type = type
        self.holder = holder
    }
    
    deinit {
        print("De-initializing CreditCard")
    }
}

func exampleResolvingMemoryLeakWithUnowned() {
    var user = User(name: "Superman")
    var card = CreditCard(type: "Visa", holder: user)
    user.creditCard = card
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 34
/// `What is Hashable? What's the concept and how it works in Swift?`
///
/// `Hashable`
/// An object in computer science is said to be hashable if it's `hash` value never changes during it's lifetime.
///
/// `Hash Value`
/// Hash value can be defined as a finger print for an object or say a file based on it's content. The contents are
/// processed through some cryptographic algorithm, producing a unique numerical value. This numerical value
/// is the `hash value` and it identifies the content.
/// Now if contents get changes in any way the hash value will also change.
///
/// There are two algorithms widely being used producing hash values :
/// - MD5
/// - SHA1
///
/// Hashes are output of these hashing algorithm mentioned above (MD5 & SHA1)
///
/// One cannot reverse a hash value to re-construct file/object. It can simply confirm if two files/objects are identical
/// or not, without need to know about their content.
///
/// A hash function, which calculates hash value should
/// - Be deterministic and produce same hash value for same content
/// - Be fast
/// - Uniform in distributing range of hash values to avoid collision (small range can lead to more collision)
/// - Avalanche effect : should produce significantly different hash for a small change in content, this promotes
/// randomness
///
///
/// In Swift, Hashable is declared as ```protocol Hashable : Equatable```
/// Here as per definition we can see that the Hashable protocol is inheriting from Equatable protocol so when
/// conformance to Hashable is required then one needs to satisfy the requirements from Equatable protocol
/// as well.
struct Coordinates {
    var x: Int
    var y: Int
}

/// Below attempt will make compiler cry with error :
/// `Generic struct 'Set' requires that 'Coordinates' conform to 'Hashable'`
/// ```let setOfCoordinates: Set = [Coordinates(x: 1.0, y: 2.0)]```
///
/// To make our Coordinates work with Set we need to make it conform to Hashable protocol. We can add that
/// in an extension. Now only conformance is needed, Coordinates not having any custom properties the required
/// methods are easily synthesized.

extension Coordinates: Hashable { }

func codeExampleQuestion34() {
    let coordinate1 = Coordinates(x: 1, y: 1)
    let coordinate2 = Coordinates(x: 1, y: 1)
    print(coordinate1 == coordinate2)
    print(coordinate1.hashValue)
}
// TODO: What is hash table


// MARK: -----------------------------------------------------------------------
// MARK: Question 35
/// `Some devices are not able to receive push notifications, what could be issue?`
///
/// Few of the reasons this issue might be happening
///
/// 1. Notifications turned off in device settings. Notifications can be managed for each app individually, it should
/// be turned on for app to receive it.
///
/// 2. Unstable network can lead to device not receiving notifications.
///
/// 3. Server contacting APNs should ensure the push notifications are delivered correclty to APNs to send further
/// to devices.
///
/// 4. Provisioning file used to sign target while build should have a unique app id in order to use push notification.
/// If instead wildcard app id is used, this might not work and app might fail to receive push notifications.
///
/// 5. Check the Focus mode, if focus mode is turned on and is configured not to receive notifications then device
/// won't receive it.
///
/// 6. APNs connection issues, if connection to APNs can't be established.
///
/// 7. Ports/Hosts firewall settings might affect if notifications are sent to APNs or not.
///
/// 8. Date/Time/TimeZone should be set correctly on devices.


// MARK: -----------------------------------------------------------------------
// MARK: Question 36
/// `What's difference between self and Self?`
///
/// `self` refers to instance of a type, whereas `Self` refers to the type itself. This is notable when writing
/// protocols and protocol extensions.
/// `Self` in case of protocols refers to the actual type which conforms to the protocol. Wheras `self` refers
/// to the instance of the type which is conforming to the protocol.
///
/// For example in below extension for Int, the computed property square returns `Self` which means that the
/// square property will return an Int which is the type. In the comoutation block for the property `self` is used
/// which refers to the instance on which this computed property gets called.

extension Int {
    var square: Self { return self * self }
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 37
/// `Is lazy thread safe?`
///
/// NO, as per Apple's documentation for lazy property itself, defining a property as lazy doesn't guarantees any
/// thread safety. Quoting from Apple documentation :
/// _ If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property
/// hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once._


// MARK: -----------------------------------------------------------------------
// MARK: Question 38
/// `Can we cancel a task in GCD?`
///
/// YES, DispatchWorkItem has an instance method cancel() which cancels the current work item asyncronously.
/// The CATCH however is that cancellation causes future attempts to execute the work item return immediately.
/// Cancellation has no effect on the current work item being executed.
func codeExampleQuestion38() {
    // TODO: Work on this example
}


// MARK: -----------------------------------------------------------------------
// MARK: Question 39
/// `What's the difference between class and static keywords?`
///
/// static members cannot be overriden in subclasses.


// MARK: -----------------------------------------------------------------------
// MARK: Question 40
/// `What's use of @inline attribute in Swift?`
///
/// `@inline` attribute helps Swift compiler in making optimization decisions. To better understand this
/// attribute one needs to understand what is meant by `function inlining` in programming world.
///
/// `Function Inlining`
/// Function inlining is a compiler optimization technique used in programming languages to improve the
/// performance of a program by replacing a function call with the actual code of the function. In other words,
/// instead of executing a separate function call instruction, the compiler includes the function's code directly
/// at the location where it's called. This can eliminate the overhead associated with function calls, such as
/// pushing and popping data onto the call stack and jumping to a different part of the program's code.
/// Though this provides a great performance boost, this also increases the size of binaries as this can lead to
/// code duplication in a way.
///
/// Now coming back to `Swift` and `@inline`. Swift compiler can automatically perform some inlining based
/// of weather it's optimizing for speed or for binary size.
///
/// Now Swift compiler can take it's own decision, however using `@inline` attribute one can force Swift
/// compiler to behave differently. There are two options available :-
/// ```
/// 1. @inline(__always): Signals the compiler to always inline the method, if possible.
/// 2. @inline(never): Signals the compiler to never inline the method.
/// ```
///
/// Should `@inline` be used?
/// `@inline` is widely used in Swift source code and this attribute is publicly available. However as a
/// general practice one shouldn't be using it.
///


// MARK: -----------------------------------------------------------------------
// MARK: Question 41
/// `What's the use of @inlinable attribute in Swift?`
///
/// `@inlinable` helps in taking concept of `function inlining` across frameworks. Imagine a single
/// module where compiler makes optimisation using `function inlining`. This works well as compiler
/// in this scenario knows everything about the module. However if to this module we add a framework or a library
/// then things become complicated.
/// Swift 4.2 introduced `@inlinable` attribute enabling cross module inlining. When a api is marked with this
/// attribute then implementation is exposed as part of modules public api and it helps compilor to optimize and
/// inline when this api is used in other modules.
/// If this `@inlinable` marked method call any other method internally then that also needs to be marked
/// with `@inlinable` or `@usableFromInline` as per need.
///
/// Similar to `@inline`, `@inlinable` gives performance boost at the cost of binary size.
///
/// When `@inlinable` is used the function stays private.


// MARK: -----------------------------------------------------------------------
// MARK: Question 42
/// `What is meant by code obfuscation?`
///
/// `Obfuscate` means to make obscure, unclear, or unintelligible.
///
/// `Code Obfuscation` in software development world is a technique which makes code difficult to understand
/// or reverse engineer or to de-compile. It's primary goal is to prevent any unauthorized access to the code. It's
/// usually employed when code needs to be distributed like a commercial software or mobile apps etc.
///
/// Xcode as such doesn't provide any built-in way for code obfuscation, however third party options are available
/// like https://www.guardsquare.com/ixguard

// MARK: -----------------------------------------------------------------------
// MARK: Question 43


// MARK: -----------------------------------------------------------------------
// MARK: Question 44


// MARK: -----------------------------------------------------------------------
// MARK: Question 45


