//
//  DessertDetailViewModelTests.swift
//  Fetch_TakeHomeProjectTests
//
//  Created by Boone on 6/21/23.
//

import XCTest

@testable import Fetch_TakeHomeProject

final class DessertDetailViewModelTests: XCTestCase {
    private var viewModel: DessertDetailViewModel!
    private var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        self.mockNetworkManager = MockNetworkManager()
        let dessert = Dessert()
        self.viewModel = DessertDetailViewModel(details: dessert, networkManager: mockNetworkManager)
    }

    override func tearDown() {
        self.viewModel = nil
    }

    func testCreateDessert() async {
        let data = """
            {
                "meals": [
                    {
                        "strMeal": "Dessert 1",
                        "strInstructions": "Instructions"
                    }
                ]
            }
            """.data(using: .utf8)!

        mockNetworkManager.data = data

        await viewModel.loadDessert("")

        XCTAssertTrue(mockNetworkManager.fetchEndpointWasCalled)
        XCTAssertEqual(viewModel.details, Dessert(name: "Dessert 1", instructions: "Instructions"))
        XCTAssertTrue(viewModel.isLoaded)
    }

    func testCreateDessert_ShouldThrowInvalidFormat() async {
        let data = """
            {
                "meals": [

                ]
            }
            """.data(using: .utf8)!

        mockNetworkManager.data = data

        await viewModel.loadDessert("")

        XCTAssertTrue(mockNetworkManager.fetchEndpointWasCalled)
        XCTAssertEqual(viewModel.details, Dessert())
        XCTAssertFalse(viewModel.isLoaded)
    }

    func testFormatInstructions() async {
        let data = """
            {
                "meals": [
                    {
                    "strInstructions": "\\rInstructions\\r\\n\\r\\n"
                    }
                ]
            }
            """.data(using: .utf8)!

        mockNetworkManager.data = data

        await viewModel.loadDessert("")

        XCTAssertTrue(mockNetworkManager.fetchEndpointWasCalled)
        XCTAssertEqual(viewModel.details, Dessert(instructions: "\rInstructions"))
        XCTAssertTrue(viewModel.isLoaded)
    }

    func testFormatInstructions_null() async {
        let data = """
            {
                "meals": [
                    {
                    "strInstructions": null
                    }
                ]
            }
            """.data(using: .utf8)!

        mockNetworkManager.data = data

        await viewModel.loadDessert("")

        XCTAssertTrue(mockNetworkManager.fetchEndpointWasCalled)
        XCTAssertEqual(viewModel.details, Dessert())
        XCTAssertTrue(viewModel.isLoaded)
    }
}
