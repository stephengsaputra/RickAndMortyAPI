//
//  SearchVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 16/01/23.
//

import UIKit

/// Configurable view controller to search
class SearchVC: UIViewController {

    // MARK: - Properties
    struct Config {
        
        enum `Type` {
            case character
            case location
            case episode
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    // MARK: - Lifecycle
    init(config: Config) {
        
        self.config = config
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
        
        self.title = "Search"
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
