//
//  DessertViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import SwiftUI

@MainActor
class DessertViewModel: ObservableObject {
    @Published var desserts: [Dessert] = []

    public func fetchDesserts() async {
        self.desserts = await NetworkHelper.loadAllDesserts()
    }
}
