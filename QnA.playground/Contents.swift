// Created by Saurabh Verma on 06/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import UIKit

/// `Question 1`
/// `What is the difference between the Float, Double, and CGFloat data types in Swift?`
///
/// CGFloat depends upon the CPU architecture. Which means if build is for 64 bit CPU then CGFloat is equivalent
/// to Double type and when build is for 32 bit CPU then CGFloat is equivalent to Float type.
/// In CGBase.h header a typedef is defined for the same based on architecture of CPU.
/// CGFloat even has a property `var native: CGFloat.NativeType` which tell its type (Double or Float)


/// `Question 2`
/// `What is the default data type Swift uses when you define a decimal number?`
///
/// Swift uses Double by default when it sees a decimal number without any explicit type defined for it.
/// Swift defaults to Double as Double is more accurate data type in comparison to Float.

let someNumber = 3.14
print("Default type of someNumber is :: \(type(of: someNumber))")

let explicitFloat: Float = 3.14
print("Type of explicitFloat is :: \(type(of: explicitFloat))")

/// `Question 3`
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

/// `Question 4`
/// `Can we check if code is running on main thread?`
///
/// Yes this can be checked using API `Thread.isMainThread` as shown in example below.

print("Is this running on main thread :: \(Thread.isMainThread)")
DispatchQueue.global(qos: .background).async {
    print("Is global dispatchqueue with background qos running on main thread :: \(Thread.isMainThread)")
}

/// `Question 5`
/// `How to execute some code on main thread?`
///
/// There are following ways to execute something on main thread.
/// 1. Using `DispatchQueue.main`, this is associated with main thread and any task dispatched to it will
/// get executed on main thread.

DispatchQueue.main.async {
    print("Does DispatchQueue.main executes this on main thread :: \(Thread.isMainThread)")
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

let object = SomeClass()
object.execute()

/// `Question 6`
/// `Take an array and give a resulting array with elements multiplied by a factor.`

let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
func byFactorOf(_ array: [Int], _ factor: Int) -> [Int] {
    return array.map { $0 * factor }
}
print(byFactorOf(array, 10))

/// `Question 7`
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

/// `Question 8`
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

/// `Question 9`
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


/// `Question 10`
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

/// `Question 11`
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
/// `Question 12`
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


/// `Question 13`
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


/// `Question 14`
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


/// `Question 15`
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


/// `Question 16`
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


/// `Question 17`
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

/// `Question 18`
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

/// `Question 19`
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

/// `Question 20`
/// `Does closures in Swift have retain count?`
///
/// YES
/// Closures are reference types so they have retain count. Reference types are objects that can be referenced
/// by other objects. When a closure is referenced by another object, the closure's retain count is incremented.
/// This means that the closure will not be deallocated until its retain count reaches zero.
/// This is the reason when self is captured in a closure then it can lead to memory leaks. Wheras self inside a
/// function doesn't causes any issues.

/// `Question 21`
/// `Does Implicitly Unwrapped Optionals in Swift have retain count?`

/// `Question 22`
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

/// `Question 23`
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

/// `Question 24`
/// `How many times does application(_:didFinishLaunchingWithOptions:) gets called?`
///
/// `application(_:didFinishLaunchingWithOptions:)` is called only once.


/// `Question 24`
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

/// `Question 25`
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
