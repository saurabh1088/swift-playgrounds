// Created by Saurabh Verma on 05/06/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 1. Swift file containing a single extension to a type Type, adding conformance to a protocol Protocol is named
 Type+Protocol.swift.
 
 2. Imports of whole modules are preferred to imports of individual declarations or submodules.
 
 3. In general practice is to have a source file contain only ONE top level type, exceptions to this can be when
 a type's smaller related helper types need to be defined.
 
 4. There is no hard and fast rule to order members in a file or type. However while ordering the members blindly
 adding to the bottom also doesn't makes much sense. Based on file and type a logical order which can work case
 by case basis could be followed. Also one should make use of grouping similar members using // MARK: comments.
 
 - // MARK: Helps not only to provide grouping but also gives Xcode to interpret and provide bookmark for quick
 access.
 
 5. One should ensure that there is a newline at the end of every file. This is required because

 - It's UNIX standard, as a text file under unix consists of series of lines each ending in newline character. A file
 that is not empty and does not end with a newline is therefore not a text file.
 - When last line isn't newline, then whenever any newline is added to the file it affects two lines instead of one.
 This causes confusion in versioning systems diff.
 - There can be utilities which work on text files which can cause unwanted behaviour if newline is not present.
 
 */
import UIKit
