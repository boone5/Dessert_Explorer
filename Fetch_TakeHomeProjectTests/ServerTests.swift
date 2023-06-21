//
//  ServerTests.swift
//  Fetch_TakeHomeProjectTests
//
//  Created by Boone on 6/20/23.
//

import XCTest

@testable import Fetch_TakeHomeProject

class ServerTests: XCTestCase {
    var server: Server!

    override func setUp() {
        super.setUp()
        server = Server()
    }

    override func tearDown() {
        super.tearDown()
        server = nil
    }

    func testMakeRequest_ShouldReturnData_GetAllDesserts() async {
        do {
            let data = try await server.makeRequest(urlStr: APIEndpoint.getAllDesserts.path)

            XCTAssertNotNil(data)
        } catch {
            XCTFail("Test should not fail. Error: \(error)")
        }
    }

    func testMakeRequest_InvalidServerResponse() async throws {
        do {
            let data = try await server.makeRequest(urlStr: "")

            XCTAssertNil(data)
        } catch {
            let apiError = try XCTUnwrap(error as? APIError)
            XCTAssertEqual(apiError.description, "😡 Invalid server response: \(error)")
        }
    }
}
