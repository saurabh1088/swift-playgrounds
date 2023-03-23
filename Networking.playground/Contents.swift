// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `URLSession`

 Usually an app may create one or more `URLSession` instances, which help in coordinating group of related
 data-transfer tasks. For e.g a web browser app might create one instance for each browser tab. A separate instance
 might be required for creating an ephemeral browsing session.

 So basically a `URLSession` instance is created (or more than one if needed). The instance gives capabilities(APIs)
 to perform tasks. All the tasks which a `URLSession` instance performs or will perform will share same a common
 configuration object. This configuration object is `URLSessionConfiguration`

 One can create different kinds of `URLSession` instances like :-

 - `URLSession` provides a singleton shared instance (`URLSession.shared`). This shared instance doesn’t have any configuration object so is not customisable but will serve a good starting point for simple use cases.
 - `URLSession` instance initialised and configured with a default `URLSessionConfiguration` object
 - `URLSession` instance initialised and configured with a ephemeral `URLSessionConfiguration` object
 - `URLSession` instance initialised and configured with a `URLSessionConfiguration` object which allows background operations


 Using a `URLSession` instance ultimately allows us to create tasks. These tasks eventually perform one of the below operations

 1. Data tasks
 - using `Data` objects
 - these are for short often interactive requests to a server
 2. Upload tasks
 - send data in form of file
 - support background uploads
 3. Download tasks
 - retrieve data in form of file
 - support background downloads and uploads
 4. Websocket task exchange


 `URLSessionDelegate`

 Tasks in a `URLSession` instance share a common delegate object i.e. `URLSessionDelegate`.
 `URLSessionDelegate` defines methods `URLSession` instance will call on it’s delegate to handle session-level events.
 `URLAuthenticationChallenge` is received as a part of `URLSessionDelegate`.
 `URLSession` instance can be created without a `URLSessionDelegate` as well.


 `URLSession` APIs are highly asynchronous. There are APIs available to use with following usual ways of asynchronous programming
 - async/await
 - completion handler
 - delegate callback


 `URLSessionConfiguration`

 `URLSessionConfiguration` object help defining the behaviour and policies when using a `URLSession`
 instance for networking. One can establish behaviour for example :
 - Caching policy
 - Timeouts
 - Supporting Multipath TCP - multipathServiceType


 When `URLSession` instance is initialised, a `URLSessionConfiguration` object can be passed.
 This `URLSessionConfiguration` object `URLSession` will copy and further no changes can be made.
 This implies once a `URLSession` instance is configured for a `URLSessionConfiguration` then the
 only way to change configuration is to create a new `URLSession` instance. So the configuration object
 `URLSessionConfiguration` should be setup very carefully.

 */

import UIKit

/// Creating a URLSession instance
/// Use `URLSession.shared` to create a shared instance.
/// Limitations of `URLSession.shared`
/// 1. One can't set any `URLSessionConfiguration` object to shared `URLSession` instance.
/// 2. One can't set any delegate i.e. `URLSessionDelegate`
/// 3. Background downloads or uploads can't be performed as those need to have a `URLSessionConfiguration`
/// configured for performing those operations.

let sharedSession = URLSession.shared

// #############################################################################

/// This will generate a compile issue stating
/// Cannot assign to property: 'configuration' is a get-only property
/// `configuration` property can only be injected to URLSession instance while initialisation
/// ```sharedSession.configuration = URLSessionConfiguration.default```

let defaultConfigurations = URLSessionConfiguration.default
let defaultConfigURLSession = URLSession(configuration: defaultConfigurations)
print("Default URLSessionConfiguration : allowsCellularAccess value is : \(defaultConfigurations.allowsCellularAccess)")

/// `defaultConfigurations` can be modified, for e.g. we can change the default value of `allowsCellularAccess`
defaultConfigurations.allowsCellularAccess = false
print("Updated URLSessionConfiguration : allowsCellularAccess value is : \(defaultConfigurations.allowsCellularAccess)")

/// However when `URLSession` is instantiated with a `URLSessionConfiguration` then the configuration
/// object gets copied so now after intantiation any changes made to `URLSessionConfiguration` will not
/// change the `URLSession` configurations.
/// Now ONLY way would be to instantiate a NEW `URLSession` object.
print("allowsCellularAccess value for our defaultConfigURLSession : \(defaultConfigURLSession.configuration.allowsCellularAccess)")

// #############################################################################

/// `URLSessionConfiguration ephemeral`
/// `ephemeral` configuration uses no persistent storage for caches, cookies or credentials.
/// This means all this won't get saved to disk.
/// `ephemeral` session will store all session related data to RAM
/// However one can tell it to write contents of a URL to file.
/// `ephemeral` sessions are great for private browsing. Size of cache being restricted due to RAM can potentially
/// appear to be reduced performance.
/// All session data for an `ephemeral` session is purged the moment session is invalidated. It is alsp purged when
/// app is terminated or system is experiencing memory pressure.
let ephemeralConfiguration = URLSessionConfiguration.ephemeral
let ephemeralURLSession = URLSession(configuration: ephemeralConfiguration)
