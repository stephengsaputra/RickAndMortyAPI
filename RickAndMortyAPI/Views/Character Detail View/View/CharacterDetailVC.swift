//
//  CharacterDetailVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 31/12/22.
//

import UIKit

/// Controller to display a single character's details
final class CharacterDetailVC: UIViewController {

    // MARK: - Properties
    private let viewModel: CharacterDetailVM
    
    // MARK: - Lifecycle
    init(viewModel: CharacterDetailVM) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureNavigation()
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .systemBackground
    }
    
    func configureNavigation() {
        
        self.title = viewModel.title
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
