// Created by Saurabh Verma on 09/05/23
// Copyright © 2023 Saurabh Verma, (saurabh1088@gmail.com). All rights reserved.

import UIKit

/**
 `Encoding, Decoding, and Serialization`
 
 `Serialization` is a  process of converting an object or data structure in memory to a format which then
 can be stored or transmitted, such as a file or network stream. Basically converting an object into a format so
 that it can be stored or transmittable all along should also be able to be able to put it back to it's old object form.
 
 `Serialization` helps in facilitating the persistence of data and also helps in communicating data between
 different systems.
 
 So in a nutshell one can say that `Serialization` helps achieve following in terms of Software Engineering
 
 1. Conversion of Object to Data
 2. Storage and Persistence
 3. Data Transmission
 4. Interoperability
 5. Compatibility
 6. Common Serialization Formats like JSON or XML
 
 `Encoding`
 Converting an object to a format(for e.g. JSON) which can be transmittable or can be stored on disk.
 
 `Decoding`
 Converting, for e.g. JSON back to an object represented by model.
 
 JSONSerialization and JSONEncoder are options for object Serialization in Swift. In JavaScript one can serialize
 object using JSON.stringify(object)
 */

/// `Serialization` & `Deserialisation` examples
/// Example 1 : JSON using `JSONSerialization`
/// `JSONSerialization` object helps to convert data between JSON and some equivalent Foundation object.

let EMPTY = String()
struct Employee: Codable, CustomStringConvertible {
    var id: Int
    var name: String
    var address: Address
    var description: String {
        return "Employee ID: \(id)\nName: \(name)\nAddress:\n\(address.description)"
    }
    
    func toJSON() -> [String: Any] {
        return ["id": self.id,
                "name": self.name,
                "address": self.address.toJSON()]
    }
}

struct Address: Codable, CustomStringConvertible {
    var houseNumber: String
    var streetName: String
    var city: String
    var description: String {
        return "House no: \(houseNumber)\nStreet: \(streetName)\nCity: \(city)"
    }
    
    func toJSON() -> [String: Any] {
        return ["houseNumber": self.houseNumber,
                "streetName": self.streetName,
                "city": self.city]
    }
}

let jsonString = """
{
   "id": 1,
   "name": "JSON Serialization",
   "address": {
      "streetName": "JSON",
      "city": "To Object",
      "houseNumber": "Converting"
   }
}
"""

let jsonData = jsonString.data(using: .utf8)!
do {
    if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
        let id = jsonObject["id"] as? Int
        let name = jsonObject["name"] as? String
        let address = jsonObject["address"] as? [String: Any]
        let streetName = address?["streetName"] as? String
        let city = address?["city"] as? String
        let houseNumber = address?["houseNumber"] as? String
        let employee = Employee(id: id ?? 0,
                                name: name ?? EMPTY,
                                address: Address(houseNumber: houseNumber ?? EMPTY,
                                                 streetName: streetName ?? EMPTY,
                                                 city: city ?? EMPTY))
        print(employee.description)
    }
} catch {
    print("Error occurred while deserializing JSON :: \(error.localizedDescription)")
}


let employeeToJSON = Employee(id: 2,
                              name: "JSON Deserialisation",
                              address: Address(houseNumber: "Converting",
                                               streetName: "Object",
                                               city: "To JSON String"))

do {
    let jsonData = try JSONSerialization.data(withJSONObject: employeeToJSON.toJSON(), options: [.prettyPrinted])
    let deserialisedString = String(data: jsonData, encoding: .utf8) as AnyObject
    print(deserialisedString)
    
} catch {
    print("Error occurred :: \(error.localizedDescription)")
}


let address = Address(houseNumber: "X-420", streetName: "Beverly Hills", city: "Razmatazz")
let employee = Employee(id: 1, name: "Bob Builder", address: address)

/// Using `JSONEncoder` here we are encoding an object of type `Employee` to a JSON
let data = try JSONEncoder().encode(employee)
print(String(data: data, encoding: .utf8) as AnyObject)

/// Using `JSONDecoder` here we are `decoding` a JSON to an object of type `Employee`
let decodedObject = try JSONDecoder().decode(Employee.self, from: jsonData)
decodedObject.description


struct Person: Codable, CustomStringConvertible {
    var name: String
    var age: Int
    var description: String {
        return "My name is \(name) and my age is \(age)yrs."
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case age
    }
}

let someJsonString = """
{
"full_name" : "Sanju Simon",
"age" : 69
}
"""
/// If in `someJsonString` instead of using `full_name` the key is used as `name` then we will get runtime
/// error while decoding.
/// Error : No value associated with key CodingKeys(stringValue: \"full_name\", intValue: nil) (\"full_name\").
let someJsonStringData = someJsonString.data(using: .utf8)!
let decodedPersonObject = try JSONDecoder().decode(Person.self, from: someJsonStringData)
print(decodedPersonObject.description)


/// Example
/// Here instead of using `CodingKey` we are using `keyDecodingStrategy` property of `JSONDecoder`
/// which when set to `convertFromSnakeCase` will automatically try to decode using strategy and map to
/// a snake case to it's equivalent camel case one.
/// In the example below we have the struct with property defined name in camel casing i.e. bodyType. However
/// in the JSON string someJsonStringWithDifferentKeys it's defined in snake case i.e. body_type
struct Vehicle: Codable, CustomStringConvertible {
    var bodyType: String
    var wheels: Int
    var description: String {
        return "I am a \(bodyType) and I have \(wheels) wheels."
    }
}

let someJsonStringWithDifferentKeys = """
{
"body_type" : "suv",
"wheels" : 4
}
"""

let jsonDecoder = JSONDecoder()
jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

let dataSomeJsonStringWithDifferentKeys = someJsonStringWithDifferentKeys.data(using: .utf8)!
let decodedVehicleObject = try jsonDecoder.decode(Vehicle.self, from: dataSomeJsonStringWithDifferentKeys)
print(decodedVehicleObject.description)


struct EncodedToSnakeCaseExample: Encodable {
    let somePropertyNameString: String
    let somePropertyNameInt: Int
}

let jsonEncoderSnakeCase = JSONEncoder()
jsonEncoderSnakeCase.keyEncodingStrategy = .convertToSnakeCase

let objEncodedToSnakeCaseExample = EncodedToSnakeCaseExample(somePropertyNameString: "value", somePropertyNameInt: 1)

let snakeCaseEncodedData = try jsonEncoderSnakeCase.encode(objEncodedToSnakeCaseExample)
print("snakeCaseEncodedData :: \(String(data: snakeCaseEncodedData, encoding: .utf8) as AnyObject)")

