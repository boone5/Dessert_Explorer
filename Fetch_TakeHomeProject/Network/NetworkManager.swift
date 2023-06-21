//
//  NetworkManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import Foundation.NSData

struct NetworkManager {
    private let server = Server()

    /// Notifies the Server to make a request using the endpoint.
    func fetchEndpoint(_ endpoint: APIEndpoint) async throws -> Data {
        return try await server.makeRequest(urlStr: endpoint.path)
    }
}
