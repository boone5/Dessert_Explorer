//
//  DessertDetailView.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/17/23.
//

import SwiftUI

struct DessertDetailView: View {
    @ObservedObject var dessertDetailViewModel: DessertDetailViewModel

    public var id: String?
    public var dessert: Dessert? {
        dessertDetailViewModel.details
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                Text(dessert?.name ?? "uh oh")

                Text(dessert?.instructions ?? "uh oh")

                if let ingredients = dessert?.ingredients {
                    ForEach(ingredients) { ingredient in
                        HStack {
                            Text(ingredient.ingredientName)
                            Text(ingredient.measurement)
                        }
                    }
                } else {
                    Text("uh oh")
                }
            }
        }
        .task {
            await dessertDetailViewModel.loadData(.getRecipeByID(self.id))
        }
        .navigationTitle("")
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(dessertDetailViewModel: DessertDetailViewModel())
    }
}
