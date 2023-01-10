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
            .photo(viewModel: .init(imageURL: URL(string: character.image ?? ""))),
            .information(viewModels: [
                .init(type: .status, value: character.status?.text ?? ""),
                .init(type: .gender, value: character.gender?.rawValue ?? ""),
                .init(type: .type, value: character.type ?? ""),
                .init(type: .species, value: character.species ?? ""),
                .init(type: .origin, value: character.origin?.name ?? ""),
                .init(type: .location, value: character.location?.name ?? ""),
                .init(type: .created, value: character.created ?? ""),
                .init(type: .totalEpisodesCount, value: "\(character.episode?.count ?? 0)")
            ]),
            .episodes(viewModels: (character.episode?.compactMap({
                return CharacterDetailEpisodesVM(episodeDataURL: URL(string: $0))
            }))!)
        ]
    }
}
