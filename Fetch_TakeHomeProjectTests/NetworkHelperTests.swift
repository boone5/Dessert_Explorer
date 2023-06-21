//
//  NetworkHelperTests.swift
//  Fetch_TakeHomeProjectTests
//
//  Created by Boone on 6/20/23.
//

import XCTest

@testable import Fetch_TakeHomeProject

class NetworkHelperTests: XCTestCase {
    var networkHelper: NetworkHelper!

    override func setUp() {
        super.setUp()
        networkHelper = NetworkHelper()
    }

    override func tearDown() {
        networkHelper = nil
        super.tearDown()
    }

    func testConvertToJSON_ShouldReturnArrayOfJSONObjects() {
        let data = """
            {
                "meals": [
                    {
                        "id": "1",
                        "name": "Dessert 1"
                    },
                    {
                        "id": "2",
                        "name": "Dessert 2"
                    }
                ]
            }
            """.data(using: .utf8)!

        do {
            let jsonArray = try NetworkHelper.convertToJSON(from: data)

            XCTAssertEqual(jsonArray.count, 2)

            if let firstDessert = jsonArray.first {
                XCTAssertEqual(firstDessert["id"] as? String, "1")
                XCTAssertEqual(firstDessert["name"] as? String, "Dessert 1")
            } else {
                XCTFail("Invalid JSON Format")
            }

            if let lastDessert = jsonArray.last {
                XCTAssertEqual(lastDessert["id"] as? String, "2")
                XCTAssertEqual(lastDessert["name"] as? String, "Dessert 2")
            } else {
                XCTFail("Invalid JSON Format")
            }
        } catch {
            XCTFail("Test should not fail. Error: \(error)")
        }
    }

    func testConvertToJSON_ShouldThrowDecodingError() {
        let invalidData = Data()

        XCTAssertThrowsError(try NetworkHelper.convertToJSON(from: invalidData), "Expected decoding error!") { error in
            if let error = error as? APIError {
                XCTAssertEqual(error.description, "Invalid server response: \(error)")
            }
        }
    }

    func testConvertToJSON_ShouldThrowInvalidFormat_InvalidKey() {
        let invalidData = """
            {
                "meal": [
                    {
                        "id": "1",
                        "name": "Dessert 1"
                    },
                    {
                        "id": "2",
                        "name": "Dessert 2"
                    }
                ]
            }
            """.data(using: .utf8)!

        XCTAssertThrowsError(try NetworkHelper.convertToJSON(from: invalidData), "Expected invalid format error!") { error in
            if let error = error as? APIError {
                XCTAssertEqual(error.description, "Invalid server response: \(error)")
            }
        }
    }

    func testConvertToJSON_ShouldThrowInvalidFormat_InvalidObject() {
        let invalidData = """
            {
                "id": "1",
                "name": "Dessert 1"
            }
            """.data(using: .utf8)!

        XCTAssertThrowsError(try NetworkHelper.convertToJSON(from: invalidData), "Expected invalid format error!") { error in
            if let error = error as? APIError {
                XCTAssertEqual(error.description, "Invalid server response: \(error)")
            }
        }
    }

    func testAddProperties() {
        var dessert = Dessert()

        let json = """
            {
                "strIngredient1": "test1",
                "strIngredient2": "test2",
                "strMeasure1": "test3",
                "strMeasure2": "test4"
            }
            """.data(using: .utf8)!

        do {
            // We do this just to get it in a type our function will accept. 
            let jsonDict = try XCTUnwrap(JSONSerialization.jsonObject(with: json, options: []) as? [String: Any])

            NetworkHelper.addProperties(to: &dessert, with: jsonDict)

            XCTAssertEqual(dessert.ingredients?.first?.name, "test1")
            XCTAssertEqual(dessert.ingredients?.last?.name, "test2")
            XCTAssertEqual(dessert.measurements?.first?.name, "test3")
            XCTAssertEqual(dessert.measurements?.last?.name, "test4")

        } catch {
            XCTFail("Test should not fail. Error: \(error)")
        }
    }

    // We want to omit null values.
    func testAddProperties_nullValues() {
        var dessert = Dessert()

        let json = """
            {
                "strIngredient1": "test1",
                "strIngredient2": null,
                "strMeasure1": "test3",
                "strMeasure2": null
            }
            """.data(using: .utf8)!

        do {
            // We do this just to get it in a type our function will accept.
            let jsonDict = try XCTUnwrap(JSONSerialization.jsonObject(with: json, options: []) as? [String: Any])

            NetworkHelper.addProperties(to: &dessert, with: jsonDict)

            XCTAssertEqual(dessert.ingredients?.count, 1)
            XCTAssertEqual(dessert.ingredients?.first?.name, "test1")
            XCTAssertEqual(dessert.measurements?.count, 1)
            XCTAssertEqual(dessert.measurements?.first?.name, "test3")

        } catch {
            XCTFail("Test should not fail. Error: \(error)")
        }
    }

    // We want to omit empty strings.
    func testAddProperties_emptyString() {
        var dessert = Dessert()

        let json = """
            {
                "strIngredient1": "test1",
                "strIngredient2": "",
                "strMeasure1": "test3",
                "strMeasure2": ""
            }
            """.data(using: .utf8)!

        do {
            // We do this just to get it in a type our function will accept.
            let jsonDict = try XCTUnwrap(JSONSerialization.jsonObject(with: json, options: []) as? [String: Any])

            NetworkHelper.addProperties(to: &dessert, with: jsonDict)

            XCTAssertEqual(dessert.ingredients?.count, 1)
            XCTAssertEqual(dessert.ingredients?.first?.name, "test1")
            XCTAssertEqual(dessert.measurements?.count, 1)
            XCTAssertEqual(dessert.measurements?.first?.name, "test3")

        } catch {
            XCTFail("Test should not fail. Error: \(error)")
        }
    }

    // I noticed some values returned a space rather than an empty string. This test makes sure thats covered.
    func testAddProperties_stringContainsSpace() {
        var dessert = Dessert()

        let json = """
            {
                "strIngredient1": "test1",
                "strIngredient2": " ",
                "strMeasure1": "test3",
                "strMeasure2": " "
            }
            """.data(using: .utf8)!

        do {
            // We do this just to get it in a type our function will accept. 
            let jsonDict = try XCTUnwrap(JSONSerialization.jsonObject(with: json, options: []) as? [String: Any])

            NetworkHelper.addProperties(to: &dessert, with: jsonDict)

            XCTAssertEqual(dessert.ingredients?.count, 1)
            XCTAssertEqual(dessert.ingredients?.first?.name, "test1")
            XCTAssertEqual(dessert.measurements?.count, 1)
            XCTAssertEqual(dessert.measurements?.first?.name, "test3")

        } catch {
            XCTFail("Test should not fail. Error: \(error)")
        }
    }

    func testAddProperties_InvalidKey() {
        var dessert = Dessert()

        let json = """
            {
                "strIngredient": "test1",
                "strIngredien": " ",
                "strMeasure": "test3",
                "strMeasur": " "
            }
            """.data(using: .utf8)!

        do {
            // We do this just to get it in a type our function will accept.
            let jsonDict = try XCTUnwrap(JSONSerialization.jsonObject(with: json, options: []) as? [String: Any])

            NetworkHelper.addProperties(to: &dessert, with: jsonDict)

            XCTAssertEqual(dessert.ingredients?.count, 0)
            XCTAssertEqual(dessert.measurements?.count, 0)

        } catch {
            XCTFail("Test should not fail. Error: \(error)")
        }
    }
}
