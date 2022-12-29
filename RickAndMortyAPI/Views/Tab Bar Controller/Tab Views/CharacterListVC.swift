//
//  CharacterListVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import UIKit

/// Controller to show and search for Character
final class CharacterListVC: UIViewController {

    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        
        APIService.shared.execute(.listCharactersRequests, expecting: CharactersResponse.self) { result in
            switch result {
                case .success(let model):
                    print("Total: \(model.info?.count)")
                    print("Page results count: \(model.results?.count)")
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        
        self.title = "Characters"
        view.backgroundColor = .systemBackground
    }
}
