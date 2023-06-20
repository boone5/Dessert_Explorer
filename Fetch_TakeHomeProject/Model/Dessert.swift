//
//  Dessert.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import UIKit

struct Dessert: Identifiable {
    let id: String?
    let name: String?
    var thumbnailImage: UIImage?
    var instructions: String?
    var ingredients: [Ingredient]?
    var measurements: [Measurement]?

    init(
        id: String? = nil,
        name: String? = nil,
        thumbnailImage: UIImage? = nil,
        instructions: String? = nil,
        ingredients: [Ingredient]? = [],
        measurements: [Measurement]? = []
    ) {
        self.id = id
        self.name = name
        self.thumbnailImage = thumbnailImage
        self.instructions = instructions
        self.ingredients = ingredients
        self.measurements = measurements
    }
}
