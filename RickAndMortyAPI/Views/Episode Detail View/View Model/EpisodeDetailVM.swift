//
//  EpisodeDetailVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 14/01/23.
//

import Foundation

final class EpisodeDetailVM {
    
    private let endpointURL: URL?
    public weak var delegate: EpisodeDetailVCDelegate?
    
    private var dataTuple: (episode: Episode, characters: [Character])? {
        didSet {
            self.delegate?.didFetchEpisodeDetail()
            self.createCellViewModels()
        }
    }
    
    enum SectionType {
        case information(viewModels: [EpisodeInfoCollectionViewCellVM])
        case characters(viewModels: [CharacterCollectionViewCellVM])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: - Initializer
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
    }
    
    // MARK: - Functions
    func fetchEpisodeData() {
        
        guard let url = endpointURL, let request = APIRequest(url: url) else {
            return
        }
        
        APIService.shared.execute(request, expecting: Episode.self) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacter(episode: model)
            case .failure:
                break
            }
        }
    }
    
    private func fetchRelatedCharacter(episode: Episode) {
        
        let requests: [APIRequest] = (episode.characters?.compactMap({ character in
            return URL(string: character)
        }).compactMap({ character in
            return APIRequest(url: character)
        })) ?? []
        
        let group = DispatchGroup()
        var characters: [Character] = []
        
        for request in requests {
            
            defer {
                group.leave()
            }
            
            group.enter()
            
            APIService.shared.execute(request, expecting: Character.self) { result in
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (episode: episode, characters: characters)
        }
    }
    
    private func createCellViewModels() {
        
        guard let dataTuple = dataTuple else {
            return
        }
        
        let episode = dataTuple.episode
        
        var createdString = ""
        
        if let createdDate = CharacterDetailInformationVM.dateFormatter.date(from: episode.created ?? "") {
            createdString = CharacterDetailInformationVM.shortDateFormatter.string(from: createdDate)
        }
        
        cellViewModels.append(
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name ?? ""),
                .init(title: "Season", value: episode.episode ?? ""),
                .init(title: "Air Date", value: episode.airDate ?? ""),
                .init(title: "Created", value: createdString)
            ])
        )
        
        let characters = dataTuple.characters
        cellViewModels.append(
            .characters(viewModels: characters.compactMap({ character in
                return CharacterCollectionViewCellVM(
                    characterName: character.name ?? "",
                    characterStatus: character.status ?? .unknown,
                    characterImageURL: URL(string: character.image ?? "")
                )
            }))
        )
    }
    
    func character(at index: Int) -> Character? {
        
        guard let dataTuple = dataTuple else {
            return nil
        }
        
        return dataTuple.characters[index]
    }
}
