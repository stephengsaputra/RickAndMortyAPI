//
//  CharacterDetailVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 31/12/22.
//

import Foundation

final class CharacterDetailVM {
    
    private let character: Character
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    init(character: Character) {
        self.character = character
    }
    
    private var requestURL: URL? {
        return URL(string: character.url ?? "")
    }
    
    public var title: String {
        character.name ?? ""
    }
}
