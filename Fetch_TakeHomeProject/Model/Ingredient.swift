//
//  Ingredient.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//
import Foundation.NSUUID

struct Ingredient: Identifiable, Equatable {
    let id = UUID()
    let name: String
}
