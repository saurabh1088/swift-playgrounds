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
        print("That's it, just create and give a closure.")
        print("This is printed from a Task")
        print("A task runs immediately after it is created.")
        print("One doesn't need to call any api to get it executed")
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
// MARK: Example 5 :
func exampleMultipleTasksDefaultBehaviour() {
    Task {
        for index in 1...5 {
            print("This is task number : 1")
        }
    }
    Task {
        for index in 1...5 {
            print("This is task number : 2")
        }
    }
    Task {
        for index in 1...5 {
            print("This is task number : 3")
        }
    }
    Task {
        for index in 1...5 {
            print("This is task number : 4")
        }
    }
    Task {
        for index in 1...5 {
            print("This is task number : 5")
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 6 :
func exampleMultipleTasksSerialBehaviour() {
    Task {
        await Task {
            for index in 1...5 {
                print("This is task number : 1")
            }
        }.value
        await Task {
            for index in 1...5 {
                print("This is task number : 2")
            }
        }.value
        await Task {
            for index in 1...5 {
                print("This is task number : 3")
            }
        }.value
        await Task {
            for index in 1...5 {
                print("This is task number : 4")
            }
        }.value
        await Task {
            for index in 1...5 {
                print("This is task number : 5")
            }
        }.value
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 7 :
func exampleTaskWithPriority() {
    Task(priority: .background) {
        print("Priority of task is .background")
        for _ in 1...5 {
            print("Background Task Working...")
        }
    }
    Task(priority: .userInitiated) {
        print("Priority of task is .userInitiated")
        for _ in 1...5 {
            print("User Initiated Task Working...")
        }
    }
    Task(priority: .utility) {
        print("Priority of task is .utility")
        for _ in 1...5 {
            print("Utility Task Working...")
        }
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 8 : Task Group (Structured Concurrency)
func exampleTaskGroup() {
    Task {
        print("Starting Task Group Example...")
        var collectedResults = [String]()
        
        await withTaskGroup(of: String.self, body: { group in
            group.addTask {
                print("Starting Task A...")
                try? await Task.sleep(for: .seconds(2))
                return "Result from Task A"
            }
            group.addTask {
                print("Starting Task B...")
                try? await Task.sleep(for: .seconds(2))
                return "Result from Task B"
            }
            group.addTask {
                print("Starting Task C...")
                try? await Task.sleep(for: .seconds(2))
                return "Result from Task C"
            }
            
            /// The for await loop collects results as they become available, not necessarily in the order tasks were added.
            /// The await withTaskGroup ensures all tasks in the group complete before the block finishes.
            for await result in group {
                collectedResults.append(result)
            }
        })
        
        print("All tasks in group completed. Results: \(collectedResults.sorted())")
        print("Task Group Example Finished.")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 9 : Task Group with Error Handling and Cancellation
enum SomeError: Error {
    case failedToFetch(String)
    case cancelled
}

func exampleTaskGroupWithErrorAndCancellation() {
    Task {
        print("Starting Task Group with Error and Cancellation Example...")
        do {
            let finalResult = try await withThrowingTaskGroup(of: String.self) { group in
                group.addTask {
                    print("Child Task 1: Starting long operation...")
                    try await Task.sleep(for: .seconds(4)) // This task will be cancelled
                    try Task.checkCancellation() // Will throw here
                    return "Result from Task 1"
                }

                group.addTask {
                    print("Child Task 2: Starting short operation...")
                    try await Task.sleep(for: .seconds(1))
                    return "Result from Task 2"
                }

                group.addTask {
                    print("Child Task 3: Simulating a failure...")
                    try await Task.sleep(for: .seconds(2))
                    throw SomeError.failedToFetch("Data for Task 3")
                }

                // Cancel the group after a short delay
                try await Task.sleep(for: .seconds(1.5))
                print("Cancelling Task Group...")
                group.cancelAll() // Propagates cancellation to all child tasks

                var results: [String] = []
                for try await result in group {
                    results.append(result)
                }
                return "Collected: \(results.sorted().joined(separator: ", "))"
            }
            print("Task Group Succeeded: \(finalResult)")
        } catch {
            print("Task Group Failed with error: \(error.localizedDescription)")
            if let myError = error as? SomeError {
                switch myError {
                case .failedToFetch(let msg): print("Specific error: \(msg)")
                case .cancelled: print("Specific error: Task Group was cancelled.")
                }
            } else if error is CancellationError {
                print("Specific error: A task within the group was cancelled.")
            }
        }
        print("Task Group with Error and Cancellation Example Finished.")
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 10 : Task.detached (Unstructured Concurrency)

// TODO: Fix this
/*
func exampleDetachedTask() {
    print("🚀 Starting Detached Task Example...")

    let parentTask = Task {
        print("👨‍👧 Parent Task: Starting...")

        let detachedTask = Task.detached {
            print("🔗 Detached Task: Starting long operation...")
            for i in 1...5 {
                try? await Task.sleep(for: .seconds(1))
                print("🔗 Detached Task: Working \(i)")

                if Task.isCancelled {
                    print("🔗 Detached Task: Detected cancellation.")
                    try? Task.checkCancellation() // Optional: force throw on cancellation
                }
            }
            print("🔗 Detached Task: Finished.")
            return "Detached Result"
        }

        // ✅ Correct way to cancel: hold a reference to parentTask and cancel it externally
        // Schedule cancellation after delay using another Task
        Task {
            try await Task.sleep(for: .seconds(2.5))
            print("❌ Cancelling Parent Task...")
            parentTask.cancel()  // ✅ Correct: cancel by calling `.cancel()` on the Task instance
        }

        do {
            let result = await detachedTask.value
            print("👨‍👧 Parent Task: Awaited detached task result: \(result)")
        } catch {
            print("👨‍👧 Parent Task: Error awaiting detached task: \(error.localizedDescription)")
        }

        print("👨‍👧 Parent Task: Finished.")
    }

    // Optional: you can also cancel from outside:
    // parentTask.cancel()
}
*/


// MARK: -----------------------------------------------------------------------
// MARK: Examples

//exampleSimpleTask()
//exampleTaskWithReturnValue()
//exampleTaskWithSomeOperationAndReturnValuePostThat()
//exampleTaskLongRunningWithCheckForCancellation()
//exampleMultipleTasksDefaultBehaviour()
//exampleMultipleTasksSerialBehaviour()
//exampleTaskWithPriority()
//exampleTaskGroup()
//exampleTaskGroupWithErrorAndCancellation()

//: [Next](@next)
