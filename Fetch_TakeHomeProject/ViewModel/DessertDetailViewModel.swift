//
//  DessertDetailViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import SwiftUI

@MainActor
class DessertDetailViewModel: ObservableObject {
    private let networkManager = NetworkManager()

    @Published var details: Dessert? = nil

    public func loadData(_ endpoint: APIEndpoint) async {
        do {

            let desserts = try await networkManager.request(endpoint: endpoint)
            self.details = desserts.first

        } catch {
            // MARK: Todo
            // - Custom Errors
            // - Logs
            print(error)
        }
    }
}
