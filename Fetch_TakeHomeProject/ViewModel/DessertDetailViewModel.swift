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

    public func fetchDessertByID(_ id: String?) async {
        self.details = await NetworkHelper.loadDessert(by: id)

        self.isLoaded = true
    }
}
