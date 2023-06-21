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

    @Published var desserts: [Dessert]
    @Published var isLoaded: Bool

    init(desserts: [Dessert], isLoaded: Bool = false) {
        self.desserts = desserts
        self.isLoaded = isLoaded
    }

    public func loadDesserts() async {
        do {
            let data = try await networkManager.fetchEndpoint(.getAllDesserts)

            try await createDessertList(with: data)

            let sorted = self.sortAlphabetically(list: self.desserts)
            self.desserts = sorted

            self.isLoaded = true

        } catch(let error) {
            if let error = error as? APIError {
                // MARK: LOG
                // This is an area where I could log an event with the error we receive back.
                print(error.description)
            }
            print(APIError.unknownError(error).description)
        }
    }

    private func createDessertList(with data: Data) async throws {
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

    private func sortAlphabetically(list: [Dessert]) -> [Dessert] {
        guard list.count > 1 else { return list }

        return list.sorted { $0.name ?? "" < $1.name ?? "" }
    }
}
