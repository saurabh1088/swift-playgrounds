// Created by Saurabh Verma on 03/03/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

/**
 `URL Loading System & it's players`
 
 Below is discussion about Apple's URL loading system APIs and it's players.
 In a nutshell one creates a `URLSession` instances which is then used to create one or more `URLSessionTask`
 instances which can fetch and return some data, download or upload files. Session is configured using a `URLSessionConfiguration`
 object controlling ths behaviour in general.
 
 `URLSession`

 Usually an app may create one or more `URLSession` instances, which help in coordinating group of related
 data-transfer tasks. For e.g a web browser app might create one instance for each browser tab. A separate instance
 might be required for creating an ephemeral browsing session.

 So basically a `URLSession` instance is created (or more than one if needed). The instance gives capabilities(APIs)
 to perform tasks. All the tasks which a `URLSession` instance performs or will perform will share same a common
 configuration object. This configuration object is `URLSessionConfiguration`
 
 `URLSession` is the key object which one uses for sending requests and receiving responses.

 One can create different kinds of `URLSession` instances like :-

 - `URLSession` provides a singleton shared instance (`URLSession.shared`). This shared instance doesn’t have any configuration object so is not customisable but will serve a good starting point for simple use cases.
 - `URLSession` instance initialised and configured with a default `URLSessionConfiguration` object
 - `URLSession` instance initialised and configured with a ephemeral `URLSessionConfiguration` object
 - `URLSession` instance initialised and configured with a background `URLSessionConfiguration` object which allows background operations


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
 - Additional HTTP headers


 When `URLSession` instance is initialised, a `URLSessionConfiguration` object can be passed.
 This `URLSessionConfiguration` object `URLSession` will copy and further no changes can be made.
 This implies once a `URLSession` instance is configured for a `URLSessionConfiguration` then the
 only way to change configuration is to create a new `URLSession` instance. So the configuration object
 `URLSessionConfiguration` should be setup very carefully.
 
 `Delegates`
 `URLSession` has a `delegate` property to which any type conforming to `URLSessionDelegate` can
 be assigned. There are several other delegates as well which play some part in URL loading system.
 
 - `URLSessionDelegate`
    - `URLSessionTaskDelegate`
        - `URLSessionDataDelegate`
        - `URLSessionDownloadDelegate`
        - `URLSessionStreamDelegate`
        - `URLSessionWebSocketDelegate`
 
 
 `URLSessionTaskDelegate` inherits from `URLSessionDelegate`.
 `URLSessionDataDelegate`, `URLSessionDownloadDelegate`, `URLSessionStreamDelegate`
 & `URLSessionWebSocketDelegate` all inherit from `URLSessionTaskDelegate`

 */

import UIKit
import Foundation
import Combine
import PlaygroundSupport

// MARK: -----------------------------------------------------------------------
// MARK: Example 1 : URLSession instance options

func exampleURLSessionInstanceOptionsAndConfigurations() {
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

    print("Shared URLSession delegate property value is :: \(sharedSession.delegate)")
    
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
    /// This means all of these won't get saved to disk.
    /// `ephemeral` session will store all session related data to RAM
    /// However one can tell it to write contents of a URL to file.
    /// `ephemeral` sessions are great for private browsing. Size of cache being restricted due to RAM can potentially
    /// appear to reduce the performance.
    /// All session data for an `ephemeral` session is purged the moment session is invalidated. It is also get purged when
    /// app is terminated or system is experiencing memory pressure.
    let ephemeralConfiguration = URLSessionConfiguration.ephemeral
    let ephemeralURLSession = URLSession(configuration: ephemeralConfiguration)
}


// MARK: -----------------------------------------------------------------------
// MARK: Example 2 : URLSession using completion handler
class MySimpleNetworkingClass {
    static let shared = MySimpleNetworkingClass()
    private let session = URLSession.shared
    
    private init() {}
    
    func makeAPICallFor(request: URLRequest) {
        let task = session.dataTask(with: request) { data, response, error in
            if let receivedData = data,
               let dataToString = String(data: receivedData, encoding: .utf8) {
                print("Received data successfully :: \(dataToString)")
            } else if let error = error {
                print("iTunes search request failed with error :: \(error)")
            }
        }
        task.resume()
    }
}

