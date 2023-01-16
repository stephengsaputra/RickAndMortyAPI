//
//  LocationListVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import UIKit

/// Controller to show and search for Location
final class LocationListVC: UIViewController {

    // MARK: - Properties
    internal let viewModel = LocationListVM()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureNavigation()
    }
    
    // MARK: - Selectors
    @objc func handleSearchButton() {
        
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        self.title = "Locations"
        view.backgroundColor = .systemBackground
        
        viewModel.fetchLocations()
    }
    
    func configureNavigation() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchButton))
    }
}
