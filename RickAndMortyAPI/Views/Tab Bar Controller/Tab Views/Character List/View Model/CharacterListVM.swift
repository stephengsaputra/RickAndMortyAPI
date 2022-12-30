//
//  CharacterListVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 29/12/22.
//

import Foundation
import UIKit

protocol CharacterListVMDelegate: AnyObject {
    
    func didLoadInitialCharacters()
}

final class CharacterListVM {
    
    public weak var delegate: CharacterListVMDelegate?
    var characters: [Character] = []

    func fetchCharacters() {
        
        APIService.shared.execute(.listCharactersRequests, expecting: CharactersResponse.self) { [weak self] result in
            switch result {
                case .success(let model):
                    self?.characters.append(contentsOf: model.results ?? [])
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialCharacters()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
