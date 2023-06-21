//
//  CachedImage.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/20/23.
//

import SwiftUI

struct CachedImage: View {

    @StateObject private var manager = CachedImageManager()
    let url: String

    var body: some View {
        VStack {
            if let data = manager.data,
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
            }
        }
        .task {
            await manager.load(url)
        }
    }
}

struct CachedImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedImage(url: "https://www.themealdb.com/images/media/meals/ryppsv1511815505.jpg")
    }
}
