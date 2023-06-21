//
//  ImageManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import UIKit

class ImageManager {
    func fetch(from strURL: String?) async throws -> Data {
        guard
            let strURL = strURL,
            let url = URL(string: strURL)
        else {
            // MARK: ERROR
            throw APIError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return data
    }
}
