//: [Previous](@previous)

// Created by Saurabh Verma on 26/02/24
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 Linked list is a data structure used in software engineering which stores a collection of elements. This may sound
 like an array but there are fundamental differences. An array usually stores elements in a contiguous memory locations
 whereas linked lists has collections of elements which are connected via references.
 */
import Foundation

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
        
        if head?.next == nil {
            // There isn't any node added to linked list yet
            head?.next = node
        } else {
            var someNode = head?.next
            while someNode?.next != nil {
                someNode = someNode?.next
            }
            someNode?.next = node
        }
    }
    
    func printList() {
        var currentNode = head
        while currentNode?.next != nil {
            print(currentNode?.value)
            currentNode = currentNode?.next
        }
    }
}

func exampleLinkedList() {
    let linkedList = LinkedList<String>()
    linkedList.append("Batman")
    linkedList.append("Wonder Woman")
    linkedList.append("Superman")
    linkedList.append("Flash")
    linkedList.printList()
}

exampleLinkedList()
//: [Next](@next)
