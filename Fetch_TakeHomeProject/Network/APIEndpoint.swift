//
//  APIEndpoint.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

enum APIEndpoint {
    case getAllDesserts
    case getDessertByID(_ id: String?)

    var path: String {
        switch self {
        case .getAllDesserts:
            return "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        case .getDessertByID(let id):
            return "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id ?? "")"
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
