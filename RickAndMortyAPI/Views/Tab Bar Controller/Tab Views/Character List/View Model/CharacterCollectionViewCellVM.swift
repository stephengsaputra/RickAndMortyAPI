//
//  CharacterCollectionViewCellVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import Foundation

final class CharacterCollectionViewCellVM: Hashable, Equatable {
    
    let characterName: String
    let characterStatus: Status
    let characterImageURL: URL?
    
    init(characterName: String, characterStatus: Status, characterImageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageManager.shared.downloadImage(url, completion: completion)
    }
    
    // MARK: - Hashable
    static func == (lhs: CharacterCollectionViewCellVM, rhs: CharacterCollectionViewCellVM) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
}
