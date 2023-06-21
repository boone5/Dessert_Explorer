//
//  APIEndpoint.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

enum APIEndpoint {
    case getAllDesserts
    case getDessertByID(_ id: String?)
    case getImage(_ url: String)

    var path: String {
        switch self {
        case .getAllDesserts:
            return "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        case .getDessertByID(let id):
            return "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id ?? "")"
        case .getImage(let url):
            return url
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
            return "😡 No internet connection."
        case .unknownError(let error):
            return "😡 Something went wrong: \(error)"
        case .decodingError(_), .encodingError, .invalidFormat, .badURL:
            return "😡 Invalid server response: \(self)"
        }
    }
}
