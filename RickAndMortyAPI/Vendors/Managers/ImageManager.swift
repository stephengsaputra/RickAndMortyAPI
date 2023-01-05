//
//  ImageManager.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/01/23.
//

import Foundation

final class ImageManager {
    
    static let shared = ImageManager()
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    /// Get image content with URL
    /// - Parameters:
    ///   - url: Source URL for the Image
    ///   - completion: Callback
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key) {
            
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
        
            completion(.success(data))
        }
        
        task.resume()
    }
}
