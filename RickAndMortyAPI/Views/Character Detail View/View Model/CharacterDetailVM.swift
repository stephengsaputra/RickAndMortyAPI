//
//  CharacterDetailVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 31/12/22.
//

import Foundation

final class CharacterDetailVM {
    
    private let character: Character
    
    init(character: Character) {
        
        self.character = character
    }
    
    public var title: String {
        character.name ?? ""
    }
    
}
