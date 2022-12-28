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
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        
        self.title = "Characters"
        view.backgroundColor = .systemBackground
    }
}
