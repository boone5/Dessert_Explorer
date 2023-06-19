//
//  NetworkManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()

    // MARK: MAKE API REQUEST
    func makeRequest(endpoint: APIEndpoint) async throws -> [String: Any] {
        guard let url = URL(string: endpoint.path) else {
            // MARK: ERROR
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

            guard let responseJSON = jsonObject else {
                throw URLError(.badServerResponse)
            }

            return responseJSON

        // MARK: ERROR
        } catch(let error) {
            print("😡 " + error.localizedDescription)
            throw error
        }
    }
}
