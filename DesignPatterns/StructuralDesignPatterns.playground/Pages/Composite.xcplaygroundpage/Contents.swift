//: [Previous](@previous)

// Created by Saurabh Verma on 12/07/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Composite`
 Composite design pattern helps one create a tree-like structure of objects where both the individual objects and
 the compositions of objects can be accessed and manipulated in a consistent way.
 
 A composite design pattern usually consists of following players :
 
 1. Component
 Component here is an abstraction/protocol/interfact. This is common to both collections and individual objects.
 All the elements in the tree structure being implemented using composite design pattern should derive from this
 only.

 2. Primitive
 Primitives are individual objects in the tree structure which do not contain any child components.
 
 3. Composite
 Composite holds array or collection of components.
 
 So in `Composite` design pattern both Composite and Primitive will conform to Component.
 
 - Primitive
 
 */
import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
