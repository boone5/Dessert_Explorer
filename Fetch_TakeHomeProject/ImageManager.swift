//
//  ImageManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import UIKit

class ImageManager {
    static func fetchImage(from str: String?) async throws -> UIImage {
        guard
            let str = str,
            let url = URL(string: str)
        else {
            // MARK: ERROR
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let image = UIImage(data: data) else {
            // MARK: ERROR
            throw URLError(.resourceUnavailable)
        }

        return image
    }
}
