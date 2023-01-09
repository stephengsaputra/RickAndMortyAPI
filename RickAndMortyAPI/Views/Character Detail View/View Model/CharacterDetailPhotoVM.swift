//
//  CharacterDetailPhotoVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 07/01/23.
//

import Foundation

final class CharacterDetailPhotoVM {
    
    private let imageURL: URL?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let imageURL = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageManager.shared.downloadImage(imageURL, completion: completion)
    }
}
