//
//  APIEndpoint.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

enum APIEndpoint {
    case getDesserts
    case getRecipeByID(_ id: String?)

    var path: String {
        switch self {
        case .getDesserts:
            return "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        case .getRecipeByID(let id):
            return "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id ?? "")"
        }
    }
}
