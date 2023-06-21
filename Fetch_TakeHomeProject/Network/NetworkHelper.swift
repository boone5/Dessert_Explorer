//
//  NetworkHelper.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import Foundation

struct NetworkHelper {
    public static func convertToJSON(from data: Data) throws -> [[String: Any]] {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

            guard let responseJSON = jsonObject else {
                throw APIError.invalidFormat
            }

            guard let dessertJSON = responseJSON["meals"] as? [[String: Any]] else {
                throw APIError.invalidFormat
            }

            return dessertJSON

        // MARK: ERROR
        } catch (let error) {
            // There was an error on line 25
            throw APIError.decodingError(error)
        }
    }

    /// The API returns json with indiviudal ingredient and mesaure properties. This function iterates over them until the index is no longer valid.
    /// - "strIngredientX" : "sugar"
    /// - "strMeasureX" : "1 tbps"
    ///
    /// Where "X" is an integer from 1-20.
    public static func addProperties(to dessert: inout Dessert, with json: [String: Any]) {
        var ingredientIndex = 1
        var measurementIndex = 1

        while
            let name = json["strIngredient\(ingredientIndex)"] as? String,
            name.replacingOccurrences(of: " ", with: "") != ""
        {
            ingredientIndex += 1
            dessert.ingredients?.append(Ingredient(name: name))
        }

        while
            let name = json["strMeasure\(measurementIndex)"] as? String,
            name.replacingOccurrences(of: " ", with: "") != ""
        {
            measurementIndex += 1
            dessert.measurements?.append(Measurement(name: name))
        }
    }
}
