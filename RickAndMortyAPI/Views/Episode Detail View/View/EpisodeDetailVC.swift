//
//  EpisodeDetailVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 12/01/23.
//

import UIKit

protocol EpisodeDetailVCDelegate: AnyObject {
    
    func didFetchEpisodeDetail()
    func showCharacterDetailView(_ detailView: EpisodeDetailView, didSelect character: Character)
}

/// Controller to display a single episode
final class EpisodeDetailVC: UIViewController {

    // MARK: - Properties
    private let viewModel: EpisodeDetailVM
    private lazy var episodeDetailView = EpisodeDetailView()
    
    // MARK: - Lifecycle
    init(url: URL?) {
        self.viewModel = EpisodeDetailVM(endpointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
        episodeDetailView.delegate = self
        
        configureUI()
        configureNavigation()
    }
    
    // MARK: - Selectors
    @objc func handleShareButton() {
        
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(episodeDetailView)
        NSLayoutConstraint.activate([
            
            episodeDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            episodeDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func configureNavigation() {
        
        self.title = "Episode"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleShareButton))
    }
}

extension EpisodeDetailVC: EpisodeDetailVCDelegate {
    
    func didFetchEpisodeDetail() {
        episodeDetailView.configure(with: viewModel)
    }
    
    func showCharacterDetailView(_ detailView: EpisodeDetailView, didSelect character: Character) {
        
        let vc = CharacterDetailVC(viewModel: .init(character: character))
        navigationController?.pushViewController(vc, animated: true)
    }
}
