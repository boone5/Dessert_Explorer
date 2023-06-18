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

    var body: some View {
        Text(dessertDetailViewModel.details?.name ?? "")
            .task {
                await dessertDetailViewModel.loadData(.getRecipeByID(self.id))
            }
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailView(dessertDetailViewModel: DessertDetailViewModel())
    }
}
