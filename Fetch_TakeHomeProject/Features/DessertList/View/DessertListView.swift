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

                                        Text(dessert.name ?? "")
                                            .font(.title2.weight(.bold))
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.black)
                                            .padding(.leading, 20)
                                    }
                                    .padding()
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            }
                        }
                    }
                    .padding(.top, 10)
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
