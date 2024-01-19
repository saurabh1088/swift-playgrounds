//: [Previous](@previous)

// Created by Saurabh Verma on 03/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `SOLID Design Principles`
 
 Introduced by Robert C Martin (Uncle Bob)
 
 `Single Responsibility Principle`
 
 A class should have only one reason to change.
 Separation of concern.
 
 A class should have ONLY one reason to change. This means that a class should only have single responsibility
 or a single purpose for it's existence.
 This ensures classes created in s system are well defined and maintainable. If a class has only single responsibility
 it would be easier to maintain and debug it in event of future issues/changes.
 
 A class should encapsulate ONLY one aspect of application's functionality. If if does have more than one reason
 to change, then it should be split into multiple classes.
 */

import Foundation

/// This class `Journal` is having a single responsibility which is to represent a journal. A journal can have
/// zero or more entries, one should be able to add and remove a journal entry and that's all.
class Journal: CustomStringConvertible {
    var entries = [String]()
    var count = 0
    
    var description: String {
        return entries.joined(separator: "\n")
    }
    
    func addEntry(_ entry: String) {
        count += 1
        entries.append(entry)
    }
    
    func removeEntry(at index: Int) {
        entries.remove(at: index)
        count -= 1
    }
}

/// Now suppose while we wanted to write a journal, we also wanted persistence. So we want our journal and
/// it's entries to be persisted in a disk so that it could be retrieved offline as well.
/// One might be tempted to modify `Journal` class itself and add functionality to save journal entry to a
/// persistence store, like below.

/**
 `SINGLE RESPONSIBILITY PRINCIPLE VIOLATION`
 
 extension Journal {
     func saveJournalToPersistentStore() {
         print("Journal saved to persistent store")
     }
 }
 */

/// Above code to add a new function to `Journal` to save it to a persistent store is perfectly fine and will
/// serve the purpose. HOWEVER IT VIOLATES SINGLE RESPONSIBILITY PRINCIPLE.
///
/// This requirement for persistance should be better serve by introducing a new class to handle persistence
/// related functionality.
///
/// So now `Persist` is introduced which has a Single Responsibility for saving some data to some persistent store.
/// Now the end client using these APIs to store some journals into a persistent store need to create some journals
/// and then when those need to be persisted, instance of Persist can be used to perform the same instead of
/// previous implementation where the journal instances itself would have been needed to call and save to persistent
/// store.
/// This makes `Journal` and `Persist` independent and maintaining single responsibilities.
protocol Persistable {}
extension Journal: Persistable {}

class Persist {
    func saveToPersistentStore(data: Persistable) {
        print("Data saved to persistent store")
    }
}


//: [Next](@next)
