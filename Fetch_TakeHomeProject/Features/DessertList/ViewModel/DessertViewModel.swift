//
//  DessertViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import Foundation

@MainActor
class DessertViewModel: ObservableObject {
    private let networkManager = NetworkManager()

    @Published var desserts: [Dessert]
    @Published var isLoaded: Bool

    init(desserts: [Dessert], isLoaded: Bool = false) {
        self.desserts = desserts
        self.isLoaded = isLoaded
    }

    /// Make a network request to load an array of Dessert objects. Function handles errors respectively.
    public func loadDesserts() async {
        do {
            let data = try await networkManager.fetchEndpoint(.getAllDesserts)

            try await createDessertList(from: data)

            let sorted = self.sortAlphabetically(list: self.desserts)

            self.desserts = sorted
            self.isLoaded = true

        } catch(let error) {
            // MARK: LOG
            // This is an area where I could log an event with an error we receive back.
            if let error = error as? APIError {
                print(error.description)
            }
            print(APIError.unknownError(error).description)
        }
    }

    private func createDessertList(from data: Data) async throws {
        let jsonArray = try NetworkHelper.convertToJSON(from: data)

        for json in jsonArray {
            let id = json["idMeal"] as? String
            let name = json["strMeal"] as? String
            let urlString = json["strMealThumb"] as? String

            let dessert = Dessert(
                id: id,
                name: name,
                thumbnailImage: urlString
            )

            desserts.append(dessert)
        }
    }

    /// Sorts our list of desserts by name.
    private func sortAlphabetically(list: [Dessert]) -> [Dessert] {
        guard list.count > 1 else { return list }

        return list.sorted { $0.name ?? "" < $1.name ?? "" }
    }
}
