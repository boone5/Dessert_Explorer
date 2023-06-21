//
//  ImageManager.swift
//  Fetch_TakeHomeProject
//
//  Created by Boone on 6/18/23.
//

import UIKit

class ImageManager {
    func fetchImage(from str: String?) async throws -> UIImage {
        guard
            let str = str,
            let url = URL(string: str)
        else {
            // MARK: ERROR
            throw APIError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let image = UIImage(data: data) else {
            // MARK: ERROR
            throw URLError(.resourceUnavailable)
        }

        return image
    }

    func fetch(from str: String?) async throws -> Data {
        guard
            let str = str,
            let url = URL(string: str)
        else {
            // MARK: ERROR
            throw APIError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return data
    }
}
