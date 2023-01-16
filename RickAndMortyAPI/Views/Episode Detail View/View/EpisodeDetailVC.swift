//
//  EpisodeDetailVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 12/01/23.
//

import UIKit

/// Controller to display a single episode
final class EpisodeDetailVC: UIViewController {

    // MARK: - Properties
    private let viewModel: EpisodeDetailVM
    
    // MARK: - Lifecycle
    init(url: URL?) {
        self.viewModel = .init(endpointURL: url)
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
    @objc func handleShareButton() {
        
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .systemBackground
    }
    
    func configureNavigation() {
        
        self.title = "Episode"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleShareButton))
    }
}
