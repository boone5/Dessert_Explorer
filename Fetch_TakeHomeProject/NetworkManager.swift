//
//  NetworkManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import Foundation
import UIKit

class NetworkManager {
    func request(endpoint: APIEndpoint) async throws -> [[String: Any]] {
        guard let url = URL(string: endpoint.path) else {
            // MARK: TODO - Custom Errors
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let responseJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let meals = responseJSON?["meals"] as? [[String: Any]] else {
            throw URLError(.badServerResponse)
        }

        return meals
    }

    // MARK: TODO - Move to own file/extension
    func fetchImages(for meals: [Dessert]) async throws -> [Dessert] {
        var updatedMeals = meals

        for index in 0..<meals.count {
            if let thumbnailURL = meals[index].thumbnail {
                let image = try await fetchImage(from: thumbnailURL)
                updatedMeals[index].thumbnailImage = image
            }
        }

        return updatedMeals
    }

    func fetchImage(from url: URL) async throws -> UIImage {
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
    let thumbnail: URL?
    var thumbnailImage: UIImage?
    let instructions: String?
    var ingredients: [IngredientWithMeasurement]?

    init(
        id: String?,
        name: String?,
        thumbnail: URL?,
        thumbnailImage: UIImage? = nil,
        instructions: String? = nil,
        ingredients: [IngredientWithMeasurement]? = []
    ) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.thumbnailImage = thumbnailImage
        self.instructions = instructions
        self.ingredients = ingredients
    }
}

struct IngredientWithMeasurement {
    let ingredientName: String
    let measurement: String
}
