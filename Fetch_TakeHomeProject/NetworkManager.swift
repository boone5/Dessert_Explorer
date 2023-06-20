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
    func makeRequest(endpoint: APIEndpoint) async throws -> Result<Data, APIError> {
        guard let url = URL(string: endpoint.path) else {
            // MARK: ERROR
            throw APIError.badURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            return .success(data)

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

enum APIError: Error {
    case networkUnavailable
    case invalidFormat
    case unknownError(Error)
    case decodingError(Error)
    case encodingError
    case badURL

    var description: String {
        switch self {
        case .networkUnavailable:
            return "No internet connection."
        case .unknownError(_):
            return "Something went wrong"
        case .decodingError(_), .encodingError, .invalidFormat, .badURL:
            return "Invalid server response"
        }
    }
}
