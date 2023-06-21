//
//  DessertDetailViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import SwiftUI

@MainActor
class DessertDetailViewModel: ObservableObject {
    @Published var details: Dessert
    @Published var isLoaded: Bool

    init(details: Dessert, isLoaded: Bool = false) {
        self.details = details
        self.isLoaded = isLoaded
    }

    public func createDessert(by id: String?) async {
        do {
            let jsonArray = try await NetworkHelper.fetchEndpoint(.getDessertByID(id))

            // The API returns an array of length 1 with our specified Dessert object. We need this line to access the first element.
            guard let json = jsonArray.first else {
                throw APIError.invalidFormat
            }

            let id = json["idMeal"] as? String
            let name = json["strMeal"] as? String
            let instructions = json["strInstructions"] as? String

            let formatted = NetworkHelper.formatJSON(jsonString: instructions)

            var dessert = Dessert(
                id: id,
                name: name,
                instructions: formatted
            )

            NetworkHelper.addProperties(to: &dessert, with: json)

            self.details = dessert
            isLoaded = true
        } catch (let error) {
            print("😡 \(error)")
        }
    }
}
