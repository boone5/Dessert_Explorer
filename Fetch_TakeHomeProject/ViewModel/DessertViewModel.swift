//
//  DessertViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import SwiftUI

@MainActor
class DessertViewModel: ObservableObject {
    private let networkManager = NetworkManager()

    @Published var desserts: [Dessert] = []

    public func loadData(_ endpoint: APIEndpoint) async {
        do {
            self.desserts = try await networkManager.request(endpoint: endpoint)

        } catch {
            // MARK: Todo
            // - Custom Errors
            // - Logs
            print(error)
        }
    }
}
