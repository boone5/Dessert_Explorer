//
//  DessertViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import SwiftUI

@MainActor
class DessertViewModel: ObservableObject {

    @Published var desserts: [Dessert]
    @Published var isLoaded: Bool

    init(desserts: [Dessert], isLoaded: Bool = false) {
        self.desserts = desserts
        self.isLoaded = isLoaded
    }

    public func createDessertList() async {
        var list: [Dessert] = []

        do {
            let jsonArray = try await NetworkHelper.fetchEndpoint(.getAllDesserts)

            for json in jsonArray {
                let id = json["idMeal"] as? String
                let name = json["strMeal"] as? String
                let urlString = json["strMealThumb"] as? String

                // Load the image from endpoint in "strMealThumb".
                // - Implementing a cache wasn't as trivial as I thought it would be
                let image = try await ImageManager.fetchImage(from: urlString)

                let dessert = Dessert(
                    id: id,
                    name: name,
                    thumbnailImage: image
                )

                list.append(dessert)
            }
        } catch (let error) {
            print("😡 \(error)")
        }

        self.desserts = sortAlphabetically(list: list)
        self.isLoaded = true
    }

    private func sortAlphabetically(list: [Dessert]) -> [Dessert] {
        guard list.count > 1 else { return list }

        return list.sorted { $0.name ?? "" < $1.name ?? "" }
    }
}
