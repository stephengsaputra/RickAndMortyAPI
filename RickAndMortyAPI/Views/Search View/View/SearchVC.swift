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
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .location:
                    return "Search Location"
                case .episode:
                    return "Search Episode"
                }
            }
        }
        
        let type: `Type`
    }
    
    private let viewModel: SearchViewVM
    private let searchView: SearchView
    
    // MARK: - Lifecycle
    init(config: Config) {
        
        let viewModel = SearchViewVM(config: config)
        self.viewModel = viewModel
        self.searchView = SearchView(frame: .zero, viewModel: viewModel)
        
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
    @objc func didTapSearchButton() {
        
        print("SEARCH")
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchView)
        NSLayoutConstraint.activate([
        
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    func configureNavigation() {
        
        self.title = viewModel.config.type.title
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapSearchButton))
    }
}
