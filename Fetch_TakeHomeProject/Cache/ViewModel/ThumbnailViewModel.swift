//
//  ThumbnailViewModel.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/20/23.
//

import Foundation

final class ThumbnailViewModel: ObservableObject {
    private let networkManager = NetworkManager()

    @Published private(set) var data: Data?

    @MainActor
    func load(_ imgURL: String, cache: ImageCache = .shared) async {
        do {
            if let imageData = cache.getObject(forKey: imgURL as NSString) {
                self.data = imageData
                print("⬇️ Fetching Image from Cache: \(imgURL)")
                return
            }

            self.data = try await networkManager.fetchEndpoint(.getImage(imgURL))

            if let dataToCache = data as? NSData {
                cache.set(object: dataToCache, forKey: imgURL as NSString)
                print("⬆️ Storing Image in Cache: \(imgURL)")
            }

        } catch(let error) {
            if let error = error as? APIError {
                // MARK: LOG
                // This is an area where I could log an event with the error we receive back.
                print(error.description)
            }
            print(APIError.unknownError(error).description)
        }
    }
}
