//: [Previous](@previous)

// Created by Saurabh Verma on 22/04/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Task`
 
 Task as pe Apple's official documentation is a unit of asynchronous work.
 
 `How do one runs a Task?`
 
 A task runs immediately after it is created and one doesn't need to call any api to get it executed.
 
 The closure given to Task is marked as async as one can see in the definition of Task initialisers.
 
 `Can Task be cancelled?`
 
 Yes, a task can be cancelled, but the responsibility lies with the code running as part of Task itself to check if it's
 cancelled.
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Simple Task
func exampleSimpleTask() {
    Task {
        print("This is printed from a Task")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Task returning some value
func exampleTaskWithReturnValue() {
    let whatIsMyNameTask = Task {
        return "Batman"
    }
    
    Task {
        let value = await whatIsMyNameTask.value
        print(value)
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Task performing some operation and then returning value
func exampleTaskWithSomeOperationAndReturnValuePostThat() {
    let justiceLeague = Task {
        var justiceLeague = [String]()
        print("Recruiting Superman.")
        for index in 1...5 {
            print("\(index)...")
            sleep(1)
        }
        justiceLeague.append("Superman")
        
        print("Recruiting Wonder Woman.")
        for index in 1...5 {
            print("\(index)...")
            sleep(1)
        }
        justiceLeague.append("Wonder Woman")
        
        return justiceLeague
    }
    
    Task {
        let justiceLeagueRecruitedMembers = await justiceLeague.value
        print("Recruited members :: \(justiceLeagueRecruitedMembers)")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 :
func exampleTaskLongRunningWithCheckForCancellation() {
    let someLongRunningTask = Task {
        for index in 1...100 {
            do {
                try Task.checkCancellation()
                print("Performing a long runnig task...")
                print("% Completion : \(index)%")
                try await Task.sleep(for: .seconds(1))
            } catch {
                print("Task is cancelled")
                break
            }
        }
    }
    
    Task {
        Task {
            try await Task.sleep(for: .seconds(5))
            someLongRunningTask.cancel()
        }
        await someLongRunningTask.value
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleSimpleTask()
//exampleTaskWithReturnValue()
//exampleTaskWithSomeOperationAndReturnValuePostThat()
//exampleTaskLongRunningWithCheckForCancellation()

//: [Next](@next)
