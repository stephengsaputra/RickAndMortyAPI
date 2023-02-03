//
//  LocationDetailVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import UIKit

protocol LocationDetailVCDelegate: AnyObject {
    
    func didFetchLocationDetail()
    func showCharacterDetailView(_ detailView: LocationDetailView, didSelect character: Character)
}

/// Controller to display a single episode
final class LocationDetailVC: UIViewController {

    // MARK: - Properties
    private let viewModel: LocationDetailVM
    private lazy var locationDetailView = LocationDetailView()
    
    // MARK: - Lifecycle
    init(location: Location) {
        
        let url = URL(string: location.url ?? "")
        self.viewModel = LocationDetailVM(endpointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchLocationData()
        locationDetailView.delegate = self
        
        configureUI()
        configureNavigation()
    }
    
    // MARK: - Selectors
    @objc func handleShareButton() {
        
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(locationDetailView)
        NSLayoutConstraint.activate([
            
            locationDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            locationDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            locationDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func configureNavigation() {
        
        self.title = "Episode"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleShareButton))
    }
}

extension LocationDetailVC: LocationDetailVCDelegate {
    
    func didFetchLocationDetail() {
        locationDetailView.configure(with: viewModel)
    }
    
    func showCharacterDetailView(_ detailView: LocationDetailView, didSelect character: Character) {
        
        let vc = CharacterDetailVC(viewModel: .init(character: character))
        navigationController?.pushViewController(vc, animated: true)
    }
}
