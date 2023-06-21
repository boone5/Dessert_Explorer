//
//  Thumbnail.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/20/23.
//

import SwiftUI

struct Thumbnail: View {

    @StateObject private var thumbnailViewModel = ThumbnailViewModel()
    let url: String

    var body: some View {
        VStack {
            if let data = thumbnailViewModel.data,
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .task {
            await thumbnailViewModel.load(url)
        }
    }
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        Thumbnail(url: "https://www.themealdb.com/images/media/meals/ryppsv1511815505.jpg")
    }
}
