//
//  EpisodeDetailVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 14/01/23.
//

import Foundation

final class EpisodeDetailVM {
    
    private let endpointURL: URL?
    
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
        fetchEpisodeData()
    }
    
    func fetchEpisodeData() {
        
        guard let url = endpointURL, let request = APIRequest(url: url) else {
            return
        }
        
        APIService.shared.execute(request, expecting: Episode.self) { result in
            
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
