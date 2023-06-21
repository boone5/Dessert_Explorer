//
//  Dessert.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

struct Dessert: Identifiable, Equatable {
    let id: String?
    let name: String?
    var thumbnailImage: String?
    var instructions: String?
    var ingredients: [Ingredient]?
    var measurements: [Measurement]?

    init(
        id: String? = nil,
        name: String? = nil,
        thumbnailImage: String? = nil,
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

    static func == (lhs: Dessert, rhs: Dessert) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.thumbnailImage == rhs.thumbnailImage &&
        lhs.instructions == rhs.instructions &&
        lhs.ingredients == rhs.ingredients &&
        lhs.measurements == rhs.measurements
    }
}
