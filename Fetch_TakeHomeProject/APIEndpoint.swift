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
