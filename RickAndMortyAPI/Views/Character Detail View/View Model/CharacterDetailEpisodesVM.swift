//
//  CharacterDetailEpisodesVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 07/01/23.
//

import Foundation

protocol EpisodeDataRender {
    
    var name: String? { get }
    var airDate: String? { get }
    var episode: String? { get }
}

final class CharacterDetailEpisodesVM {
    
    let episodeDataURL: URL?
    private var isFetching = false
    private var dataBlock: ((EpisodeDataRender) -> Void)?
    
    private var episode: Episode? {
        didSet {
            guard let model = episode.self else {
                return
            }
            
            dataBlock?(model)
        }
    }
    
    init(episodeDataURL: URL?) {
        self.episodeDataURL = episodeDataURL
    }
    
    public func registerForData(_ block: @escaping (EpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            
            return
        }
        
        guard let url = episodeDataURL, let request = APIRequest(url: url) else {
            return
        }
        
        isFetching = true
        
        APIService.shared.execute(request, expecting: Episode.self) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.episode = success
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
