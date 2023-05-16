// Created by Saurabh Verma on 16/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `Concurrency`
 
 `Concurrency` refers to ability of performing multiple tasks run at same time, not necessarily starting and
 running at the same instant, but definately should be making progress simultaneously, may or may not finish
 together as well.
 `Concurrency` helps modern day programming languages to fully capitalise the available respurces from
 modern hardware which are having enoromous computing power. So it helps to utilise available resources and
 execute multiple tasks concurrently.
 
 `Parallelism`
 When multiple tasks are executed at same time then we say it is as Parallelism.
 
 In iOS following are tools to achieve concurrency :
 - `Grand Central Dispatch (GCD)`
 - `OperationQueues`
 - `async/await`
 
 When one talks about concurrency, it's natural to think about threads.
 `Concurrency` model in Swift is build on top of threads, however one doesn't interacts with threads directly.
 
 */
