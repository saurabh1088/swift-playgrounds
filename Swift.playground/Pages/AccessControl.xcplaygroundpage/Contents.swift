//: [Previous](@previous)

// Created by Saurabh Verma on 12/04/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Access Control`
 
 1. Open
 2. Public
 3. Internal
 4. File-private
 5. Private
 
 */
import Foundation

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : Usage of private type
/// In the example below we have a class Tree which provides some funtionality where one can check the number
/// of branches the tree has and a funtion to make tree grow incrementally. The consumer of this Tree API doesn't
/// need to know the data structure of Branch so instead of defining the class Branch outside of Tree, one can
/// define it as a private inner class, off course if we know for sure Branch is not going to be needed anywhere else.
class Tree {
    private var branches = [Branch]()
    
    var numberOfBranches: Int {
        branches.count
    }
    
    func grow() {
        branches.append(Branch(value: "value_\(numberOfBranches)"))
    }
    
    func showGrowth() {
        for branch in branches {
            print(branch.value)
        }
    }
    
    private class Branch {
        let value: String
        
        init(value: String) {
            self.value = value
        }
    }
}

func exampleAccessControlOne() {
    let myTree = Tree()
    myTree.grow()
    myTree.grow()
    myTree.grow()
    myTree.showGrowth()
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : Override can make inherited member more accessible
public class SuperClass {
    fileprivate func someSuperFunction() {
        print("I am super function but fileprivate")
    }
}

public class SubClass: SuperClass {
    override public func someSuperFunction() {
        print("I am subclass funtion but public")
    }
}

exampleAccessControlOne()

//: [Next](@next)
