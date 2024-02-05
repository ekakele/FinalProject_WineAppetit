//
//  ImageLoader.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import UIKit

final class ImageLoader {
    // MARK: - Properties
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Inits
    private init() {}
    
    // MARK: - Methods
    func displayImage(
        from imageURL: String?,
        in imageView: UIImageView,
        indicator: ActivityIndicator? = nil,
        fallbackImageName: String = "noImage"
    ) {
        if let imageURL = imageURL, !imageURL.isEmpty {
            loadImage(from: imageURL, for: imageView, indicator: indicator)
        } else {
            imageView.image = UIImage(named: fallbackImageName)
        }
    }
    
    func loadImage(
        from urlString: String,
        for imageView: UIImageView,
        indicator: ActivityIndicator? = nil
    ) {
        indicator?.show()
        Task {
            do {
                let image = try await ImageLoader.shared.fetchAndCacheImage(with: urlString)
                await MainActor.run {
                    indicator?.hide()
                    imageView.image = image
                }
            } catch {
                await MainActor.run {
                    indicator?.hide()
                    imageView.image = UIImage(named: "noImage")
                    print("Error fetching images: \(error)")
                }
            }
        }
    }
    
    func fetchAndCacheImage(with URLString: String) async throws -> UIImage? {
        if let image = cache.object(forKey: NSString(string: URLString)) {
            return image
        }
        
        guard !URLString.isEmpty, let URL = URL(string: URLString) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        let (data, _) = try await URLSession.shared.data(from: URL)
        
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey: "Error converting data to UIImage"])
        }
        
        self.cache.setObject(image, forKey: NSString(string: URLString))
        return image
    }
}

