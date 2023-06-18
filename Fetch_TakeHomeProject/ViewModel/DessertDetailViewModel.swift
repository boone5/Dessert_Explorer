//
//  DessertDetailViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import SwiftUI

@MainActor
class DessertDetailViewModel: ObservableObject {
    private let networkManager = NetworkManager()

    @Published var details: Dessert? = nil

    public func loadData(_ endpoint: APIEndpoint) async {
        do {
            let jsonDict = try await networkManager.request(endpoint: endpoint)
            var hasMoreIngredients = true

            for key in jsonDict {
                var dessert = Dessert(
                    id: key["idMeal"] as? String,
                    name: key["strMeal"] as? String,
                    thumbnail: key["strMealThumb"] as? URL,
                    instructions: key["strInstructions"] as? String
                )

                var index = 1
                while hasMoreIngredients {
                    if
                        let ingredientName = key["strIngredient\(index)"] as? String,
                        let measurement = key["strMeasure\(index)"] as? String
                    {
                        dessert.ingredients?.append(IngredientWithMeasurement(ingredientName: ingredientName, measurement: measurement))
                        index += 1
                    } else {
                        hasMoreIngredients = false
                    }
                }

                self.details = dessert
            }

        } catch {
            // MARK: Todo
            // - Custom Errors
            // - Logs
            print(error)
        }
    }
}
