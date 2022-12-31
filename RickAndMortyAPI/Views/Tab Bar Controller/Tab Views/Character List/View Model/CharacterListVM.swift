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
    private var apiInfo: Info? = nil
    
    /// Fetch initial set of characters
    func fetchCharacters() {
        
        APIService.shared.execute(.listCharactersRequests, expecting: CharactersResponse.self) { [weak self] result in
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
    func fetchMoreCharacters() {
        
        
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}
