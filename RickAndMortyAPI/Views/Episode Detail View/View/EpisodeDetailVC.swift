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
    private var url: URL?
    
    // MARK: - Lifecycle
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        
        self.title = "Episode"
        view.backgroundColor = .systemBackground
    }
}
