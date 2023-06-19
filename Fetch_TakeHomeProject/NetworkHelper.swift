//
//  NetworkHelper.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import Foundation

class NetworkHelper {
    // MARK: LOAD ALL DESSERTs
    static func loadAllDesserts() async -> [Dessert] {
        do {
            let responseJSON = try await NetworkManager.shared.makeRequest(endpoint: .getAllDesserts)

            // Parse JSON for access to array of Dessert objects
            let jsonArray = try parseDessertsJSON(from: responseJSON)

            // Create each dessert object
            return try await createAllDesserts(from: jsonArray)

        } catch {
            print("😡 " + error.localizedDescription)
        }

        return []
    }

    // MARK: LOAD SINGLE DESSERT
    static func loadDessert(by id: String?) async -> Dessert {
        do {
            let responseJSON = try await NetworkManager.shared.makeRequest(endpoint: .getDessertByID(id))

            // Parse JSON for access to singular Dessert object
            let jsonArray = try parseDessertsJSON(from: responseJSON)

            // Create dessert object
            return try await createDessert(from: jsonArray)

        } catch {
            // This is a spot that I would log an error if the application was linked with Firebase.
            print("😡 " + error.localizedDescription)
        }

        // Not sure I like returning an object with nil values
        return Dessert()
    }

    private static func parseDessertsJSON(from responseJSON: [String: Any]) throws -> [[String: Any]] {
        guard let dessertObjects = responseJSON["meals"] as? [[String: Any]] else {
            throw URLError(.badServerResponse)
        }

        return dessertObjects
    }

    private static func createAllDesserts(from jsonArray: [[String: Any]]) async throws -> [Dessert] {
        var desserts: [Dessert] = []

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

            desserts.append(dessert)
        }

        return desserts
    }

    private static func createDessert(from jsonArray: [[String: Any]]) async throws -> Dessert {
        // The API returns an array of length 1 with our specified Dessert object. We need this line to access the first element.
        guard let json = jsonArray.first else {
            throw URLError(.badServerResponse)
        }

        let id = json["idMeal"] as? String
        let name = json["strMeal"] as? String
        let instructions = formatJSON(jsonString: json["strInstructions"] as? String)

        var dessert = Dessert(
            id: id,
            name: name,
            instructions: instructions
        )

        addProperties(to: &dessert, with: json)

        return dessert
    }

    /// The API returns json with indiviudal ingredient and mesaure properties. This function iterates over them until the index is no longer valid.
    /// - "strIngredientX" : "sugar"
    /// - "strMeasureX" : "1 tbps"
    ///
    /// Where "X" is an integer from 1-20.
    private static func addProperties(to dessert: inout Dessert, with json: [String: Any]) {
        var index = 1
        while
            let name = json["strIngredient\(index)"] as? String,
            let measurement = json["strMeasure\(index)"] as? String
        {
            dessert.ingredients?.append(Ingredient(name: name, measurement: measurement))
            index += 1
        }
    }

    /// The API returns `instructions` with newline characters that aren't consistent across each dessert. This function removes them altogether to make for a more consistent user expereince.
    ///
    /// Without removing the newline characters, one dessert object might return `instructions` with paragraph spacing while another doesn't. 
    private static func formatJSON(jsonString: String?) -> String? {
        guard let json = jsonString else { return nil }

        let replaced = json.replacingOccurrences(of: "\r\n", with: "")

        return replaced
    }
}
