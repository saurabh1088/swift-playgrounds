//: [Previous](@previous)

// Created by Saurabh Verma on 26/02/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 Linked list is a data structure used in software engineering which stores a collection of elements. This may sound
 like an array but there are fundamental differences. An array usually stores elements in a contiguous memory locations
 whereas linked lists has collections of elements which are connected via references.
 */
import Foundation
import XCTest

class Node<Value> {
    var value: Value
    var next: Node<Value>?
    
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

class LinkedList<Value> {
    var head: Node<Value>?
    
    func append(_ value: Value) {
        let node = Node(value: value)
        
        if let _ = head {
            // Only head is present in list, so there is no next element
            if head?.next == nil {
                head?.next = node
            } else {
                // Next element is present, need to find out the last element of list
                var someNode = head?.next
                while someNode?.next != nil {
                    someNode = someNode?.next
                }
                someNode?.next = node
            }
        } else {
            // There isn't any node added to linked list yet so set head here
            head = node
        }
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        var output = String()
        guard let root = head else { return "List is EMPTY!" }
        output = "\(output) \(root.value) ->"
        var currentNode = root.next
        while currentNode?.next != nil {
            if let value = currentNode?.value {
                output = "\(output) \(value) ->"
            }
            currentNode = currentNode?.next
        }
        if let value = currentNode?.value {
            output = "\(output) \(value)"
        }
        return output
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Unit Tests

class LinkedListTests: XCTestCase {
    
    func test_EmptyLinkedList() {
        let linkedList = LinkedList<Int>()
        XCTAssertNil(linkedList.head)
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example :

func exampleLinkedList() {
    let linkedList = LinkedList<String>()
    linkedList.append("Batman")
    linkedList.append("Wonder Woman")
    linkedList.append("Superman")
    linkedList.append("Flash")
    print(linkedList)
}

//exampleLinkedList()
LinkedListTests.defaultTestSuite.run()

//TODO: Add unit tests
//TODO: Check access level for methods and props
//TODO: Check for any missing funtionality
//: [Next](@next)
