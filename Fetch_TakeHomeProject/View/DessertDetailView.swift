//
//  DessertDetailView.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/17/23.
//

import SwiftUI

struct DessertDetailView: View {
    @StateObject var dessertDetailViewModel = DessertDetailViewModel()

    public var id: String?
    public var dessert: Dessert? {
        dessertDetailViewModel.details
    }

    var body: some View {
        if dessertDetailViewModel.isLoaded {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(dessert?.instructions ?? "Dessert Instructions Not Available.")

                    if let ingredients = dessert?.ingredients {
                        ForEach(ingredients) { ingredient in
                            HStack {
                                Text(ingredient.ingredientName)
                                Text(ingredient.measurement)
                            }
                        }
                    } else {
                        Text("Dessert Ingredients Not Available.")
                    }
                }
            }
            .navigationTitle(dessert?.name ?? "Dessert Title Not Available.")
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .frame(alignment: .center)
                .task {
                    await dessertDetailViewModel.loadData(.getRecipeByID(self.id))
                }
        }
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(dessertDetailViewModel: DessertDetailViewModel())
    }
}
