//
//  DessertDetailViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import Foundation

@MainActor
class DessertDetailViewModel: ObservableObject {
    private let networkManager = NetworkManager()

    @Published var details: Dessert
    @Published var isLoaded: Bool

    init(details: Dessert, isLoaded: Bool = false) {
        self.details = details
        self.isLoaded = isLoaded
    }

    /// Make a network request to load a Dessert object. Function handles errors respectively.
    public func loadDessert(_ id: String) async {
        do {
            let data = try await networkManager.fetchEndpoint(.getDessertByID(id))

            try await createDessert(from: data)

            self.isLoaded = true

        } catch(let error) {
            if let error = error as? APIError {
                // MARK: LOG
                // This is an area where I could log an event with an error we receive back.
                print(error.description)
            }
            print(APIError.unknownError(error).description)
        }
    }

    private func createDessert(from data: Data) async throws {
        let jsonArray = try NetworkHelper.convertToJSON(from: data)

        // The API returns an array of length 1 with our specified Dessert object. We need this line to access the first element.
        guard let json = jsonArray.first else {
            throw APIError.invalidFormat
        }

        let name = json["strMeal"] as? String
        let instructions = json["strInstructions"] as? String
        
        let formatted = formatInstructions(jsonString: instructions)

        var dessert = Dessert(
            name: name,
            instructions: formatted
        )

        NetworkHelper.addProperties(to: &dessert, with: json)

        self.details = dessert
    }

    /// The API returns `instructions` with newline characters that aren't consistent across each dessert object. This function removes them altogether to make for a more consistent user expereince.
    ///
    /// Without removing the newline characters, one dessert object might return `instructions` with paragraph spacing while another doesn't.
    private func formatInstructions(jsonString: String?) -> String? {
        guard let json = jsonString else { return nil }

        let replaced = json.replacingOccurrences(of: "\r\n", with: "")

        return replaced
    }
}
