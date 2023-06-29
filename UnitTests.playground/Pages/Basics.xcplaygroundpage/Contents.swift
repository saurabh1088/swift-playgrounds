//: [Previous](@previous)

import Foundation
import XCTest

enum Gender: Codable {
    case male
    case female
}

struct Employee: Codable {
    var firstName: String
    var middleName: String?
    var lastName: String
    var gender: Gender
}

class EmployeeViewModel {
    var employee: Employee
    
    init(employee: Employee) {
        self.employee = employee
    }
    
    var name: String {
        if let midName = employee.middleName {
            return "\(salutation) \(employee.firstName) \(midName) \(employee.lastName)"
        } else {
            return "\(salutation) \(employee.firstName) \(employee.lastName)"
        }
    }
    
    var salutation: String {
        return employee.gender == .female ? "Miss" : "Mr."
    }
}

class EmployeeViewModelTests: XCTestCase {
    
    var viewModel: EmployeeViewModel?
    var employee: Employee?
    
    override class func setUp() {
        print("DEBUG :: EmployeeViewModelTests :: override class func setUp()")
    }
    
    override func setUp() async throws {
        print("DEBUG :: EmployeeViewModelTests :: override func setUp() async throws")
    }
    
    override func setUpWithError() throws {
        print("DEBUG :: EmployeeViewModelTests :: override func setUpWithError() throws")
    }
    
    override func setUp() {
        print("DEBUG :: EmployeeViewModelTests :: override func setUp()")
    }
    
    func test_EmployeeViewModelFullName_WithMiddleName() {
        let employee = Employee(firstName: "Kumar",
                                middleName: "Shumar",
                                lastName: "Khumar",
                                gender: .male)
        let viewModel = EmployeeViewModel(employee: employee)
        
        XCTAssertEqual("Mr. Kumar Shumar Khumar",
                       viewModel.name,
                       "Test failed while calculating full name")
    }
    
    func test_EmployeeViewModelFullName_WithoutMiddleName() {
        let employee = Employee(firstName: "Vani", lastName: "Bani", gender: .female)
        let viewModel = EmployeeViewModel(employee: employee)
        
        XCTAssertEqual("Miss Vani Bani", viewModel.name)
    }
    
    override func tearDown() {
        print("DEBUG :: EmployeeViewModelTests :: override func tearDown()")
    }
    
    override func tearDownWithError() throws {
        print("DEBUG :: EmployeeViewModelTests :: override func tearDownWithError() throws")
    }
    
    override func tearDown() async throws {
        print("DEBUG :: EmployeeViewModelTests :: override func tearDown() async throws")
    }
    
    override class func tearDown() {
        print("DEBUG :: EmployeeViewModelTests :: override class func tearDown()")
    }
    
}

EmployeeViewModelTests.defaultTestSuite.run()
//: [Next](@next)
