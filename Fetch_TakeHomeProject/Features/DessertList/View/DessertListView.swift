//
//  DessertListView.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import SwiftUI

struct DessertListView: View {
    @ObservedObject var dessertViewModel: DessertViewModel

    var body: some View {
        NavigationView {
            if dessertViewModel.isLoaded {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(dessertViewModel.desserts) { dessert in
                            NavigationLink(destination: DessertDetailView(id: dessert.id ?? "", navigationTitle: dessert.name ?? "")) {
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                        .shadow(radius: 2, y: 2)

                                    HStack(alignment: .center) {
                                        Thumbnail(url: dessert.thumbnailImage ?? "")

                                        SectionTitle(text: dessert.name)
                                            .multilineTextAlignment(.leading)
                                            // Adds space between image and Title
                                            .padding(.leading, 20)
                                    }
                                    // Adds space on all sides between Rectangle and its children
                                    .padding()
                                }
                            }
                        }
                    }
                    .padding(.top, Margin.top.value)
                    .padding(.leading, Margin.leading.value)
                    .padding(.trailing, Margin.trailing.value)
                }
                .navigationTitle("Desserts")

            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(alignment: .center)
            }
        }
        .task {
            await dessertViewModel.loadDesserts()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView(dessertViewModel: DessertViewModel(desserts: []))
    }
}
#endif
