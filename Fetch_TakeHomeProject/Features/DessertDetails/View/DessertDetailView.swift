//
//  DessertDetailView.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/17/23.
//

import SwiftUI

struct DessertDetailView: View {
    @StateObject var dessertDetailViewModel = DessertDetailViewModel(details: Dessert())

    public var id: String
    public var navigationTitle: String
    public var details: Dessert? {
        dessertDetailViewModel.details
    }

    var body: some View {
        ZStack {
            if dessertDetailViewModel.isLoaded {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 15) {

                        SectionTitle(text: "Ingredients")

                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                if let ingredients = details?.ingredients {
                                    ForEach(ingredients) { ingredient in
                                        SectionBody(text: ingredient.name.capitalized)
                                    }
                                }
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 5) {
                                if let measurements = details?.measurements {
                                    ForEach(measurements) { measurement in
                                        SectionBody(text: measurement.name)
                                    }
                                }
                            }
                        }

                        SectionTitle(text: "Instructions")

                        SectionBody(text: details?.instructions ?? "")
                    }
                }
                .padding(.top, Margin.top.value)
                .padding(.leading, Margin.leading.value)
                .padding(.trailing, Margin.trailing.value)
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(alignment: .center)
            }
        }
        .navigationTitle(navigationTitle)
        .task {
            await dessertDetailViewModel.loadDessert(self.id)
        }
    }
}

#if DEBUG
struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(dessertDetailViewModel: DessertDetailViewModel(details: Dessert()), id: "", navigationTitle: "")
    }
}
#endif
