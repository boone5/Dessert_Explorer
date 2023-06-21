//
//  Server.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/20/23.
//

import Foundation

class Server {
    // MARK: Singleton
    static let shared = Server()

    // Keeps the instantiation explicit to this file.
    private init() { }

    /// Makes a network request to the endpoint. Handles errors respectively.
    func makeRequest(endpoint: APIEndpoint) async throws -> Data {
        guard let url = URL(string: endpoint.path) else {
            // MARK: ERROR
            throw APIError.badURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            return data

        // MARK: ERROR
        } catch(let error) {
            if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                throw APIError.networkUnavailable
            } else {
                throw APIError.unknownError(error)
            }
        }
    }
}
