//
//  NetworkManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import UIKit

struct NetworkManager {
    func fetchEndpoint(_ endpoint: APIEndpoint) async throws -> Data {
        return try await Server.shared.makeRequest(endpoint: endpoint)
    }
}
