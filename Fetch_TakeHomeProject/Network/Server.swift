//
//  Server.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/20/23.
//

import Foundation

struct Server {

    /// Makes a network request to the endpoint. Handles errors respectively.
    func makeRequest(urlStr: String) async throws -> Data {
        guard let url = URL(string: urlStr) else {
            // MARK: ERROR
            throw APIError.badURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            return data

        // MARK: ERROR
        } catch {
            if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                throw APIError.networkUnavailable
            } else {
                throw APIError.unknownError(error)
            }
        }
    }
}