func exampleURLSessionUsingCompletionHandler() {
    let apiURL = URL(string: "https://itunes.apple.com/search?term=jack+johnson&limit=1")!
    let request = URLRequest(url: apiURL)
    MySimpleNetworkingClass.shared.makeAPICallFor(request: request)
}

//TODO: Analyzing HTTP Traffic with Instruments
// https://developer.apple.com/documentation/foundation/url_loading_system/analyzing_http_traffic_with_instruments

// MARK: -----------------------------------------------------------------------
// MARK: Example 3 : Networking with URLSession and using a URLSessionDelegate
/// NOTE : It's important to not to use `URLSession's` completion handler APIs here else delegate method
/// won't get called.
class NetworkingService: NSObject {
    var session: URLSession?
    
    func setupUrlSession() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration,
                             delegate: self,
                             delegateQueue: nil)
    }
    
    func makeAPICall(with request: URLRequest) {
        let dataTask = session?.dataTask(with: request)
        dataTask?.delegate = self
        dataTask?.resume()
    }
}

extension NetworkingService: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("Received authentication challenge :: \(challenge.description)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("URLSessionTaskDelegate : urlSession task didComplete")
    }
}

extension NetworkingService: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("URLSessionDataDelegate : Received data :: \(String(data: data, encoding: .utf8)!)")
    }
}

func exampleURLSessionUsingURLSessionDelegate() {
    let apiURL = URL(string: "https://itunes.apple.com/search?term=jack+johnson&limit=1")!
    let request = URLRequest(url: apiURL)
    let service = NetworkingService()
    service.setupUrlSession()
    service.makeAPICall(with: request)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 4 : Using Combine
class NetworkingUsingCombine {
    let session = URLSession.shared
    var cancellables = Set<AnyCancellable>()
    
    func makeAPICall(with request: URLRequest) {
        session.dataTaskPublisher(for: request)
            .sink { completion in
                print("Data task publisher completed : \(completion)")
            } receiveValue: { data, response in
                print("Received value from data task publisher :")
                print(String(data: data, encoding: .utf8) as AnyObject)
            }
            .store(in: &cancellables)
    }
}

func exampleURLSessionUsingCombine() {
    let apiURL = URL(string: "https://itunes.apple.com/search?term=jack+johnson&limit=1")!
    let request = URLRequest(url: apiURL)
    let networking = NetworkingUsingCombine()
    networking.makeAPICall(with: request)
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 5 : Using async/await
class NetworkingUsingAsyncAwait {
    let session = URLSession.shared
    
    // If makeAPICall is not marked with async then compiler will cry with error :
    // 'async' call in a function that does not support concurrency
    func makeAPICall(with request: URLRequest) async throws {
        let (data, response) = try await session.data(for: request)
        print("Received response :: \(response)")
        print(String(data: data, encoding: .utf8) as AnyObject)
    }
}

func exampleURLSessionUsingAsyncAwait() {
    let apiURL = URL(string: "https://itunes.apple.com/search?term=jack+johnson&limit=1")!
    let request = URLRequest(url: apiURL)
    let serviceUsingAsyncAwait = NetworkingUsingAsyncAwait()
    Task {
        try await serviceUsingAsyncAwait.makeAPICall(with: request)
    }
}

// MARK: -----------------------------------------------------------------------
// MARK: Example 6 : URLSession with Authentication challenge

func exampleURLSessionWithAuthenticationChallenge() {
    let apiURL = URL(string: "https://chat.openai.com/chat")!
    let request = URLRequest(url: apiURL)
    let networkingService = NetworkingService()
    networkingService.setupUrlSession()
    networkingService.makeAPICall(with: request)
}

// Setup
//let apiURL = URL(string: "https://chat.openai.com/chat")!
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: -----------------------------------------------------------------------
// MARK: Example method calls

//exampleURLSessionInstanceOptionsAndConfigurations()
//exampleURLSessionUsingCompletionHandler()
//exampleURLSessionUsingURLSessionDelegate()
//exampleURLSessionUsingCombine()
//exampleURLSessionUsingAsyncAwait()
//exampleURLSessionWithAuthenticationChallenge()
