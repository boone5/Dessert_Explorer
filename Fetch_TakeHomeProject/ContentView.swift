//
//  ContentView.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dessertViewModel = DessertViewModel()

    var body: some View {
        NavigationView {
            List(dessertViewModel.desserts) { dessert in
                NavigationLink(
                    destination: DessertDetailView(id: dessert.id)
                ) {
                    self.dessertItemView(dessert: dessert)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Desserts")
        }
        .task {
            await dessertViewModel.loadData(.getDesserts)
        }
    }
}

extension ContentView {
    func dessertItemView(dessert: Dessert) -> some View {
        HStack {
            if let thumbnailImage = dessert.thumbnailImage {
                Image(uiImage: thumbnailImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            }

            Text(dessert.name ?? "")
                .font(.title3)
                .multilineTextAlignment(.leading)
                .padding(.leading, 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
