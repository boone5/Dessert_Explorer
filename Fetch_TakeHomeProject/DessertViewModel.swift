//
//  DessertViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import SwiftUI

@MainActor
class DessertViewModel: ObservableObject {
    private let network = Networking()

    @Published var meals: [Meal] = []

    public func fetch() async {
        do {
            let desserts = try await network.getDesserts()
            guard let meals = desserts.meals else {
                // MARK: Todo
                // - Custom Error
                // - Logs
                return
            }

            self.meals = meals

        } catch {
            // MARK: Todo
            // - Custom Errors
            // - Logs
            print(error)
        }
    }
}
