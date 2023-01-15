//
//  EpisodeListVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 15/01/23.
//

import Foundation
import UIKit

/// View Model to handle episode list view logic
final class EpisodeListVM {
    
    public weak var delegate: EpisodeListVCDelegate?
    
    var episodes: [Episode] = []
    var apiInfo: Info? = nil
    
    var isLoadingMoreEpisodes = false
    
    /// Fetch initial set of characters
    func fetchEpisodes() {
        
        APIService.shared.execute(.getEpisodesListRequest, expecting: EpisodesResponse.self) { [weak self] result in
            switch result {
                case .success(let model):
                
                    self?.episodes.append(contentsOf: model.results ?? [])
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialEpisodes()
                    }
                    
                    let info = model.info
                    self?.apiInfo = info
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    /// Paginate if additional characters are needed
    func fetchMoreEpisodes(url: URL) {
        
        guard !isLoadingMoreEpisodes else {
            return
        }
        
        isLoadingMoreEpisodes = true
        
        guard let request = APIRequest(url: url) else {
            
            isLoadingMoreEpisodes = false
            print("DEBUG: Failed to create request")
            return
        }
        
        APIService.shared.execute(request, expecting: EpisodesResponse.self) { [weak self] result in
            
            switch result {
            case .success(let model):
                
                self?.apiInfo = model.info
                
                let originalCount = self?.episodes.count
                let newCount = model.results?.count
                let total = (originalCount ?? 0) + (newCount ?? 0)
                
                let startingIndex = total - (newCount ?? 0)
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + (newCount ?? 0))).compactMap { int in
                    return IndexPath(row: int, section: 0 )
                }

                self?.episodes.append(contentsOf: model.results ?? [])
                DispatchQueue.main.async {

                    self?.delegate?.didLoadMoreEpisodes(with: indexPathsToAdd)
                    self?.isLoadingMoreEpisodes = false
                }
                
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreEpisodes = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}
