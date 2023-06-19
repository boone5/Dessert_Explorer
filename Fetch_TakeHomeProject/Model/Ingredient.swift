//
//  Ingredient.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//
import Foundation

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let measurement: String
}
