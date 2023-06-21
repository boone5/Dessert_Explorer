//
//  DessertViewModelTests.swift
//  Fetch_TakeHomeProjectTests
//
//  Created by Boone on 6/21/23.
//

import XCTest

@testable import Fetch_TakeHomeProject

final class DessertViewModelTests: XCTestCase {
    private var viewModel: DessertViewModel!
    private var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        self.mockNetworkManager = MockNetworkManager()
        let dessert = [Dessert()]
        self.viewModel = DessertViewModel(desserts: dessert, networkManager: mockNetworkManager)
    }

    override func tearDown() {
        super.tearDown()
        self.viewModel = nil
        self.mockNetworkManager = nil
    }

    func testCreateDessertList() async {
        let data = """
            {
                "meals": [
                    {
                        "strMeal": "Dessert 1",
                        "idMeal": "1",
                        "strMealThumb": "fakeThumbnail1"
                    },
                    {
                        "strMeal": "Dessert 2",
                        "idMeal": "2",
                        "strMealThumb": "fakeThumbnail2"
                    }
                ]
            }
            """.data(using: .utf8)!

        mockNetworkManager.data = data

        await viewModel.loadDesserts()

        XCTAssertTrue(mockNetworkManager.fetchEndpointWasCalled)
        XCTAssertEqual(viewModel.desserts[0], Dessert(id: "1", name: "Dessert 1", thumbnailImage: "fakeThumbnail1"))
        XCTAssertEqual(viewModel.desserts[1], Dessert(id: "2", name: "Dessert 2", thumbnailImage: "fakeThumbnail2"))
        XCTAssertTrue(viewModel.isLoaded)
    }

    func testSortAlphabetically() async {
        let data = """
            {
                "meals": [
                    {
                        "strMeal": "Banana",
                        "idMeal": "1",
                        "strMealThumb": "fakeThumbnail1"
                    },
                    {
                        "strMeal": "Apple",
                        "idMeal": "2",
                        "strMealThumb": "fakeThumbnail2"
                    }
                ]
            }
            """.data(using: .utf8)!

        mockNetworkManager.data = data

        await viewModel.loadDesserts()

        XCTAssertTrue(mockNetworkManager.fetchEndpointWasCalled)
        XCTAssertEqual(viewModel.desserts[0], Dessert(id: "2", name: "Apple", thumbnailImage: "fakeThumbnail2"))
        XCTAssertEqual(viewModel.desserts[1], Dessert(id: "1", name: "Banana", thumbnailImage: "fakeThumbnail1"))
        XCTAssertTrue(viewModel.isLoaded)
    }
}
