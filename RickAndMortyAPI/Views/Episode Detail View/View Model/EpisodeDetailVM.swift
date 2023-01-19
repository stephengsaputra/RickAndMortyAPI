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
            DispatchQueue.main.async {
                self.createCellViewModels()
                self.delegate?.didFetchEpisodeDetail()
            }
        }
    }
    
    enum SectionType {
        case information(viewModels: [EpisodeInfoCollectionViewCellVM])
        case characters(viewModels: [CharacterCollectionViewCellVM])
    }
    
    public var cellViewModels: [SectionType] = []
    
    // MARK: - Initializer
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
    }
    
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
        
        let requests: [APIRequest] = (episode.characters?.compactMap({
            return URL(string: $0)
        }).compactMap({
            return APIRequest(url: $0)
        })) ?? []
        
        let group = DispatchGroup()
        var characters: [Character] = []
        
        for request in requests {
            
            group.enter()
            
            APIService.shared.execute(request, expecting: Character.self) { result in
                
                switch result {
                case .success(let model):
                    print(model)
                    characters.append(model)
                case .failure:
                    break
                }
            }
            
            group.leave()
            
            group.notify(queue: .main) {
                self.dataTuple = (episode: episode, characters: characters)
            }
        }
    }
    
    private func createCellViewModels() {
        
        guard let dataTuple = dataTuple else {
            return
        }
        
        let episode = dataTuple.episode
        cellViewModels.append(
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name ?? ""),
                .init(title: "Season", value: episode.episode ?? ""),
                .init(title: "Air Date", value: episode.airDate ?? ""),
                .init(title: "Created", value: episode.created ?? "")
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
}
