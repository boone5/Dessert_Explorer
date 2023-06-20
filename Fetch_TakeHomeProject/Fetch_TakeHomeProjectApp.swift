//
//  Fetch_TakeHomeProjectApp.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import SwiftUI

@main
struct Fetch_TakeHomeProjectApp: App {
    @StateObject var dessertViewModel = DessertViewModel(desserts: [])

    init() {
        // This adds resizing so NavigationBar title's fit on screen
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }

    var body: some Scene {
        WindowGroup {
            DessertListView(dessertViewModel: dessertViewModel)
        }
    }
}
