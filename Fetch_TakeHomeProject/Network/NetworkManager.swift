//
//  NetworkManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import Foundation.NSData

class NetworkManager {
    private let server: Server

    init(server: Server = Server()) {
        self.server = server
    }

    /// Notifies the Server to make a request using the endpoint.
    func fetchEndpoint(_ endpoint: APIEndpoint) async throws -> Data {
        return try await server.makeRequest(urlStr: endpoint.path)
    }
}
