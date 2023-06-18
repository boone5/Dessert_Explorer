//
//  NetworkManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import Foundation
import UIKit

class NetworkManager {
    func request(endpoint: APIEndpoint) async throws -> [Dessert] {
        guard let url = URL(string: endpoint.path) else {
            // MARK: TODO - Custom Errors
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let dessertsJSON = try self.parseDessertsJSON(from: data)

        var desserts: [Dessert] = []

        for json in dessertsJSON {
            let dessert = try await self.createDessert(from: json)
            desserts.append(dessert)
        }

        return desserts
    }

    func parseDessertsJSON(from data: Data) throws -> [[String: Any]] {
        let responseJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let dessertsJSON = responseJSON?["meals"] as? [[String: Any]] else {
            throw URLError(.badServerResponse)
        }

        return dessertsJSON
    }

    func createDessert(from json: [String: Any]) async throws -> Dessert {
        let id = json["idMeal"] as? String
        let name = json["strMeal"] as? String
        let urlString = json["strMealThumb"] as? String
        let instructions = json["strInstructions"] as? String

        let image = try await fetchImage(from: urlString)

        var dessert = Dessert(
            id: id,
            name: name,
            thumbnailImage: image,
            instructions: instructions
        )

        appendDetails(dessert: &dessert, json: json)

        return dessert
    }

    func appendDetails(dessert: inout Dessert, json: [String: Any]) {
        var index = 1
        while
            let ingredientName = json["strIngredient\(index)"] as? String,
            let measurement = json["strMeasure\(index)"] as? String
        {
            dessert.ingredients?.append(IngredientWithMeasurement(ingredientName: ingredientName, measurement: measurement))
            index += 1
        }
    }

    func fetchImage(from str: String?) async throws -> UIImage {
        guard
            let str = str,
            let url = URL(string: str)
        else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let image = UIImage(data: data) else {
            throw URLError(.resourceUnavailable)
        }

        return image
    }
}

struct Dessert: Identifiable {
    let id: String?
    let name: String?
    var thumbnailImage: UIImage?
    let instructions: String?
    var ingredients: [IngredientWithMeasurement]?

    init(
        id: String? = nil,
        name: String? = nil,
        thumbnailImage: UIImage? = nil,
        instructions: String? = nil,
        ingredients: [IngredientWithMeasurement]? = []
    ) {
        self.id = id
        self.name = name
        self.thumbnailImage = thumbnailImage
        self.instructions = instructions
        self.ingredients = ingredients
    }
}

struct IngredientWithMeasurement: Identifiable {
    let id = UUID()
    let ingredientName: String
    let measurement: String
}
