//
//  DessertDetailView.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/17/23.
//

import SwiftUI

struct DessertDetailView: View {
    @StateObject var dessertDetailViewModel = DessertDetailViewModel(details: Dessert())

    public var id: String?
    public var navigationTitle: String?
    public var details: Dessert? {
        dessertDetailViewModel.details
    }

    var body: some View {
        ZStack {
            if dessertDetailViewModel.isLoaded {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(details?.instructions ?? "")

                        if let ingredients = details?.ingredients {
                            ForEach(ingredients) { ingredient in
                                HStack {
                                    Text(ingredient.name)
                                    Text(ingredient.measurement)
                                }
                            }
                        } else {
                            Text("Dessert Ingredients Not Available.")
                        }
                    }
                }
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(alignment: .center)
                    .task {
                        await dessertDetailViewModel.fetchDessertByID(self.id)
                    }
            }
        }
        .navigationTitle(navigationTitle ?? "Dessert Title Not Available.")
    }
}

#if DEBUG
struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(dessertDetailViewModel: DessertDetailViewModel(details: Dessert()))
    }
}
#endif
