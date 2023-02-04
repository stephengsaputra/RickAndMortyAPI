//
//  LocationListVC.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 28/12/22.
//

import UIKit

protocol LocationListVCDelegate: AnyObject {
    
    func didLoadInitialLocations()
    func didLoadMoreLocations(with newIndexPath: [IndexPath])
}

/// Controller to show and search for Location
final class LocationListVC: UIViewController {

    // MARK: - Properties
    internal let viewModel = LocationListVM()
    
    internal lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    internal lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.alpha = 0
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.fetchLocations()
        viewModel.delegate = self
        
        configureUI()
        configureNavigation()
        
        spinner.startAnimating()
    }
    
    // MARK: - Selectors
    @objc func handleSearchButton() {
        
        let vc = SearchVC(config: .init(type: .location))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        self.title = "Locations"
        view.backgroundColor = .systemBackground
        
        view.addSubviews(tableView, spinner)
        NSLayoutConstraint.activate([
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func configureNavigation() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchButton))
    }
}
