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

                        Text("Ingredients")
                            .font(.title2.weight(.bold))
                            .padding(.leading, 20)
                            .padding(.top, 20)

                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                if let ingredients = details?.ingredients {
                                    ForEach(ingredients) { ingredient in
                                        Text(ingredient.name.capitalized)
                                            .font(.headline)
                                            .foregroundColor(Color(red: 53/255, green: 53/255, blue: 53/255))
                                    }
                                }
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 5) {
                                if let measurements = details?.measurements {
                                    ForEach(measurements) { measurement in
                                        Text(measurement.name)
                                            .font(.headline)
                                            .foregroundColor(Color(red: 53/255, green: 53/255, blue: 53/255))
                                    }
                                }
                            }
                            .padding(.trailing, 20)
                        }
                        .padding(.leading, 20)

                        Text("Instructions")
                            .font(.title2.weight(.bold))
                            .padding(.leading, 20)

                        Text(details?.instructions ?? "")
                            .font(.headline)
                            .foregroundColor(Color(red: 53/255, green: 53/255, blue: 53/255))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                    }
                }
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
