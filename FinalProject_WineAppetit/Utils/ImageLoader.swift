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
    func fetchImage(with URLString: String) async throws -> UIImage? {
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

