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
                .init(title: "Status", value: character.status?.text ?? ""),
                .init(title: "Gender", value: character.gender?.rawValue ?? ""),
                .init(title: "Type", value: character.type ?? ""),
                .init(title: "Species", value: character.species ?? ""),
                .init(title: "Origin", value: character.origin?.name ?? ""),
                .init(title: "Location", value: character.location?.name ?? ""),
                .init(title: "Created", value: character.created ?? ""),
                .init(title: "Total Episodes", value: "\(character.episode?.count)")
            ]),
            .episodes(viewModels: (character.episode?.compactMap({
                return CharacterDetailEpisodesVM(episodeDataURL: URL(string: $0))
            }))!)
        ]
    }
}
