//
//  DessertViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import SwiftUI

@MainActor
class DessertViewModel: ObservableObject {
    private let networkManager = NetworkManager()

    @Published var desserts: [Dessert] = []

    public func loadData(_ endpoint: APIEndpoint) async {
        do {
            let jsonDict = try await networkManager.request(endpoint: endpoint)

            for key in jsonDict {
                let dessert = Dessert(
                    id: key["idMeal"] as? String,
                    name: key["strMeal"] as? String,
                    thumbnail: key["strMealThumb"] as? URL
                )

                self.desserts.append(dessert)
            }
        } catch {
            // MARK: Todo
            // - Custom Errors
            // - Logs
            print(error)
        }
    }
}
