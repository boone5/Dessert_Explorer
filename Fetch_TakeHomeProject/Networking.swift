//
//  Networking.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import Foundation
import UIKit

class Networking {
    func getDesserts() async throws -> Dessert {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            // MARK: Todo
            // - Custom Error
            // - Logs
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        var dessert = try JSONDecoder().decode(Dessert.self, from: data)

        if let meals = dessert.meals {
            dessert.meals = try await fetchImages(for: meals)
        }

        return dessert
    }

    // MARK: TODO - Move to own file/extension
    func fetchImages(for meals: [Meal]) async throws -> [Meal] {
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

struct Dessert: Decodable {
    var meals: [Meal]?

    init(meals: [Meal]?) {
        self.meals = meals
    }
}

struct Meal: Decodable {
    let name: String?
    let thumbnail: URL?
    let id: String?
    var thumbnailImage: UIImage?

    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case id = "idMeal"
    }
}
