//
//  CharacterListVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import Foundation
import UIKit

/// View Model to handle character list view logic
final class CharacterListVM {
    
    public weak var delegate: CharacterListVCDelegate?
    
    var characters: [Character] = []
    var apiInfo: Info? = nil
    
    var isLoadingMoreCharacters = false
    
    /// Fetch initial set of characters
    func fetchCharacters() {
        
        APIService.shared.execute(.getCharacterListRequest, expecting: CharactersResponse.self) { [weak self] result in
            switch result {
                case .success(let model):
                
                    self?.characters.append(contentsOf: model.results ?? [])
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialCharacters()
                    }
                    
                    let info = model.info
                    self?.apiInfo = info
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    /// Paginate if additional characters are needed
    func fetchMoreCharacters(url: URL) {
        
        guard !isLoadingMoreCharacters else {
            return
        }
        
        isLoadingMoreCharacters = true
        
        guard let request = APIRequest(url: url) else {
            
            isLoadingMoreCharacters = false
            print("DEBUG: Failed to create request")
            return
        }
        
        APIService.shared.execute(request, expecting: CharactersResponse.self) { [weak self] result in
            
            switch result {
                case .success(let model):
                    self?.characters.append(contentsOf: model.results ?? [])
                    self?.apiInfo = model.info
                    self?.isLoadingMoreCharacters = false
                case .failure(let failure):
                    print(String(describing: failure))
                    self?.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}
