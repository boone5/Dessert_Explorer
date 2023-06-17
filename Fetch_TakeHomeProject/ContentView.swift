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
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 20) {
                    self.dessertItemView()
                }
                .padding(.leading, 20)
                .padding(.top, 10)
            }
            .navigationTitle("Desserts")
        }
        .task {
            await dessertViewModel.fetch()
        }
    }
}

extension ContentView {
    func dessertItemView() -> some View {
        ForEach(dessertViewModel.meals, id: \.id) { meal in
            HStack {
                if let thumbnailImage = meal.thumbnailImage {
                    Image(uiImage: thumbnailImage)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                }

                Text(meal.name ?? "")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 10)

                Spacer()

                Image(systemName: "chevron.right")
                    .padding(.trailing, 20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
