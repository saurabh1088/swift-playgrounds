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

class Node<Value: Equatable> {
    var value: Value
    var next: Node<Value>?
    
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

protocol LinkedListProvider {
    associatedtype Value: Equatable
    var head: Node<Value>? { get set }
    func append(_ value: Value)
    func count() -> Int
    func remove(_ value: Value)
}

class LinkedList<Value: Equatable>: LinkedListProvider {
    var head: Node<Value>?
}

extension LinkedList {
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

extension LinkedList {
    func remove(_ value: Value) {
        // If the value to be removed itself is the head, then make next value as head
        if head?.value == value {
            head = head?.next
        } else {
            var node = head?.next
            var previousNode: Node<Value>?
            while node?.next != nil && node?.value != value {
                previousNode = node
                node = node?.next
            }
            
            if node?.value == value {
                if node?.next != nil {
                    previousNode?.next = node?.next
                } else {
                    previousNode?.next = nil
                }
            }
        }
    }
}

extension LinkedList {
    func count() -> Int {
        var numberOfValues = 0
        
        // If head itself is nil, there are 0 elements in linked list
        guard let headNode = head else { return numberOfValues }
        guard headNode.next != nil else {
            numberOfValues += 1
            return numberOfValues
        }
        
        var node: Node<Value>? = headNode
        while node?.next != nil {
            numberOfValues += 1
            node = node?.next
        }
        return numberOfValues
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
    
    func test_EmptyLinkedListCount() {
        let emptyLinkedList = LinkedList<Int>()
        XCTAssertEqual(0, emptyLinkedList.count())
    }
    
    func test_linkedListAppend() {
        let linkedList = LinkedList<String>()
        linkedList.append("One")
        XCTAssertNotNil(linkedList.head)
        XCTAssertNil(linkedList.head?.next)
        XCTAssertEqual(1, linkedList.count())
    }
    
    func test_linkedListAppendMultipleItems() {
        let linkedList = LinkedList<Int>()
        linkedList.append(1)
        linkedList.append(2)
        linkedList.append(3)
        XCTAssertEqual(2, linkedList.count())
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example :

func exampleCreateAndAppendToLinkedList() {
    let linkedList = LinkedList<String>()
    linkedList.append("Batman")
    linkedList.append("Wonder Woman")
    linkedList.append("Superman")
    linkedList.append("Flash")
    print(linkedList)
}

func exampleRemoveHeadFromLinkedList() {
    let linkedList = LinkedList<Int>()
    linkedList.append(30)
    linkedList.append(13)
    linkedList.append(22)
    linkedList.append(2)
    
    print("Complete linked list")
    print(linkedList)
    
    print("Remove head")
    linkedList.remove(30)
    print(linkedList)
}

func exampleRemoveLastFromLinkedList() {
    let linkedList = LinkedList<Int>()
    linkedList.append(30)
    linkedList.append(13)
    linkedList.append(22)
    linkedList.append(2)
    
    print("Complete linked list")
    print(linkedList)
    
    print("Remove last")
    linkedList.remove(2)
    print(linkedList)
}

func exampleRemoveInBetweenFromLinkedList() {
    let linkedList = LinkedList<Int>()
    linkedList.append(30)
    linkedList.append(13)
    linkedList.append(22)
    linkedList.append(2)
    
    print("Complete linked list")
    print(linkedList)
    
    print("Remove in between")
    linkedList.remove(22)
    print(linkedList)
}

// MARK: -----------------------------------------------------------------------
// MARK: Examples
//exampleCreateAndAppendToLinkedList()
//exampleRemoveHeadFromLinkedList()
//exampleRemoveLastFromLinkedList()
//exampleRemoveInBetweenFromLinkedList()

// MARK: -----------------------------------------------------------------------
// MARK: Unit Tests
LinkedListTests.defaultTestSuite.run()

//TODO: Add unit tests
//TODO: Check access level for methods and props
//TODO: Check for any missing funtionality
//: [Next](@next)
