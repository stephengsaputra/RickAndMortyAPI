//
//  CharacterDetailVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 31/12/22.
//

import Foundation

final class CharacterDetailVM {
    
    private let character: Character
    
    enum SectionType {
        case photo(viewModel: CharacterDetailPhotoVM)
        case information(viewModels: [CharacterDetailInformationVM])
        case episodes(viewModels: [CharacterDetailEpisodesVM])
    }
    
    public var sections: [SectionType] = []
    
    init(character: Character) {
        self.character = character
        self.setupSections()
    }
    
    private var requestURL: URL? {
        return URL(string: character.url ?? "")
    }
    
    public var title: String {
        character.name ?? ""
    }
    
    private func setupSections() {
        
        sections = [
            .photo(viewModel: .init()),
            .information(viewModels: [.init(), .init(), .init(), .init()]),
            .episodes(viewModels: [.init(), .init(), .init(), .init(), .init(), .init(), .init(), .init()])
        ]
    }
}
