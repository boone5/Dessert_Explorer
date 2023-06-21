//
//  MockNetworkManager.swift
//  Fetch_TakeHomeProjectTests
//
//  Created by Boone on 6/21/23.
//

import XCTest

@testable import Fetch_TakeHomeProject

class MockNetworkManager: NetworkManager {
    var fetchEndpointWasCalled = false
    var data: Data = Data()

    override func fetchEndpoint(_ endpoint: APIEndpoint) async throws -> Data {
        fetchEndpointWasCalled = true

        return self.data
    }
}
