//
//  ImageLoader.swift
//  FinalProject_WineAppetit
//
//  Created by Eka Kelenjeridze on 23.01.24.
//

import UIKit

final class ImageLoader {
    //MARK: - Properties
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    
    //MARK: - Inits
    private init() {}
    
    //MARK: - Methods
    func fetchImage(with URLString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        
        if let image = cache.object(forKey: NSString(string: URLString)) {
            completion(.success(image))
            return
        }
        
        guard !URLString.isEmpty, let URL = URL(string: URLString) else {
            return
        }
        
        URLSession.shared.dataTask(with: URL) { data, response, error in
            if let error = error {
                print("Error fetching image from URL: \(URLString), Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                print("No data received for URL: \(URLString)")
                completion(.failure(noDataError))
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    let imageConversionError = NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey: "Error converting data to UIImage"])
                    print("Error converting data to UIImage for URL: \(URLString)")
                    completion(.failure(imageConversionError))
                    return
                }
                
                self.cache.setObject(image, forKey: NSString(string: URLString))
                completion(.success(image))
            }
        }.resume()
        
    }
}

