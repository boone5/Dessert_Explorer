//
//  CachedImageManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/20/23.
//

import Foundation

final class CachedImageManager: ObservableObject {

    @Published private(set) var data: Data?

    private let imageRetriever = ImageManager()

    @MainActor
    func load(_ imgURL: String?, cache: ImageCache = .shared) async {
        guard let url = imgURL else {
            // MARK: ERROR
            return
        }

        if let imageData = cache.object(forKey: url as NSString) {
            self.data = imageData
            print("Fetching Image from Cache: \(url)")
            return
        }

        do {
            self.data = try await imageRetriever.fetch(from: imgURL)

            if let dataToCache = data as? NSData {
                cache.set(object: dataToCache, forKey: url as NSString)
                print("Storing Image in Cache: \(url)")
            }
        } catch {
            print("😡 " + error.localizedDescription)
        }
    }
}
